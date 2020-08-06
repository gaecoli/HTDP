#lang racket

(check-expect (all-true (cons #true '())) #true)
(check-expect (all-true (cons #false '())) #false)
(check-expect (all-true (cons #true (cons #true (cons #true '())))) #true)
(check-expect (all-true (cons #true (cons #false (cons #true '())))) #false)

(define (all-true ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (and (first ne-l) (all-true (rest ne-l)))]))

(check-expect (one-true (cons #true '())) #true)
(check-expect (one-true (cons #false '())) #false)
(check-expect (one-true (cons #false (cons #true (cons #false '())))) #true)
(check-expect (one-true (cons #false (cons #false (cons #false '())))) #false)

(define (one-true ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (or (first ne-l) (one-true (rest ne-l)))]))

(define nelist-of-boolean1 (cons #true '()))
(define nelist-of-boolean2 (cons #true (cons #false '())))