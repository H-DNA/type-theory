#lang plai-typed

(define-type Exp
  [numE (n : number)]
  [boolE (b : boolean)]
  [varE (id : string)]
  [absE (param : string) (value : Exp)]
  [appE (abs : Exp) (arg : Exp)]
  [letE (id : string) (value : Exp) (exp : Exp)])

(define-type Value
  [numV (n : number)]
  [boolV (b : boolean)]
  [funcV (param : string) (value : Exp) (env : (hashof string Value))])

(define (calc [e : Exp] [env : (hashof string Value)]) : Value
  (type-case Exp e
    [numE (n) (numV n)]
    [boolE (b) (boolV b)]
    [varE (id)
          (let ([val (hash-ref env id)])
            (type-case (optionof Value) val
              [none () (error 'var "Unbound variable")]
              [some (v) v]))]
    [absE (param value) (funcV param value env)]
    [appE (abs arg)
          (let ([absV (calc abs env)]
                [argV (calc arg env)])
            (type-case Value absV
              [funcV (param value env)
                     (calc value (hash-set env param argV))]
              [else (error 'app "The callee is not a function")]))]
    [letE (id value exp)
          (calc exp (hash-set env id (calc value env)))]))

;; Helper to run with empty environment
(define (run [e : Exp]) : Value
  (calc e (hash empty)))
