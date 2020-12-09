#lang eopl
;;;;;;;;;;;;;;;; grammatical specification for sll-gen  ;;;;;;;;;;;;;;;;

(define the-lexical-spec
  '((whitespace (whitespace) skip)
    (comment (";" (arbno (not #\newline))) skip)
    (identifier
      (letter (arbno (or letter digit "_" "-" "?")))
      symbol)
    (number ((or "" "-" "+") digit (arbno digit)) number)
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
     ("recipe" (separated-list identifier "&") "{" myexpression "}")
     function-def-exp)
    (myexpression
     ("prepare" identifier "contains" (separated-list myexpression "&") "")
     function-call-exp)
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