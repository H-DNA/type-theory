Module LateDays.
  Inductive letter : Type :=
    | A | B | C | D | E | F.
  Inductive modifier : Type :=
    | Plus | Natural | Minus.
  Inductive grade : Type :=
    Grade (l : letter) (m : modifier).
  Inductive comparison : Type :=
    | Eq
    | Lt
    | Gt.
  Definition letter_comparison (l1 l2 : letter) : comparison :=
    match l1, l2 with
    | A, A => Eq
    | A, _ => Gt
    | B, A => Lt
    | B, B => Eq
    | B, _ => Gt
    | C, (A | B) => Lt
    | C, C => Eq
    | C, _ => Gt
    | D, (A | B | C) => Lt
    | D, D => Eq
    | D, _ => Gt
    | E, F => Gt
    | E, E => Eq
    | E, _ => Lt
    | F, F => Eq
    | F, _ => Lt
    end.

  Compute letter_comparison B A.
  Compute letter_comparison D D.
  Compute letter_comparison B F.

  (* Comparing a letter against itself gives `Eq` *)
  Theorem letter_comparison_Eq :
    forall l, letter_comparison l l = Eq.
  Proof.
    intros l.
    destruct l eqn:El.
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - reflexivity.
  Qed.

  Definition modifier_comparison (m1 m2 : modifier) : comparison :=
  match m1, m2 with
  | Plus, Plus => Eq
  | Plus, _ => Gt
  | Natural, Plus => Lt
  | Natural, Natural => Eq
  | Natural, _ => Gt
  | Minus, (Plus | Natural) => Lt
  | Minus, Minus => Eq
  end.

  (* Grade comparison - by letter first, then by modifier *)
  Definition grade_comparison (g1 g2 : grade) : comparison :=
  match g1, g2 with
  | Grade l1 m1, Grade l2 m2
      => match (letter_comparison l1 l2) with
         | Lt => Lt
         | Gt => Gt
         | Eq => (modifier_comparison m1 m2)
         end
  end.

  Example test_grade_comparison1 :
    (grade_comparison (Grade A Minus) (Grade B Plus)) = Gt.
  Proof.
    reflexivity.
  Qed.

  Example test_grade_comparison2 :
    (grade_comparison (Grade A Minus) (Grade A Plus)) = Lt.
  Proof.
    reflexivity.
  Qed.

  Example test_grade_comparison3 :
    (grade_comparison (Grade F Plus) (Grade F Plus)) = Eq.
  Proof.
    reflexivity.
  Qed.

  Example test_grade_comparison4 :
    (grade_comparison (Grade B Minus) (Grade C Plus)) = Gt.
  Proof.
    reflexivity.
  Qed.

  Definition lower_letter (l : letter) : letter :=
    match l with
    | A => B
    | B => C
    | C => D
    | D => E
    | E => F
    | F => F
    end.

  Theorem lower_letter_F_is_F :
    lower_letter F = F.
  Proof.
    simpl.
    reflexivity.
  Qed.

  (* Lowered non-F letter is lower *)
  Theorem lower_letter_lowers :
    forall (l : letter),
    letter_comparison F l = Lt -> letter_comparison (lower_letter l) l = Lt.
  Proof.
    intros l.
    intros H.
    destruct l.
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - simpl in H.
      rewrite <- H.
      reflexivity.
  Qed.

  (* Lower grade *)
  Definition lower_grade (g : grade) : grade :=
  match g with
  | Grade l Plus => Grade l Natural
  | Grade l Natural => Grade l Minus
  | Grade l Minus => match l with
                     | F => g
                     | _ => Grade (lower_letter l) Plus
                     end
  end.

  Example lower_grade_A_Plus :
  lower_grade (Grade A Plus) = (Grade A Natural).
Proof. reflexivity. Qed.

Example lower_grade_A_Natural :
  lower_grade (Grade A Natural) = (Grade A Minus).
Proof. reflexivity. Qed.

Example lower_grade_A_Minus :
  lower_grade (Grade A Minus) = (Grade B Plus).
Proof. reflexivity. Qed.

Example lower_grade_B_Plus :
  lower_grade (Grade B Plus) = (Grade B Natural).
Proof. reflexivity. Qed.

Example lower_grade_F_Natural :
  lower_grade (Grade F Natural) = (Grade F Minus).
Proof. reflexivity. Qed.

Example lower_grade_twice :
  lower_grade (lower_grade (Grade B Minus)) = (Grade C Natural).
Proof. reflexivity. Qed.

Example lower_grade_thrice :
  lower_grade (lower_grade (lower_grade (Grade B Minus))) = (Grade C Minus).
Proof. reflexivity. Qed.

Example lower_grade_F_Minus :
  lower_grade (Grade F Minus) = (Grade F Minus).
Proof. reflexivity. Qed.

(* Lowered non-F-Minus-grade is lower *)
Theorem lower_grade_lowers :
  forall (g : grade),
    grade_comparison (Grade F Minus) g = Lt ->
    grade_comparison (lower_grade g) g = Lt.
Proof.
  intros g H.
  destruct g as [l m].
  destruct m.
  - (* Plus case *)
    simpl.
    rewrite letter_comparison_Eq.
    reflexivity.
  - (* Natural case *)
    simpl.
    rewrite letter_comparison_Eq.
    reflexivity.
  - (* Minus case - need to destruct letter *)
    destruct l.
    + (* A Minus *) simpl. reflexivity.
    + (* B Minus *) simpl. reflexivity.
    + (* C Minus *) simpl. reflexivity.
    + (* D Minus *) simpl. reflexivity.
    + (* E Minus *) simpl. reflexivity.
    + (* F Minus *)
      rewrite lower_grade_F_Minus.
      simpl in H.
      simpl.
      rewrite H.
      reflexivity.
Qed.
End LateDays.
