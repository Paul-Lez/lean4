/-
Copyright (c) 2024 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Leonardo de Moura
-/
prelude
import Init.Grind.Tactics
import Init.Data.Queue
import Lean.Util.ShareCommon
import Lean.HeadIndex
import Lean.Meta.Basic
import Lean.Meta.CongrTheorems
import Lean.Meta.AbstractNestedProofs
import Lean.Meta.Tactic.Simp.Types
import Lean.Meta.Tactic.Util
import Lean.Meta.Tactic.Grind.Canon
import Lean.Meta.Tactic.Grind.Attr
import Lean.Meta.Tactic.Grind.EMatchTheorem

namespace Lean.Meta.Grind

@[inline] def isSameExpr (a b : Expr) : Bool :=
  -- It is safe to use pointer equality because we hashcons all expressions
  -- inserted into the E-graph
  unsafe ptrEq a b

/-- We use this auxiliary constant to mark delayed congruence proofs. -/
def congrPlaceholderProof := mkConst (Name.mkSimple "[congruence]")

/--
Returns `true` if `e` is `True`, `False`, or a literal value.
See `LitValues` for supported literals.
-/
def isInterpreted (e : Expr) : MetaM Bool := do
  if e.isTrue || e.isFalse then return true
  isLitValue e

register_builtin_option grind.debug : Bool := {
  defValue := false
  group    := "debug"
  descr    := "check invariants after updates"
}

register_builtin_option grind.debug.proofs : Bool := {
  defValue := false
  group    := "debug"
  descr    := "check proofs between the elements of all equivalence classes"
}

/-- Context for `GrindCoreM` monad. -/
structure Context where
  simp         : Simp.Context
  simprocs     : Array Simp.Simprocs
  mainDeclName : Name
  config       : Grind.Config

/-- Key for the congruence theorem cache. -/
structure CongrTheoremCacheKey where
  f       : Expr
  numArgs : Nat

-- We manually define `BEq` because we wannt to use pointer equality.
instance : BEq CongrTheoremCacheKey where
  beq a b := isSameExpr a.f b.f && a.numArgs == b.numArgs

-- We manually define `Hashable` because we wannt to use pointer equality.
instance : Hashable CongrTheoremCacheKey where
  hash a := mixHash (unsafe ptrAddrUnsafe a.f).toUInt64 (hash a.numArgs)

/-- State for the `GrindCoreM` monad. -/
structure CoreState where
  canon      : Canon.State := {}
  /-- `ShareCommon` (aka `Hashconsing`) state. -/
  scState    : ShareCommon.State.{0} ShareCommon.objectFactory := ShareCommon.State.mk _
  /-- Next index for creating auxiliary theorems. -/
  nextThmIdx : Nat := 1
  /--
  Congruence theorems generated so far. Recall that for constant symbols
  we rely on the reserved name feature (i.e., `mkHCongrWithArityForConst?`).
  Remark: we currently do not reuse congruence theorems
  -/
  congrThms  : PHashMap CongrTheoremCacheKey CongrTheorem := {}
  simpStats  : Simp.Stats := {}
  trueExpr   : Expr
  falseExpr  : Expr

private opaque MethodsRefPointed : NonemptyType.{0}
private def MethodsRef : Type := MethodsRefPointed.type
instance : Nonempty MethodsRef := MethodsRefPointed.property

abbrev GrindCoreM := ReaderT MethodsRef $ ReaderT Context $ StateRefT CoreState MetaM

/-- Returns the user-defined configuration options -/
def getConfig : GrindCoreM Grind.Config :=
  return (← readThe Context).config

/-- Returns the internalized `True` constant.  -/
def getTrueExpr : GrindCoreM Expr := do
  return (← get).trueExpr

/-- Returns the internalized `False` constant.  -/
def getFalseExpr : GrindCoreM Expr := do
  return (← get).falseExpr

def getMainDeclName : GrindCoreM Name :=
  return (← readThe Context).mainDeclName

@[inline] def getMethodsRef : GrindCoreM MethodsRef :=
  read

/-- Returns maximum term generation that is considered during ematching. -/
def getMaxGeneration : GrindCoreM Nat := do
  return (← getConfig).gen

/--
Abtracts nested proofs in `e`. This is a preprocessing step performed before internalization.
-/
def abstractNestedProofs (e : Expr) : GrindCoreM Expr := do
  let nextIdx := (← get).nextThmIdx
  let (e, s') ← AbstractNestedProofs.visit e |>.run { baseName := (← getMainDeclName) } |>.run |>.run { nextIdx }
  modify fun s => { s with nextThmIdx := s'.nextIdx }
  return e

/--
Applies hash-consing to `e`. Recall that all expressions in a `grind` goal have
been hash-consing. We perform this step before we internalize expressions.
-/
def shareCommon (e : Expr) : GrindCoreM Expr := do
  modifyGet fun { canon, scState, nextThmIdx, congrThms, trueExpr, falseExpr, simpStats } =>
    let (e, scState) := ShareCommon.State.shareCommon scState e
    (e, { canon, scState, nextThmIdx, congrThms, trueExpr, falseExpr, simpStats })

/--
Canonicalizes nested types, type formers, and instances in `e`.
-/
def canon (e : Expr) : GrindCoreM Expr := do
  let canonS ← modifyGet fun s => (s.canon, { s with canon := {} })
  let (e, canonS) ← Canon.canon e |>.run canonS
  modify fun s => { s with canon := canonS }
  return e

/-- Returns `true` if `e` is the internalized `True` expression.  -/
def isTrueExpr (e : Expr) : GrindCoreM Bool :=
  return isSameExpr e (← getTrueExpr)

/-- Returns `true` if `e` is the internalized `False` expression.  -/
def isFalseExpr (e : Expr) : GrindCoreM Bool :=
  return isSameExpr e (← getFalseExpr)

/--
Creates a congruence theorem for a `f`-applications with `numArgs` arguments.
-/
def mkHCongrWithArity (f : Expr) (numArgs : Nat) : GrindCoreM CongrTheorem := do
  let key := { f, numArgs }
  if let some result := (← get).congrThms.find? key then
    return result
  if let .const declName us := f then
    if let some result ← mkHCongrWithArityForConst? declName us numArgs then
      modify fun s => { s with congrThms := s.congrThms.insert key result }
      return result
  let result ← Meta.mkHCongrWithArity f numArgs
  modify fun s => { s with congrThms := s.congrThms.insert key result }
  return result

/--
Stores information for a node in the egraph.
Each internalized expression `e` has an `ENode` associated with it.
-/
structure ENode where
  /-- Node represented by this ENode. -/
  self : Expr
  /-- Next element in the equivalence class. -/
  next : Expr
  /-- Root (aka canonical representative) of the equivalence class -/
  root : Expr
  /-- Root of the congruence class. This is field is a don't care if `e` is not an application. -/
  cgRoot : Expr
  /--
  When `e` was added to this equivalence class because of an equality `h : e = target`,
  then we store `target` here, and `h` at `proof?`.
  -/
  target? : Option Expr := none
  proof? : Option Expr := none
  /-- Proof has been flipped. -/
  flipped : Bool := false
  /-- Number of elements in the equivalence class, this field is meaningless if node is not the root. -/
  size : Nat := 1
  /-- `interpreted := true` if node should be viewed as an abstract value. -/
  interpreted : Bool := false
  /-- `ctor := true` if the head symbol is a constructor application. -/
  ctor : Bool := false
  /-- `hasLambdas := true` if equivalence class contains lambda expressions. -/
  hasLambdas : Bool := false
  /--
  If `heqProofs := true`, then some proofs in the equivalence class are based
  on heterogeneous equality.
  -/
  heqProofs : Bool := false
  /--
  Unique index used for pretty printing and debugging purposes.
  -/
  idx : Nat := 0
  generation : Nat := 0
  /-- Modification time -/
  mt : Nat := 0
  -- TODO: see Lean 3 implementation
  deriving Inhabited, Repr

/-- New equality to be processed. -/
structure NewEq where
  lhs   : Expr
  rhs   : Expr
  proof : Expr
  isHEq : Bool

/--
Key for the `ENodeMap` and `ParentMap` map.
We use pointer addresses and rely on the fact all internalized expressions
have been hash-consed, i.e., we have applied `shareCommon`.
-/
private structure ENodeKey where
  expr : Expr

instance : Hashable ENodeKey where
  hash k := unsafe (ptrAddrUnsafe k.expr).toUInt64

instance : BEq ENodeKey where
  beq k₁ k₂ := isSameExpr k₁.expr k₂.expr

abbrev ENodeMap := PHashMap ENodeKey ENode

/--
Key for the congruence table.
We need access to the `enodes` to be able to retrieve the equivalence class roots.
-/
structure CongrKey (enodes : ENodeMap) where
  e : Expr

private def hashRoot (enodes : ENodeMap) (e : Expr) : UInt64 :=
  if let some node := enodes.find? { expr := e } then
    unsafe (ptrAddrUnsafe node.root).toUInt64
  else
    13

private def hasSameRoot (enodes : ENodeMap) (a b : Expr) : Bool := Id.run do
  if isSameExpr a b then
    return true
  else
    let some n1 := enodes.find? { expr := a } | return false
    let some n2 := enodes.find? { expr := b } | return false
    isSameExpr n1.root n2.root

def congrHash (enodes : ENodeMap) (e : Expr) : UInt64 :=
  if e.isAppOfArity ``Lean.Grind.nestedProof 2 then
    -- We only hash the proposition
    hashRoot enodes (e.getArg! 0)
  else
    go e 17
where
  go (e : Expr) (r : UInt64) : UInt64 :=
    match e with
    | .app f a => go f (mixHash r (hashRoot enodes a))
    | _ => mixHash r (hashRoot enodes e)

/-- Returns `true` if `a` and `b` are congruent modulo the equivalence classes in `enodes`. -/
partial def isCongruent (enodes : ENodeMap) (a b : Expr) : Bool :=
  if a.isAppOfArity ``Lean.Grind.nestedProof 2 && b.isAppOfArity ``Lean.Grind.nestedProof 2 then
    hasSameRoot enodes (a.getArg! 0) (b.getArg! 0)
  else
    go a b
where
  go (a b : Expr) : Bool :=
    if a.isApp && b.isApp then
      hasSameRoot enodes a.appArg! b.appArg! && go a.appFn! b.appFn!
    else
      -- Remark: we do not check whether the types of the functions are equal here
      -- because we are not in the `MetaM` monad.
      hasSameRoot enodes a b

instance : Hashable (CongrKey enodes) where
  hash k := congrHash enodes k.e

instance : BEq (CongrKey enodes) where
  beq k1 k2 := isCongruent enodes k1.e k2.e

abbrev CongrTable (enodes : ENodeMap) := PHashSet (CongrKey enodes)

-- Remark: we cannot use pointer addresses here because we have to traverse the tree.
abbrev ParentSet := RBTree Expr Expr.quickComp
abbrev ParentMap := PHashMap ENodeKey ParentSet

/--
The E-matching module instantiates theorems using the `EMatchTheorem proof` and a (partial) assignment.
We want to avoid instantiating the same theorem with the same assignment more than once.
Therefore, we store the (pre-)instance information in set.
Recall that the proofs of activated theorems have been hash-consed.
The assignment contains internalized expressions, which have also been hash-consed.
-/
structure PreInstance where
  proof      : Expr
  assignment : Array Expr

instance : Hashable PreInstance where
  hash i := Id.run do
    let mut r := unsafe (ptrAddrUnsafe i.proof >>> 3).toUInt64
    for v in i.assignment do
      r := mixHash r (unsafe (ptrAddrUnsafe v >>> 3).toUInt64)
    return r

instance : BEq PreInstance where
  beq i₁ i₂ := Id.run do
    unless isSameExpr i₁.proof i₂.proof do return false
    unless i₁.assignment.size == i₂.assignment.size do return false
    for v₁ in i₁.assignment, v₂ in i₂.assignment do
      unless isSameExpr v₁ v₂ do return false
    return true

abbrev PreInstanceSet := PHashSet PreInstance

/-- New fact to be processed. -/
structure NewFact where
  proof      : Expr
  prop       : Expr
  generation : Nat
  deriving Inhabited

structure Goal where
  mvarId       : MVarId
  enodes       : ENodeMap := {}
  parents      : ParentMap := {}
  congrTable   : CongrTable enodes := {}
  /--
  A mapping from each function application index (`HeadIndex`) to a list of applications with that index.
  Recall that the `HeadIndex` for a constant is its constant name, and for a free variable,
  it is its unique id.
  -/
  appMap       : PHashMap HeadIndex (List Expr) := {}
  /-- Equations to be processed. -/
  newEqs       : Array NewEq := #[]
  /-- `inconsistent := true` if `ENode`s for `True` and `False` are in the same equivalence class. -/
  inconsistent : Bool := false
  /-- Goal modification time. -/
  gmt          : Nat := 0
  /-- Next unique index for creating ENodes -/
  nextIdx      : Nat := 0
  /-- Active theorems that we have performed ematching at least once. -/
  thms         : PArray EMatchTheorem := {}
  /-- Active theorems that we have not performed any round of ematching yet. -/
  newThms      : PArray EMatchTheorem := {}
  /--
  Inactive global theorems. As we internalize terms, we activate theorems as we find their symbols.
  Local theorem provided by users are added directly into `newThms`.
  -/
  thmMap       : EMatchTheorems
  /-- Number of theorem instances generated so far -/
  numInstances : Nat := 0
  /-- (pre-)instances found so far. It includes instances that failed to be instantiated. -/
  preInstances : PreInstanceSet := {}
  /-- new facts to be processed. -/
  newFacts     : Std.Queue NewFact := ∅
  deriving Inhabited

def Goal.admit (goal : Goal) : MetaM Unit :=
  goal.mvarId.admit

abbrev GoalM := StateRefT Goal GrindCoreM

@[inline] def GoalM.run (goal : Goal) (x : GoalM α) : GrindCoreM (α × Goal) :=
  goal.mvarId.withContext do StateRefT'.run x goal

@[inline] def GoalM.run' (goal : Goal) (x : GoalM Unit) : GrindCoreM Goal :=
  goal.mvarId.withContext do StateRefT'.run' (x *> get) goal

abbrev Propagator := Expr → GoalM Unit

/--
A helper function used to mark a theorem instance found by the E-matching module.
It returns `true` if it is a new instance and `false` otherwise.
-/
def markTheoremInstance (proof : Expr) (assignment : Array Expr) : GoalM Bool := do
  let k := { proof, assignment }
  if (← get).preInstances.contains k then
    return false
  modify fun s => { s with preInstances := s.preInstances.insert k }
  return true

/-- Adds a new fact `prop` with proof `proof` to the queue for processing. -/
def addNewFact (proof : Expr) (prop : Expr) (generation : Nat) : GoalM Unit := do
  modify fun s => { s with newFacts := s.newFacts.enqueue { proof, prop, generation } }

/-- Adds a new theorem instance produced using E-matching. -/
def addTheoremInstance (proof : Expr) (prop : Expr) (generation : Nat) : GoalM Unit := do
  addNewFact proof prop generation
  modify fun s => { s with numInstances := s.numInstances + 1 }

/-- Returns `true` if the maximum number of instances has been reached. -/
def checkMaxInstancesExceeded : GoalM Bool := do
  return (← get).numInstances >= (← getConfig).instances

/--
Returns `some n` if `e` has already been "internalized" into the
Otherwise, returns `none`s.
-/
def getENode? (e : Expr) : GoalM (Option ENode) :=
  return (← get).enodes.find? { expr := e }

/-- Returns node associated with `e`. It assumes `e` has already been internalized. -/
def getENode (e : Expr) : GoalM ENode := do
  let some n := (← get).enodes.find? { expr := e }
    | throwError "internal `grind` error, term has not been internalized{indentExpr e}"
  return n

/-- Returns the generation of the given term. Is assumes it has been internalized -/
def getGeneration (e : Expr) : GoalM Nat :=
  return (← getENode e).generation

/-- Returns `true` if `e` is in the equivalence class of `True`. -/
def isEqTrue (e : Expr) : GoalM Bool := do
  let n ← getENode e
  return isSameExpr n.root (← getTrueExpr)

/-- Returns `true` if `e` is in the equivalence class of `False`. -/
def isEqFalse (e : Expr) : GoalM Bool := do
  let n ← getENode e
  return isSameExpr n.root (← getFalseExpr)

/-- Returns `true` if `a` and `b` are in the same equivalence class. -/
def isEqv (a b : Expr) : GoalM Bool := do
  if isSameExpr a b then
    return true
  else
    let na ← getENode a
    let nb ← getENode b
    return isSameExpr na.root nb.root

/-- Returns `true` if the root of its equivalence class. -/
def isRoot (e : Expr) : GoalM Bool := do
  let some n ← getENode? e | return false -- `e` has not been internalized. Panic instead?
  return isSameExpr n.root e

/-- Returns the root element in the equivalence class of `e` IF `e` has been internalized. -/
def getRoot? (e : Expr) : GoalM (Option Expr) := do
  let some n ← getENode? e | return none
  return some n.root

/-- Returns the root element in the equivalence class of `e`. -/
def getRoot (e : Expr) : GoalM Expr :=
  return (← getENode e).root

/-- Returns the root enode in the equivalence class of `e`. -/
def getRootENode (e : Expr) : GoalM ENode := do
  getENode (← getRoot e)

/-- Returns the next element in the equivalence class of `e`. -/
def getNext (e : Expr) : GoalM Expr :=
  return (← getENode e).next

/-- Returns `true` if `e` has already been internalized. -/
def alreadyInternalized (e : Expr) : GoalM Bool :=
  return (← get).enodes.contains { expr := e }

def getTarget? (e : Expr) : GoalM (Option Expr) := do
  let some n ← getENode? e | return none
  return n.target?

/--
If `isHEq` is `false`, it pushes `lhs = rhs` with `proof` to `newEqs`.
Otherwise, it pushes `HEq lhs rhs`.
-/
def pushEqCore (lhs rhs proof : Expr) (isHEq : Bool) : GoalM Unit :=
  modify fun s => { s with newEqs := s.newEqs.push { lhs, rhs, proof, isHEq } }

/-- Return `true` if `a` and `b` have the same type. -/
def hasSameType (a b : Expr) : MetaM Bool :=
  withDefault do isDefEq (← inferType a) (← inferType b)

@[inline] def pushEqHEq (lhs rhs proof : Expr) : GoalM Unit := do
  if (← hasSameType lhs rhs) then
    pushEqCore lhs rhs proof (isHEq := false)
  else
    pushEqCore lhs rhs proof (isHEq := true)

/-- Pushes `lhs = rhs` with `proof` to `newEqs`. -/
@[inline] def pushEq (lhs rhs proof : Expr) : GoalM Unit :=
  pushEqCore lhs rhs proof (isHEq := false)

/-- Pushes `HEq lhs rhs` with `proof` to `newEqs`. -/
@[inline] def pushHEq (lhs rhs proof : Expr) : GoalM Unit :=
  pushEqCore lhs rhs proof (isHEq := true)

/-- Pushes `a = True` with `proof` to `newEqs`. -/
def pushEqTrue (a proof : Expr) : GoalM Unit := do
  pushEq a (← getTrueExpr) proof

/-- Pushes `a = False` with `proof` to `newEqs`. -/
def pushEqFalse (a proof : Expr) : GoalM Unit := do
  pushEq a (← getFalseExpr) proof

/--
Records that `parent` is a parent of `child`. This function actually stores the
information in the root (aka canonical representative) of `child`.
-/
def registerParent (parent : Expr) (child : Expr) : GoalM Unit := do
  let some childRoot ← getRoot? child | return ()
  let parents := if let some parents := (← get).parents.find? { expr := childRoot } then parents else {}
  modify fun s => { s with parents := s.parents.insert { expr := childRoot } (parents.insert parent) }

/--
Returns the set of expressions `e` is a child of, or an expression in
`e`s equivalence class is a child of.
The information is only up to date if `e` is the root (aka canonical representative) of the equivalence class.
-/
def getParents (e : Expr) : GoalM ParentSet := do
  let some parents := (← get).parents.find? { expr := e } | return {}
  return parents

/--
Similar to `getParents`, but also removes the entry `e ↦ parents` from the parent map.
-/
def getParentsAndReset (e : Expr) : GoalM ParentSet := do
  let parents ← getParents e
  modify fun s => { s with parents := s.parents.erase { expr := e } }
  return parents

/--
Copy `parents` to the parents of `root`.
`root` must be the root of its equivalence class.
-/
def copyParentsTo (parents : ParentSet) (root : Expr) : GoalM Unit := do
  let mut curr := if let some parents := (← get).parents.find? { expr := root } then parents else {}
  for parent in parents do
    curr := curr.insert parent
  modify fun s => { s with parents := s.parents.insert { expr := root } curr }

def setENode (e : Expr) (n : ENode) : GoalM Unit :=
  modify fun s => { s with
    enodes := s.enodes.insert { expr := e } n
    congrTable := unsafe unsafeCast s.congrTable
  }

def mkENodeCore (e : Expr) (interpreted ctor : Bool) (generation : Nat) : GoalM Unit := do
  setENode e {
    self := e, next := e, root := e, cgRoot := e, size := 1
    flipped := false
    heqProofs := false
    hasLambdas := e.isLambda
    mt := (← get).gmt
    idx := (← get).nextIdx
    interpreted, ctor, generation
  }
  modify fun s => { s with nextIdx := s.nextIdx + 1 }

/--
Creates an `ENode` for `e` if one does not already exist.
This method assumes `e` has been hashconsed.
-/
def mkENode (e : Expr) (generation : Nat) : GoalM Unit := do
  if (← alreadyInternalized e) then return ()
  let ctor := (← isConstructorAppCore? e).isSome
  let interpreted ← isInterpreted e
  mkENodeCore e interpreted ctor generation

/-- Returns `true` is `e` is the root of its congruence class. -/
def isCongrRoot (e : Expr) : GoalM Bool := do
  return isSameExpr e (← getENode e).cgRoot

/-- Return `true` if the goal is inconsistent. -/
def isInconsistent : GoalM Bool :=
  return (← get).inconsistent

/--
Returns a proof that `a = b`.
It assumes `a` and `b` are in the same equivalence class, and have the same type.
-/
-- Forward definition
@[extern "lean_grind_mk_eq_proof"]
opaque mkEqProof (a b : Expr) : GoalM Expr

/--
Returns a proof that `HEq a b`.
It assumes `a` and `b` are in the same equivalence class.
-/
-- Forward definition
@[extern "lean_grind_mk_heq_proof"]
opaque mkHEqProof (a b : Expr) : GoalM Expr

/--
Returns a proof that `a = b` if they have the same type. Otherwise, returns a proof of `HEq a b`.
It assumes `a` and `b` are in the same equivalence class.
-/
def mkEqHEqProof (a b : Expr) : GoalM Expr := do
  if (← hasSameType a b) then
    mkEqProof a b
  else
    mkHEqProof a b

/--
Returns a proof that `a = True`.
It assumes `a` and `True` are in the same equivalence class.
-/
def mkEqTrueProof (a : Expr) : GoalM Expr := do
  mkEqProof a (← getTrueExpr)

/--
Returns a proof that `a = False`.
It assumes `a` and `False` are in the same equivalence class.
-/
def mkEqFalseProof (a : Expr) : GoalM Expr := do
  mkEqProof a (← getFalseExpr)

/-- Marks current goal as inconsistent without assigning `mvarId`. -/
def markAsInconsistent : GoalM Unit := do
  modify fun s => { s with inconsistent := true }

/--
Closes the current goal using the given proof of `False` and
marks it as inconsistent if it is not already marked so.
-/
def closeGoal (falseProof : Expr) : GoalM Unit := do
  markAsInconsistent
  let mvarId := (← get).mvarId
  unless (← mvarId.isAssigned) do
    let target ← mvarId.getType
    if target.isFalse then
      mvarId.assign falseProof
    else
      mvarId.assign (← mkFalseElim target falseProof)

/-- Returns all enodes in the goal -/
def getENodes : GoalM (Array ENode) := do
  -- We must sort because we are using pointer addresses as keys in `enodes`
  let nodes := (← get).enodes.toArray.map (·.2)
  return nodes.qsort fun a b => a.idx < b.idx

def forEachENode (f : ENode → GoalM Unit) : GoalM Unit := do
  let nodes ← getENodes
  for n in nodes do
    f n

def filterENodes (p : ENode → GoalM Bool) : GoalM (Array ENode) := do
  let ref ← IO.mkRef #[]
  forEachENode fun n => do
    if (← p n) then
      ref.modify (·.push n)
  ref.get

def forEachEqc (f : ENode → GoalM Unit) : GoalM Unit := do
  let nodes ← getENodes
  for n in nodes do
    if isSameExpr n.self n.root then
      f n

structure Methods where
  propagateUp   : Propagator := fun _ => return ()
  propagateDown : Propagator := fun _ => return ()
  deriving Inhabited

def Methods.toMethodsRef (m : Methods) : MethodsRef :=
  unsafe unsafeCast m

private def MethodsRef.toMethods (m : MethodsRef) : Methods :=
  unsafe unsafeCast m

@[inline] def getMethods : GrindCoreM Methods :=
  return (← getMethodsRef).toMethods

def propagateUp (e : Expr) : GoalM Unit := do
  (← getMethods).propagateUp e

def propagateDown (e : Expr) : GoalM Unit := do
  (← getMethods).propagateDown e

/-- Returns expressions in the given expression equivalence class. -/
partial def getEqc (e : Expr) : GoalM (List Expr) :=
  go e e []
where
  go (first : Expr) (e : Expr) (acc : List Expr) : GoalM (List Expr) := do
    let next ← getNext e
    let acc := e :: acc
    if isSameExpr first next then
      return acc
    else
      go first next acc

/-- Returns all equivalence classes in the current goal. -/
partial def getEqcs : GoalM (List (List Expr)) := do
  let mut r := []
  let nodes ← getENodes
  for node in nodes do
    if isSameExpr node.root node.self then
      r := (← getEqc node.self) :: r
  return r

end Lean.Meta.Grind
