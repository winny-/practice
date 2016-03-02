#lang racket

(require math/array)

;; For http://adventofcode.com/day/6

(provide (all-defined-out))

;; Op should be 'on 'off or 'toggle
;; left should be a vector of two numbers
;; right should be a vector of two numbers
(struct instruction (op left right)
  #:transparent)

(define/contract (string->instruction s)
  (-> string? (or/c false? instruction?))
  (define groups (regexp-match #rx"(turn on|turn off|toggle) ([0-9]+),([0-9]+) through ([0-9]+),([0-9]+)" s))
  (if (false? groups)
      #f
      (instruction (match (second groups)
                     ["turn on" 'on]
                     ["turn off" 'off]
                     ["toggle" 'toggle])
                   (cons (string->number (third groups)) (string->number (fourth groups)))
                   (cons (string->number (fifth groups)) (string->number (sixth groups))))))

(define/contract (execute-instruction ins grid)
  (-> instruction? mutable-array? mutable-array?)
  (define update (match (instruction-op ins)
                   ['on (λ (cell) #t)]
                   ['off (λ (cell) #f)]
                   ['toggle not]))
  (for ([row (in-range (car (instruction-left ins)) (add1 (car (instruction-right ins))))])
    (for ([col (in-range (cdr (instruction-left ins)) (add1 (cdr (instruction-right ins))))])
      (array-set! grid (vector row col) (update (array-ref grid (vector row col))))))
  grid)


(define/contract (play-lightshow instructions [grid #f])
  (->* [(listof instruction?)] [(or/c mutable-array? false?)] mutable-array?)
  (when (false? grid)
    (set! grid (make-grid)))
  (if (empty? instructions)
      grid
      (play-lightshow (rest instructions)
                      (execute-instruction (first instructions) grid))))

(define/contract (sum-grid grid [state #t])
  (->* [mutable-array?] [boolean?] exact-nonnegative-integer?)
  (array-count (curry equal? state) grid))

(define/contract (make-grid [state #f])
  (->* [] [boolean?] mutable-array?)
  (array->mutable-array (make-array #(1000 1000) state)))


(module+ main
  (define instructions (port->list (λ (ip) (match (read-line ip)
                                             [(? eof-object? line) line]
                                             [line (string->instruction line)]))))
  (sum-grid (play-lightshow instructions)))
