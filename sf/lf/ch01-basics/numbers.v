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
  Fixpoint even (n : nat) : bool :=
    match n with
    | O => true
    | S O => false
    | S (S n') => even n'
    end.

  Fixpoint odd (n : nat) : bool :=
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

  (** If two or more arguments have the same type, we can use a shorthand **)
  Fixpoint mult (n m : nat) : nat :=
    match n with
    | O => O
    | S n' => plus m (mult n' m)
    end.

  (** Match multiple expressions at once **)
  Fixpoint minus (n m : nat) : nat :=
    match n, m with
    | O, _ => O
    | _, O => n
    | S n', S m' => minus n' m'
    end.

  Fixpoint exp (base power : nat) : nat :=
    match power with
    | O => S O
    | S p => mult base (exp base p)
    end.

  (* Define notation with specified fixity and precedence *)
  Notation "x + y" := (plus x y)
    (at level 50, left associativity) : nat_scope.

  Notation "x - y" := (minus x y)
    (at level 50, left associativity) : nat_scope.

  Notation "x * y" := (mult x y)
    (at level 40, left associativity) : nat_scope.

  Check ((0 + 1) + 1) : nat.

  Fixpoint eqb (n m : nat) : bool :=
    match n with
    | O => match m with
           | O => true
           | S m' => false
           end
    | S n' => match m with
           | O => false
           | S m' => eqb n' m'
           end
    end.

  Fixpoint leb (n m : nat) : bool :=
    match n with
    | O => true
    | S n' =>
        match m with
        | O => false
        | S m' => leb n' m'
        end
    end.

  Notation "x =? y" := (eqb x y)
    (at level 70) : nat_scope.

  Notation "x <=? y" := (leb x y)
    (at level 70) : nat_scope.

  Example test_leb1: leb 2 2 = true.
  Proof. simpl. reflexivity. Qed.
  Example test_leb2: leb 2 4 = true.
  Proof. simpl. reflexivity. Qed.
  Example test_leb3: leb 4 2 = false.
  Proof. simpl. reflexivity. Qed.
  Example test_leb3': (4 <=? 2) = false.
  Proof. simpl. reflexivity. Qed.

  (* Proof by simplification - A theorem that proves 0 is a neutral element for + on the left *)
  Theorem plus_0_n' : forall n : nat, 0 + n = n.
  Proof.
    intros n. reflexivity. Qed.

  Theorem plus_1_l : forall n : nat, 1 + n = S n.
  Proof. intros n. simpl. reflexivity. Qed.

  Theorem mult_0_l : forall n : nat, 0 * n = 0.
  Proof. intros n. simpl. reflexivity. Qed.

  (* Proof by rewriting - A theorem that only holds when a specific condition is met *)
  Theorem plus_id_example : forall n m : nat,
    n = m ->
    n + n = m + m.
  Proof.
    (* move both quantifiers into the context: *)
    intros n m.
    (* move the hypothesis into the context: *)
    intros H.
    (* rewrite the goal using the hypothesis: *)
    rewrite -> H.
    reflexivity.
  Qed.

  (* Proof by case analysis using the `destruct` tactic *)
  Theorem plus_1_neq_0 : forall n : nat,
    (n + 1) =? 0 = false.
  Proof.
    intros n.
    destruct n as [| n'] eqn:E.
    - reflexivity.
    - reflexivity.
  Qed.

  (** No intro pattern **)
  Theorem negb_involutive : forall b : bool,
    (negb (negb b)) = b.
  Proof.
    intros b.
    destruct b eqn:E.
    - reflexivity.
    - reflexivity.
  Qed.

  (** Nested destructs **)
  Theorem andb_commutative : forall b c : bool,
    andb b c = andb c b.
  Proof.
    intros b c.
    destruct b eqn:Eb.
    - destruct c eqn:Ec.
      + reflexivity.
      + reflexivity.
    - destruct c eqn:Ec.
      + reflexivity.
      + reflexivity.
  Qed.

  Theorem andb_commutative' : forall b c : bool,
    andb b c = andb c b.
  Proof.
    intros b c.
    destruct b eqn:Eb.
    { destruct c eqn:Ec.
      { reflexivity. }
      { reflexivity. } }
    { destruct c eqn:Ec.
      { reflexivity. }
      { reflexivity. } }
  Qed.
End NatPlayground.
