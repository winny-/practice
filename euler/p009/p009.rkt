#lang racket

(for*/first ([a (in-range 1 1000)]
             [b (in-range (add1 a) 1000)]
             [c (in-range (add1 b) 1000)]
             #:when (and (= 1000 (+ a b c))
                         (= (sqr c) (+ (sqr a) (sqr b)))))
  (* a b c))
