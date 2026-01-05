{
  description = "Type theory development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # OCaml
            ocaml
            dune_3
            ocamlPackages.ocaml-lsp
            ocamlPackages.ocamlformat
            ocamlPackages.utop
            ocamlPackages.findlib

            # Racket (includes DrRacket)
            racket

            # Rocq (formerly Coq)
            rocq-core
          ];

          shellHook = ''
            echo "Type theory dev environment loaded"
            echo "  - OCaml $(ocaml --version)"
            echo "  - Racket $(racket --version)"
            echo "  - Rocq $(rocq --version | head -1)"
          '';
        };
      }
    );
}
