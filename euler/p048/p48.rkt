#lang racket

(remainder
 (for/sum ([i (in-range 1 1001)])
   (expt i i))
 10000000000)
