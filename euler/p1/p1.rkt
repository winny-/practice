#lang racket

(define (p1? n)
  (or (zero? (modulo n 3))
      (zero? (modulo n 5))))

(define p1 (for/sum ([i 1000]
                     #:when (p1? i))
             i))

(module+ main
  p1)
