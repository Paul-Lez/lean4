set_option grind.warning false

/-
Use `grind` as one of the tactics for array-element access and termination proofs.
-/
macro_rules | `(tactic| get_elem_tactic_trivial) => `(tactic| grind)
/-
Note: We disable model-based theory combination (-mbtc) here because `grind` can
exhaust heartbeats when exploring certain "bad" termination checker scenarios.
For example, in `heapsort.go`, the termination checker attempts `termination_by a.size` first,
and `grind` will perform excessive case splits, consuming heartbeats too quickly.

BTW, the error message must be improved. It just says heartbeats exhausted :(
-/
macro_rules | `(tactic| decreasing_trivial) => `(tactic| grind -mbtc)
-- TODO: annotate the library
attribute [grind] Array.size_swap

abbrev leftChild (i : Nat) := 2*i + 1
abbrev parent (i : Nat) := (i - 1) / 2

-- TODO: Generalize `siftDown` to arbitrary element types (not just `Int`)
-- once other issues are resolved.

def siftDown (a : Array Int) (root : Nat) (e : Nat) (h : e ≤ a.size := by grind) : Array Int :=
  -- Remark: It is annoying to have to write `if _ : ...` to make sure the hypothesis is available
  -- while type-checking the if-then-else body.
  if _ : leftChild root < e then
    let child := leftChild root
    -- Remark: it would be nice to have a `p ∧ q` where we can assume `p` while type checking `q`
    -- I simulated it using a nested `if-then-else`
    let child := if _ : child+1 < e then
      if a[child] < a[child + 1] then
        child + 1
      else
        child
    else
      child
    if a[root] < a[child] then
      let a := a.swap root child
      siftDown a child e
    else
      a
  else
    a
termination_by e - root

/-
Function induction for `siftDown` yields three cases, but we only have
one equation lemma (`siftDown.eq_1`). This mismatch can complicate proofs
by leading to loops in `simp`. `grind` also gets lost on case-analysis.

Another issue: function induction does not erase `autoParam` from hypotheses.

Remark: while editing this comment, `siftDown` above was being recompiled by Lean :(
-/
#check siftDown.induct
#check siftDown.eq_1

/-
We attempted to prove that `siftDown` preserves the array size, but the proof
quickly became a mess because of the mismatch between `siftDown.induct` and its equation lemmas.

@[grind] theorem siftDown_size : (siftDown a root e h).size = a.size := by
   sorry
-/

-- To avoid the sorry above, I redefined `siftDown` using a subtype
def siftDown' (a : Array Int) (root : Nat) (e : Nat) (h : e ≤ a.size := by grind) : { a' : Array Int // a'.size = a.size } :=
  if _ : leftChild root < e then
    let child := leftChild root
    let child := if _ : child+1 < e then
      if a[child] < a[child + 1] then
        child + 1
      else
        child
    else
      child
    if a[root] < a[child] then
      let a := a.swap root child
      -- Remark: I found the following idiom ugly. The proof-plumbing is quite distracting.
      let ⟨a, h'⟩ := siftDown' a child e
      ⟨a, by grind⟩
    else
      ⟨a, rfl⟩
  else
    ⟨a, rfl⟩
-- Without the explicit `termination_by`, I had to increase `maxHeartbeats`.
-- I am guessing `grind` is spending a lot of time with unnecessary case-splits before it fails
-- on `termination_by a.size`, `termination_by root`, ...
termination_by e - root

def heapify (a : Array Int) : Array Int :=
  let start := parent (a.size - 1) + 1
  go a start
where
  go (a : Array Int) (start : Nat) : Array Int :=
    match start with
    | 0 => a
    | start+1 => go (siftDown' a start a.size).1 start

def heapsort (a : Array Int) : Array Int :=
  let a := heapify a
  go a a.size
where
  go (a : Array Int) (e : Nat) (h : e ≤ a.size := by grind) : Array Int :=
    -- Another annoying `_ :`
    if _ : e > 1 then
      let e := e - 1
      let a := a.swap e 0
      let ⟨a, h⟩ := siftDown' a 0 e
      go a e
    else
      a

/-- info: #[0, 1, 2, 4, 5, 7, 8, 10] -/
#guard_msgs (info) in
#eval heapsort #[4, 1, 0, 5, 7, 10, 8, 2]
