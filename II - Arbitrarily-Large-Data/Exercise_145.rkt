#lang racket

(check-expect (sorted>? (cons 5 '())) #true)
(check-expect (sorted>? (cons 10 (cons 6 (cons 2 '())))) #true)
(check-expect (sorted>? (cons 3 (cons 10 '()))) #false)

(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) #true]
    [else (and (> (first ne-l) (first (rest ne-l)))
               (sorted>? (rest ne-l)))]))

(define ne-l1 (cons 4 '()))
(define ne-l2 (cons 10 (cons -2 '())))