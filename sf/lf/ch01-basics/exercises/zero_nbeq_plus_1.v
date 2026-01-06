(* vim:ft=coq *)

Theorem zero_nbeq_plus_1 : forall n : nat,
  0 =? (n + 1) = false.
Proof.
  intros [|n'].
  - reflexivity.
  - reflexivity.
Qed.
