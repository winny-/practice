#lang racket
;; For http://adventofcode.com/day/2

(define (calculate-sqft lst)
  (define areas (map (curry apply *) (combinations lst 2)))
  (foldl + 0 (cons (argmin identity areas)
                   (map (curry * 2) areas))))

(define (read-dimmensions input-port)
  (define line (read-line input-port))
  (if (eof-object? line)
      line
      (map string->number (string-split line "x"))))

(displayln (foldl + 0 (map calculate-sqft (port->list read-dimmensions))))
