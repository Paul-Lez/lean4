/-
Copyright (c) 2024 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Markus Himmel
-/
prelude
import Std.Classes.BEq
import Std.Init.All
import Std.Data.DHashMap.Internal.List.Pairwise

set_option autoImplicit false

universe u v w

variable {α : Type u} {β : α → Type v} {γ : α → Type w}

namespace Std.DHashMap.Internal.List

@[elab_as_elim]
theorem assoc_induction {motive : List (Σ a, β a) → Prop} (nil : motive [])
    (cons : (k : α) → (v : β k) → (tail : List (Σ a, β a)) → motive tail → motive (⟨k, v⟩ :: tail)) :
    (t : List (Σ a, β a)) → motive t
  | [] => nil
  | ⟨_, _⟩ :: _ => cons _ _ _ (assoc_induction nil cons _)

def getEntry? [BEq α] (a : α) : List (Σ a, β a) → Option (Σ a, β a)
  | [] => none
  | ⟨k, v⟩ :: l => bif a == k then some ⟨k, v⟩ else getEntry? a l

@[simp] theorem getEntry?_nil [BEq α] {a : α} : getEntry? a ([] : List (Σ a, β a)) = none := rfl
theorem getEntry?_cons [BEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} :
    getEntry? a (⟨k, v⟩ :: l) = bif a == k then some ⟨k, v⟩ else getEntry? a l := rfl

theorem getEntry?_cons_of_true [BEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} (h : a == k) :
    getEntry? a (⟨k, v⟩ :: l) = some ⟨k, v⟩ := by
  simp [getEntry?, h]

theorem getEntry?_cons_of_false [BEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} (h : (a == k) = false) :
    getEntry? a (⟨k, v⟩ :: l) = getEntry? a l := by
  simp [getEntry?, h]

@[simp]
theorem getEntry?_cons_self [BEq α] [ReflBEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    getEntry? k (⟨k, v⟩ :: l) = some ⟨k, v⟩ :=
  getEntry?_cons_of_true BEq.refl

theorem getEntry?_eq_some [BEq α] {l : List (Σ a, β a)} {a : α} {p : Σ a, β a}
    (h : getEntry? a l = some p) : a == p.1 := by
  induction l using assoc_induction
  · simp at h
  · next k' v' t ih =>
    cases h' : a == k'
    · rw [getEntry?_cons_of_false h'] at h
      exact ih h
    · rw [getEntry?_cons_of_true h', Option.some.injEq] at h
      obtain rfl := congrArg Sigma.fst h
      exact h'

theorem getEntry?_congr [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {a b : α} (h : a == b) :
    getEntry? a l = getEntry? b l := by
  induction l using assoc_induction
  · simp
  · next k v l ih =>
    cases h' : b == k
    · have h₂ : (a == k) = false := BEq.neq_of_beq_of_neq h h'
      rw [getEntry?_cons_of_false h', getEntry?_cons_of_false h₂, ih]
    · rw [getEntry?_cons_of_true h', getEntry?_cons_of_true (BEq.trans h h')]

theorem isEmpty_eq_false_iff_exists_isSome_getEntry? [BEq α] [ReflBEq α] : {l : List (Σ a, β a)} →
    l.isEmpty = false ↔ ∃ a, (getEntry? a l).isSome
  | [] => by simp
  | (⟨k, v⟩::l) => by simpa using ⟨k, by simp⟩

section

variable {β : Type v}

def getValue? [BEq α] (a : α) : List ((_ : α) × β) → Option β
  | [] => none
  | ⟨k, v⟩ :: l => bif a == k then some v else getValue? a l

@[simp] theorem getValue?_nil [BEq α] {a : α} : getValue? a ([] : List ((_ : α) × β)) = none := rfl
theorem getValue?_cons [BEq α] {l : List ((_ : α) × β)} {k a : α} {v : β} :
    getValue? a (⟨k, v⟩ :: l) = bif a == k then some v else getValue? a l := rfl

theorem getValue?_cons_of_true [BEq α] {l : List ((_ : α) × β)} {k a : α} {v : β} (h : a == k) :
    getValue? a (⟨k, v⟩ :: l) = some v := by
  simp [getValue?, h]

theorem getValue?_cons_of_false [BEq α] {l : List ((_ : α) × β)} {k a : α} {v : β} (h : (a == k) = false) :
    getValue? a (⟨k, v⟩ :: l) = getValue? a l := by
  simp [getValue?, h]

@[simp]
theorem getValue?_cons_self [BEq α] [ReflBEq α] {l : List ((_ : α) × β)} {k : α} {v : β} :
    getValue? k (⟨k, v⟩ :: l) = some v :=
  getValue?_cons_of_true BEq.refl

theorem getValue?_eq_getEntry? [BEq α] {l : List ((_ : α) × β)} {a : α} :
    getValue? a l = (getEntry? a l).map (·.2) := by
  induction l using assoc_induction
  · simp
  · next k v l ih =>
    cases h : a == k
    · rw [getEntry?_cons_of_false h, getValue?_cons_of_false h, ih]
    · rw [getEntry?_cons_of_true h, getValue?_cons_of_true h, Option.map_some']

theorem getValue?_congr [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {a b : α} (h : a == b) :
    getValue? a l = getValue? b l := by
  simp [getValue?_eq_getEntry?, getEntry?_congr h]

theorem isEmpty_eq_false_iff_exists_isSome_getValue? [BEq α] [ReflBEq α] {l : List ((_ : α) × β)} :
    l.isEmpty = false ↔ ∃ a, (getValue? a l).isSome := by
  simp [isEmpty_eq_false_iff_exists_isSome_getEntry?, getValue?_eq_getEntry?]

end

def getValueCast? [BEq α] [LawfulBEq α] (a : α) : List (Σ a, β a) → Option (β a)
  | [] => none
  | ⟨k, v⟩ :: l => if h : a == k then some (cast (congrArg β (eq_of_beq h).symm) v) else getValueCast? a l

@[simp] theorem getValueCast?_nil [BEq α] [LawfulBEq α] {a : α} :
    getValueCast? a ([] : List (Σ a, β a)) = none := rfl
theorem getValueCast?_cons [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} :
    getValueCast? a (⟨k, v⟩ :: l) = if h : a == k then some (cast (congrArg β (eq_of_beq h).symm) v) else getValueCast? a l := rfl

theorem getValueCast?_cons_of_true [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} (h : a == k) :
    getValueCast? a (⟨k, v⟩ :: l) = some (cast (congrArg β (eq_of_beq h).symm) v) := by
  simp [getValueCast?, h]

theorem getValueCast?_cons_of_false [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k}
    (h : (a == k) = false) : getValueCast? a (⟨k, v⟩ :: l) = getValueCast? a l := by
  simp [getValueCast?, h]

@[simp]
theorem getValueCast?_cons_self [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    getValueCast? k (⟨k, v⟩ :: l) = some v := by
  rw [getValueCast?_cons_of_true BEq.refl, cast_eq]

theorem getValue?_eq_getValueCast? [BEq α] [LawfulBEq α] {β : Type v} {l : List ((_ : α) × β)} {a : α} :
    getValue? a l = getValueCast? a l := by
  induction l using assoc_induction <;> simp_all [getValueCast?_cons, getValue?_cons]

section

variable {β : Type v}

/--
This is a strange dependent version of `Option.map` in which the mapping function is allowed to "know" about the
option that is being mapped. This happens to be useful in this file (see `getValueCast_eq_getEntry?`), but we do
not want it to leak out of the file.
-/
private def Option.dmap : (o : Option α) → (f : (a : α) → (o = some a) → β) → Option β
  | none, _ => none
  | some a, f => some (f a rfl)

@[simp] private theorem Option.dmap_none (f : (a : α) → (none = some a) → β) : Option.dmap none f = none := rfl

@[simp] private theorem Option.dmap_some (a : α) (f : (a' : α) → (some a = some a') → β) :
    Option.dmap (some a) f = some (f a rfl) := rfl

private theorem Option.dmap_congr {o o' : Option α} {f : (a : α) → (o = some a) → β} (h : o = o') :
    Option.dmap o f = Option.dmap o' (fun a h' => f a (h ▸ h')) := by
  cases h; rfl

@[simp]
private theorem Option.isSome_dmap {o : Option α} {f : (a : α) → (o = some a) → β} :
    (Option.dmap o f).isSome = o.isSome := by
  cases o <;> rfl

end

theorem getValueCast?_eq_getEntry? [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a : α} :
    getValueCast? a l = Option.dmap (getEntry? a l) (fun p h => cast (congrArg β (eq_of_beq (getEntry?_eq_some h)).symm) p.2) := by
  induction l using assoc_induction
  · simp
  · next k v t ih =>
    cases h : a == k
    · rw [getValueCast?_cons_of_false h, ih, Option.dmap_congr (getEntry?_cons_of_false h)]
    · rw [getValueCast?_cons_of_true h, Option.dmap_congr (getEntry?_cons_of_true h), Option.dmap_some]

theorem isSome_getValueCast?_eq_isSome_getEntry? [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a : α} :
    (getValueCast? a l).isSome = (getEntry? a l).isSome := by
  rw [getValueCast?_eq_getEntry?, Option.isSome_dmap]

theorem isEmpty_eq_false_iff_exists_isSome_getValueCast? [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} :
    l.isEmpty = false ↔ ∃ a, (getValueCast? a l).isSome := by
  simp [isEmpty_eq_false_iff_exists_isSome_getEntry?, isSome_getValueCast?_eq_isSome_getEntry?]

def containsKey [BEq α] (a : α) : List (Σ a, β a) → Bool
  | [] => false
  | ⟨k, _⟩ :: l => a == k || containsKey a l

@[simp] theorem containsKey_nil [BEq α] {a : α} : containsKey a ([] : List (Σ a, β a)) = false := rfl
@[simp] theorem containsKey_cons [BEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} :
    containsKey a (⟨k, v⟩ :: l) = (a == k || containsKey a l) := rfl

theorem containsKey_cons_eq_false [BEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} :
    (containsKey a (⟨k, v⟩ :: l) = false) ↔ ((a == k) = false) ∧ (containsKey a l = false) := by
  simp [containsKey_cons, not_or]

theorem containsKey_cons_eq_true [BEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} :
    (containsKey a (⟨k, v⟩ :: l)) ↔ (a == k) ∨ (containsKey a l) := by
  simp [containsKey_cons]

theorem containsKey_cons_of_beq [BEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} (h : a == k) :
    containsKey a (⟨k, v⟩ :: l) := containsKey_cons_eq_true.2 <| Or.inl h

@[simp]
theorem containsKey_cons_self [BEq α] [ReflBEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    containsKey k (⟨k, v⟩ :: l) := containsKey_cons_of_beq BEq.refl

theorem containsKey_cons_of_containsKey [BEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} (h : containsKey a l) :
    containsKey a (⟨k, v⟩ :: l) := containsKey_cons_eq_true.2 <| Or.inr h

theorem containsKey_of_containsKey_cons [BEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} (h₁ : containsKey a (⟨k, v⟩ :: l))
    (h₂ : (a == k) = false) : containsKey a l := by
  rcases (containsKey_cons_eq_true.1 h₁) with (h|h)
  · exact False.elim (Bool.eq_false_iff.1 h₂ h)
  · exact h

theorem containsKey_eq_isSome_getEntry? [BEq α] {l : List (Σ a, β a)} {a : α} :
    containsKey a l = (getEntry? a l).isSome := by
  induction l using assoc_induction
  · simp
  · next k v l ih =>
    cases h : a == k
    · simp [getEntry?_cons_of_false h, h, ih]
    · simp [getEntry?_cons_of_true h, h]

theorem isEmpty_eq_false_of_containsKey [BEq α] {l : List (Σ a, β a)} {a : α} (h : containsKey a l = true) :
    l.isEmpty = false := by
  cases l <;> simp_all

theorem isEmpty_eq_false_iff_exists_containsKey [BEq α] [ReflBEq α] {l : List (Σ a, β a)} :
    l.isEmpty = false ↔ ∃ a, containsKey a l := by
  simp [isEmpty_eq_false_iff_exists_isSome_getEntry?, containsKey_eq_isSome_getEntry?]

@[simp]
theorem getEntry?_eq_none [BEq α] {l : List (Σ a, β a)} {a : α} :
    getEntry? a l = none ↔ containsKey a l = false := by
  rw [← Option.not_isSome_iff_eq_none, Bool.not_eq_true, ← containsKey_eq_isSome_getEntry?]

@[simp]
theorem getValue?_eq_none {β : Type v} [BEq α] {l : List ((_ : α) × β)} {a : α} :
    getValue? a l = none ↔ containsKey a l = false := by
  rw [getValue?_eq_getEntry?, Option.map_eq_none', getEntry?_eq_none]

theorem containsKey_eq_isSome_getValue? {β : Type v} [BEq α] {l : List ((_ : α) × β)} {a : α} :
    containsKey a l = (getValue? a l).isSome := by
  simp [containsKey_eq_isSome_getEntry?, getValue?_eq_getEntry?]

theorem containsKey_eq_isSome_getValueCast? [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a : α} :
    containsKey a l = (getValueCast? a l).isSome := by
  simp [containsKey_eq_isSome_getEntry?, getValueCast?_eq_getEntry?]

theorem getValueCast?_eq_none [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a : α}
    (h : containsKey a l = false) : getValueCast? a l = none := by
  rwa [← Option.not_isSome_iff_eq_none, ← containsKey_eq_isSome_getValueCast?, Bool.not_eq_true]

theorem containsKey_congr [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {a b : α} (h : a == b) :
    containsKey a l = containsKey b l := by
  simp [containsKey_eq_isSome_getEntry?, getEntry?_congr h]

theorem containsKey_of_beq [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {a b : α} (hla : containsKey a l) (hab : a == b) :
    containsKey b l := by
  rwa [← containsKey_congr hab]

def getEntry [BEq α] (a : α) (l : List (Σ a, β a)) (h : containsKey a l) : Σ a, β a :=
  (getEntry? a l).get <| containsKey_eq_isSome_getEntry?.symm.trans h

theorem getEntry?_eq_some_getEntry [BEq α] {l : List (Σ a, β a)} {a : α} (h : containsKey a l) :
    getEntry? a l = some (getEntry a l h) := by
  simp [getEntry]

theorem getEntry_eq_of_getEntry?_eq_some [BEq α] {l : List (Σ a, β a)} {k a : α} {v : β k}
    (h : getEntry? a l = some ⟨k, v⟩) {h'} : getEntry a l h' = ⟨k, v⟩ := by
  simp [getEntry, h]

theorem getEntry_cons_of_beq [BEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} (h : a == k) :
    getEntry a (⟨k, v⟩ :: l) (containsKey_cons_of_beq (v := v) h) = ⟨k, v⟩ := by
  simp [getEntry, getEntry?_cons_of_true h]

@[simp]
theorem getEntry_cons_self [BEq α] [ReflBEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    getEntry k (⟨k, v⟩ :: l) containsKey_cons_self = ⟨k, v⟩ :=
  getEntry_cons_of_beq BEq.refl

theorem getEntry_cons_of_false [BEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} {h₁ : containsKey a (⟨k, v⟩ :: l)}
    (h₂ : (a == k) = false) :
    getEntry a (⟨k, v⟩ :: l) h₁ = getEntry a l (containsKey_of_containsKey_cons (v := v) h₁ h₂) := by
  simp [getEntry, getEntry?_cons_of_false h₂]

section

variable {β : Type v}

def getValue [BEq α] (a : α) (l : List ((_ : α) × β)) (h : containsKey a l) : β :=
  (getValue? a l).get <| containsKey_eq_isSome_getValue?.symm.trans h

theorem getValue?_eq_some_getValue [BEq α] {l : List ((_ : α) × β)} {a : α} (h : containsKey a l) :
    getValue? a l = some (getValue a l h) := by
  simp [getValue]

theorem getValue_cons_of_beq [BEq α] {l : List ((_ : α) × β)} {k a : α} {v : β} (h : a == k) :
    getValue a (⟨k, v⟩ :: l) (containsKey_cons_of_beq (k := k) (v := v) h) = v := by
  simp [getValue, getValue?_cons_of_true h]

@[simp]
theorem getValue_cons_self [BEq α] [ReflBEq α] {l : List ((_ : α) × β)} {k : α} {v : β} :
    getValue k (⟨k, v⟩ :: l) containsKey_cons_self = v :=
  getValue_cons_of_beq BEq.refl

theorem getValue_cons_of_false [BEq α] {l : List ((_ : α) × β)} {k a : α} {v : β} {h₁ : containsKey a (⟨k, v⟩ :: l)}
    (h₂ : (a == k) = false) : getValue a (⟨k, v⟩ :: l) h₁ = getValue a l (containsKey_of_containsKey_cons (k := k) (v := v) h₁ h₂) := by
  simp [getValue, getValue?_cons_of_false h₂]

theorem getValue_cons [BEq α] {l : List ((_ : α) × β)} {k a : α} {v : β} {h} :
    getValue a (⟨k, v⟩ :: l) h = if h' : a == k then v else getValue a l (containsKey_of_containsKey_cons (k := k) h (Bool.eq_false_iff.2 h')) := by
  rw [← Option.some_inj, ← getValue?_eq_some_getValue, getValue?_cons, apply_dite Option.some, cond_eq_if]
  split
  · rfl
  · exact getValue?_eq_some_getValue _

theorem getValue_congr [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {a b : α} (hab : a == b) {h} :
    getValue a l h = getValue b l ((containsKey_congr hab).symm.trans h) := by
  rw [← Option.some_inj, ← getValue?_eq_some_getValue, ← getValue?_eq_some_getValue, getValue?_congr hab]

end

def getValueCast [BEq α] [LawfulBEq α] (a : α) (l : List (Σ a, β a)) (h : containsKey a l) : β a :=
  (getValueCast? a l).get <| containsKey_eq_isSome_getValueCast?.symm.trans h

theorem getValueCast?_eq_some_getValueCast [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a : α} (h : containsKey a l) :
    getValueCast? a l = some (getValueCast a l h) := by
  simp [getValueCast]

theorem Option.get_congr {o o' : Option α} {ho : o.isSome} (h : o = o') : o.get ho = o'.get (h ▸ ho) := by
  cases h; rfl

theorem getValueCast_cons [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k}
    (h : containsKey a (⟨k, v⟩ :: l)) :
    getValueCast a (⟨k, v⟩ :: l) h =
      if h' : a == k then
        cast (congrArg β (eq_of_beq h').symm) v
      else
        getValueCast a l (containsKey_of_containsKey_cons (k := k) h (Bool.eq_false_iff.2 h')) := by
  rw [getValueCast, Option.get_congr getValueCast?_cons]
  split <;> simp [getValueCast]

theorem getValue_eq_getValueCast {β : Type v} [BEq α] [LawfulBEq α] {l : List ((_ : α) × β)} {a : α} {h} :
    getValue a l h = getValueCast a l h := by
  induction l using assoc_induction
  · simp at h
  · simp_all [getValue_cons, getValueCast_cons]

def getValueCastD [BEq α] [LawfulBEq α] (a : α) (l : List (Σ a, β a)) (fallback : β a) : β a :=
  (getValueCast? a l).getD fallback

@[simp]
theorem getValueCastD_nil [BEq α] [LawfulBEq α] {a : α} {fallback : β a} : getValueCastD a ([] : List (Σ a, β a)) fallback = fallback := rfl

theorem getValueCastD_eq_getValueCast? [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a : α} {fallback : β a} :
    getValueCastD a l fallback = (getValueCast? a l).getD fallback := rfl

theorem getValueCastD_eq_fallback [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a : α} {fallback : β a}
    (h : containsKey a l = false) : getValueCastD a l fallback = fallback := by
  rw [containsKey_eq_isSome_getValueCast?, Bool.eq_false_iff, ne_eq, Option.not_isSome_iff_eq_none] at h
  rw [getValueCastD_eq_getValueCast?, h, Option.getD_none]

theorem getValueCast_eq_getValueCastD [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a : α} {fallback : β a}
    (h : containsKey a l = true) : getValueCast a l h = getValueCastD a l fallback := by
  rw [getValueCastD_eq_getValueCast?, getValueCast, Option.get_eq_getD]

theorem getValueCast?_eq_some_getValueCastD [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a : α} {fallback : β a}
    (h : containsKey a l = true) : getValueCast? a l = some (getValueCastD a l fallback) := by
  rw [getValueCast?_eq_some_getValueCast h, getValueCast_eq_getValueCastD]

def getValueCast! [BEq α] [LawfulBEq α] (a : α) [Inhabited (β a)] (l : List (Σ a, β a)) : β a :=
  (getValueCast? a l).get!

@[simp]
theorem getValueCast!_nil [BEq α] [LawfulBEq α] {a : α} [Inhabited (β a)] : getValueCast! a ([] : List (Σ a, β a)) = default := rfl

theorem getValueCast!_eq_getValueCast? [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a : α} [Inhabited (β a)] :
    getValueCast! a l = (getValueCast? a l).get! := rfl

theorem getValueCast!_eq_default [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a : α} [Inhabited (β a)]
    (h : containsKey a l = false) : getValueCast! a l = default := by
  rw [containsKey_eq_isSome_getValueCast?, Bool.eq_false_iff, ne_eq, Option.not_isSome_iff_eq_none] at h
  rw [getValueCast!_eq_getValueCast?, h, Option.get!_none]

theorem getValueCast_eq_getValueCast! [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a : α} [Inhabited (β a)]
    (h : containsKey a l = true) : getValueCast a l h = getValueCast! a l := by
  rw [getValueCast!_eq_getValueCast?, getValueCast, Option.get_eq_get!]

theorem getValueCast?_eq_some_getValueCast! [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a : α} [Inhabited (β a)]
    (h : containsKey a l = true) : getValueCast? a l = some (getValueCast! a l) := by
  rw [getValueCast?_eq_some_getValueCast h, getValueCast_eq_getValueCast!]

theorem getValueCast!_eq_getValueCastD_default [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a : α} [Inhabited (β a)] :
    getValueCast! a l = getValueCastD a l default := rfl

section

variable {β : Type v}

def getValueD [BEq α] (a : α) (l : List ((_ : α) × β)) (fallback : β) : β :=
  (getValue? a l).getD fallback

@[simp]
theorem getValueD_nil [BEq α] {a : α} {fallback : β} : getValueD a ([] : List ((_ : α) × β)) fallback = fallback := rfl

theorem getValueD_eq_getValue? [BEq α] {l : List ((_ : α) × β)} {a : α} {fallback : β} :
    getValueD a l fallback = (getValue? a l).getD fallback := rfl

theorem getValueD_eq_fallback [BEq α] {l : List ((_ : α) × β)} {a : α} {fallback : β}
    (h : containsKey a l = false) : getValueD a l fallback = fallback := by
  rw [containsKey_eq_isSome_getValue?, Bool.eq_false_iff, ne_eq, Option.not_isSome_iff_eq_none] at h
  rw [getValueD_eq_getValue?, h, Option.getD_none]

theorem getValue_eq_getValueD [BEq α] {l : List ((_ : α) × β)} {a : α} {fallback : β}
    (h : containsKey a l = true) : getValue a l h = getValueD a l fallback := by
  rw [getValueD_eq_getValue?, getValue, Option.get_eq_getD]

theorem getValue?_eq_some_getValueD [BEq α] {l : List ((_ : α) × β)} {a : α} {fallback : β}
    (h : containsKey a l = true) : getValue? a l = some (getValueD a l fallback) := by
  rw [getValue?_eq_some_getValue h, getValue_eq_getValueD]

theorem getValueD_eq_getValueCastD [BEq α] [LawfulBEq α] {l : List ((_ : α) × β)} {a : α} {fallback : β} :
    getValueD a l fallback = getValueCastD a l fallback := by
  simp only [getValueD_eq_getValue?, getValueCastD_eq_getValueCast?, getValue?_eq_getValueCast?]

theorem getValueD_congr [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {a b : α} {fallback : β} (hab : a == b) :
    getValueD a l fallback = getValueD b l fallback := by
  simp only [getValueD_eq_getValue?, getValue?_congr hab]

def getValue! [BEq α] [Inhabited β] (a : α) (l : List ((_ : α) × β)) : β :=
  (getValue? a l).get!

@[simp]
theorem getValue!_nil [BEq α] [Inhabited β] {a : α} : getValue! a ([] : List ((_ : α) × β)) = default := rfl

theorem getValue!_eq_getValue? [BEq α] [Inhabited β] {l : List ((_ : α) × β)} {a : α} :
    getValue! a l = (getValue? a l).get! := rfl

theorem getValue!_eq_default [BEq α] [Inhabited β] {l : List ((_ : α) × β)} {a : α}
    (h : containsKey a l = false) : getValue! a l = default := by
  rw [containsKey_eq_isSome_getValue?, Bool.eq_false_iff, ne_eq, Option.not_isSome_iff_eq_none] at h
  rw [getValue!_eq_getValue?, h, Option.get!_none]

theorem getValue_eq_getValue! [BEq α] [Inhabited β] {l : List ((_ : α) × β)} {a : α}
    (h : containsKey a l = true) : getValue a l h = getValue! a l := by
  rw [getValue!_eq_getValue?, getValue, Option.get_eq_get!]

theorem getValue?_eq_some_getValue! [BEq α] [Inhabited β] {l : List ((_ : α) × β)} {a : α}
    (h : containsKey a l = true) : getValue? a l = some (getValue! a l) := by
  rw [getValue?_eq_some_getValue h, getValue_eq_getValue!]

theorem getValue!_eq_getValueCast! [BEq α] [LawfulBEq α] [Inhabited β] {l : List ((_ : α) × β)} {a : α} :
    getValue! a l = getValueCast! a l := by
  simp only [getValue!_eq_getValue?, getValueCast!_eq_getValueCast?, getValue?_eq_getValueCast?]

theorem getValue!_congr [BEq α] [PartialEquivBEq α] [Inhabited β] {l : List ((_ : α) × β)} {a b : α} (hab : a == b) :
    getValue! a l = getValue! b l := by
  simp only [getValue!_eq_getValue?, getValue?_congr hab]

theorem getValue!_eq_getValueD_default [BEq α] [Inhabited β] {l : List ((_ : α) × β)} {a : α} :
    getValue! a l = getValueD a l default := rfl

end

def replaceEntry [BEq α] (k : α) (v : β k) : List (Σ a, β a) → List (Σ a, β a)
  | [] => []
  | ⟨k', v'⟩ :: l => bif k == k' then ⟨k, v⟩ :: l else ⟨k', v'⟩ :: replaceEntry k v l

@[simp] theorem replaceEntry_nil [BEq α] {k : α} {v : β k} : replaceEntry k v [] = [] := rfl
theorem replaceEntry_cons [BEq α] {l : List (Σ a, β a)} {k k' : α} {v : β k} {v' : β k'} :
    replaceEntry k v (⟨k', v'⟩ :: l) = bif k == k' then ⟨k, v⟩ :: l else ⟨k', v'⟩ :: replaceEntry k v l := rfl

theorem replaceEntry_cons_of_true [BEq α] {l : List (Σ a, β a)} {k k' : α} {v : β k} {v' : β k'} (h : k == k') :
    replaceEntry k v (⟨k', v'⟩ :: l) = ⟨k, v⟩ :: l := by
  simp [replaceEntry, h]

theorem replaceEntry_cons_of_false [BEq α] {l : List (Σ a, β a)} {k k' : α} {v : β k} {v' : β k'} (h : (k == k') = false) :
    replaceEntry k v (⟨k', v'⟩ :: l) = ⟨k', v'⟩ :: replaceEntry k v l := by
  simp [replaceEntry, h]

theorem replaceEntry_of_containsKey_eq_false [BEq α] {l : List (Σ a, β a)} {k : α} {v : β k} (h : containsKey k l = false) :
    replaceEntry k v l = l := by
  induction l
  · simp
  · next k v l ih =>
    rw [containsKey_cons_eq_false] at h
    rw [replaceEntry_cons_of_false h.1, ih h.2]

@[simp]
theorem isEmpty_replaceEntry [BEq α] {l : List (Σ a, β a)} {k : α} {v : β k} : (replaceEntry k v l).isEmpty = l.isEmpty := by
  induction l using assoc_induction
  · simp
  · simp [replaceEntry_cons, cond_eq_if]
    split <;> simp

theorem getEntry?_replaceEntry_of_containsKey_eq_false [BEq α] {l : List (Σ a, β a)} {a k : α} {v : β k}
    (hl : containsKey k l = false) : getEntry? a (replaceEntry k v l) = getEntry? a l := by
  rw [replaceEntry_of_containsKey_eq_false hl]

theorem getEntry?_replaceEntry_of_false [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {a k : α} {v : β k}
    (h : (a == k) = false) : getEntry? a (replaceEntry k v l) = getEntry? a l := by
  induction l using assoc_induction
  · simp
  · next k' v' l ih =>
    cases h' : k == k'
    · rw [replaceEntry_cons_of_false h', getEntry?_cons, getEntry?_cons, ih]
    · rw [replaceEntry_cons_of_true h']
      have hk : (a == k') = false := BEq.neq_of_neq_of_beq h h'
      simp [getEntry?_cons_of_false h, getEntry?_cons_of_false hk]

theorem getEntry?_replaceEntry_of_true [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {a k : α} {v : β k} (hl : containsKey k l = true)
    (h : a == k) : getEntry? a (replaceEntry k v l) = some ⟨k, v⟩ := by
  induction l using assoc_induction
  · simp at hl
  · next k' v' l ih =>
    cases hk'a : k == k'
    · rw [replaceEntry_cons_of_false hk'a]
      have hk'k : (a == k') = false := BEq.neq_of_beq_of_neq h hk'a
      rw [getEntry?_cons_of_false hk'k]
      exact ih (containsKey_of_containsKey_cons hl hk'a)
    · rw [replaceEntry_cons_of_true hk'a, getEntry?_cons_of_true h]

theorem getEntry?_replaceEntry [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {a k : α} {v : β k} :
    getEntry? a (replaceEntry k v l) = bif containsKey k l && a == k then some ⟨k, v⟩ else
      getEntry? a l := by
  cases hl : containsKey k l
  · simp [getEntry?_replaceEntry_of_containsKey_eq_false hl]
  · cases h : a == k
    · simp [getEntry?_replaceEntry_of_false h]
    · simp [getEntry?_replaceEntry_of_true hl h]

@[simp]
theorem length_replaceEntry [BEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    (replaceEntry k v l).length = l.length := by
  induction l using assoc_induction <;> simp_all [replaceEntry_cons, apply_bif List.length]

section

variable {β : Type v}

theorem getValue?_replaceEntry_of_containsKey_eq_false [BEq α] {l : List ((_ : α) × β)} {k a : α} {v : β}
    (hl : containsKey k l = false) : getValue? a (replaceEntry k v l) = getValue? a l := by
  simp [getValue?_eq_getEntry?, getEntry?_replaceEntry_of_containsKey_eq_false hl]

theorem getValue?_replaceEntry_of_false [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α} {v : β}
    (h : (a == k) = false) : getValue? a (replaceEntry k v l) = getValue? a l := by
  simp [getValue?_eq_getEntry?, getEntry?_replaceEntry_of_false h]

theorem getValue?_replaceEntry_of_true [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α} {v : β}
    (hl : containsKey k l = true) (h : a == k) : getValue? a (replaceEntry k v l) = some v := by
  simp [getValue?_eq_getEntry?, getEntry?_replaceEntry_of_true hl h]

end

theorem getValueCast?_replaceEntry [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {a k : α} {v : β k} :
    getValueCast? a (replaceEntry k v l) =
      if h : containsKey k l ∧ a == k then some (cast (congrArg β (eq_of_beq h.2).symm) v) else getValueCast? a l := by
  rw [getValueCast?_eq_getEntry?]
  split
  · next h =>
    rw [Option.dmap_congr (getEntry?_replaceEntry_of_true h.1 h.2), Option.dmap_some]
  · next h =>
    simp only [Decidable.not_and_iff_or_not_not] at h
    rcases h with h|h
    · rw [Option.dmap_congr (getEntry?_replaceEntry_of_containsKey_eq_false (Bool.eq_false_iff.2 h)),
        getValueCast?_eq_getEntry?]
    · rw [Option.dmap_congr (getEntry?_replaceEntry_of_false (Bool.eq_false_iff.2 h)),
        getValueCast?_eq_getEntry?]

@[simp]
theorem containsKey_replaceEntry [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {a k : α} {v : β k} :
    containsKey a (replaceEntry k v l) = containsKey a l := by
  cases h : containsKey k l && a == k
  · rw [containsKey_eq_isSome_getEntry?, getEntry?_replaceEntry, h, cond_false, containsKey_eq_isSome_getEntry?]
  · rw [containsKey_eq_isSome_getEntry?, getEntry?_replaceEntry, h, cond_true, Option.isSome_some, Eq.comm]
    rw [Bool.and_eq_true] at h
    exact containsKey_of_beq h.1 (BEq.symm h.2)

def removeKey [BEq α] (k : α) : List (Σ a, β a) → List (Σ a, β a)
  | [] => []
  | ⟨k', v'⟩ :: l => bif k == k' then l else ⟨k', v'⟩ :: removeKey k l

@[simp] theorem removeKey_nil [BEq α] {k : α} : removeKey k ([] : List (Σ a, β a)) = [] := rfl
theorem removeKey_cons [BEq α] {l : List (Σ a, β a)} {k k' : α} {v' : β k'} :
    removeKey k (⟨k', v'⟩ :: l) = bif k == k' then l else ⟨k', v'⟩ :: removeKey k l := rfl

theorem removeKey_cons_of_beq [BEq α] {l : List (Σ a, β a)} {k k' : α} {v' : β k'} (h : k == k') :
    removeKey k (⟨k', v'⟩ :: l) = l :=
  by simp [removeKey_cons, h]

@[simp]
theorem removeKey_cons_self [BEq α] [ReflBEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    removeKey k (⟨k, v⟩ :: l) = l :=
  removeKey_cons_of_beq BEq.refl

theorem removeKey_cons_of_false [BEq α] {l : List (Σ a, β a)} {k k' : α} {v' : β k'} (h : (k == k') = false) :
    removeKey k (⟨k', v'⟩ :: l) = ⟨k', v'⟩ :: removeKey k l := by
  simp [removeKey_cons, h]

theorem removeKey_of_containsKey_eq_false [BEq α] {l : List (Σ a, β a)} {k : α} (h : containsKey k l = false) :
    removeKey k l = l := by
  induction l using assoc_induction
  · simp
  · next k' v' t ih =>
    simp only [containsKey_cons, Bool.or_eq_false_iff] at h
    rw [removeKey_cons_of_false h.1, ih h.2]

theorem sublist_removeKey [BEq α] {l : List (Σ a, β a)} {k : α} : Sublist (removeKey k l) l := by
  induction l using assoc_induction
  · simp
  · next k' v' t ih =>
    rw [removeKey_cons]
    cases k == k'
    · simpa
    · simpa using Sublist.cons_right Sublist.refl

theorem length_removeKey [BEq α] {l : List (Σ a, β a)} {k : α} :
    (removeKey k l).length = bif containsKey k l then l.length - 1 else l.length := by
  induction l using assoc_induction
  · simp
  · next k' v' t ih =>
    rw [removeKey_cons, containsKey_cons]
    cases k == k'
    · rw [cond_false, Bool.false_or, List.length_cons, ih]
      cases h : containsKey k t
      · simp
      · simp only [cond_true, Nat.succ_eq_add_one, List.length_cons, Nat.add_sub_cancel]
        rw [Nat.sub_add_cancel]
        cases t
        · simp at h
        · simp
    · simp

theorem length_removeKey_le [BEq α] {l : List (Σ a, β a)} {k : α} :
    (removeKey k l).length ≤ l.length :=
  sublist_removeKey.length_le

theorem isEmpty_removeKey [BEq α] {l : List (Σ a, β a)} {k : α} :
    (removeKey k l).isEmpty = (l.isEmpty || (l.length == 1 && containsKey k l)) := by
  rw [Bool.eq_iff_iff]
  simp only [Bool.or_eq_true, Bool.and_eq_true, beq_iff_eq]
  rw [List.isEmpty_iff_length_eq_zero, length_removeKey, List.isEmpty_iff_length_eq_zero]
  cases containsKey k l <;> cases l <;> simp

@[simp] theorem keys_nil : keys ([] : List (Σ a, β a)) = [] := rfl
@[simp] theorem keys_cons {l : List (Σ a, β a)} {k : α} {v : β k} : keys (⟨k, v⟩ :: l) = k :: keys l := rfl

theorem keys_eq_map (l : List (Σ a, β a)) : keys l = l.map (·.1) := by
  induction l using assoc_induction <;> simp_all

theorem containsKey_eq_keys_contains [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {a : α} :
    containsKey a l = (keys l).contains a := by
  induction l using assoc_induction
  · rfl
  · next k _ l ih => simp [ih, BEq.comm]

theorem containsKey_eq_true_iff_exists_mem [BEq α] {l : List (Σ a, β a)} {a : α} :
    containsKey a l = true ↔ ∃ p ∈ l, a == p.1 := by
  induction l using assoc_induction <;> simp_all

theorem containsKey_of_mem [BEq α] [ReflBEq α] {l : List (Σ a, β a)} {p : Σ a, β a} (hp : p ∈ l) :
    containsKey p.1 l :=
  containsKey_eq_true_iff_exists_mem.2 ⟨p, ⟨hp, BEq.refl⟩⟩

@[simp]
theorem DistinctKeys.nil [BEq α] : DistinctKeys ([] : List (Σ a, β a)) :=
  ⟨by simp⟩

open List

theorem DistinctKeys.perm_keys [BEq α] [PartialEquivBEq α] {l l' : List (Σ a, β a)}
    (h : Perm (keys l') (keys l)) : DistinctKeys l → DistinctKeys l'
  | ⟨h'⟩ => ⟨h'.perm BEq.symm_false h.symm⟩

theorem DistinctKeys.perm [BEq α] [PartialEquivBEq α] {l l' : List (Σ a, β a)} (h : Perm l' l) :
    DistinctKeys l → DistinctKeys l' :=
  DistinctKeys.perm_keys (by simpa only [keys_eq_map] using h.map _)

theorem DistinctKeys.congr [BEq α] [PartialEquivBEq α] {l l' : List (Σ a, β a)} (h : Perm l l') :
    DistinctKeys l ↔ DistinctKeys l' :=
  ⟨fun h' => h'.perm h.symm, fun h' => h'.perm h⟩

theorem distinctKeys_of_sublist_keys [BEq α] {l : List (Σ a, β a)} {l' : List (Σ a, γ a)}
    (h : Sublist (keys l') (keys l)) : DistinctKeys l → DistinctKeys l' :=
  fun ⟨h'⟩ => ⟨h'.sublist h⟩

theorem distinctKeys_of_sublist [BEq α] {l l' : List (Σ a, β a)} (h : Sublist l' l) : DistinctKeys l → DistinctKeys l' :=
  distinctKeys_of_sublist_keys (by simpa only [keys_eq_map] using h.map _)

theorem DistinctKeys.of_keys_eq [BEq α] {l : List (Σ a, β a)} {l' : List (Σ a, γ a)} (h : keys l = keys l') : DistinctKeys l → DistinctKeys l' :=
  distinctKeys_of_sublist_keys (h ▸ Sublist.refl)

theorem containsKey_iff_exists [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {a : α} :
    containsKey a l ↔ ∃ a' ∈ keys l, a == a' := by
  rw [containsKey_eq_keys_contains, List.contains_iff_exists_mem_beq]

theorem containsKey_eq_false_iff_forall_mem_keys [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {a : α} :
    (containsKey a l) = false ↔ ∀ a' ∈ keys l, (a == a') = false := by
  simp only [Bool.eq_false_iff, ne_eq, containsKey_iff_exists, not_exists, not_and]

@[simp]
theorem distinctKeys_cons_iff [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    DistinctKeys (⟨k, v⟩ :: l) ↔ DistinctKeys l ∧ (containsKey k l) = false := by
  refine ⟨fun ⟨h⟩ => ?_, fun ⟨⟨h₁⟩, h₂⟩ => ⟨?_⟩⟩
  · rw [keys_cons, pairwise_cons] at h
    exact ⟨⟨h.2⟩, containsKey_eq_false_iff_forall_mem_keys.2 h.1⟩
  · rw [keys_cons, pairwise_cons, ← containsKey_eq_false_iff_forall_mem_keys]
    exact ⟨h₂, h₁⟩

theorem DistinctKeys.tail [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    DistinctKeys (⟨k, v⟩ :: l) → DistinctKeys l :=
  fun h => (distinctKeys_cons_iff.mp h).1

theorem DistinctKeys.containsKey_eq_false [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    DistinctKeys (⟨k, v⟩ :: l) → containsKey k l = false :=
  fun h => (distinctKeys_cons_iff.mp h).2

theorem DistinctKeys.cons [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k : α} {v : β k} (h : containsKey k l = false) :
    DistinctKeys l → DistinctKeys (⟨k, v⟩ :: l) :=
  fun h' => distinctKeys_cons_iff.mpr ⟨h', h⟩

theorem mem_iff_getEntry?_eq_some [BEq α] [EquivBEq α] {l : List (Σ a, β a)} {p : Σ a, β a} (h : DistinctKeys l) :
    p ∈ l ↔ getEntry? p.1 l = some p := by
  induction l using assoc_induction
  · simp_all
  · next k v t ih =>
    simp only [List.mem_cons, getEntry?_cons, ih h.tail]
    refine ⟨?_, ?_⟩
    · rintro (rfl|hk)
      · simp
      · suffices (p.fst == k) = false by simp_all
        refine Bool.eq_false_iff.2 fun hcon => Bool.false_ne_true ?_
        rw [← h.containsKey_eq_false, containsKey_congr (BEq.symm hcon),
          containsKey_eq_isSome_getEntry?, hk, Option.isSome_some]
    · cases p.fst == k
      · rw [cond_false]
        exact Or.inr
      · rw [cond_true, Option.some.injEq]
        exact Or.inl ∘ Eq.symm

theorem DistinctKeys.replaceEntry [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k : α} {v : β k} (h : DistinctKeys l) :
    DistinctKeys (replaceEntry k v l) := by
  induction l using assoc_induction
  · simp
  · next k' v' l ih =>
    rw [distinctKeys_cons_iff] at h
    cases hk'k : k == k'
    · rw [replaceEntry_cons_of_false hk'k, distinctKeys_cons_iff]
      refine ⟨ih h.1, ?_⟩
      simpa using h.2
    · rw [replaceEntry_cons_of_true hk'k, distinctKeys_cons_iff]
      refine ⟨h.1, ?_⟩
      simpa [containsKey_congr (BEq.symm hk'k)] using h.2

def insertEntry [BEq α]  (k : α) (v : β k) (l : List (Σ a, β a)) : List (Σ a, β a) :=
  bif containsKey k l then replaceEntry k v l else ⟨k, v⟩ :: l

@[simp]
theorem insertEntry_nil [BEq α] {k : α} {v : β k} : insertEntry k v ([] : List (Σ a, β a)) = [⟨k, v⟩] := by
  simp [insertEntry]

theorem insertEntry_of_containsKey [BEq α] {l : List (Σ a, β a)} {k : α} {v : β k} (h : containsKey k l) :
    insertEntry k v l = replaceEntry k v l := by
  simp [insertEntry, h]

theorem insertEntry_of_containsKey_eq_false [BEq α] {l : List (Σ a, β a)} {k : α} {v : β k} (h : containsKey k l = false) :
    insertEntry k v l = ⟨k, v⟩ :: l := by
  simp [insertEntry, h]

theorem DistinctKeys.insertEntry [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k : α} {v : β k} (h : DistinctKeys l) :
    DistinctKeys (insertEntry k v l) := by
  cases h' : containsKey k l
  · rw [insertEntry_of_containsKey_eq_false h', distinctKeys_cons_iff]
    exact ⟨h, h'⟩
  · rw [insertEntry_of_containsKey h']
    exact h.replaceEntry

@[simp]
theorem isEmpty_insertEntry [BEq α] {l : List (Σ a, β a)} {k : α} {v : β k} : (insertEntry k v l).isEmpty = false := by
  cases h : containsKey k l
  · simp [insertEntry_of_containsKey_eq_false h]
  · rw [insertEntry_of_containsKey h, isEmpty_replaceEntry, isEmpty_eq_false_of_containsKey h]

theorem length_insertEntry [BEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    (insertEntry k v l).length = bif containsKey k l then l.length else l.length + 1 := by
  simp [insertEntry, apply_bif List.length]

theorem length_le_length_insertEntry [BEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    l.length ≤ (insertEntry k v l).length := by
  rw [length_insertEntry]
  cases containsKey k l
  · simpa using Nat.le_add_right ..
  · simp

section

variable {β : Type v}

theorem getValue?_insertEntry_of_beq [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α} {v : β} (h : a == k) :
    getValue? a (insertEntry k v l) = some v := by
  cases h' : containsKey k l
  · rw [insertEntry_of_containsKey_eq_false h', getValue?_cons_of_true h]
  · rw [insertEntry_of_containsKey h', getValue?_replaceEntry_of_true h' h]

theorem getValue?_insertEntry_of_self [BEq α] [EquivBEq α] {l : List ((_ : α) × β)} {k : α} {v : β} :
    getValue? k (insertEntry k v l) = some v :=
  getValue?_insertEntry_of_beq BEq.refl

theorem getValue?_insertEntry_of_false [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α} {v : β} (h : (a == k) = false) :
    getValue? a (insertEntry k v l) = getValue? a l := by
  cases h' : containsKey k l
  · rw [insertEntry_of_containsKey_eq_false h', getValue?_cons_of_false h]
  · rw [insertEntry_of_containsKey h', getValue?_replaceEntry_of_false h]

theorem getValue?_insertEntry [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α} {v : β} :
    getValue? a (insertEntry k v l) = bif a == k then some v else getValue? a l := by
  cases h : a == k
  · simp [getValue?_insertEntry_of_false h, h]
  · simp [getValue?_insertEntry_of_beq h, h]

theorem getValue?_insertEntry_self [BEq α] [EquivBEq α] {l : List ((_ : α) × β)} {k : α} {v : β} :
    getValue? k (insertEntry k v l) = some v := by
  rw [getValue?_insertEntry, bif_pos BEq.refl]

end

theorem getEntry?_insertEntry [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} :
    getEntry? a (insertEntry k v l) = bif a == k then some ⟨k, v⟩ else getEntry? a l := by
  cases hl : containsKey k l
  · rw [insertEntry_of_containsKey_eq_false hl, getEntry?_cons]
  · rw [insertEntry_of_containsKey hl, getEntry?_replaceEntry, hl, Bool.true_and, BEq.comm]

theorem getValueCast?_insertEntry [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} :
    getValueCast? a (insertEntry k v l) = if h : a == k then some (cast (congrArg β (eq_of_beq h).symm) v) else getValueCast? a l := by
  cases hl : containsKey k l
  · rw [insertEntry_of_containsKey_eq_false hl, getValueCast?_cons]
  · rw [insertEntry_of_containsKey hl, getValueCast?_replaceEntry, hl]
    split <;> simp_all

theorem getValueCast?_insertEntry_self [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    getValueCast? k (insertEntry k v l) = some v := by
  rw [getValueCast?_insertEntry, dif_pos BEq.refl, cast_eq]

theorem getValueCast!_insertEntry [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} [Inhabited (β a)] {v : β k} :
    getValueCast! a (insertEntry k v l) = if h : a == k then cast (congrArg β (eq_of_beq h).symm) v else getValueCast! a l := by
  simp [getValueCast!_eq_getValueCast?, getValueCast?_insertEntry, apply_dite Option.get!]

theorem getValueCast!_insertEntry_self [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k : α} [Inhabited (β k)] {v : β k} :
    getValueCast! k (insertEntry k v l) = v := by
  rw [getValueCast!_insertEntry, dif_pos BEq.refl, cast_eq]

theorem getValueCastD_insertEntry [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} {fallback : β a} {v : β k} :
    getValueCastD a (insertEntry k v l) fallback = if h : a == k then cast (congrArg β (eq_of_beq h).symm) v else getValueCastD a l fallback := by
  simp [getValueCastD_eq_getValueCast?, getValueCast?_insertEntry, apply_dite (fun x => Option.getD x fallback)]

theorem getValueCastD_insertEntry_self [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k : α} {fallback : β k} {v : β k} :
    getValueCastD k (insertEntry k v l) fallback = v := by
  rw [getValueCastD_insertEntry, dif_pos BEq.refl, cast_eq]

theorem getValue!_insertEntry {β : Type v} [BEq α] [PartialEquivBEq α] [Inhabited β] {l : List ((_ : α) × β)} {k a : α} {v : β} :
    getValue! a (insertEntry k v l) = bif a == k then v else getValue! a l := by
  simp [getValue!_eq_getValue?, getValue?_insertEntry, apply_bif Option.get!]

theorem getValue!_insertEntry_self {β : Type v} [BEq α] [EquivBEq α] [Inhabited β] {l : List ((_ : α) × β)} {k : α} {v : β} :
    getValue! k (insertEntry k v l) = v := by
  rw [getValue!_insertEntry, BEq.refl, cond_true]

theorem getValueD_insertEntry {β : Type v} [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α} {fallback v : β} :
    getValueD a (insertEntry k v l) fallback = bif a == k then v else getValueD a l fallback := by
  simp [getValueD_eq_getValue?, getValue?_insertEntry, apply_bif (fun x => Option.getD x fallback)]

theorem getValueD_insertEntry_self {β : Type v} [BEq α] [EquivBEq α] {l : List ((_ : α) × β)} {k : α} {fallback v : β} :
    getValueD k (insertEntry k v l) fallback = v := by
  rw [getValueD_insertEntry, BEq.refl, cond_true]

@[simp]
theorem containsKey_insertEntry [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} :
    containsKey a (insertEntry k v l) = ((a == k) || containsKey a l) := by
  rw [containsKey_eq_isSome_getEntry?, containsKey_eq_isSome_getEntry?, getEntry?_insertEntry]
  cases a == k <;> simp

theorem containsKey_insertEntry_of_beq [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} (h : a == k) :
    containsKey a (insertEntry k v l) := by
  simp [h]

@[simp]
theorem containsKey_insertEntry_self [BEq α] [EquivBEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    containsKey k (insertEntry k v l) :=
  containsKey_insertEntry_of_beq BEq.refl

theorem containsKey_of_containsKey_insertEntry [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k}
    (h₁ : containsKey a (insertEntry k v l)) (h₂ : (a == k) = false) : containsKey a l := by
  rwa [containsKey_insertEntry, h₂, Bool.false_or] at h₁

theorem getValueCast_insertEntry [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} {h} :
    getValueCast a (insertEntry k v l) h =
    if h' : a == k then
      cast (congrArg β (eq_of_beq h').symm) v
    else
      getValueCast a l (containsKey_of_containsKey_insertEntry h (Bool.eq_false_iff.2 h')) := by
  rw [← Option.some_inj, ← getValueCast?_eq_some_getValueCast, apply_dite Option.some, getValueCast?_insertEntry]
  simp only [← getValueCast?_eq_some_getValueCast]

theorem getValueCast_insertEntry_self [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    getValueCast k (insertEntry k v l) containsKey_insertEntry_self = v := by
  simp [getValueCast_insertEntry]

theorem getValue_insertEntry {β : Type v} [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α} {v : β} {h} :
    getValue a (insertEntry k v l) h = if h' : a == k then v else getValue a l (containsKey_of_containsKey_insertEntry h (Bool.eq_false_iff.2 h')) := by
  rw [← Option.some_inj, ← getValue?_eq_some_getValue, apply_dite Option.some, getValue?_insertEntry, cond_eq_if, ← dite_eq_ite]
  simp only [← getValue?_eq_some_getValue]

theorem getValue_insertEntry_self {β : Type v} [BEq α] [EquivBEq α] {l : List ((_ : α) × β)} {k : α} {v : β} :
    getValue k (insertEntry k v l) containsKey_insertEntry_self = v := by
  simp [getValue_insertEntry]

def insertEntryIfNew [BEq α] (k : α) (v : β k) (l : List (Σ a, β a)) : List (Σ a, β a) :=
  bif containsKey k l then l else ⟨k, v⟩ :: l

theorem insertEntryIfNew_of_containsKey [BEq α] {l : List (Σ a, β a)} {k : α} {v : β k} (h : containsKey k l) :
    insertEntryIfNew k v l = l := by
  simp_all [insertEntryIfNew]

theorem insertEntryIfNew_of_containsKey_eq_false [BEq α] {l : List (Σ a, β a)} {k : α} {v : β k} (h : containsKey k l = false) :
    insertEntryIfNew k v l = ⟨k, v⟩ :: l := by
  simp_all [insertEntryIfNew]

@[simp]
theorem isEmpty_insertEntryIfNew [BEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    (insertEntryIfNew k v l).isEmpty = false := by
  cases h : containsKey k l
  · simp [insertEntryIfNew_of_containsKey_eq_false h]
  · rw [insertEntryIfNew_of_containsKey h]
    exact isEmpty_eq_false_of_containsKey h

theorem getEntry?_insertEntryIfNew [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} :
    getEntry? a (insertEntryIfNew k v l) = bif a == k && !containsKey k l then some ⟨k, v⟩ else getEntry? a l := by
  cases h : containsKey k l
  · simp [insertEntryIfNew_of_containsKey_eq_false h, getEntry?_cons]
  · simp [insertEntryIfNew_of_containsKey h]

theorem getValueCast?_insertEntryIfNew [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} :
    getValueCast? a (insertEntryIfNew k v l) =
      if h : a == k ∧ containsKey k l = false then some (cast (congrArg β (eq_of_beq h.1).symm) v) else getValueCast? a l := by
  cases h : containsKey k l
  · rw [insertEntryIfNew_of_containsKey_eq_false h, getValueCast?_cons]
    split <;> simp_all
  · simp [insertEntryIfNew_of_containsKey h]

theorem getValue?_insertEntryIfNew {β : Type v} [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α} {v : β} :
    getValue? a (insertEntryIfNew k v l) = bif a == k && !containsKey k l then some v else getValue? a l := by
  simp [getValue?_eq_getEntry?, getEntry?_insertEntryIfNew, apply_bif (Option.map (fun (y : ((_ : α) × β)) => y.2))]

theorem containsKey_insertEntryIfNew [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} :
    containsKey a (insertEntryIfNew k v l) = ((a == k) || containsKey a l) := by
  simp only [containsKey_eq_isSome_getEntry?, getEntry?_insertEntryIfNew, apply_bif Option.isSome,
    Option.isSome_some, Bool.cond_true_left]
  cases h : a == k
  · simp
  · rw [Bool.true_and, Bool.true_or, getEntry?_congr h, Bool.not_or_self]

theorem containsKey_insertEntryIfNew_self [BEq α] [EquivBEq α] {l : List (Σ a, β a)} {k : α}
    {v : β k} : containsKey k (insertEntryIfNew k v l) := by
  rw [containsKey_insertEntryIfNew, BEq.refl, Bool.true_or]

theorem containsKey_of_containsKey_insertEntryIfNew [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α}
    {v : β k} (h₁ : containsKey a (insertEntryIfNew k v l)) (h₂ : (a == k) = false) : containsKey a l := by
  rwa [containsKey_insertEntryIfNew, h₂, Bool.false_or] at h₁

/--
This is a restatement of `containsKey_insertEntryIfNew` that is written to exactly match the proof obligation in the
statement of `getValueCast_insertEntryIfNew`.
-/
theorem containsKey_of_containsKey_insertEntryIfNew' [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α}
    {v : β k} (h₁ : containsKey a (insertEntryIfNew k v l)) (h₂ : ¬((a == k) ∧ containsKey k l = false)) : containsKey a l := by
  rw [Decidable.not_and_iff_or_not, Bool.not_eq_true, Bool.not_eq_false] at h₂
  rcases h₂ with h₂|h₂
  · rwa [containsKey_insertEntryIfNew, h₂, Bool.false_or] at h₁
  · rwa [insertEntryIfNew_of_containsKey h₂] at h₁

theorem getValueCast_insertEntryIfNew [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} {h} :
    getValueCast a (insertEntryIfNew k v l) h =
    if h' : a == k ∧ containsKey k l = false then
      cast (congrArg β (eq_of_beq h'.1).symm) v
    else
      getValueCast a l (containsKey_of_containsKey_insertEntryIfNew' h h') := by
  rw [← Option.some_inj, ← getValueCast?_eq_some_getValueCast, apply_dite Option.some, getValueCast?_insertEntryIfNew]
  simp only [← getValueCast?_eq_some_getValueCast]

theorem getValue_insertEntryIfNew {β : Type v} [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α} {v : β} {h} :
    getValue a (insertEntryIfNew k v l) h =
    if h' : a == k ∧ containsKey k l = false then v else getValue a l (containsKey_of_containsKey_insertEntryIfNew' h
        (by simpa only [Decidable.not_and_iff_or_not_not, Bool.not_eq_false, Bool.not_eq_true] using h')) := by
  rw [← Option.some_inj, ← getValue?_eq_some_getValue, apply_dite Option.some, getValue?_insertEntryIfNew, cond_eq_if, ← dite_eq_ite]
  simp [← getValue?_eq_some_getValue]

theorem getValueCast!_insertEntryIfNew [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} [Inhabited (β a)] :
    getValueCast! a (insertEntryIfNew k v l) =
      if h : a == k ∧ containsKey k l = false then cast (congrArg β (eq_of_beq h.1).symm) v else getValueCast! a l := by
  simp [getValueCast!_eq_getValueCast?, getValueCast?_insertEntryIfNew, apply_dite Option.get!]

theorem getValue!_insertEntryIfNew {β : Type v} [BEq α] [PartialEquivBEq α] [Inhabited β] {l : List ((_ : α) × β)} {k a : α} {v : β} :
    getValue! a (insertEntryIfNew k v l) = bif a == k && !containsKey k l then v else getValue! a l := by
  simp [getValue!_eq_getValue?, getValue?_insertEntryIfNew, apply_bif Option.get!]

theorem getValueCastD_insertEntryIfNew [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} {v : β k} {fallback : β a} :
    getValueCastD a (insertEntryIfNew k v l) fallback =
      if h : a == k ∧ containsKey k l = false then cast (congrArg β (eq_of_beq h.1).symm) v else getValueCastD a l fallback := by
  simp [getValueCastD_eq_getValueCast?, getValueCast?_insertEntryIfNew, apply_dite (fun x => Option.getD x fallback)]

theorem getValueD_insertEntryIfNew {β : Type v} [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α} {fallback v : β} :
    getValueD a (insertEntryIfNew k v l) fallback =
      bif a == k && !containsKey k l then v else getValueD a l fallback := by
  simp [getValueD_eq_getValue?, getValue?_insertEntryIfNew, apply_bif (fun x => Option.getD x fallback)]

theorem length_insertEntryIfNew [BEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    (insertEntryIfNew k v l).length = bif containsKey k l then l.length else l.length + 1 := by
  simp [insertEntryIfNew, apply_bif List.length]

theorem length_le_length_insertEntryIfNew [BEq α] {l : List (Σ a, β a)} {k : α} {v : β k} :
    l.length ≤ (insertEntryIfNew k v l).length := by
  rw [length_insertEntryIfNew]
  cases containsKey k l
  · simpa using Nat.le_add_right ..
  · simp

@[simp]
theorem keys_removeKey [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k : α} :
    keys (removeKey k l) = (keys l).erase k := by
  induction l using assoc_induction
  · rfl
  · next k' v' l ih =>
    simp only [removeKey_cons, keys_cons, List.erase_cons]
    rw [BEq.comm]
    cases k' == k <;> simp [ih]

theorem DistinctKeys.removeKey [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k : α} : DistinctKeys l → DistinctKeys (removeKey k l) := by
  apply distinctKeys_of_sublist_keys (by simpa using erase_sublist _ _)

theorem getEntry?_removeKey_self [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k : α} (h : DistinctKeys l) :
    getEntry? k (removeKey k l) = none := by
  induction l using assoc_induction
  · simp
  · next k' v' t ih =>
    cases h' : k == k'
    · rw [removeKey_cons_of_false h', getEntry?_cons_of_false h']
      exact ih h.tail
    · rw [removeKey_cons_of_beq h', ← Option.not_isSome_iff_eq_none, Bool.not_eq_true,
        ← containsKey_eq_isSome_getEntry?, ← containsKey_congr (BEq.symm h')]
      exact h.containsKey_eq_false

theorem getEntry?_removeKey_of_beq [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α} (hl : DistinctKeys l)
    (hka : a == k) : getEntry? a (removeKey k l) = none := by
  rw [← getEntry?_congr (BEq.symm hka), getEntry?_removeKey_self hl]

theorem getEntry?_removeKey_of_false [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α}
    (hka : (a == k) = false) : getEntry? a (removeKey k l) = getEntry? a l := by
  induction l using assoc_induction
  · simp
  · next k' v' t ih =>
    cases h' : k == k'
    · rw [removeKey_cons_of_false h']
      cases h'' : a == k'
      · rw [getEntry?_cons_of_false h'', ih, getEntry?_cons_of_false h'']
      · rw [getEntry?_cons_of_true h'', getEntry?_cons_of_true h'']
    · rw [removeKey_cons_of_beq h']
      have hx : (a == k') = false := BEq.neq_of_neq_of_beq hka h'
      rw [getEntry?_cons_of_false hx]

theorem getEntry?_removeKey [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α} (hl : DistinctKeys l) :
    getEntry? a (removeKey k l) = bif a == k then none else getEntry? a l := by
  cases h : a == k
  · simp [getEntry?_removeKey_of_false h, h]
  · simp [getEntry?_removeKey_of_beq hl h, h]

theorem keys_filterMap [BEq α] {l : List (Σ a, β a)} {f : (a : α) → β a → Option (γ a)} :
    keys (l.filterMap fun p => (f p.1 p.2).map (⟨p.1, ·⟩)) = keys (l.filter fun p => (f p.1 p.2).isSome) := by
  induction l using assoc_induction
  · simp
  · next k v t ih =>
    simp only [List.filterMap_cons, List.filter_cons]
    cases f k v <;> simp [ih]

@[simp]
theorem keys_map [BEq α] {l : List (Σ a, β a)} {f : (a : α) → β a → γ a} :
    keys (l.map fun p => ⟨p.1, f p.1 p.2⟩) = keys l := by
  induction l using assoc_induction <;> simp_all

theorem DistinctKeys.filterMap [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {f : (a : α) → β a → Option (γ a)} :
    DistinctKeys l → DistinctKeys (l.filterMap fun p => (f p.1 p.2).map (⟨p.1, ·⟩)) := by
  apply distinctKeys_of_sublist_keys
  rw [keys_filterMap, keys_eq_map, keys_eq_map]
  apply Sublist.map
  exact filter_sublist l

theorem DistinctKeys.map [BEq α] {l : List (Σ a, β a)} {f : (a : α) → β a → γ a}
    (h : DistinctKeys l) : DistinctKeys (l.map fun p => ⟨p.1, f p.1 p.2⟩) :=
  h.of_keys_eq keys_map.symm

theorem DistinctKeys.filter [BEq α] {l : List (Σ a, β a)} {f : (a : α) → β a → Bool}
    (h : DistinctKeys l) : DistinctKeys (l.filter fun p => f p.1 p.2) :=
  distinctKeys_of_sublist (filter_sublist _) h

section

variable {β : Type v}

theorem getValue?_removeKey_self [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k : α} (h : DistinctKeys l) :
    getValue? k (removeKey k l) = none := by
  simp [getValue?_eq_getEntry?, getEntry?_removeKey_self h]

theorem getValue?_removeKey_of_beq [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α} (hl : DistinctKeys l)
    (hka : a == k) : getValue? a (removeKey k l) = none := by
  simp [getValue?_eq_getEntry?, getEntry?_removeKey_of_beq hl hka]

theorem getValue?_removeKey_of_false [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α}
    (hka : (a == k) = false) : getValue? a (removeKey k l) = getValue? a l := by
  simp [getValue?_eq_getEntry?, getEntry?_removeKey_of_false hka]

theorem getValue?_removeKey [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α} (hl : DistinctKeys l) :
    getValue? a (removeKey k l) = bif a == k then none else getValue? a l := by
  simp [getValue?_eq_getEntry?, getEntry?_removeKey hl, apply_bif (Option.map _)]

end

theorem containsKey_removeKey_self [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k : α} (h : DistinctKeys l) :
    containsKey k (removeKey k l) = false := by
  simp [containsKey_eq_isSome_getEntry?, getEntry?_removeKey_self h]

theorem containsKey_removeKey_of_beq [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α} (hl : DistinctKeys l)
    (hka : a == k) : containsKey a (removeKey k l) = false := by
  rw [containsKey_congr hka, containsKey_removeKey_self hl]

theorem containsKey_removeKey_of_false [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α}
    (hka : (a == k) = false) : containsKey a (removeKey k l) = containsKey a l := by
  simp [containsKey_eq_isSome_getEntry?, getEntry?_removeKey_of_false hka]

theorem containsKey_removeKey [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α} (hl : DistinctKeys l) :
    containsKey a (removeKey k l) = (!(a == k) && containsKey a l) := by
  simp [containsKey_eq_isSome_getEntry?, getEntry?_removeKey hl, apply_bif]

theorem getValueCast?_removeKey [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} (hl : DistinctKeys l) :
    getValueCast? a (removeKey k l) = bif a == k then none else getValueCast? a l := by
  rw [getValueCast?_eq_getEntry?, Option.dmap_congr (getEntry?_removeKey hl)]
  rcases Bool.eq_false_or_eq_true (a == k) with h|h
  · rw [Option.dmap_congr (bif_pos h), Option.dmap_none, bif_pos h]
  · rw [Option.dmap_congr (bif_neg h), getValueCast?_eq_getEntry?]
    exact (bif_neg h).symm

theorem getValueCast?_removeKey_self [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k : α} (hl : DistinctKeys l) :
    getValueCast? k (removeKey k l) = none := by
  rw [getValueCast?_removeKey hl, bif_pos BEq.refl]

theorem getValueCast!_removeKey [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} [Inhabited (β a)] (hl : DistinctKeys l) :
    getValueCast! a (removeKey k l) = bif a == k then default else getValueCast! a l := by
  simp [getValueCast!_eq_getValueCast?, getValueCast?_removeKey hl, apply_bif Option.get!]

theorem getValueCast!_removeKey_self [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k : α} [Inhabited (β k)] (hl : DistinctKeys l) :
    getValueCast! k (removeKey k l) = default := by
  simp [getValueCast!_eq_getValueCast?, getValueCast?_removeKey_self hl]

theorem getValueCastD_removeKey [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} {fallback : β a} (hl : DistinctKeys l) :
    getValueCastD a (removeKey k l) fallback = bif a == k then fallback else getValueCastD a l fallback := by
  simp [getValueCastD_eq_getValueCast?, getValueCast?_removeKey hl, apply_bif (fun x => Option.getD x fallback)]

theorem getValueCastD_removeKey_self [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k : α} {fallback : β k} (hl : DistinctKeys l) :
    getValueCastD k (removeKey k l) fallback = fallback := by
  simp [getValueCastD_eq_getValueCast?, getValueCast?_removeKey_self hl]

theorem getValue!_removeKey {β : Type v} [BEq α] [PartialEquivBEq α] [Inhabited β] {l : List ((_ : α) × β)} {k a : α}
    (hl : DistinctKeys l) : getValue! a (removeKey k l) = bif a == k then default else getValue! a l := by
  simp [getValue!_eq_getValue?, getValue?_removeKey hl, apply_bif Option.get!]

theorem getValue!_removeKey_self {β : Type v} [BEq α] [PartialEquivBEq α] [Inhabited β] {l : List ((_ : α) × β)} {k : α}
    (hl : DistinctKeys l) : getValue! k (removeKey k l) = default := by
  simp [getValue!_eq_getValue?, getValue?_removeKey_self hl]

theorem getValueD_removeKey {β : Type v} [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α} {fallback : β}
    (hl : DistinctKeys l) : getValueD a (removeKey k l) fallback = bif a == k then fallback else getValueD a l fallback := by
  simp [getValueD_eq_getValue?, getValue?_removeKey hl, apply_bif (fun x => Option.getD x fallback)]

theorem getValueD_removeKey_self {β : Type v} [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k : α} {fallback : β}
    (hl : DistinctKeys l) : getValueD k (removeKey k l) fallback = fallback := by
  simp [getValueD_eq_getValue?, getValue?_removeKey_self hl]

theorem containsKey_of_containsKey_removeKey [BEq α] [PartialEquivBEq α] {l : List (Σ a, β a)} {k a : α} (hl : DistinctKeys l) :
    containsKey a (removeKey k l) → containsKey a l := by
  simp [containsKey_removeKey hl]

theorem getValueCast_removeKey [BEq α] [LawfulBEq α] {l : List (Σ a, β a)} {k a : α} {h} (hl : DistinctKeys l) :
    getValueCast a (removeKey k l) h = getValueCast a l (containsKey_of_containsKey_removeKey hl h) := by
  rw [containsKey_removeKey hl, Bool.and_eq_true, Bool.not_eq_true'] at h
  rw [← Option.some_inj, ← getValueCast?_eq_some_getValueCast, getValueCast?_removeKey hl, h.1, cond_false,
    ← getValueCast?_eq_some_getValueCast]

theorem getValue_removeKey {β : Type v} [BEq α] [PartialEquivBEq α] {l : List ((_ : α) × β)} {k a : α} {h}
    (hl : DistinctKeys l) : getValue a (removeKey k l) h = getValue a l (containsKey_of_containsKey_removeKey hl h) := by
  rw [containsKey_removeKey hl, Bool.and_eq_true, Bool.not_eq_true'] at h
  rw [← Option.some_inj, ← getValue?_eq_some_getValue, getValue?_removeKey hl, h.1, cond_false, ← getValue?_eq_some_getValue]

theorem getEntry?_of_perm [BEq α] [PartialEquivBEq α] {l l' : List (Σ a, β a)} {a : α} (hl : DistinctKeys l)
    (h : Perm l l') : getEntry? a l = getEntry? a l' := by
  induction h
  · simp
  · next t₁ t₂ p _ ih₂ =>
    rcases p with ⟨k', v'⟩
    simp only [getEntry?_cons, ih₂ hl.tail]
  · next p p' _ _ =>
    rcases p with ⟨k₁, v₁⟩
    rcases p' with ⟨k₂, v₂⟩
    simp only [getEntry?_cons]
    cases h₂ : a == k₂ <;> cases h₁ : a == k₁ <;> try simp; done
    simp only [distinctKeys_cons_iff, containsKey_cons, Bool.or_eq_false_iff] at hl
    exact ((Bool.eq_false_iff.1 hl.2.1).elim (BEq.trans (BEq.symm h₁) h₂)).elim
  · next l₁ l₂ l₃ hl₁₂ _ ih₁ ih₂ => exact (ih₁ hl).trans (ih₂ (hl.perm (hl₁₂.symm)))

theorem containsKey_of_perm [BEq α] [PartialEquivBEq α] {l l' : List (Σ a, β a)} {k : α}
    (h : Perm l l') : containsKey k l = containsKey k l' := by
  induction h
  · simp
  · next p t₁ t₂ _ ih₂ => rw [containsKey_cons, containsKey_cons, ih₂]
  · next p p' _ =>
    rw [containsKey_cons, containsKey_cons, containsKey_cons, containsKey_cons]
    simp only [← Bool.or_assoc, Bool.or_comm]
  · next _ _ _ _ _ ih₁ ih₂ => exact ih₁.trans ih₂

theorem getValueCast?_of_perm [BEq α] [LawfulBEq α] {l l' : List (Σ a, β a)} {a : α} (hl : DistinctKeys l)
    (h : Perm l l') : getValueCast? a l = getValueCast? a l' := by
  rw [getValueCast?_eq_getEntry?, getValueCast?_eq_getEntry?, Option.dmap_congr (getEntry?_of_perm hl h)]

theorem getValueCast_of_perm [BEq α] [LawfulBEq α] {l l' : List (Σ a, β a)} {a : α} {h'} (hl : DistinctKeys l)
    (h : Perm l l') : getValueCast a l h' = getValueCast a l' ((containsKey_of_perm h).symm.trans h') := by
  rw [← Option.some_inj, ← getValueCast?_eq_some_getValueCast, ← getValueCast?_eq_some_getValueCast,
    getValueCast?_of_perm hl h]

theorem getValueCast!_of_perm [BEq α] [LawfulBEq α] {l l' : List (Σ a, β a)} {a : α} [Inhabited (β a)] (hl : DistinctKeys l)
    (h : Perm l l') : getValueCast! a l = getValueCast! a l' := by
  simp only [getValueCast!_eq_getValueCast?, getValueCast?_of_perm hl h]

theorem getValueCastD_of_perm [BEq α] [LawfulBEq α] {l l' : List (Σ a, β a)} {a : α} {fallback : β a} (hl : DistinctKeys l)
    (h : Perm l l') : getValueCastD a l fallback = getValueCastD a l' fallback := by
  simp only [getValueCastD_eq_getValueCast?, getValueCast?_of_perm hl h]

section

variable {β : Type v}

theorem getValue?_of_perm [BEq α] [PartialEquivBEq α] {l l' : List ((_ : α) × β)} {a : α} (hl : DistinctKeys l)
    (h : Perm l l') : getValue? a l = getValue? a l' := by
  simp only [getValue?_eq_getEntry?, getEntry?_of_perm hl h]

theorem getValue_of_perm [BEq α] [PartialEquivBEq α] {l l' : List ((_ : α) × β)} {a : α} {h'} (hl : DistinctKeys l)
    (h : Perm l l') : getValue a l h' = getValue a l' ((containsKey_of_perm h).symm.trans h') := by
  rw [← Option.some_inj, ← getValue?_eq_some_getValue, ← getValue?_eq_some_getValue, getValue?_of_perm hl h]

theorem getValue!_of_perm [BEq α] [PartialEquivBEq α] [Inhabited β] {l l' : List ((_ : α) × β)} {a : α} (hl : DistinctKeys l)
    (h : Perm l l') : getValue! a l = getValue! a l' := by
  simp only [getValue!_eq_getValue?, getValue?_of_perm hl h]

theorem getValueD_of_perm [BEq α] [PartialEquivBEq α] {l l' : List ((_ : α) × β)} {a : α} {fallback : β} (hl : DistinctKeys l)
    (h : Perm l l') : getValueD a l fallback = getValueD a l' fallback := by
  simp only [getValueD_eq_getValue?, getValue?_of_perm hl h]

end

theorem perm_cons_getEntry [BEq α] {l : List (Σ a, β a)} {a : α} (h : containsKey a l) :
    ∃ l', Perm l (getEntry a l h :: l') := by
  induction l using assoc_induction
  · simp at h
  · next k' v' t ih =>
    simp only [containsKey_cons, Bool.or_eq_true] at h
    cases hk : a == k'
    · obtain ⟨l', hl'⟩ := ih (h.resolve_left (Bool.not_eq_true _ ▸ hk))
      rw [getEntry_cons_of_false hk]
      exact ⟨⟨k', v'⟩ :: l', (hl'.cons _).trans (Perm.swap _ _ (Perm.refl _))⟩
    · exact ⟨t, by rw [getEntry_cons_of_beq hk]; exact Perm.refl _⟩

-- Note: this theorem becomes false if you don't assume that BEq is reflexive on α.
theorem getEntry?_ext [BEq α] [EquivBEq α] {l l' : List (Σ a, β a)} (hl : DistinctKeys l) (hl' : DistinctKeys l')
    (h : ∀ a, getEntry? a l = getEntry? a l') : Perm l l' := by
  induction l using assoc_induction generalizing l'
  · induction l' using assoc_induction
    · exact Perm.refl _
    · next k _ _ _ => simpa using h k
  · next k v t ih =>
    have hl'k₁ : getEntry? k l' = some ⟨k, v⟩ := by rw [← h, getEntry?_cons_self]
    have hl'k₂ : containsKey k l' := by
      rw [containsKey_eq_isSome_getEntry?, hl'k₁, Option.isSome_some]
    obtain ⟨l'', hl''⟩ := perm_cons_getEntry hl'k₂
    rw [getEntry_eq_of_getEntry?_eq_some hl'k₁] at hl''
    suffices Perm t l'' from (this.cons _).trans hl''.symm
    apply ih hl.tail (hl'.perm hl''.symm).tail
    intro k'
    cases hk' : k' == k
    · simpa only [getEntry?_of_perm hl' hl'', getEntry?_cons_of_false hk'] using h k'
    · rw [getEntry?_congr hk', getEntry?_congr hk', getEntry?_eq_none.2 hl.containsKey_eq_false,
          getEntry?_eq_none.2 (hl'.perm hl''.symm).containsKey_eq_false]

theorem replaceEntry_of_perm [BEq α] [EquivBEq α] {l l' : List (Σ a, β a)} {k : α} {v : β k}
    (hl : DistinctKeys l) (h : Perm l l') : Perm (replaceEntry k v l) (replaceEntry k v l') := by
  apply getEntry?_ext hl.replaceEntry (hl.perm h.symm).replaceEntry
  simp [getEntry?_replaceEntry, getEntry?_of_perm hl h, containsKey_of_perm h]

theorem insertEntry_of_perm [BEq α] [EquivBEq α] {l l' : List (Σ a, β a)} {k : α} {v : β k}
    (hl : DistinctKeys l) (h : Perm l l') : Perm (insertEntry k v l) (insertEntry k v l') := by
  apply getEntry?_ext hl.insertEntry (hl.perm h.symm).insertEntry
  simp [getEntry?_insertEntry, getEntry?_of_perm hl h]

theorem removeKey_of_perm [BEq α] [EquivBEq α] {l l' : List (Σ a, β a)} {k : α}
    (hl : DistinctKeys l) (h : Perm l l') : Perm (removeKey k l) (removeKey k l') := by
  apply getEntry?_ext hl.removeKey (hl.perm h.symm).removeKey
  simp [getEntry?_removeKey hl, getEntry?_removeKey (hl.perm h.symm), getEntry?_of_perm hl h]

@[simp]
theorem getEntry?_append [BEq α] {l l' : List (Σ a, β a)} {a : α} :
    getEntry? a (l ++ l') = (getEntry? a l).or (getEntry? a l') := by
  induction l using assoc_induction
  · simp
  · next k' v' t ih => cases h : a == k' <;> simp_all [getEntry?_cons]

theorem getEntry?_append_of_containsKey_eq_false [BEq α] {l l' : List (Σ a, β a)} {a : α}
    (h : containsKey a l' = false) : getEntry? a (l ++ l') = getEntry? a l := by
  rw [getEntry?_append, getEntry?_eq_none.2 h, Option.or_none]

@[simp]
theorem containsKey_append [BEq α] {l l' : List (Σ a, β a)} {a : α} :
    containsKey a (l ++ l') = (containsKey a l || containsKey a l') := by
  simp [containsKey_eq_isSome_getEntry?]

theorem containsKey_bind_eq_false [BEq α] {γ : Type w} {l : List γ} {f : γ → List (Σ a, β a)} {a : α}
    (h : ∀ (i : Nat) (h : i < l.length), containsKey a (f l[i]) = false) : containsKey a (l.bind f) = false := by
  induction l
  · simp
  · next g t ih =>
    simp only [List.bind_cons, containsKey_append, Bool.or_eq_false_iff]
    refine ⟨?_, ?_⟩
    · simpa using h 0 (by simp)
    · refine ih ?_
      intro i hi
      simpa using h (i + 1) (by simp only [List.length_cons]; omega)

theorem containsKey_append_of_not_contains_right [BEq α] {l l' : List (Σ a, β a)} {a : α}
    (hl' : containsKey a l' = false) : containsKey a (l ++ l') = containsKey a l := by
  simp [hl']

@[simp]
theorem getValue?_append {β : Type v} [BEq α] {l l' : List ((_ : α) × β)} {a : α} :
    getValue? a (l ++ l') = (getValue? a l).or (getValue? a l') := by
  simp [getValue?_eq_getEntry?, Option.map_or]

theorem getValue?_append_of_containsKey_eq_false {β : Type v} [BEq α] {l l' : List ((_ : α) × β)} {a : α}
    (h : containsKey a l' = false) : getValue? a (l ++ l') = getValue? a l := by
  rw [getValue?_append, getValue?_eq_none.2 h, Option.or_none]

theorem getValue_append_of_containsKey_eq_false {β : Type v} [BEq α] {l l' : List ((_ : α) × β)} {a : α} {h'}
    (h : containsKey a l' = false) : getValue a (l ++ l') h' = getValue a l ((containsKey_append_of_not_contains_right h).symm.trans h') := by
  rw [← Option.some_inj, ← getValue?_eq_some_getValue, ← getValue?_eq_some_getValue, getValue?_append_of_containsKey_eq_false h]

theorem getValueCast?_append_of_containsKey_eq_false [BEq α] [LawfulBEq α] {l l' : List (Σ a, β a)} {a : α}
    (hl' : containsKey a l' = false) : getValueCast? a (l ++ l') = getValueCast? a l := by
  rw [getValueCast?_eq_getEntry?, getValueCast?_eq_getEntry?, Option.dmap_congr getEntry?_append,
    Option.dmap_congr (by rw [getEntry?_eq_none.2 hl']), Option.dmap_congr (by rw [Option.or_none])]

theorem getValueCast_append_of_containsKey_eq_false [BEq α] [LawfulBEq α] {l l' : List (Σ a, β a)} {a : α} {h}
    (hl' : containsKey a l' = false) :
    getValueCast a (l ++ l') h = getValueCast a l ((containsKey_append_of_not_contains_right hl').symm.trans h) := by
  rw [← Option.some_inj, ← getValueCast?_eq_some_getValueCast, ← getValueCast?_eq_some_getValueCast,
    getValueCast?_append_of_containsKey_eq_false hl']

theorem replaceEntry_append_of_containsKey_left [BEq α] {l l' : List (Σ a, β a)} {k : α}
    {v : β k} (h : containsKey k l) : replaceEntry k v (l ++ l') = replaceEntry k v l ++ l' := by
  induction l using assoc_induction
  · simp at h
  · next k' v' t ih =>
    simp only [containsKey_cons, Bool.or_eq_true] at h
    cases h' : k == k'
    · simpa [replaceEntry_cons, h'] using ih (h.resolve_left (Bool.not_eq_true _ ▸ h'))
    · simp [replaceEntry_cons, h']

theorem replaceEntry_append_of_containsKey_left_eq_false [BEq α] {l l' : List (Σ a, β a)} {k : α}
    {v : β k} (h : containsKey k l = false) : replaceEntry k v (l ++ l') = l ++ replaceEntry k v l' := by
  induction l using assoc_induction
  · simp
  · next k' v' t ih =>
    simp only [containsKey_cons, Bool.or_eq_false_iff] at h
    simpa [replaceEntry_cons, h.1] using ih h.2

theorem replaceEntry_append_of_containsKey_right_eq_false [BEq α] {l l' : List (Σ a, β a)} {k : α}
    {v : β k} (h : containsKey k l' = false) : replaceEntry k v (l ++ l') = replaceEntry k v l ++ l' := by
  cases h' : containsKey k l
  · rw [replaceEntry_of_containsKey_eq_false, replaceEntry_of_containsKey_eq_false h']
    simpa using ⟨h', h⟩
  · rw [replaceEntry_append_of_containsKey_left h']

theorem insertEntry_append_of_not_contains_right [BEq α] {l l' : List (Σ a, β a)}
    {k : α} {v : β k} (h' : containsKey k l' = false) :
    insertEntry k v (l ++ l') = insertEntry k v l ++ l' := by
  cases h : containsKey k l
  · simp [insertEntry, containsKey_append, h, h']
  · simp [insertEntry, containsKey_append, h, h', replaceEntry_append_of_containsKey_left h]

theorem removeKey_append_of_containsKey_right_eq_false [BEq α] {l l' : List (Σ a, β a)} {k : α}
    (h : containsKey k l' = false) : removeKey k (l ++ l') = removeKey k l ++ l' := by
  induction l using assoc_induction
  · simp [removeKey_of_containsKey_eq_false h]
  · next k' v' t ih =>
    rw [List.cons_append, removeKey_cons, removeKey_cons]
    cases k == k'
    · rw [cond_false, cond_false, ih, List.cons_append]
    · rw [cond_true, cond_true]

end List
