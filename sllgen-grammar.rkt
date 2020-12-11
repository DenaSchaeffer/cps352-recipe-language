#lang eopl
;;;;;;;;;;;;;;;; grammatical specification for sll-gen  ;;;;;;;;;;;;;;;;

(define the-lexical-spec
  '((whitespace (whitespace) skip)
    (comment (";" (arbno (not #\newline))) skip)
    (identifier (letter (arbno (or letter digit "_" "-" "?"))) symbol)
    (number ((or "" "-" "+") (arbno digit) (or "." "") (arbno digit)) number)
    (text ((arbno (or letter digit "_" "-" "?" "!"))) string)
   )
)

(define the-grammar
  '((program (myexpression) a-program)
    (myexpression (number) lit-exp)
    (myexpression (identifier) id-exp)
    (myexpression
      ("(" primitive myexpression myexpression ")")
      primapp-exp)
    (myexpression
     ("cook" (separated-list identifier "using" myexpression "&")
             "with" myexpression)
     let-exp)
    (myexpression
     ("taste" myexpression "yummy" myexpression "bummy" myexpression)
     if-exp)
    (myexpression
     ("recipe" (separated-list identifier "&") "mix" myexpression "stop")
     function-def-exp)
    (myexpression
     ("prepare" myexpression "contains" (separated-list myexpression "&") "stop")
     function-call-exp)
    (myexpression ("print" " " (separated-list text " ") ";") print-exp)
    (primitive ("fry")              add-prim)
    (primitive ("cut")         subtract-prim)
    (primitive ("combine")     multiply-prim)
    (primitive ("split")         divide-prim)
    (primitive ("less")            less-prim)
    (primitive ("more")            more-prim)
    (primitive ("ferment")        power-prim)
   )
)

(sllgen:make-define-datatypes the-lexical-spec the-grammar)
(define display-abstractsyntax
  (lambda () (sllgen:list-define-datatypes
                           the-lexical-spec the-grammar)))

(provide (all-defined-out))