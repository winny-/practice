#lang racket

(require racket/hash)

(define (next n)
  (and (> n 1)
       (if (even? n)
           (/ n 2)
           (add1 (* 3 n)))))

(define (collatz-stream n)
  (if (> n 1)
      (stream-cons n (collatz-stream (if (even? n) (/ n 2) (add1 (* 3 n)))))
      (stream-cons 1 empty-stream)))

(define (p14)
  (stream-first
   (for/fold ([longest empty-stream])
             ([i (in-range 1 1000000)])
     (define s (collatz-stream i))
     (values (if (> (stream-length s) (stream-length longest)) s longest)))))

(define (collatz-hash n h)
  (if (hash-has-key? h n)
      h
      (let* ([m (next n)]
             [updated (collatz-hash m h)])
        (hash-set updated n (add1 (hash-ref updated m))))))

(define (p14-fast)
  (argmax
   cdr
   (hash->list (for/fold ([known (hash 1 1)])
                         ([i (in-range 1 1e6)])
                 (values (collatz-hash i known))))))
