// Lean compiler output
// Module: Lean.Meta.Tactic.Grind.MarkNestedProofs
// Imports: Init.Grind.Util Lean.Util.PtrSet Lean.Meta.Transform Lean.Meta.Basic Lean.Meta.InferType Lean.Meta.Tactic.Grind.Util
#include <lean/lean.h>
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
lean_object* l_Lean_Expr_const___override(lean_object*, lean_object*);
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__4;
lean_object* l_Lean_mkAppN(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofs_unsafe__1(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Lean_Expr_0__Lean_Expr_getAppNumArgsAux(lean_object*, lean_object*);
lean_object* l_Lean_mkAppB(lean_object*, lean_object*, lean_object*);
uint64_t lean_uint64_mix_hash(uint64_t, uint64_t);
lean_object* l_Lean_Meta_Grind_unfoldReducible___lambda__3(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
size_t lean_uint64_to_usize(uint64_t);
LEAN_EXPORT lean_object* l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
uint8_t l_Lean_Expr_isApp(lean_object*);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_Expr_sort___override(lean_object*);
static lean_object* l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7___closed__1;
uint8_t lean_usize_dec_eq(size_t, size_t);
lean_object* lean_mk_array(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofs(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_Expr_proj___override(lean_object*, lean_object*, lean_object*);
lean_object* lean_array_fset(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_AssocList_replace___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__6(lean_object*, lean_object*, lean_object*);
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__2;
uint8_t l_Lean_Expr_isAppOf(lean_object*, lean_object*);
LEAN_EXPORT uint8_t l_Std_DHashMap_Internal_AssocList_contains___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__1(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_AssocList_contains___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__1___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__1(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__1___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Std_Range_forIn_x27_loop___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__8___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_AssocList_get_x3f___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__10___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Std_Range_forIn_x27_loop___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__8(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__3;
size_t lean_ptr_addr(lean_object*);
lean_object* l_Lean_Name_mkStr3(lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_mkPtrMap___rarg(lean_object*);
size_t lean_usize_of_nat(lean_object*);
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__1;
lean_object* lean_st_ref_take(lean_object*, lean_object*);
uint64_t lean_uint64_shift_right(uint64_t, uint64_t);
uint64_t lean_usize_to_uint64(size_t);
static lean_object* l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7___closed__2;
lean_object* lean_nat_div(lean_object*, lean_object*);
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__6;
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__2___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__1;
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_Expr_forallE___override(lean_object*, lean_object*, lean_object*, uint8_t);
lean_object* lean_st_ref_get(lean_object*, lean_object*);
lean_object* lean_st_mk_ref(lean_object*, lean_object*);
lean_object* l_Lean_Meta_Grind_unfoldReducible___lambda__4___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
uint8_t l_Lean_Expr_hasLooseBVars(lean_object*);
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__2;
extern lean_object* l_Lean_levelZero;
extern lean_object* l_Lean_instInhabitedExpr;
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__9;
lean_object* l_Lean_Core_betaReduce___lambda__1___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_Raw_u2080_expand_go___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__3(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__7(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Util_0__mkPanicMessageWithDecl(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
extern lean_object* l_Lean_Meta_instMonadMetaM;
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_AssocList_get_x3f___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__10(lean_object*, lean_object*);
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl___closed__1;
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_Core_transform___at_Lean_Core_betaReduce___spec__1(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* lean_array_fget(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_AssocList_foldlM___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__4(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Lean_Expr_withAppAux___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__9(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__4(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_AssocList_foldlM___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__4___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__5(lean_object*, lean_object*);
uint8_t lean_nat_dec_lt(lean_object*, lean_object*);
uint8_t l_Lean_Expr_isProj(lean_object*);
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__5;
lean_object* lean_array_set(lean_object*, lean_object*, lean_object*);
uint64_t lean_uint64_xor(uint64_t, uint64_t);
lean_object* lean_panic_fn(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_nat_mul(lean_object*, lean_object*);
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__3;
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_Raw_u2080_expand___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__2(lean_object*);
size_t lean_usize_sub(size_t, size_t);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__4___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* lean_array_uget(lean_object*, size_t);
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__4;
lean_object* l_instInhabitedOfMonad___rarg(lean_object*, lean_object*);
lean_object* lean_st_ref_set(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__2(lean_object*, lean_object*, lean_object*, uint8_t, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_Core_transform___at_Lean_Elab_Term_exposeLevelMVars___spec__1(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* lean_array_get_size(lean_object*);
lean_object* lean_array_get(lean_object*, lean_object*, lean_object*);
lean_object* lean_infer_type(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__7___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__7;
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__5;
lean_object* lean_nat_add(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
uint8_t l_Lean_Expr_isForall(lean_object*);
static lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__8;
lean_object* lean_array_uset(lean_object*, size_t, lean_object*);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__5(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_Meta_isProof(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_ReaderT_instMonad___rarg(lean_object*);
size_t lean_usize_land(size_t, size_t);
lean_object* l_Lean_Core_betaReduce___lambda__2___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__5___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
uint8_t l___private_Lean_Expr_0__Lean_beqBinderInfo____x40_Lean_Expr___hyg_406_(uint8_t, uint8_t);
LEAN_EXPORT uint8_t l_Std_DHashMap_Internal_AssocList_contains___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__1(lean_object* x_1, lean_object* x_2) {
_start:
{
if (lean_obj_tag(x_2) == 0)
{
uint8_t x_3; 
x_3 = 0;
return x_3;
}
else
{
lean_object* x_4; lean_object* x_5; size_t x_6; size_t x_7; uint8_t x_8; 
x_4 = lean_ctor_get(x_2, 0);
x_5 = lean_ctor_get(x_2, 2);
x_6 = lean_ptr_addr(x_4);
x_7 = lean_ptr_addr(x_1);
x_8 = lean_usize_dec_eq(x_6, x_7);
if (x_8 == 0)
{
x_2 = x_5;
goto _start;
}
else
{
uint8_t x_10; 
x_10 = 1;
return x_10;
}
}
}
}
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_AssocList_foldlM___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__4(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
if (lean_obj_tag(x_3) == 0)
{
lean_dec(x_1);
return x_2;
}
else
{
uint8_t x_4; 
x_4 = !lean_is_exclusive(x_3);
if (x_4 == 0)
{
lean_object* x_5; lean_object* x_6; lean_object* x_7; lean_object* x_8; uint64_t x_9; uint64_t x_10; uint64_t x_11; uint64_t x_12; uint64_t x_13; uint64_t x_14; uint64_t x_15; size_t x_16; size_t x_17; size_t x_18; size_t x_19; size_t x_20; lean_object* x_21; lean_object* x_22; 
x_5 = lean_ctor_get(x_3, 0);
x_6 = lean_ctor_get(x_3, 2);
x_7 = lean_array_get_size(x_2);
lean_inc(x_1);
lean_inc(x_5);
x_8 = lean_apply_1(x_1, x_5);
x_9 = lean_unbox_uint64(x_8);
lean_dec(x_8);
x_10 = 32;
x_11 = lean_uint64_shift_right(x_9, x_10);
x_12 = lean_uint64_xor(x_9, x_11);
x_13 = 16;
x_14 = lean_uint64_shift_right(x_12, x_13);
x_15 = lean_uint64_xor(x_12, x_14);
x_16 = lean_uint64_to_usize(x_15);
x_17 = lean_usize_of_nat(x_7);
lean_dec(x_7);
x_18 = 1;
x_19 = lean_usize_sub(x_17, x_18);
x_20 = lean_usize_land(x_16, x_19);
x_21 = lean_array_uget(x_2, x_20);
lean_ctor_set(x_3, 2, x_21);
x_22 = lean_array_uset(x_2, x_20, x_3);
x_2 = x_22;
x_3 = x_6;
goto _start;
}
else
{
lean_object* x_24; lean_object* x_25; lean_object* x_26; lean_object* x_27; lean_object* x_28; uint64_t x_29; uint64_t x_30; uint64_t x_31; uint64_t x_32; uint64_t x_33; uint64_t x_34; uint64_t x_35; size_t x_36; size_t x_37; size_t x_38; size_t x_39; size_t x_40; lean_object* x_41; lean_object* x_42; lean_object* x_43; 
x_24 = lean_ctor_get(x_3, 0);
x_25 = lean_ctor_get(x_3, 1);
x_26 = lean_ctor_get(x_3, 2);
lean_inc(x_26);
lean_inc(x_25);
lean_inc(x_24);
lean_dec(x_3);
x_27 = lean_array_get_size(x_2);
lean_inc(x_1);
lean_inc(x_24);
x_28 = lean_apply_1(x_1, x_24);
x_29 = lean_unbox_uint64(x_28);
lean_dec(x_28);
x_30 = 32;
x_31 = lean_uint64_shift_right(x_29, x_30);
x_32 = lean_uint64_xor(x_29, x_31);
x_33 = 16;
x_34 = lean_uint64_shift_right(x_32, x_33);
x_35 = lean_uint64_xor(x_32, x_34);
x_36 = lean_uint64_to_usize(x_35);
x_37 = lean_usize_of_nat(x_27);
lean_dec(x_27);
x_38 = 1;
x_39 = lean_usize_sub(x_37, x_38);
x_40 = lean_usize_land(x_36, x_39);
x_41 = lean_array_uget(x_2, x_40);
x_42 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_42, 0, x_24);
lean_ctor_set(x_42, 1, x_25);
lean_ctor_set(x_42, 2, x_41);
x_43 = lean_array_uset(x_2, x_40, x_42);
x_2 = x_43;
x_3 = x_26;
goto _start;
}
}
}
}
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_AssocList_foldlM___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__4___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__5(lean_object* x_1, lean_object* x_2) {
_start:
{
if (lean_obj_tag(x_2) == 0)
{
return x_1;
}
else
{
uint8_t x_3; 
x_3 = !lean_is_exclusive(x_2);
if (x_3 == 0)
{
lean_object* x_4; lean_object* x_5; lean_object* x_6; size_t x_7; uint64_t x_8; uint64_t x_9; uint64_t x_10; uint64_t x_11; uint64_t x_12; uint64_t x_13; uint64_t x_14; uint64_t x_15; uint64_t x_16; size_t x_17; size_t x_18; size_t x_19; size_t x_20; size_t x_21; lean_object* x_22; lean_object* x_23; 
x_4 = lean_ctor_get(x_2, 0);
x_5 = lean_ctor_get(x_2, 2);
x_6 = lean_array_get_size(x_1);
x_7 = lean_ptr_addr(x_4);
x_8 = lean_usize_to_uint64(x_7);
x_9 = 11;
x_10 = lean_uint64_mix_hash(x_8, x_9);
x_11 = 32;
x_12 = lean_uint64_shift_right(x_10, x_11);
x_13 = lean_uint64_xor(x_10, x_12);
x_14 = 16;
x_15 = lean_uint64_shift_right(x_13, x_14);
x_16 = lean_uint64_xor(x_13, x_15);
x_17 = lean_uint64_to_usize(x_16);
x_18 = lean_usize_of_nat(x_6);
lean_dec(x_6);
x_19 = 1;
x_20 = lean_usize_sub(x_18, x_19);
x_21 = lean_usize_land(x_17, x_20);
x_22 = lean_array_uget(x_1, x_21);
lean_ctor_set(x_2, 2, x_22);
x_23 = lean_array_uset(x_1, x_21, x_2);
x_1 = x_23;
x_2 = x_5;
goto _start;
}
else
{
lean_object* x_25; lean_object* x_26; lean_object* x_27; lean_object* x_28; size_t x_29; uint64_t x_30; uint64_t x_31; uint64_t x_32; uint64_t x_33; uint64_t x_34; uint64_t x_35; uint64_t x_36; uint64_t x_37; uint64_t x_38; size_t x_39; size_t x_40; size_t x_41; size_t x_42; size_t x_43; lean_object* x_44; lean_object* x_45; lean_object* x_46; 
x_25 = lean_ctor_get(x_2, 0);
x_26 = lean_ctor_get(x_2, 1);
x_27 = lean_ctor_get(x_2, 2);
lean_inc(x_27);
lean_inc(x_26);
lean_inc(x_25);
lean_dec(x_2);
x_28 = lean_array_get_size(x_1);
x_29 = lean_ptr_addr(x_25);
x_30 = lean_usize_to_uint64(x_29);
x_31 = 11;
x_32 = lean_uint64_mix_hash(x_30, x_31);
x_33 = 32;
x_34 = lean_uint64_shift_right(x_32, x_33);
x_35 = lean_uint64_xor(x_32, x_34);
x_36 = 16;
x_37 = lean_uint64_shift_right(x_35, x_36);
x_38 = lean_uint64_xor(x_35, x_37);
x_39 = lean_uint64_to_usize(x_38);
x_40 = lean_usize_of_nat(x_28);
lean_dec(x_28);
x_41 = 1;
x_42 = lean_usize_sub(x_40, x_41);
x_43 = lean_usize_land(x_39, x_42);
x_44 = lean_array_uget(x_1, x_43);
x_45 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_45, 0, x_25);
lean_ctor_set(x_45, 1, x_26);
lean_ctor_set(x_45, 2, x_44);
x_46 = lean_array_uset(x_1, x_43, x_45);
x_1 = x_46;
x_2 = x_27;
goto _start;
}
}
}
}
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_Raw_u2080_expand_go___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__3(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; uint8_t x_5; 
x_4 = lean_array_get_size(x_2);
x_5 = lean_nat_dec_lt(x_1, x_4);
lean_dec(x_4);
if (x_5 == 0)
{
lean_dec(x_2);
lean_dec(x_1);
return x_3;
}
else
{
lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; 
x_6 = lean_array_fget(x_2, x_1);
x_7 = lean_box(0);
x_8 = lean_array_fset(x_2, x_1, x_7);
x_9 = l_Std_DHashMap_Internal_AssocList_foldlM___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__4___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__5(x_3, x_6);
x_10 = lean_unsigned_to_nat(1u);
x_11 = lean_nat_add(x_1, x_10);
lean_dec(x_1);
x_1 = x_11;
x_2 = x_8;
x_3 = x_9;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_Raw_u2080_expand___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__2(lean_object* x_1) {
_start:
{
lean_object* x_2; lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6; lean_object* x_7; lean_object* x_8; 
x_2 = lean_array_get_size(x_1);
x_3 = lean_unsigned_to_nat(2u);
x_4 = lean_nat_mul(x_2, x_3);
lean_dec(x_2);
x_5 = lean_box(0);
x_6 = lean_mk_array(x_4, x_5);
x_7 = lean_unsigned_to_nat(0u);
x_8 = l_Std_DHashMap_Internal_Raw_u2080_expand_go___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__3(x_7, x_1, x_6);
return x_8;
}
}
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_AssocList_replace___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__6(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
if (lean_obj_tag(x_3) == 0)
{
lean_object* x_4; 
lean_dec(x_2);
lean_dec(x_1);
x_4 = lean_box(0);
return x_4;
}
else
{
uint8_t x_5; 
x_5 = !lean_is_exclusive(x_3);
if (x_5 == 0)
{
lean_object* x_6; lean_object* x_7; lean_object* x_8; size_t x_9; size_t x_10; uint8_t x_11; 
x_6 = lean_ctor_get(x_3, 0);
x_7 = lean_ctor_get(x_3, 1);
x_8 = lean_ctor_get(x_3, 2);
x_9 = lean_ptr_addr(x_6);
x_10 = lean_ptr_addr(x_1);
x_11 = lean_usize_dec_eq(x_9, x_10);
if (x_11 == 0)
{
lean_object* x_12; 
x_12 = l_Std_DHashMap_Internal_AssocList_replace___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__6(x_1, x_2, x_8);
lean_ctor_set(x_3, 2, x_12);
return x_3;
}
else
{
lean_dec(x_7);
lean_dec(x_6);
lean_ctor_set(x_3, 1, x_2);
lean_ctor_set(x_3, 0, x_1);
return x_3;
}
}
else
{
lean_object* x_13; lean_object* x_14; lean_object* x_15; size_t x_16; size_t x_17; uint8_t x_18; 
x_13 = lean_ctor_get(x_3, 0);
x_14 = lean_ctor_get(x_3, 1);
x_15 = lean_ctor_get(x_3, 2);
lean_inc(x_15);
lean_inc(x_14);
lean_inc(x_13);
lean_dec(x_3);
x_16 = lean_ptr_addr(x_13);
x_17 = lean_ptr_addr(x_1);
x_18 = lean_usize_dec_eq(x_16, x_17);
if (x_18 == 0)
{
lean_object* x_19; lean_object* x_20; 
x_19 = l_Std_DHashMap_Internal_AssocList_replace___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__6(x_1, x_2, x_15);
x_20 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_20, 0, x_13);
lean_ctor_set(x_20, 1, x_14);
lean_ctor_set(x_20, 2, x_19);
return x_20;
}
else
{
lean_object* x_21; 
lean_dec(x_14);
lean_dec(x_13);
x_21 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_21, 0, x_1);
lean_ctor_set(x_21, 1, x_2);
lean_ctor_set(x_21, 2, x_15);
return x_21;
}
}
}
}
}
static lean_object* _init_l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7___closed__1() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l_Lean_Meta_instMonadMetaM;
x_2 = l_ReaderT_instMonad___rarg(x_1);
return x_2;
}
}
static lean_object* _init_l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7___closed__2() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7___closed__1;
x_2 = l_Lean_instInhabitedExpr;
x_3 = l_instInhabitedOfMonad___rarg(x_1, x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7) {
_start:
{
lean_object* x_8; lean_object* x_9; lean_object* x_10; 
x_8 = l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7___closed__2;
x_9 = lean_panic_fn(x_8, x_1);
x_10 = lean_apply_6(x_9, x_2, x_3, x_4, x_5, x_6, x_7);
return x_10;
}
}
LEAN_EXPORT lean_object* l_Std_Range_forIn_x27_loop___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__8(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8, lean_object* x_9, lean_object* x_10, lean_object* x_11, lean_object* x_12) {
_start:
{
lean_object* x_13; uint8_t x_14; 
x_13 = lean_ctor_get(x_2, 1);
x_14 = lean_nat_dec_lt(x_4, x_13);
if (x_14 == 0)
{
lean_object* x_15; 
lean_dec(x_11);
lean_dec(x_10);
lean_dec(x_9);
lean_dec(x_8);
lean_dec(x_7);
lean_dec(x_4);
x_15 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_15, 0, x_3);
lean_ctor_set(x_15, 1, x_12);
return x_15;
}
else
{
uint8_t x_16; 
x_16 = !lean_is_exclusive(x_3);
if (x_16 == 0)
{
lean_object* x_17; lean_object* x_18; lean_object* x_19; lean_object* x_20; lean_object* x_21; 
x_17 = lean_ctor_get(x_3, 0);
x_18 = lean_ctor_get(x_3, 1);
x_19 = l_Lean_instInhabitedExpr;
x_20 = lean_array_get(x_19, x_17, x_4);
lean_inc(x_11);
lean_inc(x_10);
lean_inc(x_9);
lean_inc(x_8);
lean_inc(x_7);
lean_inc(x_20);
x_21 = l_Lean_Meta_Grind_markNestedProofsImpl_visit(x_20, x_7, x_8, x_9, x_10, x_11, x_12);
if (lean_obj_tag(x_21) == 0)
{
lean_object* x_22; lean_object* x_23; size_t x_24; size_t x_25; uint8_t x_26; 
x_22 = lean_ctor_get(x_21, 0);
lean_inc(x_22);
x_23 = lean_ctor_get(x_21, 1);
lean_inc(x_23);
lean_dec(x_21);
x_24 = lean_ptr_addr(x_20);
lean_dec(x_20);
x_25 = lean_ptr_addr(x_22);
x_26 = lean_usize_dec_eq(x_24, x_25);
if (x_26 == 0)
{
lean_object* x_27; uint8_t x_28; lean_object* x_29; lean_object* x_30; lean_object* x_31; 
lean_dec(x_18);
x_27 = lean_array_set(x_17, x_4, x_22);
x_28 = 1;
x_29 = lean_box(x_28);
lean_ctor_set(x_3, 1, x_29);
lean_ctor_set(x_3, 0, x_27);
x_30 = lean_ctor_get(x_2, 2);
x_31 = lean_nat_add(x_4, x_30);
lean_dec(x_4);
x_4 = x_31;
x_5 = lean_box(0);
x_6 = lean_box(0);
x_12 = x_23;
goto _start;
}
else
{
lean_object* x_33; lean_object* x_34; 
lean_dec(x_22);
x_33 = lean_ctor_get(x_2, 2);
x_34 = lean_nat_add(x_4, x_33);
lean_dec(x_4);
x_4 = x_34;
x_5 = lean_box(0);
x_6 = lean_box(0);
x_12 = x_23;
goto _start;
}
}
else
{
uint8_t x_36; 
lean_dec(x_20);
lean_free_object(x_3);
lean_dec(x_18);
lean_dec(x_17);
lean_dec(x_11);
lean_dec(x_10);
lean_dec(x_9);
lean_dec(x_8);
lean_dec(x_7);
lean_dec(x_4);
x_36 = !lean_is_exclusive(x_21);
if (x_36 == 0)
{
return x_21;
}
else
{
lean_object* x_37; lean_object* x_38; lean_object* x_39; 
x_37 = lean_ctor_get(x_21, 0);
x_38 = lean_ctor_get(x_21, 1);
lean_inc(x_38);
lean_inc(x_37);
lean_dec(x_21);
x_39 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_39, 0, x_37);
lean_ctor_set(x_39, 1, x_38);
return x_39;
}
}
}
else
{
lean_object* x_40; lean_object* x_41; lean_object* x_42; lean_object* x_43; lean_object* x_44; 
x_40 = lean_ctor_get(x_3, 0);
x_41 = lean_ctor_get(x_3, 1);
lean_inc(x_41);
lean_inc(x_40);
lean_dec(x_3);
x_42 = l_Lean_instInhabitedExpr;
x_43 = lean_array_get(x_42, x_40, x_4);
lean_inc(x_11);
lean_inc(x_10);
lean_inc(x_9);
lean_inc(x_8);
lean_inc(x_7);
lean_inc(x_43);
x_44 = l_Lean_Meta_Grind_markNestedProofsImpl_visit(x_43, x_7, x_8, x_9, x_10, x_11, x_12);
if (lean_obj_tag(x_44) == 0)
{
lean_object* x_45; lean_object* x_46; size_t x_47; size_t x_48; uint8_t x_49; 
x_45 = lean_ctor_get(x_44, 0);
lean_inc(x_45);
x_46 = lean_ctor_get(x_44, 1);
lean_inc(x_46);
lean_dec(x_44);
x_47 = lean_ptr_addr(x_43);
lean_dec(x_43);
x_48 = lean_ptr_addr(x_45);
x_49 = lean_usize_dec_eq(x_47, x_48);
if (x_49 == 0)
{
lean_object* x_50; uint8_t x_51; lean_object* x_52; lean_object* x_53; lean_object* x_54; lean_object* x_55; 
lean_dec(x_41);
x_50 = lean_array_set(x_40, x_4, x_45);
x_51 = 1;
x_52 = lean_box(x_51);
x_53 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_53, 0, x_50);
lean_ctor_set(x_53, 1, x_52);
x_54 = lean_ctor_get(x_2, 2);
x_55 = lean_nat_add(x_4, x_54);
lean_dec(x_4);
x_3 = x_53;
x_4 = x_55;
x_5 = lean_box(0);
x_6 = lean_box(0);
x_12 = x_46;
goto _start;
}
else
{
lean_object* x_57; lean_object* x_58; lean_object* x_59; 
lean_dec(x_45);
x_57 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_57, 0, x_40);
lean_ctor_set(x_57, 1, x_41);
x_58 = lean_ctor_get(x_2, 2);
x_59 = lean_nat_add(x_4, x_58);
lean_dec(x_4);
x_3 = x_57;
x_4 = x_59;
x_5 = lean_box(0);
x_6 = lean_box(0);
x_12 = x_46;
goto _start;
}
}
else
{
lean_object* x_61; lean_object* x_62; lean_object* x_63; lean_object* x_64; 
lean_dec(x_43);
lean_dec(x_41);
lean_dec(x_40);
lean_dec(x_11);
lean_dec(x_10);
lean_dec(x_9);
lean_dec(x_8);
lean_dec(x_7);
lean_dec(x_4);
x_61 = lean_ctor_get(x_44, 0);
lean_inc(x_61);
x_62 = lean_ctor_get(x_44, 1);
lean_inc(x_62);
if (lean_is_exclusive(x_44)) {
 lean_ctor_release(x_44, 0);
 lean_ctor_release(x_44, 1);
 x_63 = x_44;
} else {
 lean_dec_ref(x_44);
 x_63 = lean_box(0);
}
if (lean_is_scalar(x_63)) {
 x_64 = lean_alloc_ctor(1, 2, 0);
} else {
 x_64 = x_63;
}
lean_ctor_set(x_64, 0, x_61);
lean_ctor_set(x_64, 1, x_62);
return x_64;
}
}
}
}
}
LEAN_EXPORT lean_object* l_Lean_Expr_withAppAux___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__9(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8, lean_object* x_9, lean_object* x_10) {
_start:
{
if (lean_obj_tag(x_2) == 5)
{
lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; lean_object* x_15; 
x_11 = lean_ctor_get(x_2, 0);
lean_inc(x_11);
x_12 = lean_ctor_get(x_2, 1);
lean_inc(x_12);
lean_dec(x_2);
x_13 = lean_array_set(x_3, x_4, x_12);
x_14 = lean_unsigned_to_nat(1u);
x_15 = lean_nat_sub(x_4, x_14);
lean_dec(x_4);
x_2 = x_11;
x_3 = x_13;
x_4 = x_15;
goto _start;
}
else
{
lean_object* x_17; lean_object* x_18; lean_object* x_19; lean_object* x_20; uint8_t x_21; lean_object* x_22; lean_object* x_23; lean_object* x_24; 
lean_dec(x_4);
x_17 = lean_array_get_size(x_3);
x_18 = lean_unsigned_to_nat(0u);
x_19 = lean_unsigned_to_nat(1u);
x_20 = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(x_20, 0, x_18);
lean_ctor_set(x_20, 1, x_17);
lean_ctor_set(x_20, 2, x_19);
x_21 = 0;
x_22 = lean_box(x_21);
x_23 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_23, 0, x_3);
lean_ctor_set(x_23, 1, x_22);
x_24 = l_Std_Range_forIn_x27_loop___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__8(x_20, x_20, x_23, x_18, lean_box(0), lean_box(0), x_5, x_6, x_7, x_8, x_9, x_10);
lean_dec(x_20);
if (lean_obj_tag(x_24) == 0)
{
lean_object* x_25; lean_object* x_26; uint8_t x_27; 
x_25 = lean_ctor_get(x_24, 0);
lean_inc(x_25);
x_26 = lean_ctor_get(x_25, 1);
lean_inc(x_26);
x_27 = lean_unbox(x_26);
lean_dec(x_26);
if (x_27 == 0)
{
uint8_t x_28; 
lean_dec(x_25);
lean_dec(x_2);
x_28 = !lean_is_exclusive(x_24);
if (x_28 == 0)
{
lean_object* x_29; 
x_29 = lean_ctor_get(x_24, 0);
lean_dec(x_29);
lean_ctor_set(x_24, 0, x_1);
return x_24;
}
else
{
lean_object* x_30; lean_object* x_31; 
x_30 = lean_ctor_get(x_24, 1);
lean_inc(x_30);
lean_dec(x_24);
x_31 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_31, 0, x_1);
lean_ctor_set(x_31, 1, x_30);
return x_31;
}
}
else
{
uint8_t x_32; 
lean_dec(x_1);
x_32 = !lean_is_exclusive(x_24);
if (x_32 == 0)
{
lean_object* x_33; lean_object* x_34; lean_object* x_35; 
x_33 = lean_ctor_get(x_24, 0);
lean_dec(x_33);
x_34 = lean_ctor_get(x_25, 0);
lean_inc(x_34);
lean_dec(x_25);
x_35 = l_Lean_mkAppN(x_2, x_34);
lean_dec(x_34);
lean_ctor_set(x_24, 0, x_35);
return x_24;
}
else
{
lean_object* x_36; lean_object* x_37; lean_object* x_38; lean_object* x_39; 
x_36 = lean_ctor_get(x_24, 1);
lean_inc(x_36);
lean_dec(x_24);
x_37 = lean_ctor_get(x_25, 0);
lean_inc(x_37);
lean_dec(x_25);
x_38 = l_Lean_mkAppN(x_2, x_37);
lean_dec(x_37);
x_39 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_39, 0, x_38);
lean_ctor_set(x_39, 1, x_36);
return x_39;
}
}
}
else
{
uint8_t x_40; 
lean_dec(x_2);
lean_dec(x_1);
x_40 = !lean_is_exclusive(x_24);
if (x_40 == 0)
{
return x_24;
}
else
{
lean_object* x_41; lean_object* x_42; lean_object* x_43; 
x_41 = lean_ctor_get(x_24, 0);
x_42 = lean_ctor_get(x_24, 1);
lean_inc(x_42);
lean_inc(x_41);
lean_dec(x_24);
x_43 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_43, 0, x_41);
lean_ctor_set(x_43, 1, x_42);
return x_43;
}
}
}
}
}
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_AssocList_get_x3f___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__10(lean_object* x_1, lean_object* x_2) {
_start:
{
if (lean_obj_tag(x_2) == 0)
{
lean_object* x_3; 
x_3 = lean_box(0);
return x_3;
}
else
{
lean_object* x_4; lean_object* x_5; lean_object* x_6; size_t x_7; size_t x_8; uint8_t x_9; 
x_4 = lean_ctor_get(x_2, 0);
x_5 = lean_ctor_get(x_2, 1);
x_6 = lean_ctor_get(x_2, 2);
x_7 = lean_ptr_addr(x_4);
x_8 = lean_ptr_addr(x_1);
x_9 = lean_usize_dec_eq(x_7, x_8);
if (x_9 == 0)
{
x_2 = x_6;
goto _start;
}
else
{
lean_object* x_11; 
lean_inc(x_5);
x_11 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_11, 0, x_5);
return x_11;
}
}
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__1(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8) {
_start:
{
lean_object* x_9; lean_object* x_10; lean_object* x_11; uint8_t x_12; 
x_9 = lean_st_ref_take(x_3, x_8);
x_10 = lean_ctor_get(x_9, 0);
lean_inc(x_10);
x_11 = lean_ctor_get(x_9, 1);
lean_inc(x_11);
lean_dec(x_9);
x_12 = !lean_is_exclusive(x_10);
if (x_12 == 0)
{
lean_object* x_13; lean_object* x_14; lean_object* x_15; size_t x_16; uint64_t x_17; uint64_t x_18; uint64_t x_19; uint64_t x_20; uint64_t x_21; uint64_t x_22; uint64_t x_23; uint64_t x_24; uint64_t x_25; size_t x_26; size_t x_27; size_t x_28; size_t x_29; size_t x_30; lean_object* x_31; uint8_t x_32; 
x_13 = lean_ctor_get(x_10, 0);
x_14 = lean_ctor_get(x_10, 1);
x_15 = lean_array_get_size(x_14);
x_16 = lean_ptr_addr(x_1);
x_17 = lean_usize_to_uint64(x_16);
x_18 = 11;
x_19 = lean_uint64_mix_hash(x_17, x_18);
x_20 = 32;
x_21 = lean_uint64_shift_right(x_19, x_20);
x_22 = lean_uint64_xor(x_19, x_21);
x_23 = 16;
x_24 = lean_uint64_shift_right(x_22, x_23);
x_25 = lean_uint64_xor(x_22, x_24);
x_26 = lean_uint64_to_usize(x_25);
x_27 = lean_usize_of_nat(x_15);
lean_dec(x_15);
x_28 = 1;
x_29 = lean_usize_sub(x_27, x_28);
x_30 = lean_usize_land(x_26, x_29);
x_31 = lean_array_uget(x_14, x_30);
x_32 = l_Std_DHashMap_Internal_AssocList_contains___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__1(x_1, x_31);
if (x_32 == 0)
{
lean_object* x_33; lean_object* x_34; lean_object* x_35; lean_object* x_36; lean_object* x_37; lean_object* x_38; lean_object* x_39; lean_object* x_40; lean_object* x_41; uint8_t x_42; 
x_33 = lean_unsigned_to_nat(1u);
x_34 = lean_nat_add(x_13, x_33);
lean_dec(x_13);
lean_inc(x_2);
x_35 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_35, 0, x_1);
lean_ctor_set(x_35, 1, x_2);
lean_ctor_set(x_35, 2, x_31);
x_36 = lean_array_uset(x_14, x_30, x_35);
x_37 = lean_unsigned_to_nat(4u);
x_38 = lean_nat_mul(x_34, x_37);
x_39 = lean_unsigned_to_nat(3u);
x_40 = lean_nat_div(x_38, x_39);
lean_dec(x_38);
x_41 = lean_array_get_size(x_36);
x_42 = lean_nat_dec_le(x_40, x_41);
lean_dec(x_41);
lean_dec(x_40);
if (x_42 == 0)
{
lean_object* x_43; lean_object* x_44; uint8_t x_45; 
x_43 = l_Std_DHashMap_Internal_Raw_u2080_expand___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__2(x_36);
lean_ctor_set(x_10, 1, x_43);
lean_ctor_set(x_10, 0, x_34);
x_44 = lean_st_ref_set(x_3, x_10, x_11);
x_45 = !lean_is_exclusive(x_44);
if (x_45 == 0)
{
lean_object* x_46; 
x_46 = lean_ctor_get(x_44, 0);
lean_dec(x_46);
lean_ctor_set(x_44, 0, x_2);
return x_44;
}
else
{
lean_object* x_47; lean_object* x_48; 
x_47 = lean_ctor_get(x_44, 1);
lean_inc(x_47);
lean_dec(x_44);
x_48 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_48, 0, x_2);
lean_ctor_set(x_48, 1, x_47);
return x_48;
}
}
else
{
lean_object* x_49; uint8_t x_50; 
lean_ctor_set(x_10, 1, x_36);
lean_ctor_set(x_10, 0, x_34);
x_49 = lean_st_ref_set(x_3, x_10, x_11);
x_50 = !lean_is_exclusive(x_49);
if (x_50 == 0)
{
lean_object* x_51; 
x_51 = lean_ctor_get(x_49, 0);
lean_dec(x_51);
lean_ctor_set(x_49, 0, x_2);
return x_49;
}
else
{
lean_object* x_52; lean_object* x_53; 
x_52 = lean_ctor_get(x_49, 1);
lean_inc(x_52);
lean_dec(x_49);
x_53 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_53, 0, x_2);
lean_ctor_set(x_53, 1, x_52);
return x_53;
}
}
}
else
{
lean_object* x_54; lean_object* x_55; lean_object* x_56; lean_object* x_57; lean_object* x_58; uint8_t x_59; 
x_54 = lean_box(0);
x_55 = lean_array_uset(x_14, x_30, x_54);
lean_inc(x_2);
x_56 = l_Std_DHashMap_Internal_AssocList_replace___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__6(x_1, x_2, x_31);
x_57 = lean_array_uset(x_55, x_30, x_56);
lean_ctor_set(x_10, 1, x_57);
x_58 = lean_st_ref_set(x_3, x_10, x_11);
x_59 = !lean_is_exclusive(x_58);
if (x_59 == 0)
{
lean_object* x_60; 
x_60 = lean_ctor_get(x_58, 0);
lean_dec(x_60);
lean_ctor_set(x_58, 0, x_2);
return x_58;
}
else
{
lean_object* x_61; lean_object* x_62; 
x_61 = lean_ctor_get(x_58, 1);
lean_inc(x_61);
lean_dec(x_58);
x_62 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_62, 0, x_2);
lean_ctor_set(x_62, 1, x_61);
return x_62;
}
}
}
else
{
lean_object* x_63; lean_object* x_64; lean_object* x_65; size_t x_66; uint64_t x_67; uint64_t x_68; uint64_t x_69; uint64_t x_70; uint64_t x_71; uint64_t x_72; uint64_t x_73; uint64_t x_74; uint64_t x_75; size_t x_76; size_t x_77; size_t x_78; size_t x_79; size_t x_80; lean_object* x_81; uint8_t x_82; 
x_63 = lean_ctor_get(x_10, 0);
x_64 = lean_ctor_get(x_10, 1);
lean_inc(x_64);
lean_inc(x_63);
lean_dec(x_10);
x_65 = lean_array_get_size(x_64);
x_66 = lean_ptr_addr(x_1);
x_67 = lean_usize_to_uint64(x_66);
x_68 = 11;
x_69 = lean_uint64_mix_hash(x_67, x_68);
x_70 = 32;
x_71 = lean_uint64_shift_right(x_69, x_70);
x_72 = lean_uint64_xor(x_69, x_71);
x_73 = 16;
x_74 = lean_uint64_shift_right(x_72, x_73);
x_75 = lean_uint64_xor(x_72, x_74);
x_76 = lean_uint64_to_usize(x_75);
x_77 = lean_usize_of_nat(x_65);
lean_dec(x_65);
x_78 = 1;
x_79 = lean_usize_sub(x_77, x_78);
x_80 = lean_usize_land(x_76, x_79);
x_81 = lean_array_uget(x_64, x_80);
x_82 = l_Std_DHashMap_Internal_AssocList_contains___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__1(x_1, x_81);
if (x_82 == 0)
{
lean_object* x_83; lean_object* x_84; lean_object* x_85; lean_object* x_86; lean_object* x_87; lean_object* x_88; lean_object* x_89; lean_object* x_90; lean_object* x_91; uint8_t x_92; 
x_83 = lean_unsigned_to_nat(1u);
x_84 = lean_nat_add(x_63, x_83);
lean_dec(x_63);
lean_inc(x_2);
x_85 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_85, 0, x_1);
lean_ctor_set(x_85, 1, x_2);
lean_ctor_set(x_85, 2, x_81);
x_86 = lean_array_uset(x_64, x_80, x_85);
x_87 = lean_unsigned_to_nat(4u);
x_88 = lean_nat_mul(x_84, x_87);
x_89 = lean_unsigned_to_nat(3u);
x_90 = lean_nat_div(x_88, x_89);
lean_dec(x_88);
x_91 = lean_array_get_size(x_86);
x_92 = lean_nat_dec_le(x_90, x_91);
lean_dec(x_91);
lean_dec(x_90);
if (x_92 == 0)
{
lean_object* x_93; lean_object* x_94; lean_object* x_95; lean_object* x_96; lean_object* x_97; lean_object* x_98; 
x_93 = l_Std_DHashMap_Internal_Raw_u2080_expand___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__2(x_86);
x_94 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_94, 0, x_84);
lean_ctor_set(x_94, 1, x_93);
x_95 = lean_st_ref_set(x_3, x_94, x_11);
x_96 = lean_ctor_get(x_95, 1);
lean_inc(x_96);
if (lean_is_exclusive(x_95)) {
 lean_ctor_release(x_95, 0);
 lean_ctor_release(x_95, 1);
 x_97 = x_95;
} else {
 lean_dec_ref(x_95);
 x_97 = lean_box(0);
}
if (lean_is_scalar(x_97)) {
 x_98 = lean_alloc_ctor(0, 2, 0);
} else {
 x_98 = x_97;
}
lean_ctor_set(x_98, 0, x_2);
lean_ctor_set(x_98, 1, x_96);
return x_98;
}
else
{
lean_object* x_99; lean_object* x_100; lean_object* x_101; lean_object* x_102; lean_object* x_103; 
x_99 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_99, 0, x_84);
lean_ctor_set(x_99, 1, x_86);
x_100 = lean_st_ref_set(x_3, x_99, x_11);
x_101 = lean_ctor_get(x_100, 1);
lean_inc(x_101);
if (lean_is_exclusive(x_100)) {
 lean_ctor_release(x_100, 0);
 lean_ctor_release(x_100, 1);
 x_102 = x_100;
} else {
 lean_dec_ref(x_100);
 x_102 = lean_box(0);
}
if (lean_is_scalar(x_102)) {
 x_103 = lean_alloc_ctor(0, 2, 0);
} else {
 x_103 = x_102;
}
lean_ctor_set(x_103, 0, x_2);
lean_ctor_set(x_103, 1, x_101);
return x_103;
}
}
else
{
lean_object* x_104; lean_object* x_105; lean_object* x_106; lean_object* x_107; lean_object* x_108; lean_object* x_109; lean_object* x_110; lean_object* x_111; lean_object* x_112; 
x_104 = lean_box(0);
x_105 = lean_array_uset(x_64, x_80, x_104);
lean_inc(x_2);
x_106 = l_Std_DHashMap_Internal_AssocList_replace___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__6(x_1, x_2, x_81);
x_107 = lean_array_uset(x_105, x_80, x_106);
x_108 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_108, 0, x_63);
lean_ctor_set(x_108, 1, x_107);
x_109 = lean_st_ref_set(x_3, x_108, x_11);
x_110 = lean_ctor_get(x_109, 1);
lean_inc(x_110);
if (lean_is_exclusive(x_109)) {
 lean_ctor_release(x_109, 0);
 lean_ctor_release(x_109, 1);
 x_111 = x_109;
} else {
 lean_dec_ref(x_109);
 x_111 = lean_box(0);
}
if (lean_is_scalar(x_111)) {
 x_112 = lean_alloc_ctor(0, 2, 0);
} else {
 x_112 = x_111;
}
lean_ctor_set(x_112, 0, x_2);
lean_ctor_set(x_112, 1, x_110);
return x_112;
}
}
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__2(lean_object* x_1, lean_object* x_2, lean_object* x_3, uint8_t x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8, lean_object* x_9, lean_object* x_10, lean_object* x_11, lean_object* x_12, lean_object* x_13) {
_start:
{
lean_object* x_14; size_t x_15; size_t x_16; uint8_t x_17; 
lean_inc(x_3);
lean_inc(x_2);
lean_inc(x_1);
x_14 = l_Lean_Expr_forallE___override(x_1, x_2, x_3, x_4);
x_15 = lean_ptr_addr(x_2);
lean_dec(x_2);
x_16 = lean_ptr_addr(x_5);
x_17 = lean_usize_dec_eq(x_15, x_16);
if (x_17 == 0)
{
lean_object* x_18; lean_object* x_19; 
lean_dec(x_14);
lean_dec(x_3);
x_18 = l_Lean_Expr_forallE___override(x_1, x_5, x_7, x_4);
x_19 = lean_apply_7(x_6, x_18, x_8, x_9, x_10, x_11, x_12, x_13);
return x_19;
}
else
{
size_t x_20; size_t x_21; uint8_t x_22; 
x_20 = lean_ptr_addr(x_3);
lean_dec(x_3);
x_21 = lean_ptr_addr(x_7);
x_22 = lean_usize_dec_eq(x_20, x_21);
if (x_22 == 0)
{
lean_object* x_23; lean_object* x_24; 
lean_dec(x_14);
x_23 = l_Lean_Expr_forallE___override(x_1, x_5, x_7, x_4);
x_24 = lean_apply_7(x_6, x_23, x_8, x_9, x_10, x_11, x_12, x_13);
return x_24;
}
else
{
uint8_t x_25; 
x_25 = l___private_Lean_Expr_0__Lean_beqBinderInfo____x40_Lean_Expr___hyg_406_(x_4, x_4);
if (x_25 == 0)
{
lean_object* x_26; lean_object* x_27; 
lean_dec(x_14);
x_26 = l_Lean_Expr_forallE___override(x_1, x_5, x_7, x_4);
x_27 = lean_apply_7(x_6, x_26, x_8, x_9, x_10, x_11, x_12, x_13);
return x_27;
}
else
{
lean_object* x_28; 
lean_dec(x_7);
lean_dec(x_5);
lean_dec(x_1);
x_28 = lean_apply_7(x_6, x_14, x_8, x_9, x_10, x_11, x_12, x_13);
return x_28;
}
}
}
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__1() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("Lean.Meta.Tactic.Grind.MarkNestedProofs", 39, 39);
return x_1;
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__2() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("Lean.Meta.Grind.markNestedProofsImpl.visit", 42, 42);
return x_1;
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__3() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("unreachable code has been reached", 33, 33);
return x_1;
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__4() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6; 
x_1 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__1;
x_2 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__2;
x_3 = lean_unsigned_to_nat(68u);
x_4 = lean_unsigned_to_nat(13u);
x_5 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__3;
x_6 = l___private_Init_Util_0__mkPanicMessageWithDecl(x_1, x_2, x_3, x_4, x_5);
return x_6;
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__5() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l_Lean_levelZero;
x_2 = l_Lean_Expr_sort___override(x_1);
return x_2;
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8) {
_start:
{
switch (lean_obj_tag(x_1)) {
case 5:
{
lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; lean_object* x_15; 
x_9 = lean_unsigned_to_nat(0u);
x_10 = l___private_Lean_Expr_0__Lean_Expr_getAppNumArgsAux(x_1, x_9);
x_11 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__5;
lean_inc(x_10);
x_12 = lean_mk_array(x_10, x_11);
x_13 = lean_unsigned_to_nat(1u);
x_14 = lean_nat_sub(x_10, x_13);
lean_dec(x_10);
lean_inc(x_7);
lean_inc(x_6);
lean_inc(x_5);
lean_inc(x_4);
lean_inc(x_3);
lean_inc_n(x_1, 2);
x_15 = l_Lean_Expr_withAppAux___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__9(x_1, x_1, x_12, x_14, x_3, x_4, x_5, x_6, x_7, x_8);
if (lean_obj_tag(x_15) == 0)
{
lean_object* x_16; lean_object* x_17; lean_object* x_18; 
x_16 = lean_ctor_get(x_15, 0);
lean_inc(x_16);
x_17 = lean_ctor_get(x_15, 1);
lean_inc(x_17);
lean_dec(x_15);
x_18 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__1(x_1, x_16, x_3, x_4, x_5, x_6, x_7, x_17);
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
return x_18;
}
else
{
uint8_t x_19; 
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_1);
x_19 = !lean_is_exclusive(x_15);
if (x_19 == 0)
{
return x_15;
}
else
{
lean_object* x_20; lean_object* x_21; lean_object* x_22; 
x_20 = lean_ctor_get(x_15, 0);
x_21 = lean_ctor_get(x_15, 1);
lean_inc(x_21);
lean_inc(x_20);
lean_dec(x_15);
x_22 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_22, 0, x_20);
lean_ctor_set(x_22, 1, x_21);
return x_22;
}
}
}
case 7:
{
lean_object* x_23; lean_object* x_24; lean_object* x_25; uint8_t x_26; lean_object* x_27; lean_object* x_28; 
x_23 = lean_ctor_get(x_1, 0);
lean_inc(x_23);
x_24 = lean_ctor_get(x_1, 1);
lean_inc(x_24);
x_25 = lean_ctor_get(x_1, 2);
lean_inc(x_25);
x_26 = lean_ctor_get_uint8(x_1, sizeof(void*)*3 + 8);
x_27 = lean_alloc_closure((void*)(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__1___boxed), 8, 1);
lean_closure_set(x_27, 0, x_1);
lean_inc(x_7);
lean_inc(x_6);
lean_inc(x_5);
lean_inc(x_4);
lean_inc(x_3);
lean_inc(x_24);
x_28 = l_Lean_Meta_Grind_markNestedProofsImpl_visit(x_24, x_3, x_4, x_5, x_6, x_7, x_8);
if (lean_obj_tag(x_28) == 0)
{
lean_object* x_29; lean_object* x_30; uint8_t x_31; 
x_29 = lean_ctor_get(x_28, 0);
lean_inc(x_29);
x_30 = lean_ctor_get(x_28, 1);
lean_inc(x_30);
lean_dec(x_28);
x_31 = l_Lean_Expr_hasLooseBVars(x_25);
if (x_31 == 0)
{
lean_object* x_32; 
lean_inc(x_7);
lean_inc(x_6);
lean_inc(x_5);
lean_inc(x_4);
lean_inc(x_3);
lean_inc(x_25);
x_32 = l_Lean_Meta_Grind_markNestedProofsImpl_visit(x_25, x_3, x_4, x_5, x_6, x_7, x_30);
if (lean_obj_tag(x_32) == 0)
{
lean_object* x_33; lean_object* x_34; lean_object* x_35; 
x_33 = lean_ctor_get(x_32, 0);
lean_inc(x_33);
x_34 = lean_ctor_get(x_32, 1);
lean_inc(x_34);
lean_dec(x_32);
x_35 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__2(x_23, x_24, x_25, x_26, x_29, x_27, x_33, x_3, x_4, x_5, x_6, x_7, x_34);
return x_35;
}
else
{
uint8_t x_36; 
lean_dec(x_29);
lean_dec(x_27);
lean_dec(x_25);
lean_dec(x_24);
lean_dec(x_23);
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
x_36 = !lean_is_exclusive(x_32);
if (x_36 == 0)
{
return x_32;
}
else
{
lean_object* x_37; lean_object* x_38; lean_object* x_39; 
x_37 = lean_ctor_get(x_32, 0);
x_38 = lean_ctor_get(x_32, 1);
lean_inc(x_38);
lean_inc(x_37);
lean_dec(x_32);
x_39 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_39, 0, x_37);
lean_ctor_set(x_39, 1, x_38);
return x_39;
}
}
}
else
{
lean_object* x_40; 
lean_inc(x_25);
x_40 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__2(x_23, x_24, x_25, x_26, x_29, x_27, x_25, x_3, x_4, x_5, x_6, x_7, x_30);
return x_40;
}
}
else
{
uint8_t x_41; 
lean_dec(x_27);
lean_dec(x_25);
lean_dec(x_24);
lean_dec(x_23);
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
x_41 = !lean_is_exclusive(x_28);
if (x_41 == 0)
{
return x_28;
}
else
{
lean_object* x_42; lean_object* x_43; lean_object* x_44; 
x_42 = lean_ctor_get(x_28, 0);
x_43 = lean_ctor_get(x_28, 1);
lean_inc(x_43);
lean_inc(x_42);
lean_dec(x_28);
x_44 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_44, 0, x_42);
lean_ctor_set(x_44, 1, x_43);
return x_44;
}
}
}
case 11:
{
lean_object* x_45; lean_object* x_46; lean_object* x_47; lean_object* x_48; 
x_45 = lean_ctor_get(x_1, 0);
lean_inc(x_45);
x_46 = lean_ctor_get(x_1, 1);
lean_inc(x_46);
x_47 = lean_ctor_get(x_1, 2);
lean_inc(x_47);
lean_inc(x_7);
lean_inc(x_6);
lean_inc(x_5);
lean_inc(x_4);
lean_inc(x_3);
lean_inc(x_47);
x_48 = l_Lean_Meta_Grind_markNestedProofsImpl_visit(x_47, x_3, x_4, x_5, x_6, x_7, x_8);
if (lean_obj_tag(x_48) == 0)
{
lean_object* x_49; lean_object* x_50; size_t x_51; size_t x_52; uint8_t x_53; 
x_49 = lean_ctor_get(x_48, 0);
lean_inc(x_49);
x_50 = lean_ctor_get(x_48, 1);
lean_inc(x_50);
lean_dec(x_48);
x_51 = lean_ptr_addr(x_47);
lean_dec(x_47);
x_52 = lean_ptr_addr(x_49);
x_53 = lean_usize_dec_eq(x_51, x_52);
if (x_53 == 0)
{
lean_object* x_54; lean_object* x_55; 
x_54 = l_Lean_Expr_proj___override(x_45, x_46, x_49);
x_55 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__1(x_1, x_54, x_3, x_4, x_5, x_6, x_7, x_50);
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
return x_55;
}
else
{
lean_object* x_56; 
lean_dec(x_49);
lean_dec(x_46);
lean_dec(x_45);
lean_inc(x_1);
x_56 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__1(x_1, x_1, x_3, x_4, x_5, x_6, x_7, x_50);
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
return x_56;
}
}
else
{
uint8_t x_57; 
lean_dec(x_47);
lean_dec(x_46);
lean_dec(x_45);
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_1);
x_57 = !lean_is_exclusive(x_48);
if (x_57 == 0)
{
return x_48;
}
else
{
lean_object* x_58; lean_object* x_59; lean_object* x_60; 
x_58 = lean_ctor_get(x_48, 0);
x_59 = lean_ctor_get(x_48, 1);
lean_inc(x_59);
lean_inc(x_58);
lean_dec(x_48);
x_60 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_60, 0, x_58);
lean_ctor_set(x_60, 1, x_59);
return x_60;
}
}
}
default: 
{
lean_object* x_61; lean_object* x_62; 
x_61 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__4;
lean_inc(x_7);
lean_inc(x_6);
lean_inc(x_5);
lean_inc(x_4);
lean_inc(x_3);
x_62 = l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7(x_61, x_3, x_4, x_5, x_6, x_7, x_8);
if (lean_obj_tag(x_62) == 0)
{
lean_object* x_63; lean_object* x_64; lean_object* x_65; 
x_63 = lean_ctor_get(x_62, 0);
lean_inc(x_63);
x_64 = lean_ctor_get(x_62, 1);
lean_inc(x_64);
lean_dec(x_62);
x_65 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__1(x_1, x_63, x_3, x_4, x_5, x_6, x_7, x_64);
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
return x_65;
}
else
{
uint8_t x_66; 
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_1);
x_66 = !lean_is_exclusive(x_62);
if (x_66 == 0)
{
return x_62;
}
else
{
lean_object* x_67; lean_object* x_68; lean_object* x_69; 
x_67 = lean_ctor_get(x_62, 0);
x_68 = lean_ctor_get(x_62, 1);
lean_inc(x_68);
lean_inc(x_67);
lean_dec(x_62);
x_69 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_69, 0, x_67);
lean_ctor_set(x_69, 1, x_68);
return x_69;
}
}
}
}
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__4(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8) {
_start:
{
lean_object* x_9; uint8_t x_10; 
x_9 = lean_st_ref_get(x_3, x_8);
x_10 = !lean_is_exclusive(x_9);
if (x_10 == 0)
{
lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; size_t x_15; uint64_t x_16; uint64_t x_17; uint64_t x_18; uint64_t x_19; uint64_t x_20; uint64_t x_21; uint64_t x_22; uint64_t x_23; uint64_t x_24; size_t x_25; size_t x_26; size_t x_27; size_t x_28; size_t x_29; lean_object* x_30; lean_object* x_31; 
x_11 = lean_ctor_get(x_9, 0);
x_12 = lean_ctor_get(x_9, 1);
x_13 = lean_ctor_get(x_11, 1);
lean_inc(x_13);
lean_dec(x_11);
x_14 = lean_array_get_size(x_13);
x_15 = lean_ptr_addr(x_1);
x_16 = lean_usize_to_uint64(x_15);
x_17 = 11;
x_18 = lean_uint64_mix_hash(x_16, x_17);
x_19 = 32;
x_20 = lean_uint64_shift_right(x_18, x_19);
x_21 = lean_uint64_xor(x_18, x_20);
x_22 = 16;
x_23 = lean_uint64_shift_right(x_21, x_22);
x_24 = lean_uint64_xor(x_21, x_23);
x_25 = lean_uint64_to_usize(x_24);
x_26 = lean_usize_of_nat(x_14);
lean_dec(x_14);
x_27 = 1;
x_28 = lean_usize_sub(x_26, x_27);
x_29 = lean_usize_land(x_25, x_28);
x_30 = lean_array_uget(x_13, x_29);
lean_dec(x_13);
x_31 = l_Std_DHashMap_Internal_AssocList_get_x3f___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__10(x_1, x_30);
lean_dec(x_30);
if (lean_obj_tag(x_31) == 0)
{
lean_object* x_32; lean_object* x_33; 
lean_free_object(x_9);
x_32 = lean_box(0);
x_33 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3(x_1, x_32, x_3, x_4, x_5, x_6, x_7, x_12);
return x_33;
}
else
{
lean_object* x_34; 
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_1);
x_34 = lean_ctor_get(x_31, 0);
lean_inc(x_34);
lean_dec(x_31);
lean_ctor_set(x_9, 0, x_34);
return x_9;
}
}
else
{
lean_object* x_35; lean_object* x_36; lean_object* x_37; lean_object* x_38; size_t x_39; uint64_t x_40; uint64_t x_41; uint64_t x_42; uint64_t x_43; uint64_t x_44; uint64_t x_45; uint64_t x_46; uint64_t x_47; uint64_t x_48; size_t x_49; size_t x_50; size_t x_51; size_t x_52; size_t x_53; lean_object* x_54; lean_object* x_55; 
x_35 = lean_ctor_get(x_9, 0);
x_36 = lean_ctor_get(x_9, 1);
lean_inc(x_36);
lean_inc(x_35);
lean_dec(x_9);
x_37 = lean_ctor_get(x_35, 1);
lean_inc(x_37);
lean_dec(x_35);
x_38 = lean_array_get_size(x_37);
x_39 = lean_ptr_addr(x_1);
x_40 = lean_usize_to_uint64(x_39);
x_41 = 11;
x_42 = lean_uint64_mix_hash(x_40, x_41);
x_43 = 32;
x_44 = lean_uint64_shift_right(x_42, x_43);
x_45 = lean_uint64_xor(x_42, x_44);
x_46 = 16;
x_47 = lean_uint64_shift_right(x_45, x_46);
x_48 = lean_uint64_xor(x_45, x_47);
x_49 = lean_uint64_to_usize(x_48);
x_50 = lean_usize_of_nat(x_38);
lean_dec(x_38);
x_51 = 1;
x_52 = lean_usize_sub(x_50, x_51);
x_53 = lean_usize_land(x_49, x_52);
x_54 = lean_array_uget(x_37, x_53);
lean_dec(x_37);
x_55 = l_Std_DHashMap_Internal_AssocList_get_x3f___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__10(x_1, x_54);
lean_dec(x_54);
if (lean_obj_tag(x_55) == 0)
{
lean_object* x_56; lean_object* x_57; 
x_56 = lean_box(0);
x_57 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3(x_1, x_56, x_3, x_4, x_5, x_6, x_7, x_36);
return x_57;
}
else
{
lean_object* x_58; lean_object* x_59; 
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_1);
x_58 = lean_ctor_get(x_55, 0);
lean_inc(x_58);
lean_dec(x_55);
x_59 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_59, 0, x_58);
lean_ctor_set(x_59, 1, x_36);
return x_59;
}
}
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__5(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8) {
_start:
{
uint8_t x_9; 
x_9 = l_Lean_Expr_isApp(x_1);
if (x_9 == 0)
{
uint8_t x_10; 
x_10 = l_Lean_Expr_isForall(x_1);
if (x_10 == 0)
{
uint8_t x_11; 
x_11 = l_Lean_Expr_isProj(x_1);
if (x_11 == 0)
{
lean_object* x_12; 
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
x_12 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_12, 0, x_1);
lean_ctor_set(x_12, 1, x_8);
return x_12;
}
else
{
lean_object* x_13; lean_object* x_14; 
x_13 = lean_box(0);
x_14 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__4(x_1, x_13, x_3, x_4, x_5, x_6, x_7, x_8);
return x_14;
}
}
else
{
lean_object* x_15; lean_object* x_16; 
x_15 = lean_box(0);
x_16 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__4(x_1, x_15, x_3, x_4, x_5, x_6, x_7, x_8);
return x_16;
}
}
else
{
lean_object* x_17; lean_object* x_18; 
x_17 = lean_box(0);
x_18 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__4(x_1, x_17, x_3, x_4, x_5, x_6, x_7, x_8);
return x_18;
}
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__1() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Lean_Meta_Grind_unfoldReducible___lambda__3), 6, 0);
return x_1;
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__2() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Lean_Meta_Grind_unfoldReducible___lambda__4___boxed), 6, 0);
return x_1;
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__3() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Lean_Core_betaReduce___lambda__1___boxed), 4, 0);
return x_1;
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__4() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Lean_Core_betaReduce___lambda__2___boxed), 4, 0);
return x_1;
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__5() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("Lean", 4, 4);
return x_1;
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__6() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("Grind", 5, 5);
return x_1;
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__7() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("nestedProof", 11, 11);
return x_1;
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__8() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; lean_object* x_4; 
x_1 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__5;
x_2 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__6;
x_3 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__7;
x_4 = l_Lean_Name_mkStr3(x_1, x_2, x_3);
return x_4;
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__9() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = lean_box(0);
x_2 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__8;
x_3 = l_Lean_Expr_const___override(x_2, x_1);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8) {
_start:
{
lean_object* x_9; 
lean_inc(x_7);
lean_inc(x_6);
lean_inc(x_5);
lean_inc(x_4);
lean_inc(x_1);
x_9 = lean_infer_type(x_1, x_4, x_5, x_6, x_7, x_8);
if (lean_obj_tag(x_9) == 0)
{
lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; 
x_10 = lean_ctor_get(x_9, 0);
lean_inc(x_10);
x_11 = lean_ctor_get(x_9, 1);
lean_inc(x_11);
lean_dec(x_9);
x_12 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__1;
x_13 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__2;
lean_inc(x_7);
lean_inc(x_6);
lean_inc(x_5);
lean_inc(x_4);
x_14 = l_Lean_Core_transform___at_Lean_Elab_Term_exposeLevelMVars___spec__1(x_10, x_12, x_13, x_4, x_5, x_6, x_7, x_11);
if (lean_obj_tag(x_14) == 0)
{
lean_object* x_15; lean_object* x_16; lean_object* x_17; lean_object* x_18; lean_object* x_19; 
x_15 = lean_ctor_get(x_14, 0);
lean_inc(x_15);
x_16 = lean_ctor_get(x_14, 1);
lean_inc(x_16);
lean_dec(x_14);
x_17 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__3;
x_18 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__4;
lean_inc(x_7);
lean_inc(x_6);
x_19 = l_Lean_Core_transform___at_Lean_Core_betaReduce___spec__1(x_15, x_17, x_18, x_6, x_7, x_16);
if (lean_obj_tag(x_19) == 0)
{
lean_object* x_20; lean_object* x_21; lean_object* x_22; 
x_20 = lean_ctor_get(x_19, 0);
lean_inc(x_20);
x_21 = lean_ctor_get(x_19, 1);
lean_inc(x_21);
lean_dec(x_19);
lean_inc(x_3);
x_22 = l_Lean_Meta_Grind_markNestedProofsImpl_visit(x_20, x_3, x_4, x_5, x_6, x_7, x_21);
if (lean_obj_tag(x_22) == 0)
{
lean_object* x_23; lean_object* x_24; lean_object* x_25; lean_object* x_26; lean_object* x_27; lean_object* x_28; lean_object* x_29; uint8_t x_30; 
x_23 = lean_ctor_get(x_22, 0);
lean_inc(x_23);
x_24 = lean_ctor_get(x_22, 1);
lean_inc(x_24);
lean_dec(x_22);
x_25 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__9;
lean_inc(x_1);
x_26 = l_Lean_mkAppB(x_25, x_23, x_1);
x_27 = lean_st_ref_take(x_3, x_24);
x_28 = lean_ctor_get(x_27, 0);
lean_inc(x_28);
x_29 = lean_ctor_get(x_27, 1);
lean_inc(x_29);
lean_dec(x_27);
x_30 = !lean_is_exclusive(x_28);
if (x_30 == 0)
{
lean_object* x_31; lean_object* x_32; lean_object* x_33; size_t x_34; uint64_t x_35; uint64_t x_36; uint64_t x_37; uint64_t x_38; uint64_t x_39; uint64_t x_40; uint64_t x_41; uint64_t x_42; uint64_t x_43; size_t x_44; size_t x_45; size_t x_46; size_t x_47; size_t x_48; lean_object* x_49; uint8_t x_50; 
x_31 = lean_ctor_get(x_28, 0);
x_32 = lean_ctor_get(x_28, 1);
x_33 = lean_array_get_size(x_32);
x_34 = lean_ptr_addr(x_1);
x_35 = lean_usize_to_uint64(x_34);
x_36 = 11;
x_37 = lean_uint64_mix_hash(x_35, x_36);
x_38 = 32;
x_39 = lean_uint64_shift_right(x_37, x_38);
x_40 = lean_uint64_xor(x_37, x_39);
x_41 = 16;
x_42 = lean_uint64_shift_right(x_40, x_41);
x_43 = lean_uint64_xor(x_40, x_42);
x_44 = lean_uint64_to_usize(x_43);
x_45 = lean_usize_of_nat(x_33);
lean_dec(x_33);
x_46 = 1;
x_47 = lean_usize_sub(x_45, x_46);
x_48 = lean_usize_land(x_44, x_47);
x_49 = lean_array_uget(x_32, x_48);
x_50 = l_Std_DHashMap_Internal_AssocList_contains___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__1(x_1, x_49);
if (x_50 == 0)
{
lean_object* x_51; lean_object* x_52; lean_object* x_53; lean_object* x_54; lean_object* x_55; lean_object* x_56; lean_object* x_57; lean_object* x_58; lean_object* x_59; uint8_t x_60; 
x_51 = lean_unsigned_to_nat(1u);
x_52 = lean_nat_add(x_31, x_51);
lean_dec(x_31);
lean_inc(x_26);
x_53 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_53, 0, x_1);
lean_ctor_set(x_53, 1, x_26);
lean_ctor_set(x_53, 2, x_49);
x_54 = lean_array_uset(x_32, x_48, x_53);
x_55 = lean_unsigned_to_nat(4u);
x_56 = lean_nat_mul(x_52, x_55);
x_57 = lean_unsigned_to_nat(3u);
x_58 = lean_nat_div(x_56, x_57);
lean_dec(x_56);
x_59 = lean_array_get_size(x_54);
x_60 = lean_nat_dec_le(x_58, x_59);
lean_dec(x_59);
lean_dec(x_58);
if (x_60 == 0)
{
lean_object* x_61; lean_object* x_62; uint8_t x_63; 
x_61 = l_Std_DHashMap_Internal_Raw_u2080_expand___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__2(x_54);
lean_ctor_set(x_28, 1, x_61);
lean_ctor_set(x_28, 0, x_52);
x_62 = lean_st_ref_set(x_3, x_28, x_29);
lean_dec(x_3);
x_63 = !lean_is_exclusive(x_62);
if (x_63 == 0)
{
lean_object* x_64; 
x_64 = lean_ctor_get(x_62, 0);
lean_dec(x_64);
lean_ctor_set(x_62, 0, x_26);
return x_62;
}
else
{
lean_object* x_65; lean_object* x_66; 
x_65 = lean_ctor_get(x_62, 1);
lean_inc(x_65);
lean_dec(x_62);
x_66 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_66, 0, x_26);
lean_ctor_set(x_66, 1, x_65);
return x_66;
}
}
else
{
lean_object* x_67; uint8_t x_68; 
lean_ctor_set(x_28, 1, x_54);
lean_ctor_set(x_28, 0, x_52);
x_67 = lean_st_ref_set(x_3, x_28, x_29);
lean_dec(x_3);
x_68 = !lean_is_exclusive(x_67);
if (x_68 == 0)
{
lean_object* x_69; 
x_69 = lean_ctor_get(x_67, 0);
lean_dec(x_69);
lean_ctor_set(x_67, 0, x_26);
return x_67;
}
else
{
lean_object* x_70; lean_object* x_71; 
x_70 = lean_ctor_get(x_67, 1);
lean_inc(x_70);
lean_dec(x_67);
x_71 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_71, 0, x_26);
lean_ctor_set(x_71, 1, x_70);
return x_71;
}
}
}
else
{
lean_object* x_72; lean_object* x_73; lean_object* x_74; lean_object* x_75; lean_object* x_76; uint8_t x_77; 
x_72 = lean_box(0);
x_73 = lean_array_uset(x_32, x_48, x_72);
lean_inc(x_26);
x_74 = l_Std_DHashMap_Internal_AssocList_replace___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__6(x_1, x_26, x_49);
x_75 = lean_array_uset(x_73, x_48, x_74);
lean_ctor_set(x_28, 1, x_75);
x_76 = lean_st_ref_set(x_3, x_28, x_29);
lean_dec(x_3);
x_77 = !lean_is_exclusive(x_76);
if (x_77 == 0)
{
lean_object* x_78; 
x_78 = lean_ctor_get(x_76, 0);
lean_dec(x_78);
lean_ctor_set(x_76, 0, x_26);
return x_76;
}
else
{
lean_object* x_79; lean_object* x_80; 
x_79 = lean_ctor_get(x_76, 1);
lean_inc(x_79);
lean_dec(x_76);
x_80 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_80, 0, x_26);
lean_ctor_set(x_80, 1, x_79);
return x_80;
}
}
}
else
{
lean_object* x_81; lean_object* x_82; lean_object* x_83; size_t x_84; uint64_t x_85; uint64_t x_86; uint64_t x_87; uint64_t x_88; uint64_t x_89; uint64_t x_90; uint64_t x_91; uint64_t x_92; uint64_t x_93; size_t x_94; size_t x_95; size_t x_96; size_t x_97; size_t x_98; lean_object* x_99; uint8_t x_100; 
x_81 = lean_ctor_get(x_28, 0);
x_82 = lean_ctor_get(x_28, 1);
lean_inc(x_82);
lean_inc(x_81);
lean_dec(x_28);
x_83 = lean_array_get_size(x_82);
x_84 = lean_ptr_addr(x_1);
x_85 = lean_usize_to_uint64(x_84);
x_86 = 11;
x_87 = lean_uint64_mix_hash(x_85, x_86);
x_88 = 32;
x_89 = lean_uint64_shift_right(x_87, x_88);
x_90 = lean_uint64_xor(x_87, x_89);
x_91 = 16;
x_92 = lean_uint64_shift_right(x_90, x_91);
x_93 = lean_uint64_xor(x_90, x_92);
x_94 = lean_uint64_to_usize(x_93);
x_95 = lean_usize_of_nat(x_83);
lean_dec(x_83);
x_96 = 1;
x_97 = lean_usize_sub(x_95, x_96);
x_98 = lean_usize_land(x_94, x_97);
x_99 = lean_array_uget(x_82, x_98);
x_100 = l_Std_DHashMap_Internal_AssocList_contains___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__1(x_1, x_99);
if (x_100 == 0)
{
lean_object* x_101; lean_object* x_102; lean_object* x_103; lean_object* x_104; lean_object* x_105; lean_object* x_106; lean_object* x_107; lean_object* x_108; lean_object* x_109; uint8_t x_110; 
x_101 = lean_unsigned_to_nat(1u);
x_102 = lean_nat_add(x_81, x_101);
lean_dec(x_81);
lean_inc(x_26);
x_103 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_103, 0, x_1);
lean_ctor_set(x_103, 1, x_26);
lean_ctor_set(x_103, 2, x_99);
x_104 = lean_array_uset(x_82, x_98, x_103);
x_105 = lean_unsigned_to_nat(4u);
x_106 = lean_nat_mul(x_102, x_105);
x_107 = lean_unsigned_to_nat(3u);
x_108 = lean_nat_div(x_106, x_107);
lean_dec(x_106);
x_109 = lean_array_get_size(x_104);
x_110 = lean_nat_dec_le(x_108, x_109);
lean_dec(x_109);
lean_dec(x_108);
if (x_110 == 0)
{
lean_object* x_111; lean_object* x_112; lean_object* x_113; lean_object* x_114; lean_object* x_115; lean_object* x_116; 
x_111 = l_Std_DHashMap_Internal_Raw_u2080_expand___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__2(x_104);
x_112 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_112, 0, x_102);
lean_ctor_set(x_112, 1, x_111);
x_113 = lean_st_ref_set(x_3, x_112, x_29);
lean_dec(x_3);
x_114 = lean_ctor_get(x_113, 1);
lean_inc(x_114);
if (lean_is_exclusive(x_113)) {
 lean_ctor_release(x_113, 0);
 lean_ctor_release(x_113, 1);
 x_115 = x_113;
} else {
 lean_dec_ref(x_113);
 x_115 = lean_box(0);
}
if (lean_is_scalar(x_115)) {
 x_116 = lean_alloc_ctor(0, 2, 0);
} else {
 x_116 = x_115;
}
lean_ctor_set(x_116, 0, x_26);
lean_ctor_set(x_116, 1, x_114);
return x_116;
}
else
{
lean_object* x_117; lean_object* x_118; lean_object* x_119; lean_object* x_120; lean_object* x_121; 
x_117 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_117, 0, x_102);
lean_ctor_set(x_117, 1, x_104);
x_118 = lean_st_ref_set(x_3, x_117, x_29);
lean_dec(x_3);
x_119 = lean_ctor_get(x_118, 1);
lean_inc(x_119);
if (lean_is_exclusive(x_118)) {
 lean_ctor_release(x_118, 0);
 lean_ctor_release(x_118, 1);
 x_120 = x_118;
} else {
 lean_dec_ref(x_118);
 x_120 = lean_box(0);
}
if (lean_is_scalar(x_120)) {
 x_121 = lean_alloc_ctor(0, 2, 0);
} else {
 x_121 = x_120;
}
lean_ctor_set(x_121, 0, x_26);
lean_ctor_set(x_121, 1, x_119);
return x_121;
}
}
else
{
lean_object* x_122; lean_object* x_123; lean_object* x_124; lean_object* x_125; lean_object* x_126; lean_object* x_127; lean_object* x_128; lean_object* x_129; lean_object* x_130; 
x_122 = lean_box(0);
x_123 = lean_array_uset(x_82, x_98, x_122);
lean_inc(x_26);
x_124 = l_Std_DHashMap_Internal_AssocList_replace___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__6(x_1, x_26, x_99);
x_125 = lean_array_uset(x_123, x_98, x_124);
x_126 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_126, 0, x_81);
lean_ctor_set(x_126, 1, x_125);
x_127 = lean_st_ref_set(x_3, x_126, x_29);
lean_dec(x_3);
x_128 = lean_ctor_get(x_127, 1);
lean_inc(x_128);
if (lean_is_exclusive(x_127)) {
 lean_ctor_release(x_127, 0);
 lean_ctor_release(x_127, 1);
 x_129 = x_127;
} else {
 lean_dec_ref(x_127);
 x_129 = lean_box(0);
}
if (lean_is_scalar(x_129)) {
 x_130 = lean_alloc_ctor(0, 2, 0);
} else {
 x_130 = x_129;
}
lean_ctor_set(x_130, 0, x_26);
lean_ctor_set(x_130, 1, x_128);
return x_130;
}
}
}
else
{
uint8_t x_131; 
lean_dec(x_3);
lean_dec(x_1);
x_131 = !lean_is_exclusive(x_22);
if (x_131 == 0)
{
return x_22;
}
else
{
lean_object* x_132; lean_object* x_133; lean_object* x_134; 
x_132 = lean_ctor_get(x_22, 0);
x_133 = lean_ctor_get(x_22, 1);
lean_inc(x_133);
lean_inc(x_132);
lean_dec(x_22);
x_134 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_134, 0, x_132);
lean_ctor_set(x_134, 1, x_133);
return x_134;
}
}
}
else
{
uint8_t x_135; 
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_1);
x_135 = !lean_is_exclusive(x_19);
if (x_135 == 0)
{
return x_19;
}
else
{
lean_object* x_136; lean_object* x_137; lean_object* x_138; 
x_136 = lean_ctor_get(x_19, 0);
x_137 = lean_ctor_get(x_19, 1);
lean_inc(x_137);
lean_inc(x_136);
lean_dec(x_19);
x_138 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_138, 0, x_136);
lean_ctor_set(x_138, 1, x_137);
return x_138;
}
}
}
else
{
uint8_t x_139; 
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_1);
x_139 = !lean_is_exclusive(x_14);
if (x_139 == 0)
{
return x_14;
}
else
{
lean_object* x_140; lean_object* x_141; lean_object* x_142; 
x_140 = lean_ctor_get(x_14, 0);
x_141 = lean_ctor_get(x_14, 1);
lean_inc(x_141);
lean_inc(x_140);
lean_dec(x_14);
x_142 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_142, 0, x_140);
lean_ctor_set(x_142, 1, x_141);
return x_142;
}
}
}
else
{
uint8_t x_143; 
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_1);
x_143 = !lean_is_exclusive(x_9);
if (x_143 == 0)
{
return x_9;
}
else
{
lean_object* x_144; lean_object* x_145; lean_object* x_146; 
x_144 = lean_ctor_get(x_9, 0);
x_145 = lean_ctor_get(x_9, 1);
lean_inc(x_145);
lean_inc(x_144);
lean_dec(x_9);
x_146 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_146, 0, x_144);
lean_ctor_set(x_146, 1, x_145);
return x_146;
}
}
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__7(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8) {
_start:
{
lean_object* x_9; uint8_t x_10; 
x_9 = lean_st_ref_get(x_3, x_8);
x_10 = !lean_is_exclusive(x_9);
if (x_10 == 0)
{
lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; size_t x_15; uint64_t x_16; uint64_t x_17; uint64_t x_18; uint64_t x_19; uint64_t x_20; uint64_t x_21; uint64_t x_22; uint64_t x_23; uint64_t x_24; size_t x_25; size_t x_26; size_t x_27; size_t x_28; size_t x_29; lean_object* x_30; lean_object* x_31; 
x_11 = lean_ctor_get(x_9, 0);
x_12 = lean_ctor_get(x_9, 1);
x_13 = lean_ctor_get(x_11, 1);
lean_inc(x_13);
lean_dec(x_11);
x_14 = lean_array_get_size(x_13);
x_15 = lean_ptr_addr(x_1);
x_16 = lean_usize_to_uint64(x_15);
x_17 = 11;
x_18 = lean_uint64_mix_hash(x_16, x_17);
x_19 = 32;
x_20 = lean_uint64_shift_right(x_18, x_19);
x_21 = lean_uint64_xor(x_18, x_20);
x_22 = 16;
x_23 = lean_uint64_shift_right(x_21, x_22);
x_24 = lean_uint64_xor(x_21, x_23);
x_25 = lean_uint64_to_usize(x_24);
x_26 = lean_usize_of_nat(x_14);
lean_dec(x_14);
x_27 = 1;
x_28 = lean_usize_sub(x_26, x_27);
x_29 = lean_usize_land(x_25, x_28);
x_30 = lean_array_uget(x_13, x_29);
lean_dec(x_13);
x_31 = l_Std_DHashMap_Internal_AssocList_get_x3f___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__10(x_1, x_30);
lean_dec(x_30);
if (lean_obj_tag(x_31) == 0)
{
lean_object* x_32; lean_object* x_33; 
lean_free_object(x_9);
x_32 = lean_box(0);
x_33 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6(x_1, x_32, x_3, x_4, x_5, x_6, x_7, x_12);
return x_33;
}
else
{
lean_object* x_34; 
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_1);
x_34 = lean_ctor_get(x_31, 0);
lean_inc(x_34);
lean_dec(x_31);
lean_ctor_set(x_9, 0, x_34);
return x_9;
}
}
else
{
lean_object* x_35; lean_object* x_36; lean_object* x_37; lean_object* x_38; size_t x_39; uint64_t x_40; uint64_t x_41; uint64_t x_42; uint64_t x_43; uint64_t x_44; uint64_t x_45; uint64_t x_46; uint64_t x_47; uint64_t x_48; size_t x_49; size_t x_50; size_t x_51; size_t x_52; size_t x_53; lean_object* x_54; lean_object* x_55; 
x_35 = lean_ctor_get(x_9, 0);
x_36 = lean_ctor_get(x_9, 1);
lean_inc(x_36);
lean_inc(x_35);
lean_dec(x_9);
x_37 = lean_ctor_get(x_35, 1);
lean_inc(x_37);
lean_dec(x_35);
x_38 = lean_array_get_size(x_37);
x_39 = lean_ptr_addr(x_1);
x_40 = lean_usize_to_uint64(x_39);
x_41 = 11;
x_42 = lean_uint64_mix_hash(x_40, x_41);
x_43 = 32;
x_44 = lean_uint64_shift_right(x_42, x_43);
x_45 = lean_uint64_xor(x_42, x_44);
x_46 = 16;
x_47 = lean_uint64_shift_right(x_45, x_46);
x_48 = lean_uint64_xor(x_45, x_47);
x_49 = lean_uint64_to_usize(x_48);
x_50 = lean_usize_of_nat(x_38);
lean_dec(x_38);
x_51 = 1;
x_52 = lean_usize_sub(x_50, x_51);
x_53 = lean_usize_land(x_49, x_52);
x_54 = lean_array_uget(x_37, x_53);
lean_dec(x_37);
x_55 = l_Std_DHashMap_Internal_AssocList_get_x3f___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__10(x_1, x_54);
lean_dec(x_54);
if (lean_obj_tag(x_55) == 0)
{
lean_object* x_56; lean_object* x_57; 
x_56 = lean_box(0);
x_57 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6(x_1, x_56, x_3, x_4, x_5, x_6, x_7, x_36);
return x_57;
}
else
{
lean_object* x_58; lean_object* x_59; 
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_1);
x_58 = lean_ctor_get(x_55, 0);
lean_inc(x_58);
lean_dec(x_55);
x_59 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_59, 0, x_58);
lean_ctor_set(x_59, 1, x_36);
return x_59;
}
}
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7) {
_start:
{
lean_object* x_8; 
lean_inc(x_6);
lean_inc(x_5);
lean_inc(x_4);
lean_inc(x_3);
lean_inc(x_1);
x_8 = l_Lean_Meta_isProof(x_1, x_3, x_4, x_5, x_6, x_7);
if (lean_obj_tag(x_8) == 0)
{
lean_object* x_9; uint8_t x_10; 
x_9 = lean_ctor_get(x_8, 0);
lean_inc(x_9);
x_10 = lean_unbox(x_9);
lean_dec(x_9);
if (x_10 == 0)
{
lean_object* x_11; lean_object* x_12; lean_object* x_13; 
x_11 = lean_ctor_get(x_8, 1);
lean_inc(x_11);
lean_dec(x_8);
x_12 = lean_box(0);
x_13 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__5(x_1, x_12, x_2, x_3, x_4, x_5, x_6, x_11);
return x_13;
}
else
{
uint8_t x_14; 
x_14 = !lean_is_exclusive(x_8);
if (x_14 == 0)
{
lean_object* x_15; lean_object* x_16; lean_object* x_17; uint8_t x_18; 
x_15 = lean_ctor_get(x_8, 1);
x_16 = lean_ctor_get(x_8, 0);
lean_dec(x_16);
x_17 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__8;
x_18 = l_Lean_Expr_isAppOf(x_1, x_17);
if (x_18 == 0)
{
lean_object* x_19; lean_object* x_20; 
lean_free_object(x_8);
x_19 = lean_box(0);
x_20 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__7(x_1, x_19, x_2, x_3, x_4, x_5, x_6, x_15);
return x_20;
}
else
{
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_2);
lean_ctor_set(x_8, 0, x_1);
return x_8;
}
}
else
{
lean_object* x_21; lean_object* x_22; uint8_t x_23; 
x_21 = lean_ctor_get(x_8, 1);
lean_inc(x_21);
lean_dec(x_8);
x_22 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__8;
x_23 = l_Lean_Expr_isAppOf(x_1, x_22);
if (x_23 == 0)
{
lean_object* x_24; lean_object* x_25; 
x_24 = lean_box(0);
x_25 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__7(x_1, x_24, x_2, x_3, x_4, x_5, x_6, x_21);
return x_25;
}
else
{
lean_object* x_26; 
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_2);
x_26 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_26, 0, x_1);
lean_ctor_set(x_26, 1, x_21);
return x_26;
}
}
}
}
else
{
uint8_t x_27; 
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_2);
lean_dec(x_1);
x_27 = !lean_is_exclusive(x_8);
if (x_27 == 0)
{
return x_8;
}
else
{
lean_object* x_28; lean_object* x_29; lean_object* x_30; 
x_28 = lean_ctor_get(x_8, 0);
x_29 = lean_ctor_get(x_8, 1);
lean_inc(x_29);
lean_inc(x_28);
lean_dec(x_8);
x_30 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_30, 0, x_28);
lean_ctor_set(x_30, 1, x_29);
return x_30;
}
}
}
}
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_AssocList_contains___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__1___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
uint8_t x_3; lean_object* x_4; 
x_3 = l_Std_DHashMap_Internal_AssocList_contains___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__1(x_1, x_2);
lean_dec(x_2);
lean_dec(x_1);
x_4 = lean_box(x_3);
return x_4;
}
}
LEAN_EXPORT lean_object* l_Std_Range_forIn_x27_loop___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__8___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8, lean_object* x_9, lean_object* x_10, lean_object* x_11, lean_object* x_12) {
_start:
{
lean_object* x_13; 
x_13 = l_Std_Range_forIn_x27_loop___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__8(x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9, x_10, x_11, x_12);
lean_dec(x_2);
lean_dec(x_1);
return x_13;
}
}
LEAN_EXPORT lean_object* l_Std_DHashMap_Internal_AssocList_get_x3f___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__10___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_Std_DHashMap_Internal_AssocList_get_x3f___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__10(x_1, x_2);
lean_dec(x_2);
lean_dec(x_1);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__1___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8) {
_start:
{
lean_object* x_9; 
x_9 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__1(x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8);
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
return x_9;
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__2___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8, lean_object* x_9, lean_object* x_10, lean_object* x_11, lean_object* x_12, lean_object* x_13) {
_start:
{
uint8_t x_14; lean_object* x_15; 
x_14 = lean_unbox(x_4);
lean_dec(x_4);
x_15 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__2(x_1, x_2, x_3, x_14, x_5, x_6, x_7, x_8, x_9, x_10, x_11, x_12, x_13);
return x_15;
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8) {
_start:
{
lean_object* x_9; 
x_9 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3(x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8);
lean_dec(x_2);
return x_9;
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__4___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8) {
_start:
{
lean_object* x_9; 
x_9 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__4(x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8);
lean_dec(x_2);
return x_9;
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__5___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8) {
_start:
{
lean_object* x_9; 
x_9 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__5(x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8);
lean_dec(x_2);
return x_9;
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8) {
_start:
{
lean_object* x_9; 
x_9 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6(x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8);
lean_dec(x_2);
return x_9;
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__7___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6, lean_object* x_7, lean_object* x_8) {
_start:
{
lean_object* x_9; 
x_9 = l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__7(x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8);
lean_dec(x_2);
return x_9;
}
}
static lean_object* _init_l_Lean_Meta_Grind_markNestedProofsImpl___closed__1() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lean_unsigned_to_nat(64u);
x_2 = l_Lean_mkPtrMap___rarg(x_1);
return x_2;
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofsImpl(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; 
x_7 = l_Lean_Meta_Grind_markNestedProofsImpl___closed__1;
x_8 = lean_st_mk_ref(x_7, x_6);
x_9 = lean_ctor_get(x_8, 0);
lean_inc(x_9);
x_10 = lean_ctor_get(x_8, 1);
lean_inc(x_10);
lean_dec(x_8);
lean_inc(x_9);
x_11 = l_Lean_Meta_Grind_markNestedProofsImpl_visit(x_1, x_9, x_2, x_3, x_4, x_5, x_10);
if (lean_obj_tag(x_11) == 0)
{
lean_object* x_12; lean_object* x_13; lean_object* x_14; uint8_t x_15; 
x_12 = lean_ctor_get(x_11, 0);
lean_inc(x_12);
x_13 = lean_ctor_get(x_11, 1);
lean_inc(x_13);
lean_dec(x_11);
x_14 = lean_st_ref_get(x_9, x_13);
lean_dec(x_9);
x_15 = !lean_is_exclusive(x_14);
if (x_15 == 0)
{
lean_object* x_16; 
x_16 = lean_ctor_get(x_14, 0);
lean_dec(x_16);
lean_ctor_set(x_14, 0, x_12);
return x_14;
}
else
{
lean_object* x_17; lean_object* x_18; 
x_17 = lean_ctor_get(x_14, 1);
lean_inc(x_17);
lean_dec(x_14);
x_18 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_18, 0, x_12);
lean_ctor_set(x_18, 1, x_17);
return x_18;
}
}
else
{
uint8_t x_19; 
lean_dec(x_9);
x_19 = !lean_is_exclusive(x_11);
if (x_19 == 0)
{
return x_11;
}
else
{
lean_object* x_20; lean_object* x_21; lean_object* x_22; 
x_20 = lean_ctor_get(x_11, 0);
x_21 = lean_ctor_get(x_11, 1);
lean_inc(x_21);
lean_inc(x_20);
lean_dec(x_11);
x_22 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_22, 0, x_20);
lean_ctor_set(x_22, 1, x_21);
return x_22;
}
}
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofs_unsafe__1(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
lean_object* x_7; 
x_7 = l_Lean_Meta_Grind_markNestedProofsImpl(x_1, x_2, x_3, x_4, x_5, x_6);
return x_7;
}
}
LEAN_EXPORT lean_object* l_Lean_Meta_Grind_markNestedProofs(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
lean_object* x_7; 
x_7 = l_Lean_Meta_Grind_markNestedProofsImpl(x_1, x_2, x_3, x_4, x_5, x_6);
return x_7;
}
}
lean_object* initialize_Init_Grind_Util(uint8_t builtin, lean_object*);
lean_object* initialize_Lean_Util_PtrSet(uint8_t builtin, lean_object*);
lean_object* initialize_Lean_Meta_Transform(uint8_t builtin, lean_object*);
lean_object* initialize_Lean_Meta_Basic(uint8_t builtin, lean_object*);
lean_object* initialize_Lean_Meta_InferType(uint8_t builtin, lean_object*);
lean_object* initialize_Lean_Meta_Tactic_Grind_Util(uint8_t builtin, lean_object*);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_Lean_Meta_Tactic_Grind_MarkNestedProofs(uint8_t builtin, lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init_Grind_Util(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Lean_Util_PtrSet(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Lean_Meta_Transform(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Lean_Meta_Basic(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Lean_Meta_InferType(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Lean_Meta_Tactic_Grind_Util(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7___closed__1 = _init_l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7___closed__1();
lean_mark_persistent(l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7___closed__1);
l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7___closed__2 = _init_l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7___closed__2();
lean_mark_persistent(l_panic___at_Lean_Meta_Grind_markNestedProofsImpl_visit___spec__7___closed__2);
l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__1 = _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__1();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__1);
l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__2 = _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__2();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__2);
l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__3 = _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__3();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__3);
l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__4 = _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__4();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__4);
l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__5 = _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__5();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__3___closed__5);
l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__1 = _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__1();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__1);
l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__2 = _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__2();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__2);
l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__3 = _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__3();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__3);
l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__4 = _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__4();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__4);
l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__5 = _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__5();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__5);
l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__6 = _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__6();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__6);
l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__7 = _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__7();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__7);
l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__8 = _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__8();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__8);
l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__9 = _init_l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__9();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl_visit___lambda__6___closed__9);
l_Lean_Meta_Grind_markNestedProofsImpl___closed__1 = _init_l_Lean_Meta_Grind_markNestedProofsImpl___closed__1();
lean_mark_persistent(l_Lean_Meta_Grind_markNestedProofsImpl___closed__1);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
