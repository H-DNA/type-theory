(* vim:ft=coq *)

Module NatPlayground.
  (* Recursive definition to define an unary representation of natural numbers *)
  Inductive nat : Type :=
    | O             (* zero *)
    | S (n : nat).  (* successor/scratch *)
  
  (** At this point, nat and otherNat just use different markers, other than that, they have no differences **)
  Inductive otherNat : Type :=
    | stop
    | tick (foo : otherNat).
  
  (* Give an interpretation to nat to distinguish it from otherNat *)
  Definition pred (n : nat) : nat :=
    match n with
    | O => O
    | S n' => n'
    end.

  (* Natural numbers receive a special treament regarding parsing and printing: ordinary decimal numerals can be used *)
  Check (S (S (S (S O)))).
  (* ==> 4 : nat *)

  Definition minusTwo (n : nat) : nat :=
    match n with
    | O => O
    | S O => O
    | S (S n') => n'
    end.

  (* The constructor has the type nat -> nat, just like the functions, however, the constructor has no computation rules *)
  Check S : nat -> nat.
  Check pred : nat -> nat.
  Check minusTwo : nat -> nat.

  (* Recursive function definition *)
  Fixpoint even (n : nat) : nat :=
    match n with
    | O => true
    | S O => false
    | S (S n') => even n'
    end.

  Fixpoint odd (n : nat) : nat :=
    match n with
    | O => false
    | S O => true
    | S (S n') => odd n'
    end.

  Example test_odd1: odd 1 = true.
  Proof. simpl. reflexivity. Qed.
  Example test_odd2: odd 4 = false.
  Proof. simpl. reflexivity. Qed.

  (* Arithmetic operations *)
  Fixpoint plus (n : nat) (m : nat) : nat :=
    match n with
    | O => m
    | S n' => S (plus n' m)
    end.
End NatPlayground.
