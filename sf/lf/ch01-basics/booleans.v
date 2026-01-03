(* vim:ft=coq *)

Inductive bool : Type :=
  | true
  | false.

Definition negb (b : bool) : bool :=
  match b with
  | true => false
  | false => true
  end.

Definition andb (b1 : bool) (b2 : bool) : bool :=
  match b1 with
  | true => b2
  | false => false
  end.

Definition orb (b1 : bool) (b2 : bool) : bool :=
  match b1 with
  | true => true
  | false => b2
  end.

(* Examples *)

Example test_orb1: (orb true false) = true.
Proof. simpl. reflexivity. Qed.
Example test_orb2: (orb false false) = false.
Proof. simpl. reflexivity. Qed.
Example test_orb3: (orb false true) = true.
Proof. simpl. reflexivity. Qed.
Example test_orb4: (orb true true) = true.
Proof. simpl. reflexivity. Qed.

Example test_andb1: (andb true false) = false.
Proof. simpl. reflexivity. Qed.
Example test_andb2: (andb false false) = false.
Proof. simpl. reflexivity. Qed.
Example test_andb3: (andb false true) = false.
Proof. simpl. reflexivity. Qed.
Example test_andb4: (andb true true) = true.
Proof. simpl. reflexivity. Qed.

Example test_negb1: (negb true) = false.
Proof. simpl. reflexivity. Qed.
Example test_negb2: (negb false) = true.
Proof. simpl. reflexivity. Qed.

(* Notation *)
Notation "x && y" := (andb x y).
Notation "x || y" := (orb x y).

Example test_orb5: false || false || true = true.
Proof. simpl. reflexivity. Qed.

(* Conditional expression *)
Definition negb' (b : bool) : bool :=
  if b then false
  else true.

Definition andb' (b1 : bool) (b2 : bool) : bool :=
  if b1 then b2
  else false.

Definition orb' (b1: bool) (b2 : bool) : bool :=
  if b1 then true
  else b2.
