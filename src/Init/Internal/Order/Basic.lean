/-
Copyright (c) 2024 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joachim Breitner
-/

prelude

import Init.ByCases
import Init.RCases

universe u v w

namespace Lean.Order

class PartialOrder (α : Sort u) where
  /-- The less-defined than relation -/
  rel : α → α → Prop
  rel_refl : ∀ {x}, rel x x
  rel_trans : ∀ {x y z}, rel x y → rel y z → rel x z
  rel_antisymm : ∀ {x y}, rel x y → rel y x → x = y


@[inherit_doc] scoped infix:50 " ⊑ " => PartialOrder.rel

section PartialOrder

variable {α  : Sort u} [PartialOrder α]

theorem PartialOrder.rel_of_eq {x y : α} (h : x = y) : x ⊑ y := by cases h; apply rel_refl

def chain (c : α → Prop) : Prop := ∀ x y , c x → c y → x ⊑ y ∨ y ⊑ x

end PartialOrder

section CCPO

class CCPO (α : Sort u) extends PartialOrder α where
  csup : (α → Prop) → α
  csup_spec {c : α → Prop} (hc : chain c) : csup c ⊑ x ↔ (∀ y, c y → y ⊑ x)

open PartialOrder CCPO

variable {α  : Sort u} [CCPO α]

theorem csup_le {c : α → Prop} (hchain : chain c) : (∀ y, c y → y ⊑ x) → csup c ⊑ x :=
  (csup_spec hchain).mpr

theorem le_csup {c : α → Prop} (hchain : chain c) {y} (hy : c y) : y ⊑ csup c :=
  (csup_spec hchain).mp rel_refl y hy

end CCPO

section monotone

variable {α : Sort u} [PartialOrder α]
variable {β : Sort v} [PartialOrder β]

def monotone (f : α → β) : Prop := ∀ x y, x ⊑ y → f x ⊑ f y

theorem monotone_const (c : β) : monotone (fun (_ : α) => c) :=
  fun _ _ _ => PartialOrder.rel_refl

theorem monotone_id : monotone (fun (x : α) => x) :=
  fun _ _ hxy => hxy

theorem monotone_compose
    {γ : Sort w} [PartialOrder γ]
    {f : α → β} {g : β → γ}
    (hf : monotone f) (hg : monotone g) :
   monotone (fun x => g (f x)) := fun _ _ hxy => hg _ _ (hf _ _ hxy)

end monotone

section admissibility

variable {α : Sort u} [CCPO α]

open PartialOrder CCPO

-- The isabelle definition quantifies over non-empty chains here. Is this needed?
def admissible (P : α → Prop) :=
  ∀ (c : α → Prop), chain c → (∀ x, c x → P x) → P (csup c)

theorem admissible_const_true : admissible (fun (_ : α) => True) :=
  fun _ _ _ => trivial

theorem admissible_and (P Q : α → Prop)
  (hadm₁ : admissible P) (hadm₂ : admissible Q) : admissible (fun x => P x ∧ Q x) :=
    fun c hchain h =>
    ⟨ hadm₁ c hchain fun x hx => (h x hx).1,
      hadm₂ c hchain fun x hx => (h x hx).2⟩

theorem chain_conj (c P : α → Prop) (hchain : chain c) : chain (fun x => c x ∧ P x) := by
  intro x y ⟨hcx, _⟩ ⟨hcy, _⟩
  exact hchain x y hcx hcy

theorem csup_conj (c P : α → Prop) (hchain : chain c) (h : ∀ x, c x → ∃ y, c y ∧ x ⊑ y ∧ P y) :
    csup c = csup (fun x => c x ∧ P x) := by
  apply rel_antisymm
  · apply csup_le hchain
    intro x hcx
    obtain ⟨y, hcy, hxy, hPy⟩ := h x hcx
    apply rel_trans hxy; clear x hcx hxy
    apply le_csup (chain_conj _ _ hchain) ⟨hcy, hPy⟩
  · apply csup_le (chain_conj _ _ hchain)
    intro x ⟨hcx, hPx⟩
    apply le_csup hchain hcx

theorem admissible_or (P Q : α → Prop)
  (hadm₁ : admissible P) (hadm₂ : admissible Q) : admissible (fun x => P x ∨ Q x) := by
  intro c hchain h
  have : (∀ x, c x → ∃ y, c y ∧ x ⊑ y ∧ P y) ∨ (∀ x, c x → ∃ y, c y ∧ x ⊑ y ∧ Q y) := by
    open Classical in
    apply Decidable.or_iff_not_imp_left.mpr
    intro h'
    simp only [not_forall, not_imp, not_exists, not_and] at h'
    obtain ⟨x, hcx, hx⟩ := h'
    intro y hcy
    cases hchain x y hcx hcy  with
    | inl hxy =>
      refine ⟨y, hcy, rel_refl, ?_⟩
      cases h y hcy with
      | inl hPy => exfalso; apply hx y hcy hxy hPy
      | inr hQy => assumption
    | inr hyx =>
      refine ⟨x, hcx, hyx , ?_⟩
      cases h x hcx with
      | inl hPx => exfalso; apply hx x hcx rel_refl hPx
      | inr hQx => assumption
  cases this with
  | inl hP =>
    left
    rw [csup_conj (h := hP) (hchain := hchain)]
    apply hadm₁ _ (chain_conj _ _ hchain)
    intro x ⟨hcx, hPx⟩
    exact hPx
  | inr hQ =>
    right
    rw [csup_conj (h := hQ) (hchain := hchain)]
    apply hadm₂ _ (chain_conj _ _ hchain)
    intro x ⟨hcx, hQx⟩
    exact hQx


def admissible_pi (P : α → β → Prop)
  (hadm₁ : ∀ y, admissible (fun x => P x y)) : admissible (fun x => ∀ y, P x y) :=
    fun c hchain h y => hadm₁ y c hchain fun x hx => h x hx y

end admissibility

section fix

open PartialOrder CCPO

variable {α  : Sort u} [CCPO α]

variable {c : α → Prop} (hchain : chain c)


inductive iterates (f : α → α) : α → Prop where
  | step : iterates f x → iterates f (f x)
  | sup {c : α → Prop} (hc : chain c) (hi : ∀ x, c x → iterates f x) : iterates f (csup c)

def bot : α := csup (fun _ => False)

scoped notation "⊥" => bot

theorem bot_le (x : α) : ⊥ ⊑ x := by
  apply csup_le
  · intro x y hx hy; contradiction
  · intro x hx; contradiction

theorem chain_iterates {f : α → α} (hf : monotone f) : chain (iterates f) := by
  intros x y hx hy
  induction hx generalizing y
  case step x hx ih =>
    induction hy
    case step y hy _ =>
      cases ih y hy
      · left; apply hf; assumption
      · right; apply hf; assumption
    case sup c hchain hi ih2 =>
      show f x ⊑ csup c ∨ csup c ⊑ f x
      by_cases h : ∃ z, c z ∧ f x ⊑ z
      · left
        obtain ⟨z, hz, hfz⟩ := h
        apply rel_trans hfz
        apply le_csup hchain hz
      · right
        apply csup_le hchain _
        intro z hz
        rw [not_exists] at h
        specialize h z
        rw [not_and] at h
        specialize h hz
        cases ih2 z hz
        next => contradiction
        next => assumption
  case sup c hchain hi ih =>
    show rel (csup c) y ∨ rel y (csup c)
    by_cases h : ∃ z, c z ∧ rel y z
    · right
      obtain ⟨z, hz, hfz⟩ := h
      apply rel_trans hfz
      apply le_csup hchain hz
    · left
      apply csup_le hchain _
      intro z hz
      rw [not_exists] at h
      specialize h z
      rw [not_and] at h
      specialize h hz
      cases ih z hz y hy
      next => assumption
      next => contradiction

theorem rel_f_of_iterates {f : α → α} (hf : monotone f) {x : α} (hx : iterates f x) : x ⊑ f x := by
  induction hx
  case step ih =>
    apply hf
    assumption
  case sup c hchain hi ih =>
    apply csup_le hchain
    intro y hy
    apply rel_trans (ih y hy)
    apply hf
    apply le_csup hchain hy

set_option linter.unusedVariables false in
-- We include hmono as an assumption already on the definition so that
-- we always have it available when applying `fix_eq`
def fix (f : α → α) (hmono : monotone f) := csup (iterates f)

theorem fix_eq {f : α → α} (hf : monotone f) : fix f hf = f (fix f hf) := by
  apply rel_antisymm
  · apply rel_f_of_iterates hf
    apply iterates.sup (chain_iterates hf)
    exact fun _ h => h
  · apply le_csup (chain_iterates hf)
    apply iterates.step
    apply iterates.sup (chain_iterates hf)
    intro y hy
    exact hy

theorem fix_induct {f : α → α} (P : α → Prop) (hf : monotone f) (hadm: admissible P)
    (h : ∀ x, P x → P (f x)) : P (fix f hf) := by
  apply hadm _ (chain_iterates hf)
  intro x hiterates
  induction hiterates with
  | @step x hiter ih => apply h x ih
  | @sup c hchain hiter ih => apply hadm c hchain ih

end fix

section fun_order

open PartialOrder

variable {α : Sort u}
variable {β : α → Sort v}
variable {γ : Sort w}

instance instOrderPi [∀ x, PartialOrder (β x)] : PartialOrder (∀ x, β x) where
  rel f g := ∀ x, f x ⊑ g x
  rel_refl _ := rel_refl
  rel_trans hf hg x := rel_trans (hf x) (hg x)
  rel_antisymm hf hg := funext (fun x => rel_antisymm (hf x) (hg x))

theorem monotone_of_monotone_apply [PartialOrder γ] [∀ x, PartialOrder (β x)] (f : γ → (∀ x, β x))
  (h : ∀ y, monotone (fun x => f x y)) : monotone f :=
  fun x y hxy z => h z x y hxy

theorem monotone_apply [PartialOrder γ] [∀ x, PartialOrder (β x)] (a : α) (f : γ → ∀ x, β x)
    (h : monotone f) :
    monotone (fun x => f x a) := fun _ _ hfg => h _ _ hfg a

theorem chain_apply [∀ x, PartialOrder (β x)] {c : (∀ x, β x) → Prop} (hc : chain c) (x : α) :
    chain (fun y => ∃ f, c f ∧ f x = y) := by
  intro _ _ ⟨f, hf, hfeq⟩ ⟨g, hg, hgeq⟩
  subst hfeq; subst hgeq
  cases hc f g hf hg
  next h => left; apply h x
  next h => right; apply h x

def fun_csup [∀ x, CCPO (β x)] (c : (∀ x, β x) → Prop) (x : α) :=
  CCPO.csup (fun y => ∃ f, c f ∧ f x = y)

instance instCCPOPi [∀ x, CCPO (β x)] : CCPO (∀ x, β x) where
  csup := fun_csup
  csup_spec := by
    intro f c hc
    constructor
    next =>
      intro hf g hg x
      apply rel_trans _ (hf x); clear hf
      apply le_csup (chain_apply hc x)
      exact ⟨g, hg, rfl⟩
    next =>
      intro h x
      apply csup_le (chain_apply hc x)
      intro y ⟨z, hz, hyz⟩
      subst y
      apply h z hz

end fun_order

section monotone_lemmas

theorem monotone_letFun
    {α : Sort u} {β : Sort v} {γ : Sort w} [PartialOrder α] [PartialOrder β]
    (v : γ) (k : α → γ → β)
    (hmono : ∀ y, monotone (fun x => k x y)) :
  monotone fun (x : α) => letFun v (k x) := hmono v

theorem monotone_ite
    {α : Sort u} {β : Sort v} [PartialOrder α] [PartialOrder β]
    (c : Prop) [Decidable c]
    (k₁ : α → β) (k₂ : α → β)
    (hmono₁ : monotone k₁) (hmono₂ : monotone k₂) :
  monotone fun x => if c then k₁ x else k₂ x := by
    split
    · apply hmono₁
    · apply hmono₂

theorem monotone_dite
    {α : Sort u} {β : Sort v} [PartialOrder α] [PartialOrder β]
    (c : Prop) [Decidable c]
    (k₁ : α → c → β) (k₂ : α → ¬ c → β)
    (hmono₁ : monotone k₁) (hmono₂ : monotone k₂) :
  monotone fun x => dite c (k₁ x) (k₂ x) := by
    split
    · apply monotone_apply _ _ hmono₁
    · apply monotone_apply _ _ hmono₂

end monotone_lemmas

section prod_order

open PartialOrder

variable {α : Sort u}
variable {β : Sort v}
variable {γ : Sort w}

instance [PartialOrder α] [PartialOrder β] : PartialOrder (α ×' β) where
  rel a b := a.1 ⊑ b.1 ∧ a.2 ⊑ b.2
  rel_refl := ⟨rel_refl, rel_refl⟩
  rel_trans ha hb := ⟨rel_trans ha.1 hb.1, rel_trans ha.2 hb.2⟩
  rel_antisymm := fun {a} {b} ha hb => by
    cases a; cases b;
    dsimp at *
    rw [rel_antisymm ha.1 hb.1, rel_antisymm ha.2 hb.2]

theorem monotone_prod [PartialOrder α] [PartialOrder β] [PartialOrder γ]
    {f : γ → α} {g : γ → β} (hf : monotone f) (hg : monotone g) :
    monotone (fun x => PProd.mk (f x) (g x)) :=
  fun _ _ h12 => ⟨hf _ _ h12, hg _ _ h12⟩

theorem monotone_fst [PartialOrder α] [PartialOrder β] [PartialOrder γ]
    {f : γ → α ×' β} (hf : monotone f) : monotone (fun x => (f x).1) :=
  fun _ _ h12 => (hf _ _ h12).1

theorem monotone_snd [PartialOrder α] [PartialOrder β] [PartialOrder γ]
    {f : γ → α ×' β} (hf : monotone f) : monotone (fun x => (f x).2) :=
  fun _ _ h12 => (hf _ _ h12).2

def chain_fst [CCPO α] [CCPO β] (c : α ×' β → Prop) : α → Prop := (fun a => ∃ b, c ⟨a, b⟩)
def chain_snd [CCPO α] [CCPO β] (c : α ×' β → Prop) : β → Prop := (fun b => ∃ a, c ⟨a, b⟩)

theorem chain.fst [CCPO α] [CCPO β] (c : α ×' β → Prop) (hchain : chain c) :
    chain (chain_fst c) := by
  intro a₁ a₂ ⟨b₁, h₁⟩ ⟨b₂, h₂⟩
  cases hchain ⟨a₁, b₁⟩ ⟨a₂, b₂⟩ h₁ h₂
  case inl h => left; exact h.1
  case inr h => right; exact h.1

theorem chain.snd [CCPO α] [CCPO β] (c : α ×' β → Prop) (hchain : chain c) :
    chain (chain_snd c) := by
  intro b₁ b₂ ⟨a₁, h₁⟩ ⟨a₂, h₂⟩
  cases hchain ⟨a₁, b₁⟩ ⟨a₂, b₂⟩ h₁ h₂
  case inl h => left; exact h.2
  case inr h => right; exact h.2

instance [CCPO α] [CCPO β] : CCPO (α ×' β) where
  csup c := ⟨CCPO.csup (chain_fst c), CCPO.csup (chain_snd c)⟩
  csup_spec := by
    intro ⟨a, b⟩ c hchain
    dsimp
    constructor
    next =>
      intro ⟨h₁, h₂⟩ ⟨a', b'⟩ cab
      dsimp at *
      constructor <;> dsimp
      · apply rel_trans ?_ h₁
        apply le_csup hchain.fst
        exact ⟨b', cab⟩
      · apply rel_trans ?_ h₂
        apply le_csup hchain.snd
        exact ⟨a', cab⟩
    next =>
      intro h
      constructor <;> dsimp
      · apply csup_le hchain.fst
        intro a' ⟨b', hcab⟩
        apply (h _ hcab).1
      · apply csup_le hchain.snd
        intro b' ⟨a', hcab⟩
        apply (h _ hcab).2

end prod_order

section flat_order

variable {α : Sort u}
variable [Nonempty α]

set_option linter.unusedVariables false in
def FlatOrder {α : Sort u} (b : α) := α

variable {b : α}

inductive FlatOrder.rel : (x y : FlatOrder b) → Prop where
  | bot : rel b x
  | refl : rel x x

instance FlatOrder.instOrder : PartialOrder (FlatOrder b) where
  rel := rel
  rel_refl := .refl
  rel_trans {x y z : α} (hxy : rel x y) (hyz : rel y z) := by
    cases hxy <;> cases hyz <;> constructor
  rel_antisymm {x y : α} (hxy : rel x y) (hyz : rel y x) : x = y := by
    cases hxy <;> cases hyz <;> constructor

open Classical in
private theorem Classical.some_spec₂ {α : Sort _} {p : α → Prop} {h : ∃ a, p a} (q : α → Prop)
    (hpq : ∀ a, p a → q a) : q (choose h) := hpq _ <| choose_spec _

noncomputable def flat_csup (c : FlatOrder b → Prop) : FlatOrder b := by
  by_cases h : ∃ (x : FlatOrder b), c x ∧ x ≠ b
  · exact Classical.choose h
  · exact b

noncomputable instance FlatOrder.instCCPO : CCPO (FlatOrder b) where
  csup := flat_csup
  csup_spec := by
    intro x c hc
    unfold flat_csup
    split
    next hex =>
      apply Classical.some_spec₂ (q := (· ⊑ x ↔ (∀ y, c y → y ⊑ x)))
      clear hex
      intro z ⟨hz, hnb⟩
      constructor
      · intro h y hy
        apply PartialOrder.rel_trans _ h; clear h
        cases hc y z hy hz
        next => assumption
        next h =>
          cases h
          · contradiction
          · constructor
      · intro h
        cases h z hz
        · contradiction
        · constructor
    next hnotex =>
      constructor
      · intro h y hy; clear h
        suffices y = b by rw [this]; exact rel.bot
        rw [not_exists] at hnotex
        specialize hnotex y
        rw [not_and] at hnotex
        specialize hnotex hy
        rw [@Classical.not_not] at hnotex
        assumption
      · intro; exact rel.bot

noncomputable
abbrev TailrecOrder α [Nonempty α] := FlatOrder (@Classical.ofNonempty α _)

end flat_order

section mono_bind

class MonoBind (m : Type u → Type v) [Bind m] [∀ α, PartialOrder (m α)] where
  bind_mono_left (a₁ a₂ : m α) (f : α → m b) (h : a₁ ⊑ a₂) : a₁ >>= f ⊑ a₂ >>= f
  bind_mono_right (a : m α) (f₁ f₂ : α → m b) (h : ∀ x, f₁ x ⊑ f₂ x) : a >>= f₁ ⊑ a >>= f₂

theorem monotone_bind
    (m : Type u → Type v) [Bind m] [∀ α, PartialOrder (m α)] [MonoBind m]
    {α β : Type u}
    {γ : Type w} [PartialOrder γ]
    (f : γ → m α) (g : γ → α → m β)
    (hmono₁ : monotone f)
    (hmono₂ : monotone g) :
    monotone (fun (x : γ) => f x >>= g x) := by
  intro x₁ x₂ hx₁₂
  apply PartialOrder.rel_trans
  · apply MonoBind.bind_mono_left _ _ _ (hmono₁ _ _ hx₁₂)
  · apply MonoBind.bind_mono_right _ _ _ (fun y => monotone_apply y _ hmono₂ _ _ hx₁₂)

instance : PartialOrder (Option α) := inferInstanceAs (PartialOrder (FlatOrder none))
noncomputable instance : CCPO (Option α) := inferInstanceAs (CCPO (FlatOrder none))
noncomputable instance : MonoBind Option where
  bind_mono_left _ _ _ h := by
    cases h
    · exact FlatOrder.rel.bot
    · exact FlatOrder.rel.refl
  bind_mono_right a _ _ h := by
    cases a
    · exact FlatOrder.rel.refl
    · exact h _

instance [Monad m] [inst : ∀ α, PartialOrder (m α)] : PartialOrder (ExceptT ε m α) := inst _
instance [Monad m] [∀ α, PartialOrder (m α)] [inst : ∀ α, CCPO (m α)] : CCPO (ExceptT ε m α) := inst _
instance [Monad m] [∀ α, PartialOrder (m α)] [∀ α, CCPO (m α)] [MonoBind m] : MonoBind (ExceptT ε m) where
  bind_mono_left a₁ a₂ f h₁₂ := by
    apply MonoBind.bind_mono_left (m := m)
    exact h₁₂
  bind_mono_right a₁ a₂ f h₁₂ := by
    apply MonoBind.bind_mono_right (m := m)
    intro x
    cases x
    · apply PartialOrder.rel_refl
    · apply h₁₂

end mono_bind



namespace Example

def findF (P : Nat → Bool) (rec : Nat → Option Nat) (x : Nat) : Option Nat :=
  if P x then
    some x
  else
    rec (x + 1)

noncomputable def find (P : Nat → Bool) : Nat → Option Nat := fix (α := _ → TailrecOrder _) (findF P) <| by
  unfold findF
  apply monotone_of_monotone_apply (β := fun _ => TailrecOrder _)
  intro n
  split
  · apply monotone_const
  · apply monotone_apply
    apply monotone_id

theorem find_eq : find P = findF P (find P) := fix_eq (α := _ → TailrecOrder _) ..

end Example

end Lean.Order
