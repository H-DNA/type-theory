(* vim:ft=coq *)

Fact mult_n_0 : forall p : nat,
  0 = p * 0.
Proof. Admitted.

Theorem mult_n_1 : forall p : nat,
  p * 1 = p.
Proof.
  intros p.
  rewrite <- mult_n_Sm.
  rewrite <- mult_n_0.
  reflexivity.
Qed.
