#lang racket

(require rackunit
         "day6.rkt")

(check-equal? (string->instruction "turn on 0,0 through 999,999")
              (instruction 'on (cons 0 0) (cons 999 999)))
(check-equal? (string->instruction "toggle 0,0 through 999,0")
              (instruction 'toggle (cons 0 0) (cons 999 0)))
(check-equal? (string->instruction "turn off 499,499 through 500,500")
              (instruction 'off (cons 499 499) (cons 500 500)))
(check-false (string->instruction "bomb the bejesus out of those forces"))
(check-false (string->instruction "do nothing on 0,0 through 1,1"))

(check-equal? (length (make-grid)) 999)
(check-equal? (length (first (make-grid))) 999)
(check-equal? (list-ref (list-ref (make-grid #f) 999) 999) #f)

(check-equal? (sum-grid (make-grid #t) #t) 998001)
(check-equal? (sum-grid (make-grid #f) #t) 0)

(check-equal? (play-lightshow '()) (make-grid))

(check-equal? (execute-instruction (instruction 'on (cons 0 0) (cons 999 999)) (make-grid))
              (make-grid #t))
