(* vim:ft=coq *)

Theorem andb_eq_orb :
  forall (b c : bool),
  (andb b c = orb b c) ->
  b = c.
Proof.
  intros b c.
  intros H.
  destruct b as [|] eqn:Eb.
  - simpl in H.
    rewrite <- H.
    reflexivity.
  - simpl in H.
    rewrite <- H.
    reflexivity.
Qed.
