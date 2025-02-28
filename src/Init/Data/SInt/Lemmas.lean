/-
Copyright (c) 2025 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Markus Himmel
-/
prelude
import Init.Data.SInt.Basic
import Init.Data.BitVec.Bitblast

section MoveMe

theorem Int.sub_eq_iff_eq_add {b a c : Int} : a - b = c ↔ a = c + b := by omega
theorem Int.sub_eq_iff_eq_add' {b a c : Int} : a - b = c ↔ a = b + c := by omega

@[simp] theorem Int.bmod_sub_mul_cancel (x : Int) (n : Nat) (k : Int) : (x - n * k).bmod n = x.bmod n := by
  rw [Int.sub_eq_add_neg, Int.neg_mul_eq_mul_neg, Int.bmod_add_mul_cancel]

theorem Int.bmod_bmod_of_dvd {a : Int} {n m : Nat} (hnm : n ∣ m) :
    (a.bmod m).bmod n = a.bmod n := by
  rw [← sub_eq_iff_eq_add.2 (bmod_add_bdiv a m).symm]
  obtain ⟨k, rfl⟩ := hnm
  simp [Int.mul_assoc]

theorem BitVec.toInt_signExtend' {w v : Nat} (x : BitVec w) :
    (x.signExtend v).toInt = x.toInt.bmod (2 ^ min v w) := by
  rw [toInt_signExtend, BitVec.toInt_eq_toNat_bmod, Int.bmod_bmod_of_dvd]
  exact Nat.pow_dvd_pow _ (Nat.min_le_right v w)

theorem BitVec.toInt_signExtend_of_le' {w v : Nat} (x : BitVec w) (h : v ≤ w) :
    (x.signExtend v).toInt = x.toInt.bmod (2 ^ v) := by
  rw [BitVec.toInt_signExtend', Nat.min_eq_left h]

attribute [simp] BitVec.signExtend_eq

theorem BitVec.toInt_signExtend_of_le'' {w v : Nat} (x : BitVec w) (h : w ≤ v) :
    (x.signExtend v).toInt = x.toInt := by
  by_cases hlt : w < v
  · rw [BitVec.toInt_signExtend_of_lt hlt]
  · obtain rfl : w = v := by omega
    simp

theorem BitVec.toNat_toInt_of_msb {w : Nat} (b : BitVec w) (hb : b.msb = false) : b.toInt.toNat = b.toNat := by
  simp [b.toInt_eq_toNat_of_msb hb]
theorem BitVec.slt_zero_eq_msb {w : Nat} {x : BitVec  w} : x.slt 0#w = x.msb := by
  rw [Bool.eq_iff_iff, BitVec.slt_zero_iff_msb_cond]
theorem BitVec.zero_sle_eq_not_msb {w : Nat} {x : BitVec w} : BitVec.sle 0#w x = !x.msb := by
  rw [BitVec.sle_eq_not_slt, BitVec.slt_zero_eq_msb]
theorem BitVec.zero_sle_iff_msb_eq_false {w : Nat} {x : BitVec w} : BitVec.sle 0#w x ↔ x.msb = false := by
  simp [zero_sle_eq_not_msb]
theorem BitVec.toNat_toInt_of_sle {w : Nat} (b : BitVec w) (hb : BitVec.sle 0#w b) : b.toInt.toNat = b.toNat :=
  BitVec.toNat_toInt_of_msb b (BitVec.zero_sle_iff_msb_eq_false.1 hb)

@[simp] theorem Int.toNat_le {m : Int} {n : Nat} : m.toNat ≤ n ↔ m ≤ n := by omega
@[simp] theorem Int.toNat_lt' {m : Int} {n : Nat} (hn : 0 < n) : m.toNat < n ↔ m < n := by omega

end MoveMe

open Lean in
set_option hygiene false in
macro "declare_int_theorems" typeName:ident _bits:term:arg : command => do
  let mut cmds ← Syntax.getArgs <$> `(
  namespace $typeName

  @[int_toBitVec] theorem le_def {a b : $typeName} : a ≤ b ↔ a.toBitVec.sle b.toBitVec := Iff.rfl
  @[int_toBitVec] theorem lt_def {a b : $typeName} : a < b ↔ a.toBitVec.slt b.toBitVec := Iff.rfl
  theorem toBitVec_inj {a b : $typeName} : a.toBitVec = b.toBitVec ↔ a = b :=
    ⟨toBitVec.inj, (· ▸ rfl)⟩
  @[int_toBitVec] theorem eq_iff_toBitVec_eq {a b : $typeName} : a = b ↔ a.toBitVec = b.toBitVec :=
    toBitVec_inj.symm
  @[int_toBitVec] theorem ne_iff_toBitVec_ne {a b : $typeName} : a ≠ b ↔ a.toBitVec ≠ b.toBitVec :=
    Decidable.not_iff_not.2 eq_iff_toBitVec_eq
  @[simp] theorem toBitVec_ofNat {n : Nat} : toBitVec (ofNat n) = BitVec.ofNat _ n := rfl
  @[simp, int_toBitVec] theorem toBitVec_ofNatOfNat {n : Nat} : toBitVec (no_index (OfNat.ofNat n)) = OfNat.ofNat n := rfl

  end $typeName
  )
  return ⟨mkNullNode cmds⟩

declare_int_theorems Int8 8
declare_int_theorems Int16 16
declare_int_theorems Int32 32
declare_int_theorems Int64 64
declare_int_theorems ISize System.Platform.numBits

@[simp] theorem ISize.toBitVec_neg (x : ISize) : (-x).toBitVec = -x.toBitVec := rfl
@[simp] theorem ISize.toBitVec_zero : (0 : ISize).toBitVec = 0 := rfl
@[simp] theorem ISize.toBitVec_ofInt (i : Int) : (ofInt i).toBitVec = BitVec.ofInt _ i := rfl

@[simp] theorem Int8.neg_zero : -(0 : Int8) = 0 := rfl
@[simp] theorem Int16.neg_zero : -(0 : Int16) = 0 := rfl
@[simp] theorem Int32.neg_zero : -(0 : Int32) = 0 := rfl
@[simp] theorem Int64.neg_zero : -(0 : Int64) = 0 := rfl
@[simp] theorem ISize.neg_zero : -(0 : ISize) = 0 := ISize.toBitVec.inj (by simp)

theorem ISize.toNat_toBitVec_ofNat_of_lt {n : Nat} (h : n < 2^32) :
    (ofNat n).toBitVec.toNat = n :=
  Nat.mod_eq_of_lt (Nat.lt_of_lt_of_le h (by cases USize.size_eq <;> simp_all +decide))

theorem ISize.toInt_ofInt {n : Int} (hn : -2^31 ≤ n) (hn' : n < 2^31) : toInt (ofInt n) = n := by
  rw [toInt, toBitVec_ofInt, BitVec.toInt_ofInt_eq_self] <;> cases System.Platform.numBits_eq
    <;> (simp_all; try omega)

theorem ISize.toInt_ofInt_of_two_pow_numBits_le {n : Int} (hn : -2 ^ (System.Platform.numBits - 1) ≤ n)
    (hn' : n < 2 ^ (System.Platform.numBits - 1)) : toInt (ofInt n) = n := by
  rw [toInt, toBitVec_ofInt, BitVec.toInt_ofInt_eq_self _ hn hn']
  cases System.Platform.numBits_eq <;> simp_all

theorem ISize.toNatClampNeg_ofInt_eq_zero {n : Int} (hn : -2^31 ≤ n) (hn' : n ≤ 0) :
    toNatClampNeg (ofInt n) = 0 := by
  rwa [toNatClampNeg, toInt_ofInt hn (by omega), Int.toNat_eq_zero]

theorem ISize.neg_ofInt {n : Int} : -ofInt n = ofInt (-n) :=
  toBitVec.inj (by simp [BitVec.ofInt_neg])

theorem ISize.ofInt_eq_ofNat {n : Nat} : ofInt n = ofNat n :=
  toBitVec.inj (by simp)

theorem ISize.neg_ofNat {n : Nat} : -ofNat n = ofInt (-n) := by
  rw [← neg_ofInt, ofInt_eq_ofNat]

theorem ISize.toNatClampNeg_ofNat_of_lt {n : Nat} (h : n < 2 ^ 31) :
    toNatClampNeg (ofNat n) = n := by
  rw [toNatClampNeg, ← ofInt_eq_ofNat, toInt_ofInt (by omega) (by omega), Int.toNat_ofNat]

theorem ISize.toNatClampNeg_neg_ofNat_of_le {n : Nat} (h : n ≤ 2 ^ 31) :
    toNatClampNeg (-ofNat n) = 0 := by
  rw [neg_ofNat, toNatClampNeg_ofInt_eq_zero (by omega) (by omega)]

theorem ISize.toInt_ofNat_of_lt {n : Nat} (h : n < 2 ^ 31) : toInt (ofNat n) = n := by
  rw [← ofInt_eq_ofNat, toInt_ofInt (by omega) (by omega)]

theorem ISize.toInt_neg_ofNat_of_le {n : Nat} (h : n ≤ 2 ^ 31) : toInt (-ofNat n) = -n := by
  rw [← ofInt_eq_ofNat, neg_ofInt, toInt_ofInt (by omega) (by omega)]

@[simp] theorem UInt8.toBitVec_toInt8 (x : UInt8) : x.toInt8.toBitVec = x.toBitVec := rfl
@[simp] theorem UInt16.toBitVec_toInt16 (x : UInt16) : x.toInt16.toBitVec = x.toBitVec := rfl
@[simp] theorem UInt32.toBitVec_toInt32 (x : UInt32) : x.toInt32.toBitVec = x.toBitVec := rfl
@[simp] theorem UInt64.toBitVec_toInt64 (x : UInt64) : x.toInt64.toBitVec = x.toBitVec := rfl
@[simp] theorem USize.toBitVec_toISize (x : USize) : x.toISize.toBitVec = x.toBitVec := rfl

@[simp] theorem Int8.ofBitVec_uInt8ToBitVec (x : UInt8) : Int8.ofBitVec x.toBitVec = x.toInt8 := rfl
@[simp] theorem Int16.ofBitVec_uInt16ToBitVec (x : UInt16) : Int16.ofBitVec x.toBitVec = x.toInt16 := rfl
@[simp] theorem Int32.ofBitVec_uInt32ToBitVec (x : UInt32) : Int32.ofBitVec x.toBitVec = x.toInt32 := rfl
@[simp] theorem Int64.ofBitVec_uInt64ToBitVec (x : UInt64) : Int64.ofBitVec x.toBitVec = x.toInt64 := rfl
@[simp] theorem ISize.ofBitVec_uSize8ToBitVec (x : USize) : ISize.ofBitVec x.toBitVec = x.toISize := rfl

@[simp] theorem UInt8.toUInt8_toInt8 (x : UInt8) : x.toInt8.toUInt8 = x := rfl
@[simp] theorem UInt16.toUInt16_toInt16 (x : UInt16) : x.toInt16.toUInt16 = x := rfl
@[simp] theorem UInt32.toUInt32_toInt32 (x : UInt32) : x.toInt32.toUInt32 = x := rfl
@[simp] theorem UInt64.toUInt64_toInt64 (x : UInt64) : x.toInt64.toUInt64 = x := rfl
@[simp] theorem USize.toUSize_toISize (x : USize) : x.toISize.toUSize = x := rfl

@[simp] theorem Int8.toNat_toInt (x : Int8) : x.toInt.toNat = x.toNatClampNeg := rfl
@[simp] theorem Int16.toNat_toInt (x : Int16) : x.toInt.toNat = x.toNatClampNeg := rfl
@[simp] theorem Int32.toNat_toInt (x : Int32) : x.toInt.toNat = x.toNatClampNeg := rfl
@[simp] theorem Int64.toNat_toInt (x : Int64) : x.toInt.toNat = x.toNatClampNeg := rfl
@[simp] theorem ISize.toNat_toInt (x : ISize) : x.toInt.toNat = x.toNatClampNeg := rfl

@[simp] theorem Int8.toInt_toBitVec (x : Int8) : x.toBitVec.toInt = x.toInt := rfl
@[simp] theorem Int16.toInt_toBitVec (x : Int16) : x.toBitVec.toInt = x.toInt := rfl
@[simp] theorem Int32.toInt_toBitVec (x : Int32) : x.toBitVec.toInt = x.toInt := rfl
@[simp] theorem Int64.toInt_toBitVec (x : Int64) : x.toBitVec.toInt = x.toInt := rfl
@[simp] theorem ISize.toInt_toBitVec (x : ISize) : x.toBitVec.toInt = x.toInt := rfl

@[simp] theorem Int8.toBitVec_toInt16 (x : Int8) : x.toInt16.toBitVec = x.toBitVec.signExtend 16 := rfl
@[simp] theorem Int8.toBitVec_toInt32 (x : Int8) : x.toInt32.toBitVec = x.toBitVec.signExtend 32 := rfl
@[simp] theorem Int8.toBitVec_toInt64 (x : Int8) : x.toInt64.toBitVec = x.toBitVec.signExtend 64 := rfl
@[simp] theorem Int8.toBitVec_toISize (x : Int8) : x.toISize.toBitVec = x.toBitVec.signExtend System.Platform.numBits := rfl

@[simp] theorem Int16.toBitVec_toInt8 (x : Int16) : x.toInt8.toBitVec = x.toBitVec.signExtend 8 := rfl
@[simp] theorem Int16.toBitVec_toInt32 (x : Int16) : x.toInt32.toBitVec = x.toBitVec.signExtend 32 := rfl
@[simp] theorem Int16.toBitVec_toInt64 (x : Int16) : x.toInt64.toBitVec = x.toBitVec.signExtend 64 := rfl
@[simp] theorem Int16.toBitVec_toISize (x : Int16) : x.toISize.toBitVec = x.toBitVec.signExtend System.Platform.numBits := rfl

@[simp] theorem Int32.toBitVec_toInt8 (x : Int32) : x.toInt8.toBitVec = x.toBitVec.signExtend 8 := rfl
@[simp] theorem Int32.toBitVec_toInt16 (x : Int32) : x.toInt16.toBitVec = x.toBitVec.signExtend 16 := rfl
@[simp] theorem Int32.toBitVec_toInt64 (x : Int32) : x.toInt64.toBitVec = x.toBitVec.signExtend 64 := rfl
@[simp] theorem Int32.toBitVec_toISize (x : Int32) : x.toISize.toBitVec = x.toBitVec.signExtend System.Platform.numBits := rfl

@[simp] theorem Int64.toBitVec_toInt8 (x : Int64) : x.toInt8.toBitVec = x.toBitVec.signExtend 8 := rfl
@[simp] theorem Int64.toBitVec_toInt16 (x : Int64) : x.toInt16.toBitVec = x.toBitVec.signExtend 16 := rfl
@[simp] theorem Int64.toBitVec_toInt32 (x : Int64) : x.toInt32.toBitVec = x.toBitVec.signExtend 32 := rfl
@[simp] theorem Int64.toBitVec_toISize (x : Int64) : x.toISize.toBitVec = x.toBitVec.signExtend System.Platform.numBits := rfl

@[simp] theorem ISize.toBitVec_toInt8 (x : ISize) : x.toInt8.toBitVec = x.toBitVec.signExtend 8 := rfl
@[simp] theorem ISize.toBitVec_toInt16 (x : ISize) : x.toInt16.toBitVec = x.toBitVec.signExtend 16 := rfl
@[simp] theorem ISize.toBitVec_toInt32 (x : ISize) : x.toInt32.toBitVec = x.toBitVec.signExtend 32 := rfl
@[simp] theorem ISize.toBitVec_toInt64 (x : ISize) : x.toInt64.toBitVec = x.toBitVec.signExtend 64 := rfl

theorem Int8.toInt_lt (x : Int8) : x.toInt < 2 ^ 7 := Int.lt_of_mul_lt_mul_left BitVec.toInt_lt (by decide)
theorem Int8.le_toInt (x : Int8) : -2 ^ 7 ≤ x.toInt := Int.le_of_mul_le_mul_left BitVec.le_toInt (by decide)
theorem Int16.toInt_lt (x : Int16) : x.toInt < 2 ^ 15 := Int.lt_of_mul_lt_mul_left BitVec.toInt_lt (by decide)
theorem Int16.le_toInt (x : Int16) : -2 ^ 15 ≤ x.toInt := Int.le_of_mul_le_mul_left BitVec.le_toInt (by decide)
theorem Int32.toInt_lt (x : Int32) : x.toInt < 2 ^ 31 := Int.lt_of_mul_lt_mul_left BitVec.toInt_lt (by decide)
theorem Int32.le_toInt (x : Int32) : -2 ^ 31 ≤ x.toInt := Int.le_of_mul_le_mul_left BitVec.le_toInt (by decide)
theorem Int64.toInt_lt (x : Int64) : x.toInt < 2 ^ 63 := Int.lt_of_mul_lt_mul_left BitVec.toInt_lt (by decide)
theorem Int64.le_toInt (x : Int64) : -2 ^ 63 ≤ x.toInt := Int.le_of_mul_le_mul_left BitVec.le_toInt (by decide)
theorem ISize.toInt_lt_two_pow_numBits (x : ISize) : x.toInt < 2 ^ (System.Platform.numBits - 1) := by
  have := x.toBitVec.toInt_lt; cases System.Platform.numBits_eq <;> simp_all <;> omega
theorem ISize.two_pow_numBits_le_toInt (x : ISize) : -2 ^ (System.Platform.numBits - 1) ≤ x.toInt := by
  have := x.toBitVec.le_toInt; cases System.Platform.numBits_eq <;> simp_all <;> omega
theorem ISize.toInt_lt (x : ISize) : x.toInt < 2 ^ 63 := by
  have := x.toBitVec.toInt_lt; cases System.Platform.numBits_eq <;> simp_all <;> omega
theorem ISize.le_toInt (x : ISize) : -2 ^ 63 ≤ x.toInt := by
  have := x.toBitVec.le_toInt; cases System.Platform.numBits_eq <;> simp_all <;> omega

theorem Int8.toInt_le (x : Int8) : x.toInt ≤ Int8.maxValue.toInt := Int.le_of_lt_add_one x.toInt_lt
theorem Int16.toInt_le (x : Int16) : x.toInt ≤ Int16.maxValue.toInt := Int.le_of_lt_add_one x.toInt_lt
theorem Int32.toInt_le (x : Int32) : x.toInt ≤ Int32.maxValue.toInt := Int.le_of_lt_add_one x.toInt_lt
theorem Int64.toInt_le (x : Int64) : x.toInt ≤ Int64.maxValue.toInt := Int.le_of_lt_add_one x.toInt_lt
theorem ISize.toInt_le (x : ISize) : x.toInt ≤ ISize.maxValue.toInt := by
  rw [toInt_ofInt_of_two_pow_numBits_le]
  · exact Int.le_of_lt_add_one (by simpa using x.toInt_lt_two_pow_numBits)
  · cases System.Platform.numBits_eq <;> simp_all
  · cases System.Platform.numBits_eq <;> simp_all
theorem Int8.minValue_le_toInt (x : Int8) : Int8.minValue.toInt ≤ x.toInt := x.le_toInt
theorem Int16.minValue_le_toInt (x : Int16) : Int16.minValue.toInt ≤ x.toInt := x.le_toInt
theorem Int32.minValue_le_toInt (x : Int32) : Int32.minValue.toInt ≤ x.toInt := x.le_toInt
theorem Int64.minValue_le_toInt (x : Int64) : Int64.minValue.toInt ≤ x.toInt := x.le_toInt
theorem ISize.minValue_le_toInt (x : ISize) : ISize.minValue.toInt ≤ x.toInt := by
  rw [toInt_ofInt_of_two_pow_numBits_le]
  · exact x.two_pow_numBits_le_toInt
  · cases System.Platform.numBits_eq <;> simp_all
  · cases System.Platform.numBits_eq <;> simp_all

theorem Int8.iSizeMinValue_le_toInt (x : Int8) : ISize.minValue.toInt ≤ x.toInt := sorry
theorem Int8.toInt_le_iSizeMaxValue (x : Int8) : x.toInt ≤ ISize.maxValue.toInt := sorry
theorem Int16.iSizeMinValue_le_toInt (x : Int16) : ISize.minValue.toInt ≤ x.toInt := sorry
theorem Int16.toInt_le_iSizeMaxValue (x : Int16) : x.toInt ≤ ISize.maxValue.toInt := sorry
theorem Int32.iSizeMinValue_le_toInt (x : Int32) : ISize.minValue.toInt ≤ x.toInt := sorry
theorem Int32.toInt_le_iSizeMaxValue (x : Int32) : x.toInt ≤ ISize.maxValue.toInt := sorry

theorem ISize.int64MinValue_le_toInt (x : ISize) : Int64.minValue.toInt ≤ x.toInt := sorry
theorem ISize.toInt_le_int64MaxValue (x : ISize) : x.toInt ≤ Int64.maxValue.toInt := sorry

theorem Int8.toNatClampNeg_lt (x : Int8) : x.toNatClampNeg < 2 ^ 7 := (Int.toNat_lt' (by decide)).2 x.toInt_lt
theorem Int16.toNatClampNeg_lt (x : Int16) : x.toNatClampNeg < 2 ^ 15 := (Int.toNat_lt' (by decide)).2 x.toInt_lt
theorem Int32.toNatClampNeg_lt (x : Int32) : x.toNatClampNeg < 2 ^ 31 := (Int.toNat_lt' (by decide)).2 x.toInt_lt
theorem Int64.toNatClampNeg_lt (x : Int64) : x.toNatClampNeg < 2 ^ 63 := (Int.toNat_lt' (by decide)).2 x.toInt_lt
theorem ISize.toNatClampNeg_lt_two_pow_numBits (x : ISize) : x.toNatClampNeg < 2 ^ (System.Platform.numBits - 1) := by
  rw [toNatClampNeg, Int.toNat_lt', Int.natCast_pow]
  · exact x.toInt_lt_two_pow_numBits
  · cases System.Platform.numBits_eq <;> simp_all
theorem ISize.toNatClampNeg_lt (x : ISize) : x.toNatClampNeg < 2 ^ 63 := (Int.toNat_lt' (by decide)).2 x.toInt_lt

@[simp] theorem Int8.toInt_toInt16 (x : Int8) : x.toInt16.toInt = x.toInt :=
  x.toBitVec.toInt_signExtend_of_lt (by decide)
@[simp] theorem Int8.toInt_toInt32 (x : Int8) : x.toInt32.toInt = x.toInt :=
  x.toBitVec.toInt_signExtend_of_lt (by decide)
@[simp] theorem Int8.toInt_toInt64 (x : Int8) : x.toInt64.toInt = x.toInt :=
  x.toBitVec.toInt_signExtend_of_lt (by decide)
@[simp] theorem Int8.toInt_toISize (x : Int8) : x.toISize.toInt = x.toInt :=
  x.toBitVec.toInt_signExtend_of_lt (by cases System.Platform.numBits_eq <;> simp_all)

@[simp] theorem Int16.toInt_toInt8 (x : Int16) : x.toInt8.toInt = x.toInt.bmod (2 ^ 8) :=
  x.toBitVec.toInt_signExtend_of_le' (by decide)
@[simp] theorem Int16.toInt_toInt32 (x : Int16) : x.toInt32.toInt = x.toInt :=
  x.toBitVec.toInt_signExtend_of_lt (by decide)
@[simp] theorem Int16.toInt_toInt64 (x : Int16) : x.toInt64.toInt = x.toInt :=
  x.toBitVec.toInt_signExtend_of_lt (by decide)
@[simp] theorem Int16.toInt_toISize (x : Int16) : x.toISize.toInt = x.toInt :=
  x.toBitVec.toInt_signExtend_of_lt (by cases System.Platform.numBits_eq <;> simp_all)

@[simp] theorem Int32.toInt_toInt8 (x : Int32) : x.toInt8.toInt = x.toInt.bmod (2 ^ 8) :=
  x.toBitVec.toInt_signExtend_of_le' (by decide)
@[simp] theorem Int32.toInt_toInt16 (x : Int32) : x.toInt16.toInt = x.toInt.bmod (2 ^ 16) :=
  x.toBitVec.toInt_signExtend_of_le' (by decide)
@[simp] theorem Int32.toInt_toInt64 (x : Int32) : x.toInt64.toInt = x.toInt :=
  x.toBitVec.toInt_signExtend_of_lt (by decide)
@[simp] theorem Int32.toInt_toISize (x : Int32) : x.toISize.toInt = x.toInt :=
  x.toBitVec.toInt_signExtend_of_le'' (by cases System.Platform.numBits_eq <;> simp_all)

@[simp] theorem Int64.toInt_toInt8 (x : Int64) : x.toInt8.toInt = x.toInt.bmod (2 ^ 8) :=
  x.toBitVec.toInt_signExtend_of_le' (by decide)
@[simp] theorem Int64.toInt_toInt16 (x : Int64) : x.toInt16.toInt = x.toInt.bmod (2 ^ 16) :=
  x.toBitVec.toInt_signExtend_of_le' (by decide)
@[simp] theorem Int64.toInt_toInt32 (x : Int64) : x.toInt32.toInt = x.toInt.bmod (2 ^ 32) :=
  x.toBitVec.toInt_signExtend_of_le' (by decide)
@[simp] theorem Int64.toInt_toISize (x : Int64) : x.toISize.toInt = x.toInt.bmod (2 ^ System.Platform.numBits) :=
  x.toBitVec.toInt_signExtend_of_le' (by cases System.Platform.numBits_eq <;> simp_all)

@[simp] theorem ISize.toInt_toInt8 (x : ISize) : x.toInt8.toInt = x.toInt.bmod (2 ^ 8) :=
  x.toBitVec.toInt_signExtend_of_le' (by cases System.Platform.numBits_eq <;> simp_all)
@[simp] theorem ISize.toInt_toInt16 (x : ISize) : x.toInt16.toInt = x.toInt.bmod (2 ^ 16) :=
  x.toBitVec.toInt_signExtend_of_le' (by cases System.Platform.numBits_eq <;> simp_all)
@[simp] theorem ISize.toInt_toInt32 (x : ISize) : x.toInt32.toInt = x.toInt.bmod (2 ^ 32) :=
  x.toBitVec.toInt_signExtend_of_le' (by cases System.Platform.numBits_eq <;> simp_all)
@[simp] theorem ISize.toInt_toInt64 (x : ISize) : x.toInt64.toInt = x.toInt :=
  x.toBitVec.toInt_signExtend_of_le'' (by cases System.Platform.numBits_eq <;> simp_all)

@[simp] theorem Int8.toNatClampNeg_toInt16 (x : Int8) : x.toInt16.toNatClampNeg = x.toNatClampNeg :=
  congrArg Int.toNat x.toInt_toInt16
@[simp] theorem Int8.toNatClampNeg_toInt32 (x : Int8) : x.toInt32.toNatClampNeg = x.toNatClampNeg :=
  congrArg Int.toNat x.toInt_toInt32
@[simp] theorem Int8.toNatClampNeg_toInt64 (x : Int8) : x.toInt64.toNatClampNeg = x.toNatClampNeg :=
  congrArg Int.toNat x.toInt_toInt64
@[simp] theorem Int8.toNatClampNeg_toISize (x : Int8) : x.toISize.toNatClampNeg = x.toNatClampNeg :=
  congrArg Int.toNat x.toInt_toISize

@[simp] theorem Int16.toNatClampNeg_toInt32 (x : Int16) : x.toInt32.toNatClampNeg = x.toNatClampNeg :=
  congrArg Int.toNat x.toInt_toInt32
@[simp] theorem Int16.toNatClampNeg_toInt64 (x : Int16) : x.toInt64.toNatClampNeg = x.toNatClampNeg :=
  congrArg Int.toNat x.toInt_toInt64
@[simp] theorem Int16.toNatClampNeg_toISize (x : Int16) : x.toISize.toNatClampNeg = x.toNatClampNeg :=
  congrArg Int.toNat x.toInt_toISize

@[simp] theorem Int32.toNatClampNeg_toInt64 (x : Int32) : x.toInt64.toNatClampNeg = x.toNatClampNeg :=
  congrArg Int.toNat x.toInt_toInt64
@[simp] theorem Int32.toNatClampNeg_toISize (x : Int32) : x.toISize.toNatClampNeg = x.toNatClampNeg :=
  congrArg Int.toNat x.toInt_toISize

@[simp] theorem ISize.toNatClampNeg_toInt64 (x : ISize) : x.toInt64.toNatClampNeg = x.toNatClampNeg :=
  congrArg Int.toNat x.toInt_toInt64

@[simp] theorem Int8.toInt8_toUInt8 (x : Int8) : x.toUInt8.toInt8 = x := rfl
@[simp] theorem Int16.toInt16_toUInt16 (x : Int16) : x.toUInt16.toInt16 = x := rfl
@[simp] theorem Int32.toInt32_toUInt32 (x : Int32) : x.toUInt32.toInt32 = x := rfl
@[simp] theorem Int64.toInt64_toUInt64 (x : Int64) : x.toUInt64.toInt64 = x := rfl
@[simp] theorem ISize.toISize_toUSize (x : ISize) : x.toUSize.toISize = x := rfl

-- TODO: possibly good simp lemmas in the reverse direction?
theorem Int8.toNat_toBitVec (x : Int8) : x.toBitVec.toNat = x.toUInt8.toNat := rfl
theorem Int16.toNat_toBitVec (x : Int16) : x.toBitVec.toNat = x.toUInt16.toNat := rfl
theorem Int32.toNat_toBitVec (x : Int32) : x.toBitVec.toNat = x.toUInt32.toNat := rfl
theorem Int64.toNat_toBitVec (x : Int64) : x.toBitVec.toNat = x.toUInt64.toNat := rfl
theorem ISize.toNat_toBitVec (x : ISize) : x.toBitVec.toNat = x.toUSize.toNat := rfl

theorem Int8.toNat_toBitVec_of_le {x : Int8} (hx : 0 ≤ x) : x.toBitVec.toNat = x.toNatClampNeg :=
  (x.toBitVec.toNat_toInt_of_sle hx).symm
theorem Int16.toNat_toBitVec_of_le {x : Int16} (hx : 0 ≤ x) : x.toBitVec.toNat = x.toNatClampNeg :=
  (x.toBitVec.toNat_toInt_of_sle hx).symm
theorem Int32.toNat_toBitVec_of_le {x : Int32} (hx : 0 ≤ x) : x.toBitVec.toNat = x.toNatClampNeg :=
  (x.toBitVec.toNat_toInt_of_sle hx).symm
theorem Int64.toNat_toBitVec_of_le {x : Int64} (hx : 0 ≤ x) : x.toBitVec.toNat = x.toNatClampNeg :=
  (x.toBitVec.toNat_toInt_of_sle hx).symm
theorem ISize.toNat_toBitVec_of_le {x : ISize} (hx : 0 ≤ x) : x.toBitVec.toNat = x.toNatClampNeg :=
  (x.toBitVec.toNat_toInt_of_sle hx).symm

theorem Int8.toNat_toUInt8_of_le {x : Int8} (hx : 0 ≤ x) : x.toUInt8.toNat = x.toNatClampNeg := by
  rw [← toNat_toBitVec, toNat_toBitVec_of_le hx]
theorem Int16.toNat_toUInt16_of_le {x : Int16} (hx : 0 ≤ x) : x.toUInt16.toNat = x.toNatClampNeg := by
  rw [← toNat_toBitVec, toNat_toBitVec_of_le hx]
theorem Int32.toNat_toUInt32_of_le {x : Int32} (hx : 0 ≤ x) : x.toUInt32.toNat = x.toNatClampNeg := by
  rw [← toNat_toBitVec, toNat_toBitVec_of_le hx]
theorem Int64.toNat_toUInt64_of_le {x : Int64} (hx : 0 ≤ x) : x.toUInt64.toNat = x.toNatClampNeg := by
  rw [← toNat_toBitVec, toNat_toBitVec_of_le hx]
theorem ISize.toNat_toUISize_of_le {x : ISize} (hx : 0 ≤ x) : x.toUSize.toNat = x.toNatClampNeg := by
  rw [← toNat_toBitVec, toNat_toBitVec_of_le hx]

-- TODO: possibly good simp lemmas in the reverse direction?
theorem Int8.toFin_toBitVec (x : Int8) : x.toBitVec.toFin = x.toUInt8.toFin := rfl
theorem Int16.toFin_toBitVec (x : Int16) : x.toBitVec.toFin = x.toUInt16.toFin := rfl
theorem Int32.toFin_toBitVec (x : Int32) : x.toBitVec.toFin = x.toUInt32.toFin := rfl
theorem Int64.toFin_toBitVec (x : Int64) : x.toBitVec.toFin = x.toUInt64.toFin := rfl
theorem ISize.toFin_toBitVec (x : ISize) : x.toBitVec.toFin = x.toUSize.toFin := rfl

@[simp] theorem Int8.toBitVec_toUInt8 (x : Int8) : x.toUInt8.toBitVec = x.toBitVec := rfl
@[simp] theorem Int16.toBitVec_toUInt16 (x : Int16) : x.toUInt16.toBitVec = x.toBitVec := rfl
@[simp] theorem Int32.toBitVec_toUInt32 (x : Int32) : x.toUInt32.toBitVec = x.toBitVec := rfl
@[simp] theorem Int64.toBitVec_toUInt64 (x : Int64) : x.toUInt64.toBitVec = x.toBitVec := rfl
@[simp] theorem ISize.toBitVec_toUISize (x : ISize) : x.toUSize.toBitVec = x.toBitVec := rfl

@[simp] theorem UInt8.ofBitVec_int8ToBitVec (x : Int8) : UInt8.ofBitVec x.toBitVec = x.toUInt8 := rfl
@[simp] theorem UInt16.ofBitVec_int16ToBitVec (x : Int16) : UInt16.ofBitVec x.toBitVec = x.toUInt16 := rfl
@[simp] theorem UInt32.ofBitVec_int32ToBitVec (x : Int32) : UInt32.ofBitVec x.toBitVec = x.toUInt32 := rfl
@[simp] theorem UInt64.ofBitVec_int64ToBitVec (x : Int64) : UInt64.ofBitVec x.toBitVec = x.toUInt64 := rfl
@[simp] theorem USize.ofBitVec_iSizeToBitVec (x : ISize) : USize.ofBitVec x.toBitVec = x.toUSize := rfl

@[simp] theorem Int8.ofBitVec_toBitVec (x : Int8) : Int8.ofBitVec x.toBitVec = x := rfl
@[simp] theorem Int16.ofBitVec_toBitVec (x : Int16) : Int16.ofBitVec x.toBitVec = x := rfl
@[simp] theorem Int32.ofBitVec_toBitVec (x : Int32) : Int32.ofBitVec x.toBitVec = x := rfl
@[simp] theorem Int64.ofBitVec_toBitVec (x : Int64) : Int64.ofBitVec x.toBitVec = x := rfl
@[simp] theorem ISize.ofBitVec_toBitVec (x : ISize) : ISize.ofBitVec x.toBitVec = x := rfl

@[simp] theorem Int8.ofBitVec_int16ToBitVec (x : Int16) : Int8.ofBitVec (x.toBitVec.signExtend 8) = x.toInt8 := rfl
@[simp] theorem Int8.ofBitVec_int32ToBitVec (x : Int32) : Int8.ofBitVec (x.toBitVec.signExtend 8) = x.toInt8 := rfl
@[simp] theorem Int8.ofBitVec_int64ToBitVec (x : Int64) : Int8.ofBitVec (x.toBitVec.signExtend 8) = x.toInt8 := rfl
@[simp] theorem Int8.ofBitVec_iSizeToBitVec (x : ISize) : Int8.ofBitVec (x.toBitVec.signExtend 8) = x.toInt8 := rfl

@[simp] theorem Int16.ofBitVec_int8toBitVec (x : Int8) : Int16.ofBitVec (x.toBitVec.signExtend 16) = x.toInt16 := rfl
@[simp] theorem Int16.ofBitVec_int32ToBitVec (x : Int32) : Int16.ofBitVec (x.toBitVec.signExtend 16) = x.toInt16 := rfl
@[simp] theorem Int16.ofBitVec_int64ToBitVec (x : Int64) : Int16.ofBitVec (x.toBitVec.signExtend 16) = x.toInt16 := rfl
@[simp] theorem Int16.ofBitVec_iSizeToBitVec (x : ISize) : Int16.ofBitVec (x.toBitVec.signExtend 16) = x.toInt16 := rfl

@[simp] theorem Int32.ofBitVec_int8toBitVec (x : Int8) : Int32.ofBitVec (x.toBitVec.signExtend 32) = x.toInt32 := rfl
@[simp] theorem Int32.ofBitVec_int16ToBitVec (x : Int16) : Int32.ofBitVec (x.toBitVec.signExtend 32) = x.toInt32 := rfl
@[simp] theorem Int32.ofBitVec_int64ToBitVec (x : Int64) : Int32.ofBitVec (x.toBitVec.signExtend 32) = x.toInt32 := rfl
@[simp] theorem Int32.ofBitVec_iSizeToBitVec (x : ISize) : Int32.ofBitVec (x.toBitVec.signExtend 32) = x.toInt32 := rfl

@[simp] theorem Int64.ofBitVec_int8toBitVec (x : Int8) : Int64.ofBitVec (x.toBitVec.signExtend 64) = x.toInt64 := rfl
@[simp] theorem Int64.ofBitVec_int16ToBitVec (x : Int16) : Int64.ofBitVec (x.toBitVec.signExtend 64) = x.toInt64 := rfl
@[simp] theorem Int64.ofBitVec_int32ToBitVec (x : Int32) : Int64.ofBitVec (x.toBitVec.signExtend 64) = x.toInt64 := rfl
@[simp] theorem Int64.ofBitVec_iSizeToBitVec (x : ISize) : Int64.ofBitVec (x.toBitVec.signExtend 64) = x.toInt64 := rfl

@[simp] theorem ISize.ofBitVec_int8toBitVec (x : Int8) : ISize.ofBitVec (x.toBitVec.signExtend System.Platform.numBits) = x.toISize := rfl
@[simp] theorem ISize.ofBitVec_int16ToBitVec (x : Int16) : ISize.ofBitVec (x.toBitVec.signExtend System.Platform.numBits) = x.toISize := rfl
@[simp] theorem ISize.ofBitVec_int32ToBitVec (x : Int32) : ISize.ofBitVec (x.toBitVec.signExtend System.Platform.numBits) = x.toISize := rfl
@[simp] theorem ISize.ofBitVec_int64ToBitVec (x : Int64) : ISize.ofBitVec (x.toBitVec.signExtend System.Platform.numBits) = x.toISize := rfl

@[simp] theorem Int8.toBitVec_ofIntLE (x : Int) (h₁ h₂) : (Int8.ofIntLE x h₁ h₂).toBitVec = BitVec.ofInt 8 x := rfl
@[simp] theorem Int16.toBitVec_ofIntLE (x : Int) (h₁ h₂) : (Int16.ofIntLE x h₁ h₂).toBitVec = BitVec.ofInt 16 x := rfl
@[simp] theorem Int32.toBitVec_ofIntLE (x : Int) (h₁ h₂) : (Int32.ofIntLE x h₁ h₂).toBitVec = BitVec.ofInt 32 x := rfl
@[simp] theorem Int64.toBitVec_ofIntLE (x : Int) (h₁ h₂) : (Int64.ofIntLE x h₁ h₂).toBitVec = BitVec.ofInt 64 x := rfl
@[simp] theorem ISize.toBitVec_ofIntLE (x : Int) (h₁ h₂) : (ISize.ofIntLE x h₁ h₂).toBitVec = BitVec.ofInt System.Platform.numBits x := rfl

@[simp] theorem Int8.toInt_bmod (x : Int8) : x.toInt.bmod 256 = x.toInt := Int.bmod_eq_self_of_le x.le_toInt x.toInt_lt
@[simp] theorem Int16.toInt_bmod (x : Int16) : x.toInt.bmod 65536 = x.toInt := Int.bmod_eq_self_of_le x.le_toInt x.toInt_lt
@[simp] theorem Int32.toInt_bmod (x : Int32) : x.toInt.bmod 4294967296 = x.toInt := Int.bmod_eq_self_of_le x.le_toInt x.toInt_lt
@[simp] theorem Int64.toInt_bmod (x : Int64) : x.toInt.bmod 18446744073709551616 = x.toInt := Int.bmod_eq_self_of_le x.le_toInt x.toInt_lt
@[simp] theorem ISize.toInt_bmod_two_pow_numBits (x : ISize) : x.toInt.bmod (2 ^ System.Platform.numBits) = x.toInt := by
  refine Int.bmod_eq_self_of_le ?_ ?_
  · have := x.two_pow_numBits_le_toInt
    cases System.Platform.numBits_eq <;> simp_all
  · have := x.toInt_lt_two_pow_numBits
    cases System.Platform.numBits_eq <;> simp_all

@[simp] theorem BitVec.ofInt_int8ToInt (x : Int8) : BitVec.ofInt 8 x.toInt = x.toBitVec := BitVec.eq_of_toInt_eq (by simp)
@[simp] theorem BitVec.ofInt_int16ToInt (x : Int16) : BitVec.ofInt 16 x.toInt = x.toBitVec := BitVec.eq_of_toInt_eq (by simp)
@[simp] theorem BitVec.ofInt_int32ToInt (x : Int32) : BitVec.ofInt 32 x.toInt = x.toBitVec := BitVec.eq_of_toInt_eq (by simp)
@[simp] theorem BitVec.ofInt_int64ToInt (x : Int64) : BitVec.ofInt 64 x.toInt = x.toBitVec := BitVec.eq_of_toInt_eq (by simp)
@[simp] theorem BitVec.ofInt_iSizeToInt (x : ISize) : BitVec.ofInt System.Platform.numBits x.toInt = x.toBitVec :=
  BitVec.eq_of_toInt_eq (by simp)

@[simp] theorem Int8.ofIntLE_toInt (x : Int8) : Int8.ofIntLE x.toInt x.minValue_le_toInt x.toInt_le = x := Int8.toBitVec.inj (by simp)
@[simp] theorem Int16.ofIntLE_toInt (x : Int16) : Int16.ofIntLE x.toInt x.minValue_le_toInt x.toInt_le = x := Int16.toBitVec.inj (by simp)
@[simp] theorem Int32.ofIntLE_toInt (x : Int32) : Int32.ofIntLE x.toInt x.minValue_le_toInt x.toInt_le = x := Int32.toBitVec.inj (by simp)
@[simp] theorem Int64.ofIntLE_toInt (x : Int64) : Int64.ofIntLE x.toInt x.minValue_le_toInt x.toInt_le = x := Int64.toBitVec.inj (by simp)
@[simp] theorem ISize.ofIntLE_toInt (x : ISize) : ISize.ofIntLE x.toInt x.minValue_le_toInt x.toInt_le = x := ISize.toBitVec.inj (by simp)

theorem Int8.ofIntLE_int16ToInt (x : Int16) {h₁ h₂} : Int8.ofIntLE x.toInt h₁ h₂ = x.toInt8 := rfl
theorem Int8.ofIntLE_int32ToInt (x : Int32) {h₁ h₂} : Int8.ofIntLE x.toInt h₁ h₂ = x.toInt8 := rfl
theorem Int8.ofIntLE_int64ToInt (x : Int64) {h₁ h₂} : Int8.ofIntLE x.toInt h₁ h₂ = x.toInt8 := rfl
theorem Int8.ofIntLE_iSizeToInt (x : ISize) {h₁ h₂} : Int8.ofIntLE x.toInt h₁ h₂ = x.toInt8 := rfl

@[simp] theorem Int16.ofIntLE_int8ToInt (x : Int8) :
    Int16.ofIntLE x.toInt (Int.le_trans (by decide) x.minValue_le_toInt) (Int.le_trans x.toInt_le (by decide)) = x.toInt16 := rfl
theorem Int16.ofIntLE_int32ToInt (x : Int32) {h₁ h₂} : Int16.ofIntLE x.toInt h₁ h₂ = x.toInt16 := rfl
theorem Int16.ofIntLE_int64ToInt (x : Int64) {h₁ h₂} : Int16.ofIntLE x.toInt h₁ h₂ = x.toInt16 := rfl
theorem Int16.ofIntLE_iSizeToInt (x : ISize) {h₁ h₂} : Int16.ofIntLE x.toInt h₁ h₂ = x.toInt16 := rfl

@[simp] theorem Int32.ofIntLE_int8ToInt (x : Int8) :
    Int32.ofIntLE x.toInt (Int.le_trans (by decide) x.minValue_le_toInt) (Int.le_trans x.toInt_le (by decide)) = x.toInt32 := rfl
@[simp] theorem Int32.ofIntLE_int16ToInt (x : Int16) :
    Int32.ofIntLE x.toInt (Int.le_trans (by decide) x.minValue_le_toInt) (Int.le_trans x.toInt_le (by decide)) = x.toInt32 := rfl
theorem Int32.ofIntLE_int64ToInt (x : Int64) {h₁ h₂} : Int32.ofIntLE x.toInt h₁ h₂ = x.toInt32 := rfl
theorem Int32.ofIntLE_iSizeToInt (x : ISize) {h₁ h₂} : Int32.ofIntLE x.toInt h₁ h₂ = x.toInt32 := rfl

@[simp] theorem Int64.ofIntLE_int8ToInt (x : Int8) :
    Int64.ofIntLE x.toInt (Int.le_trans (by decide) x.minValue_le_toInt) (Int.le_trans x.toInt_le (by decide)) = x.toInt64 := rfl
@[simp] theorem Int64.ofIntLE_int16ToInt (x : Int16) :
    Int64.ofIntLE x.toInt (Int.le_trans (by decide) x.minValue_le_toInt) (Int.le_trans x.toInt_le (by decide)) = x.toInt64 := rfl
@[simp] theorem Int64.ofIntLE_int32ToInt (x : Int32) :
    Int64.ofIntLE x.toInt (Int.le_trans (by decide) x.minValue_le_toInt) (Int.le_trans x.toInt_le (by decide)) = x.toInt64 := rfl
@[simp] theorem Int64.ofIntLE_iSizeToInt (x : ISize) :
    Int64.ofIntLE x.toInt x.int64MinValue_le_toInt x.toInt_le_int64MaxValue = x.toInt64 := rfl

@[simp] theorem ISize.ofIntLE_int8ToInt (x : Int8) :
    ISize.ofIntLE x.toInt x.iSizeMinValue_le_toInt x.toInt_le_iSizeMaxValue = x.toISize := rfl
@[simp] theorem ISize.ofIntLE_int16ToInt (x : Int16) :
    ISize.ofIntLE x.toInt x.iSizeMinValue_le_toInt x.toInt_le_iSizeMaxValue = x.toISize := rfl
@[simp] theorem ISize.ofIntLE_int32ToInt (x : Int32) :
    ISize.ofIntLE x.toInt x.iSizeMinValue_le_toInt x.toInt_le_iSizeMaxValue = x.toISize := rfl
theorem ISize.ofIntLE_int64ToInt (x : Int64) {h₁ h₂} : ISize.ofIntLE x.toInt h₁ h₂ = x.toISize := rfl
