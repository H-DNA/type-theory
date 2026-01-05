(* vim:ft=coq *)

Inductive nat : Type :=
  | O
  | S (n : nat).

Fixpoint plus (n : nat) (m : nat) : nat :=
    match n with
    | O => m
    | S n' => S (plus n' m)
    end.

Fixpoint mult (n m : nat) : nat :=
  match n with
  | O => O
  | S n' => plus m (mult n' m)
  end.

Fixpoint factorial (n : nat) : nat :=
  match n with
  | O => S O
  | S O => S O
  | S n' => mult n (factorial n')
  end.
