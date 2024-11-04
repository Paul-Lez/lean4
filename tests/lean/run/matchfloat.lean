import Lean.Elab.Command

def test1 : Nat → Nat
  | 0 => 0
  | _+1 => 42

-- set_option pp.match false

/--
info: test1.match_1.float.{u, v} {α : Sort u} {β : Sort v} (f : α → β) (x✝ : Nat) (h_1 : Unit → (fun x => α) 0)
  (h_2 : (n : Nat) → (fun x => α) n.succ) :
  f
      (match x✝ with
      | 0 => h_1 ()
      | n.succ => h_2 n) =
    match x✝ with
    | 0 => f (h_1 ())
    | n.succ => f (h_2 n)
-/
#guard_msgs in
#check test1.match_1.float

def test2 (α β) : α ∨ β → γ → (β ∨ α) ∧ γ
  | .inl x, y => ⟨.inr x, y⟩
  | .inr x, y => ⟨.inl x, y⟩

set_option pp.proofs true in
/--
info: test2.match_1.float {α β : Prop} (f : α → β) {γ : Prop} (α✝ β✝ : Prop) (x✝ : α✝ ∨ β✝) (x✝¹ : γ)
  (h_1 : ∀ (x : α✝) (y : γ), (fun x x => α) (Or.inl x) y) (h_2 : ∀ (x : β✝) (y : γ), (fun x x => α) (Or.inr x) y) :
  f
      (match x✝, x✝¹ with
      | Or.inl x, y => h_1 x y
      | Or.inr x, y => h_2 x y) =
    match x✝, x✝¹ with
    | Or.inl x, y => f (h_1 x y)
    | Or.inr x, y => f (h_2 x y)
-/
#guard_msgs in
#check test2.match_1.float

-- A typical example

theorem List.filter_map' (f : β → α) (l : List β) : filter p (map f l) = map f (filter (p ∘ f) l) := by
  induction l <;> simp [filter, map, *, ↑ match_float]


-- A simple example

example (o : Option Bool) :
  (match o with | some b => b | none => false)
    = !(match o with | some b => !b | none => true) := by
  simp [↑ match_float]

-- Dependent context; must not rewrite

set_option trace.match_float true in
/--
warning: declaration uses 'sorry'
---
info: [match_float] Cannot float match: f is dependent
-/
#guard_msgs in
example (o : Option Bool) (motive : Bool → Type)
  (f : (x : Bool) → motive x) (rhs : motive (match o with | some b => b | none => false)) :
  f (match (motive := ∀ _, Bool) o with | some b => b | none => false) = rhs := by
  fail_if_success simp [↑ match_float]
  sorry

-- Context depends on the concrete value of the match, must not rewrite

set_option trace.match_float true in
/--
warning: declaration uses 'sorry'
---
info: [match_float] Cannot float match: context is not type correct
-/
#guard_msgs in
example (o : Option Bool)
  (f : (x : Bool) → (h : x = (match o with | some b => b | none => false)) → Bool):
  f (match (motive := ∀ _, Bool) o with | some b => b | none => false) rfl = true := by
  fail_if_success simp [↑ match_float]
  sorry

/-
This code quickly finds many matcher where deriving the floater fails, usually
because the splitter cannot be generated, for example Nat.lt_or_gt_of_ne.match_1.float

open Lean Meta in
run_meta do
  for es in (Match.Extension.extension.toEnvExtension.getState (← getEnv)).importedEntries do
    for e in es do
      -- Let's not look at matchers that eliminate to Prop only
      if e.info.uElimPos?.isNone then continue
      let _ ← realizeGlobalName (e.name ++ `float)

-/
