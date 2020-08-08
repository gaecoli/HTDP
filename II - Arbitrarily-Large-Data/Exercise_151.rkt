#lang racket

(check-expect (multiply 0 5) 0)
(check-expect (multiply 2 4) 8)
(check-expect (multiply 5 1) 5)
(check-expect (multiply 4 0) 0)
(check-expect (multiply 1 3) 3)

(define (multiply n x)
  (cond
    [(equal? x 0) 0]
    [else (+ n (multiply n (sub1 x)))]))

(define N1 0)
(define N2 5)

(multiply 3 4)