/-
Copyright (c) 2025 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Leonardo de Moura
-/
prelude
import Init.Tactics

namespace Lean.Try
/--
Configuration for `try?`.
-/
structure Config where
  /-- If `main` is `true`, all functions in the current module are considered for function induction, unfolding, etc. -/
  main := true
  /-- If `name` is `true`, all functions in the same namespace are considere for function induction, unfolding, etc. -/
  name := true
  /-- If `lib` is `true`, uses `libSearch` results. -/
  lib := true
  /-- If `targetOnly` is `true`, `try?` collects information using the goal target only. -/
  targetOnly := false
  /-- Maximum number of suggestions. -/
  max := 8
  /-- If `missing` is `true`, allows the construction of partial solutions where some of the subgoals are `sorry`. -/
  missing := false
  deriving Inhabited

end Lean.Try

namespace Lean.Parser.Tactic

syntax (name := tryTrace) "try?" optConfig : tactic

/-- Helper internal tactic for implementing the tactic `try?`. -/
syntax (name := attemptAll) "attempt_all " withPosition((ppDedent(ppLine) colGe "| " tacticSeq)+) : tactic

/-- Helper internal tactic used to implement `evalSuggest` in `try?` -/
syntax (name := tryResult) "try_suggestions " tactic* : tactic

end Lean.Parser.Tactic
