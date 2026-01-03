(* vim:ft=coq *)

Inductive bool : Type :=
  | true
  | false.

Module TuplePlayground.
  (* bit datatype that represents bool *)
  Inductive bit : Type :=
    | B1
    | B0.

  (* nybble datatype that represents half a byte *)
  Inductive nybble : Type :=
    | bits (b0 b1 b2 b3 : bit). (* Tuple definition *)

  Check (bits B1 B0 B1 B0) : nybble.

  (* Unwrap tuple *)
  Definition all_zero (nb : nybble) : bool :=
    match nb with
    | (bits B0 B0 B0 B0) => true
    | (bits _ _ _ _) => false
    end.
End TuplePlayground.
