#lang racket

(provide (all-defined-out))

(struct gate (op args dest)
  #:transparent)

(define operations
  (hash
   'assign identity
   'not (λ (n) (- (expt 2 16) 1 n))
   'and bitwise-and
   'or bitwise-ior
   'lshift arithmetic-shift
   'rshift (λ (n m) (arithmetic-shift n (- m)))))

(define (string->gate s)
  (define (f token)
    (let ([n (string->number token)])
      (if n n token)))
  (define lst (map f (remove "->" (string-split s " "))))
  (match lst
    [(list a dest) (gate 'assign (list a) dest)]
    [(list "NOT" a dest) (gate 'not (list a) dest)]
    [(list a "AND" b dest) (gate 'and (list a b) dest)]
    [(list a "OR" b dest) (gate 'or (list a b) dest)]
    [(list a "LSHIFT" b dest) (gate 'lshift (list a b) dest)]
    [(list a "RSHIFT" b dest) (gate 'rshift (list a b) dest)]
    [_ #f]))

(define (read-gate ip)
  (define line (read-line ip))
  (if (eof-object? line)
      line
      (string->gate line)))

(define (sort-circuit gates)
  gates)

(define (execute-gate g state)
  (define (f s-or-n)
    (if (string? s-or-n)
        (hash-ref state s-or-n 0)
        s-or-n))
  (hash-set state (gate-dest g) (apply (hash-ref operations (gate-op g)) (map f (gate-args g)))))

(define (execute-circuit gates [state #f])
  (define st (if state state (hash)))
  (if (empty? gates)
      st
      (run (rest gates)
           (execute-gate (first gates) st))))

(module+ main
  (hash-ref (execute-circuit (sort-circuit (port->list read-gate))) "a"))
