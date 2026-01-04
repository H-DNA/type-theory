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
End NatPlayground.
