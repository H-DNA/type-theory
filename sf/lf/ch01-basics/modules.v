(* vim:ft=coq *)

Inductive bool : Type :=
  | true
  | false.

Inductive rgb : Type :=
  | red
  | green
  | blue.

Inductive color : Type :=
  | black
  | white
  | primary (p : rgb).

(* An example module *)
Module Playground.
  (* A member declaration *)
  Definition foo : rgb := blue.
End Playground.

(* A top-level declaration *)
Definition foo : bool := true.

(* The two `foo` refer to different declarations *)
Check Playground.foo : rgb.
Check foo : bool.
