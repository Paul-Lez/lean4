/-
Copyright (c) 2024 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Leonardo de Moura
-/
prelude
import Init.Grind.Util
import Lean.Meta.LitValues
import Lean.Meta.Tactic.Grind.Types
import Lean.Meta.Tactic.Grind.Inv
import Lean.Meta.Tactic.Grind.PP
import Lean.Meta.Tactic.Grind.Ctor
import Lean.Meta.Tactic.Grind.Internalize

namespace Lean.Meta.Grind

/--
The fields `target?` and `proof?` in `e`'s `ENode` are encoding a transitivity proof
from `e` to the root of the equivalence class
This method "inverts" the proof, and makes it to go from the root of the equivalence class to `e`.

We use this method when merging two equivalence classes.
-/
private partial def invertTrans (e : Expr) : GoalM Unit := do
  go e false none none
where
  go (e : Expr) (flippedNew : Bool) (targetNew? : Option Expr) (proofNew? : Option Expr) : GoalM Unit := do
    let node ← getENode e
    if let some target := node.target? then
      go target (!node.flipped) (some e) node.proof?
    setENode e { node with
      target? := targetNew?
      flipped := flippedNew
      proof?  := proofNew?
    }

/--
Remove `root` parents from the congruence table.
This is an auxiliary function performed while merging equivalence classes.
-/
private def removeParents (root : Expr) : GoalM ParentSet := do
  let parents ← getParentsAndReset root
  for parent in parents do
    -- Recall that we may have `Expr.forallE` in `parents` because of `ForallProp.lean`
    if (← pure parent.isApp <&&> isCongrRoot parent) then
      trace_goal[grind.debug.parent] "remove: {parent}"
      modify fun s => { s with congrTable := s.congrTable.erase { e := parent } }
  return parents

/--
Reinsert parents into the congruence table and detect new equalities.
This is an auxiliary function performed while merging equivalence classes.
-/
private def reinsertParents (parents : ParentSet) : GoalM Unit := do
  for parent in parents do
    if (← pure parent.isApp <&&> isCongrRoot parent) then
      trace_goal[grind.debug.parent] "reinsert: {parent}"
      addCongrTable parent

/-- Closes the goal when `True` and `False` are in the same equivalence class. -/
private def closeGoalWithTrueEqFalse : GoalM Unit := do
  let mvarId := (← get).mvarId
  unless (← mvarId.isAssigned) do
    let trueEqFalse ← mkEqFalseProof (← getTrueExpr)
    let falseProof ← mkEqMP trueEqFalse (mkConst ``True.intro)
    closeGoal falseProof

/-- Closes the goal when `lhs` and `rhs` are both literal values and belong to the same equivalence class. -/
private def closeGoalWithValuesEq (lhs rhs : Expr) : GoalM Unit := do
  let p ← mkEq lhs rhs
  let hp ← mkEqProof lhs rhs
  let d ← mkDecide p
  let pEqFalse := mkApp3 (mkConst ``eq_false_of_decide) p d.appArg! (mkApp2 (mkConst ``Eq.refl [1]) (mkConst ``Bool) (mkConst ``false))
  let falseProof ← mkEqMP pEqFalse hp
  closeGoal falseProof

/--
Updates the modification time to `gmt` for the parents of `root`.
The modification time is used to decide which terms are considered during e-matching.
-/
private partial def updateMT (root : Expr) : GoalM Unit := do
  let gmt := (← get).gmt
  for parent in (← getParents root) do
    let node ← getENode parent
    if node.mt < gmt then
      setENode parent { node with mt := gmt }
      updateMT parent

private partial def addEqStep (lhs rhs proof : Expr) (isHEq : Bool) : GoalM Unit := do
  let lhsNode ← getENode lhs
  let rhsNode ← getENode rhs
  if isSameExpr lhsNode.root rhsNode.root then
    -- `lhs` and `rhs` are already in the same equivalence class.
    trace_goal[grind.debug] "{← ppENodeRef lhs} and {← ppENodeRef rhs} are already in the same equivalence class"
    return ()
  trace_goal[grind.eqc] "{← if isHEq then mkHEq lhs rhs else mkEq lhs rhs}"
  let lhsRoot ← getENode lhsNode.root
  let rhsRoot ← getENode rhsNode.root
  let mut valueInconsistency := false
  let mut trueEqFalse := false
  if lhsRoot.interpreted && rhsRoot.interpreted then
    if lhsNode.root.isTrue || rhsNode.root.isTrue then
      markAsInconsistent
      trueEqFalse := true
    else
      valueInconsistency := true
  if    (lhsRoot.interpreted && !rhsRoot.interpreted)
     || (lhsRoot.ctor && !rhsRoot.ctor)
     || (lhsRoot.size > rhsRoot.size && !rhsRoot.interpreted && !rhsRoot.ctor) then
    go rhs lhs rhsNode lhsNode rhsRoot lhsRoot true
  else
    go lhs rhs lhsNode rhsNode lhsRoot rhsRoot false
  if trueEqFalse then
    closeGoalWithTrueEqFalse
  unless (← isInconsistent) do
    if lhsRoot.ctor && rhsRoot.ctor then
      propagateCtor lhsRoot.self rhsRoot.self
  unless (← isInconsistent) do
    if valueInconsistency then
      closeGoalWithValuesEq lhsRoot.self rhsRoot.self
  trace_goal[grind.debug] "after addEqStep, {← (← get).ppState}"
  checkInvariants
where
  go (lhs rhs : Expr) (lhsNode rhsNode lhsRoot rhsRoot : ENode) (flipped : Bool) : GoalM Unit := do
    trace_goal[grind.debug] "adding {← ppENodeRef lhs} ↦ {← ppENodeRef rhs}"
    /-
    We have the following `target?/proof?`
    `lhs -> ... -> lhsNode.root`
    `rhs -> ... -> rhsNode.root`
    We want to convert it to
    `lhsNode.root -> ... -> lhs -*-> rhs -> ... -> rhsNode.root`
    where step `-*->` is justified by `proof` (or `proof.symm` if `flipped := true`)
    -/
    invertTrans lhs
    setENode lhs { lhsNode with
      target? := rhs
      proof?  := proof
      flipped
    }
    let parents ← removeParents lhsRoot.self
    updateRoots lhs rhsNode.root
    trace_goal[grind.debug] "{← ppENodeRef lhs} new root {← ppENodeRef rhsNode.root}, {← ppENodeRef (← getRoot lhs)}"
    reinsertParents parents
    propagateEqcDown lhs
    setENode lhsNode.root { (← getENode lhsRoot.self) with -- We must retrieve `lhsRoot` since it was updated.
      next := rhsRoot.next
    }
    setENode rhsNode.root { rhsRoot with
      next := lhsRoot.next
      size := rhsRoot.size + lhsRoot.size
      hasLambdas := rhsRoot.hasLambdas || lhsRoot.hasLambdas
      heqProofs  := isHEq || rhsRoot.heqProofs || lhsRoot.heqProofs
    }
    copyParentsTo parents rhsNode.root
    unless (← isInconsistent) do
      for parent in parents do
        propagateUp parent
    unless (← isInconsistent) do
      updateMT rhsRoot.self

  updateRoots (lhs : Expr) (rootNew : Expr) : GoalM Unit := do
    traverseEqc lhs fun n =>
      setENode n.self { n with root := rootNew }

  propagateEqcDown (lhs : Expr) : GoalM Unit := do
    traverseEqc lhs fun n =>
      unless (← isInconsistent) do
        propagateDown n.self

/-- Ensures collection of equations to be processed is empty. -/
private def resetNewEqs : GoalM Unit :=
  modify fun s => { s with newEqs := #[] }

/-- Pops and returns the next equality to be processed. -/
private def popNextEq? : GoalM (Option NewEq) := do
  let r := (← get).newEqs.back?
  if r.isSome then
    modify fun s => { s with newEqs := s.newEqs.pop }
  return r

private partial def addEqCore (lhs rhs proof : Expr) (isHEq : Bool) : GoalM Unit := do
  addEqStep lhs rhs proof isHEq
  processTodo
where
  processTodo : GoalM Unit := do
    if (← isInconsistent) then
      resetNewEqs
      return ()
    checkSystem "grind"
    let some { lhs, rhs, proof, isHEq } := (← popNextEq?) | return ()
    addEqStep lhs rhs proof isHEq
    processTodo

/-- Adds a new equality `lhs = rhs`. It assumes `lhs` and `rhs` have already been internalized. -/
private def addEq (lhs rhs proof : Expr) : GoalM Unit := do
  addEqCore lhs rhs proof false

/-- Adds a new heterogeneous equality `HEq lhs rhs`. It assumes `lhs` and `rhs` have already been internalized. -/
private def addHEq (lhs rhs proof : Expr) : GoalM Unit := do
  addEqCore lhs rhs proof true

/-- Save asserted facts for pretty printing goal. -/
private def storeFact (fact : Expr) : GoalM Unit := do
  modify fun s => { s with facts := s.facts.push fact }

/-- Internalizes `lhs` and `rhs`, and then adds equality `lhs = rhs`. -/
def addNewEq (lhs rhs proof : Expr) (generation : Nat) : GoalM Unit := do
  storeFact (← mkEq lhs rhs)
  internalize lhs generation
  internalize rhs generation
  addEq lhs rhs proof

/-- Adds a new `fact` justified by the given proof and using the given generation. -/
def add (fact : Expr) (proof : Expr) (generation := 0) : GoalM Unit := do
  storeFact fact
  trace_goal[grind.assert] "{fact}"
  if (← isInconsistent) then return ()
  resetNewEqs
  let_expr Not p := fact
    | go fact false
  go p true
where
  go (p : Expr) (isNeg : Bool) : GoalM Unit := do
    match_expr p with
    | Eq α lhs rhs =>
      if α.isProp then
        -- It is morally an iff.
        -- We do not use the `goEq` optimization because we want to register `p` as a case-split
        goFact p isNeg
      else
        goEq p lhs rhs isNeg false
    | HEq _ lhs _ rhs => goEq p lhs rhs isNeg true
    | _ => goFact p isNeg

  goFact (p : Expr) (isNeg : Bool) : GoalM Unit := do
    internalize p generation
    if isNeg then
      addEq p (← getFalseExpr) (← mkEqFalse proof)
    else
      addEq p (← getTrueExpr) (← mkEqTrue proof)

  goEq (p : Expr) (lhs rhs : Expr) (isNeg : Bool) (isHEq : Bool) : GoalM Unit := do
    if isNeg then
      internalize p generation
      addEq p (← getFalseExpr) (← mkEqFalse proof)
    else
      internalize lhs generation
      internalize rhs generation
      addEqCore lhs rhs proof isHEq

/-- Adds a new hypothesis. -/
def addHypothesis (fvarId : FVarId) (generation := 0) : GoalM Unit := do
  add (← fvarId.getType) (mkFVar fvarId) generation

end Lean.Meta.Grind
