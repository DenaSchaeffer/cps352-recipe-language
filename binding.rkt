#lang eopl

;;;;;;;;;;;;;;;; environments ;;;;;;;;;;;;;;;;
(define-datatype environment environment?
  (empty-env-record)
  (extended-env-record
    (syms (list-of symbol?))
    (vec vector?)    ; can use this for anything.
    (env environment?))
)

(define empty-env
  (lambda ()
    (empty-env-record)))

(define binding
  (lambda (syms vals env)
    (extended-env-record syms (list->vector vals) env)))

(define value-of
  (lambda (sym env)
    (cases environment env
      (empty-env-record ()
        (eopl:error 'value-of "No binding for ~s" sym))
      (extended-env-record (syms vals env)
        (let ((position (rib-find-position sym syms)))
          (if (number? position)
              (vector-ref vals position)
              (value-of sym env)))))))

(define rib-find-position 
  (lambda (sym los)
    (list-find-position sym los)))

(define list-find-position
  (lambda (sym los)
    (list-index (lambda (sym1) (eqv? sym1 sym)) los)))

(define list-index
  (lambda (pred ls)
    (cond
      ((null? ls) #f)
      ((pred (car ls)) 0)
      (else (let ((list-index-r (list-index pred (cdr ls))))
              (if (number? list-index-r)
                (+ list-index-r 1)
                #f))))))

(define init-env 
  (lambda ()
    (binding
      '(i v x a) '(1 5 10 0) (empty-env))))


(provide (all-defined-out))
