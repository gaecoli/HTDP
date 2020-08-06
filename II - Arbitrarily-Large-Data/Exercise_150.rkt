#lang racket

(check-within (add-to-pi 0) pi 0.001)
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
(check-within (add-to-pi 5) (+ 5 pi) 0.001)

(define (add-to-pi n)
  (cond
    [(equal? n 0) pi]
    [else (add1 (add-to-pi (sub1 n)))]))

(check-expect (add 0 5) 5)
(check-expect (add 2 4) 6)
(check-expect (add 10 2) 12)

(define (add n x)
  (cond
    [(equal? n 0) x]
    [else (add1 (add (sub1 n) x))]))

(define N1 0)
(define N2 5)