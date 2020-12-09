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
  '((program (ingredient) a-program)
    (ingredient (number) lit-exp)
    (ingredient (identifier) id-exp)   
    (ingredient
      ("(" primitive ingredient ingredient ")")
      primapp-exp)
    (ingredient
     ("cook" (separated-list identifier "using" ingredient "&")
            "with" ingredient)
     let-exp)
    (ingredient
     ("taste" ingredient "yummy" ingredient "bummy" ingredient)
     if-exp)
    (ingredient
     ("recipe" (separated-list identifier "&") "{" ingredient "}")
     function-def-exp)
    (ingredient
     ("prepare" identifier "contains" (separated-list ingredient "&"))
     function-call-exp)
    (primitive ("fry")              add-prim)
    (primitive ("cut")              sub-prim)
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