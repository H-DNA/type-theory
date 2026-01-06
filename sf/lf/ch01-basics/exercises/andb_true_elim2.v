(* vim:ft=coq *)

Theorem andb_true_elim2 : forall b c : bool,
  andb b c = true -> c = true.
Proof.
  intros b c.
  intros H.
  destruct c as [|] eqn:Ec.
  - reflexivity.
  - destruct b as [|] eqn:Eb.
    + simpl in H. rewrite <- H. reflexivity.
    + simpl in H. rewrite <- H. reflexivity.
Qed.
