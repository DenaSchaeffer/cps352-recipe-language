#lang eopl

(require "binding.rkt")

(display "CPS352 - Interpreter Implementation with sllgen\nby Quan Nguyen <nguyenq2@udayton.edu>\n")

(require "sllgen-grammar.rkt")

(define eval-program
  (lambda (prog-ast)
       (cases program prog-ast
         (a-program (expr)
                    (eval-expression expr (empty-env))
                    )
         )
      )
  )

(define eval-expression
  (lambda (expr env)
    (cases myexpression expr
      (lit-exp (datum) datum)
      (id-exp (id) 
              (value-of id env)
              )
      (let-exp (id-list exp-list in-exp)
               (let* ((values-list(map (lambda (exp) (eval-expression exp env)) exp-list))
                      (local-env(binding id-list values-list env)))
                 (eval-expression in-exp local-env)
                 )
               )
      (if-exp (cond-exp then-exp else-exp)
              (if (true? (eval-expression cond-exp env))
                  (eval-expression then-exp env)
                  (eval-expression else-exp env)
                  )
              )
      (primapp-exp (prim expr1 expr2)   
            (eval-primapp prim expr1 expr2 env)       
            )
      (function-def-exp (id-list func-body)
                        ; (eopl:printf "DEBUG>id-list=~s\n func-body=~s\n" id-list func-body)
                        (function-closure id-list func-body env))
      (function-call-exp (func-exp argument-list)
                         ; (eopl:printf "DEBUG>func-exp=~s\n argument-list=~s\n" func-exp argument-list)
                         (let ((func-closure (eval-expression func-exp env))
                               (args-values (map (lambda(exp) (eval-expression exp env)) argument-list)))
                           (if (function-def? func-closure)
                               (eval-function-call func-closure args-values)
                               (eopl:error 'eval-expression "Cannot execute a non-function: ~s" func-exp)))
                         )
      )
    )
  )

(define-datatype function-def function-def?
  (function-closure
   (id-list (list-of symbol?))
   (func-body myexpression?)
   (env environment?)))

(define eval-function-call
  (lambda (func-closure argument-values)
    (cases function-def func-closure
      (function-closure (id-list func-body env)
                        (eval-expression func-body (binding id-list argument-values env))
                        ))))

(define true?
  (lambda (x) (not (zero? x)))
  )

(define eval-primapp
  (lambda (prim expr1 expr2 env)
    (cases primitive prim
      (add-prim ()
                (+ (eval-expression expr1 env) (eval-expression expr2 env))
       )
      (subtract-prim ()
                (- (eval-expression expr1 env) (eval-expression expr2 env))
       )

      )
    )
  )

(define myinterpreter
  (lambda (source-program)
    (let ((syntaxtree (myparser source-program))
          )
      (eval-program syntaxtree)
     )
  )
 )

(define myparser
  (sllgen:make-string-parser the-lexical-spec the-grammar))

(define myinterpreter-REPL
  (sllgen:make-rep-loop "myinterpreter-nguyenq2> "
                        (lambda (pgm) (eval-program pgm))
                        (sllgen:make-stream-parser the-lexical-spec the-grammar)))
(myinterpreter-REPL)