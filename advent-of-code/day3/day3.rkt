#lang racket
;; For http://adventofcode.com/day/3

(define/contract (read-movement input-port)
  (-> input-port? (or/c eof-object? vector?))
  (match (read-char input-port)
    [#\^ #(0 -1)]
    [#\v #(0 1)]
    [#\< #(-1 0)]
    [#\> #(1 0)]
    [(? eof-object? c) c]
    [_ #(0 0)]))

(define/contract (plot-path ht cur-pos lst)
  (-> hash? vector? list? hash?)
  (if (empty? lst)
      ht
      (let ([next-pos (vector-map + cur-pos (first lst))])
        (plot-path (hash-set ht next-pos #t) next-pos (rest lst)))))

(hash-count (plot-path #hash((#(0 0) . #t)) #(0 0) (port->list read-movement)))
