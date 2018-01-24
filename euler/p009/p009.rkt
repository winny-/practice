#lang racket

(for*/first ([a (in-range 1 1000)]
             [b (in-range (add1 a) (- 1001 a))]
             [c (in-range (add1 b) (- 1001.0 a b))]
             #:when (and (= 1000 (+ a b c))
                         (= (sqr c) (+ (sqr a) (sqr b)))))
  (* a b c))
