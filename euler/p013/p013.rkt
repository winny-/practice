#lang racket

(define ls (with-input-from-file "input.txt" (thunk (port->list read))))

(define p13-silly (substring (number->string (foldl + 0 ls)) 0 10))
