# Type Theory

![OCaml](https://img.shields.io/badge/OCaml-EC6813?logo=ocaml&logoColor=white)
![Coq](https://img.shields.io/badge/Coq-CC2927?logo=coq&logoColor=white)
![Racket](https://img.shields.io/badge/Racket-9F1D20?logo=racket&logoColor=white)

Hands-on implementations of type systems, interpreters, and related concepts. Includes exercises from TAPL, PLAI, Software Foundations, and other sources.

**Concepts tracker**: [Notion](https://painted-jodhpur-6fe.notion.site/Concepts-master-2bbaa8fcd08880cc91bacfef709d0aec)

## Setup

This project uses [Nix](https://nixos.org/) for reproducible development environments.

### Prerequisites

- [Nix](https://nixos.org/download/) with flakes enabled

### Getting Started

```bash
# Enter the development shell
nix develop

# Or use direnv for automatic activation
echo "use flake" > .envrc && direnv allow
```

The dev shell provides:
- **OCaml** — compiler, dune, utop, ocaml-lsp, ocamlformat
- **Racket** — includes DrRacket
- **Coq** — compiler and IDE support

## Project Structure

```
.
├── tapl/                 # Types and Programming Languages (OCaml)
│   └── ch03-untyped-arithmetic/
├── plai/                 # Programming Languages: Application and Interpretation (Racket)
│   └── lambda-calc-evaluator/
└── sf/                   # Software Foundations (Coq)
    └── lf/               # Logical Foundations
```

## Books

### TAPL — Types and Programming Languages

- **Author:** Benjamin C. Pierce
- **Language:** OCaml
- **Link:** [MIT Press](https://mitpress.mit.edu/9780262162098/types-and-programming-languages/)

The definitive textbook on type systems. Covers type systems, operational semantics, lambda calculus, subtyping, polymorphism, and type reconstruction.

### PLAI — Programming Languages: Application and Interpretation

- **Author:** Shriram Krishnamurthi
- **Language:** Typed Plait (Racket)
- **Link:** [plai.org](https://www.plai.org/)

An interpreter-based approach to programming languages. Covers parsing, desugaring, interpreters, environments, mutation, objects, type systems, and continuations.

### SF — Software Foundations

- **Authors:** Benjamin C. Pierce et al.
- **Language:** Coq/Rocq
- **Link:** [softwarefoundations.cis.upenn.edu](https://softwarefoundations.cis.upenn.edu/)

A series of electronic textbooks on the mathematical underpinnings of reliable software using the Coq proof assistant.

**Volumes:**
- **LF** — Logical Foundations
- **PLF** — Programming Language Foundations
- **VFA** — Verified Functional Algorithms
- **QC** — QuickChick: Property-based testing
