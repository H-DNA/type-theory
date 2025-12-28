#lang plai-typed

(require "main.rkt")

(define mt-env (hash empty))

;; Test numbers and booleans
(test (calc (numE 42) mt-env) (numV 42))
(test (calc (boolE #t) mt-env) (boolV #t))
(test (calc (boolE #f) mt-env) (boolV #f))

;; Test identity function: (λx.x) 5 => 5
(test (run (appE (absE "x" (varE "x")) (numE 5)))
      (numV 5))

;; Test constant function: (λx.λy.x) 1 2 => 1
(test (run (appE (appE (absE "x" (absE "y" (varE "x")))
                       (numE 1))
                 (numE 2)))
      (numV 1))

;; Test let: let x = 10 in x => 10
(test (run (letE "x" (numE 10) (varE "x")))
      (numV 10))

;; Test nested let: let x = 5 in let y = x in y => 5
(test (run (letE "x" (numE 5)
                 (letE "y" (varE "x")
                       (varE "y"))))
      (numV 5))
