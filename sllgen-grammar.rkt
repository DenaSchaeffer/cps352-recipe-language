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
      ("(" primitive  myexpression myexpression ")")
      primapp-exp)
    (myexpression
     ("let" (separated-list identifier "=" myexpression ",")
            "in" myexpression)
     let-exp)
    (myexpression
     ("if" myexpression "then" myexpression "else" myexpression)
     if-exp)
    (myexpression
     ("func" "(" (separated-list identifier ",") ")" "{" myexpression "}")
     function-def-exp)
    (myexpression
     ("exec" myexpression "(" (separated-list myexpression ",") ")")
     function-call-exp)
    (primitive ("+")     add-prim)
    (primitive ("-")     subtract-prim)
    (primitive ("*")     multiply-prim)
    (primitive ("/")     divide-prim)
    (primitive (">")     more-prim)
    (primitive ("<")     less-prim)
    (primitive ("^")     power-prim)
   )
)

(sllgen:make-define-datatypes the-lexical-spec the-grammar)
(define display-abstractsyntax
  (lambda () (sllgen:list-define-datatypes
                           the-lexical-spec the-grammar)))

(provide (all-defined-out))