(* vim:ft=coq *)

Inductive bool : Type :=
  | true
  | false.

Definition negb (b : bool) : bool :=
  if b then false
  else true.

Definition nandb (b1 : bool) (b2 : bool) : bool :=
  if b1 then (negb b2)
  else true.

Example test_nandb1: (nandb true false) = true.
Proof. simpl. reflexivity. Qed.
Example test_nandb2: (nandb false false) = true.
Proof. simpl. reflexivity. Qed.
Example test_nandb3: (nandb false true) = true.
Proof. simpl. reflexivity. Qed.
Example test_nandb4: (nandb true true) = false.
Proof. simpl. reflexivity. Qed.
