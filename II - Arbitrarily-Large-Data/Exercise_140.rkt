#lang racket

(check-expect (all-true '()) #true)
(check-expect (all-true (cons #true '())) #true)
(check-expect (all-true (cons #false '())) #false)
(check-expect (all-true (cons #true (cons #true (cons #true '())))) #true)
(check-expect (all-true (cons #true (cons #false (cons #true '())))) #false)

(define (all-true l)
  (cond
    [(empty? l) #true]
    [else (and (first l)
               (all-true (rest l)))]))

(check-expect (one-true '()) #false)
(check-expect (one-true (cons #true '())) #true)
(check-expect (one-true (cons #false '())) #false)
(check-expect (one-true (cons #false (cons #true (cons #false '())))) #true)
(check-expect (one-true (cons #false (cons #false (cons #false '())))) #false)

(define (one-true l)
  (cond
    [(empty? l) #false]
    [else (or (first l)
               (one-true (rest l)))]))

(define list-of-boolean1 '())
(define list-of-boolean2 (cons #true (cons #false '())))