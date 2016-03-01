#lang racket

;; For http://adventofcode.com/day/6

(provide (all-defined-out))

;; Operation should be 'on 'off or 'toggle
;; left should be a vector of two numbers
;; right should be a vector of two numbers
(struct instruction (operation left right)
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
  (-> instruction? (listof list?) (listof list?))
  (define update-cell (match (instruction-operation ins)
                        ['on (λ (cell) #t)]
                        ['off (λ (cell) #f)]
                        ['toggle not]))
  (define left (instruction-left ins))
  (define right (instruction-right ins))
  (for ([row (in-range (car left) (add1 (car right)))])
    (set! grid (list-set grid row (for/list ([cell (list-ref grid row)]
                                             [column (in-range 1000)])
                                    (if (or (>= column (cdr left)) (<= column (cdr right)))
                                        (update-cell cell)
                                        cell)))))
  grid)


(define/contract (play-lightshow instructions [grid #f])
  (->* [(listof instruction?)] [((or/c listof list?) false?)] (listof list?))
  (when (false? grid)
    (set! grid (make-grid)))
  (if (empty? instructions)
      grid
      (play-lightshow (rest instructions)
                      (execute-instruction (first instructions) grid))))

(define/contract (sum-grid grid [state #t])
  (->* [(listof list?)] [boolean?] exact-nonnegative-integer?)
  (for/sum ([row grid])
    (for/sum ([cell row])
      (if (equal? cell state) 1 0))))

(define/contract (make-grid [state #f])
  (->* [] [boolean?] (listof list?))
  (make-list 999 (make-list 999 state)))

(module+ main
  (define instructions (port->list (λ (ip) (match (read-line ip)
                                             [(? eof-object? line) line]
                                             [line (string->instruction line)]))))
  (sum-grid (play-lightshow instructions)))
