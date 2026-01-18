# Learning Points

## Pattern matching & Proof

### TL;DR

1. Pattern structure affects proofs, not just runtime behavior.
2. Mixing specific and general patterns at the same level causes trouble with abstract variables.
3. Nested matching isolates specificity—each level stays orthogonal.

### Context

When I was doing the "Coure late policies" exercise set of this chapter, I ran into a pretty puzzling situtation with the theorem `lower_grade_lowers` (exercise 17).

My solution to `lower_grade` (exercise 16) was:
    
```rocq
Definition lower_grade (g : grade) : grade :=
  match g with
  | Grade m Plus => Grade m Natural
  | Grade m Natural => Grade m Minus
  | Grade F Minus => g                            (* specific *)
  | Grade m Minus => Grade (lower_letter m) Plus  (* general *)
  end.
```

It seemed perfectly fine.

My solution to `lower_grade_lowers` (exercise 17) was:
```rocq
(* Lowered non-F-Minus-grade is lower *)
Theorem lower_grade_lowers :
  forall (g : grade),
    grade_comparison (Grade F Minus) g = Lt ->
    grade_comparison (lower_grade g) g = Lt.
Proof.
  intros g H.
  destruct g as [l m].
  destruct m.
  - (* Plus case *)
    simpl.                        (* --> Weird simplified goal *)
    rewrite letter_comparison_Eq. (* --> Failed! *)
    reflexivity.
  - (* Natural case *)
    simpl.
    rewrite letter_comparison_Eq.
    reflexivity.
  - (* Minus case - need to destruct letter *)
    destruct l.
    + (* A Minus *) simpl. reflexivity.
    + (* B Minus *) simpl. reflexivity.
    + (* C Minus *) simpl. reflexivity.
    + (* D Minus *) simpl. reflexivity.
    + (* E Minus *) simpl. reflexivity.
    + (* F Minus *)
      rewrite lower_grade_F_Minus.
      simpl in H.
      simpl.
      rewrite H.
      reflexivity.
Qed.
```

`simpl` produced weird residual matches like `match l with | A | _ => ... end` even for the `Plus` case, blocking simplification.

The probable cause (according to Claude): Coq saw `F` mentioned in the patterns and couldn't simplify with an abstract letter variable `l`—it worried `l` might be `F`.

So the fix was this: Use nested matching to isolate the specific case:

```rocq
Definition lower_grade (g : grade) : grade :=
  match g with
  | Grade l Plus => Grade l Natural
  | Grade l Natural => Grade l Minus
  | Grade l Minus => match l with
                     | F => g
                     | _ => Grade (lower_letter l) Plus
                     end
  end.
```

</details>
