/-
Copyright (c) 2021 Microsoft Corporation. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Leonardo de Moura, Joachim Breitner
-/
prelude
import Lean.Parser.Term

set_option autoImplicit false

namespace Lean.Elab

/-! # Support for `termination_by` notation -/

/-- A single `termination_by` clause -/
structure TerminationBy where
  ref          : Syntax
  structural   : Bool
  vars         : TSyntaxArray [`ident, ``Lean.Parser.Term.hole]
  body         : Term
  /--
  If `synthetic := true`, then this `termination_by` clause was
  generated by `GuessLex`, and `vars` refers to *all* parameters
  of the function, not just the “extra parameters”.
  Cf. Lean.Elab.WF.unpackUnary
  -/
  synthetic    : Bool := false
  deriving Inhabited

/-- A single `decreasing_by` clause -/
structure DecreasingBy where
  ref       : Syntax
  tactic    : TSyntax ``Lean.Parser.Tactic.tacticSeq
  deriving Inhabited

/-- A single `partial_fixpoint` clause -/
structure PartialFixpoint where
  ref       : Syntax
  term?     : Option Term
  deriving Inhabited

/--
The termination annotations for a single function.
For `decreasing_by`, we store the whole `decreasing_by tacticSeq` expression, as this
is what `Term.runTactic` expects.
 -/
structure TerminationHints where
  ref : Syntax
  terminationBy?? : Option Syntax
  terminationBy? : Option TerminationBy
  partialFixpoint? : Option PartialFixpoint
  decreasingBy?  : Option DecreasingBy
  /--
  Here we record the number of parameters past the `:`. It is set by
  `TerminationHints.rememberExtraParams` and used as follows:

  * When we guess the termination measure in `GuessLex` and want to print it in surface-syntax
    compatible form.
  * If there are fewer variables in the `termination_by` annotation than there are extra
    parameters, we know which parameters they should apply to (`TerminationBy.checkVars`).
  -/
  extraParams : Nat
  deriving Inhabited

def TerminationHints.none : TerminationHints := ⟨.missing, .none, .none, .none, .none, 0⟩

/-- Logs warnings when the `TerminationHints` are unexpectedly present.  -/
def TerminationHints.ensureNone (hints : TerminationHints) (reason : String) : CoreM Unit := do
  match hints.terminationBy??, hints.terminationBy?, hints.decreasingBy?, hints.partialFixpoint? with
  | .none, .none, .none, .none => pure ()
  | .none, .none, .some dec_by, .none =>
    logWarningAt dec_by.ref m!"unused `decreasing_by`, function is {reason}"
  | .some term_by?, .none, .none, .none =>
    logWarningAt term_by? m!"unused `termination_by?`, function is {reason}"
  | .none, .some term_by, .none, .none =>
    logWarningAt term_by.ref m!"unused `termination_by`, function is {reason}"
  | .none, .none, .none, .some partialFixpoint =>
    logWarningAt partialFixpoint.ref m!"unused `partial_fixpoint`, function is {reason}"
  | _, _, _, _=>
    logWarningAt hints.ref m!"unused termination hints, function is {reason}"

/-- True if any form of termination hint is present. -/
def TerminationHints.isNotNone (hints : TerminationHints) : Bool :=
  hints.terminationBy??.isSome ||
  hints.terminationBy?.isSome ||
  hints.decreasingBy?.isSome ||
  hints.partialFixpoint?.isSome

/--
Remembers `extraParams` for later use. Needs to happen early enough where we still know
how many parameters came from the function header (`headerParams`).
-/
def TerminationHints.rememberExtraParams (headerParams : Nat) (hints : TerminationHints)
    (value : Expr) : TerminationHints :=
  { hints with extraParams := value.getNumHeadLambdas - headerParams }

/--
Checks that `termination_by` binds at most as many variables are present in the outermost
lambda of `value`, and throws appropriate errors.
-/
def TerminationBy.checkVars (funName : Name) (extraParams : Nat) (tb : TerminationBy) : MetaM Unit := do
  unless tb.synthetic do
    if h : tb.vars.size > extraParams then
      let mut msg := m!"{parameters tb.vars.size} bound in `termination_by`, but the body of " ++
        m!"{funName} only binds {parameters extraParams}."
      if let `($ident:ident) := tb.vars[0] then
        if ident.getId.isSuffixOf funName then
            msg := msg ++ m!" (Since Lean v4.6.0, the `termination_by` clause no longer " ++
              "expects the function name here.)"
      throwErrorAt tb.ref msg
  where
    parameters : Nat → MessageData
    | 1 => "one parameter"
    | n => m!"{n} parameters"

open Parser.Termination

/-- Takes apart a `Termination.suffix` syntax object -/
def elabTerminationHints {m} [Monad m] [MonadError m] (stx : TSyntax ``suffix) : m TerminationHints := do
  -- Fail gracefully upon partial parses
  if let .missing := stx.raw then
    return { TerminationHints.none with ref := stx }
  match stx with
  | `(suffix| $[$t?]? $[$d?:decreasingBy]? ) => do
    let terminationBy?? : Option Syntax ← if let some t := t? then match t with
      | `(terminationBy?|termination_by?) => pure (some t)
      | _ => pure none
      else pure none
    let terminationBy? : Option TerminationBy ← if let some t := t? then match t with
      | `(terminationBy|termination_by partialFixpointursion) =>
        pure (some {ref := t, structural := false, vars := #[], body := ⟨.missing⟩ : TerminationBy})
      | `(terminationBy|termination_by $[structural%$s]? => $_body) =>
        throwErrorAt t "no extra parameters bounds, please omit the `=>`"
      | `(terminationBy|termination_by $[structural%$s]? $vars* => $body) =>
        pure (some {ref := t, structural := s.isSome, vars, body})
      | `(terminationBy|termination_by $[structural%$s]? $body:term) =>
        pure (some {ref := t, structural := s.isSome, vars := #[], body})
      | `(terminationBy?|termination_by?) => pure none
      | `(partialFixpoint|partial_fixpoint $[monotonicity $_]?) => pure none
      | _ => throwErrorAt t "unexpected `termination_by` syntax"
      else pure none
    let partialFixpoint? : Option PartialFixpoint ← if let some t := t? then match t with
      | `(partialFixpoint|partial_fixpoint $[monotonicity $term?]?) => pure (some {ref := t, term?})
      | _ => pure none
      else pure none
    let decreasingBy? ← d?.mapM fun d => match d with
      | `(decreasingBy|decreasing_by $tactic) => pure {ref := d, tactic}
      | _ => throwErrorAt d "unexpected `decreasing_by` syntax"
    return { ref := stx, terminationBy??, terminationBy?, partialFixpoint?, decreasingBy?, extraParams := 0 }
  | _ => throwErrorAt stx s!"Unexpected Termination.suffix syntax: {stx} of kind {stx.raw.getKind}"

end Lean.Elab
