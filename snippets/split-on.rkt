#lang racket

(define/contract (split-on lst func)
  (list? (any/c any/c . -> . boolean?) . -> . list?)
  (define-values (l r) (split-on-first lst func))
  (if (empty? r)
      (list l)
      (append (list l) (split-on r func))))

(define/contract (split-on-first lst func)
  (list? (any/c any/c . -> . boolean?) . -> . (values list? list?))
  (if (or (empty? lst) (empty? (cdr lst)))
      (values lst empty)
      (if (func (car lst) (cadr lst))
          (let-values ([(l r) (split-on-first (cdr lst) func)])
            (values (cons (car lst) l) r))
          (values (list (car lst)) (cdr lst)))))

(require rackunit)
(define-syntax (check-values-equal? stx)
  (syntax-case stx ()
    [(_ a (b ...)) #'(check-equal? (call-with-values (thunk a) list)
                                   (list b ...))]
    [(_ a (b ...) c) #'(check-equal? (call-with-values (thunk a) list)
                                     (list b ...)
                                     c)]))

(module+ test
  (require rackunit)
  (check-values-equal? (split-on-first '() equal?)
                       (empty empty))
  (check-values-equal? (split-on-first '(a) equal?)
                       ('(a) empty))
  (check-values-equal? (split-on-first '(a b) (compose not equal?))
                       ('(a b) empty))
  (check-values-equal? (split-on-first '(a a b b c) equal?)
                       ('(a a) '(b b c)))
  (check-values-equal? (split-on-first '(a b c d e) equal?)
                       ('(a) '(b c d e)))
  (check-equal? (split-on '() equal?) '(())) ; is this the best way??
  (check-equal? (split-on '(a) equal?) '((a)))
  (check-equal? (split-on '(a b) equal?) '((a) (b)))
  (check-equal? (split-on '(a a b b c) equal?) '((a a) (b b) (c)))
  (check-equal? (split-on '(a b c d e) equal?) '((a) (b) (c) (d) (e))))
