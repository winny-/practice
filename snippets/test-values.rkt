#lang racket

(require rackunit)

(define-syntax-rule (check-values e (list e* ...))
  (check-equal? (call-with-values (thunk e) list) (list e* ...)))

(check-values (values 1 2 3) (list 1 2 3))
