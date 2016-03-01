#lang racket

(define (f2n c)
  (match c
    [#\( 1]
    [#\) -1]
    [_ 0]))
(define (calculate-floor s)
  (sum (map f2n (string->list s))))
(define (read-floor input-port)
  (let ([char (read-char input-port)])
    (if (eof-object? char)
        char
        (f2n char))))
(define (sum lst) (foldl + 0 lst))

(displayln (sum (port->list read-floor)))
