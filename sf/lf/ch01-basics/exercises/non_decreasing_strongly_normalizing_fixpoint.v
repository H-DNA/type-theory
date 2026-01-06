(* vim:ft=coq *)

Inductive bool : Type :=
  | true
  | false.

Inductive nat : Type :=
  | O
  | S (n : nat).

Definition negb (b : bool) : bool :=
  match b with
  | true => false
  | false => true
  end.

Fixpoint plus (n m : nat) : nat :=
  match n with
  | O => m
  | S n' => S (plus n' m)
  end.

Fixpoint minus (n m : nat) : nat :=
  match n, m with
  | O, _ => O
  | _, O => n
  | S n', S m' => minus n' m'
  end.

Notation "x + y" := (plus x y)
  (at level 50, left associativity) : nat_scope.

Notation "x - y" := (minus x y)
  (at level 50, left associativity) : nat_scope.

(* A Fixpoint definition that does terminate on all inputs but will be rejected by Rocq due to the "decreasing argument" restriction *)
Fixpoint foo (n : nat) (m : bool) : nat :=
  match n with
  | O => O
  | S _ => if m then (foo (n + 1) (negb m))
           else (foo (n - 2) (negb m))
  end.

