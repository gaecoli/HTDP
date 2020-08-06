#lang racket

(check-expect (average (cons 10 (cons 20 '()))) 15)
(check-expect (average (cons -10 (cons 9 (cons 25 '())))) 8)
(check-expect (average (cons 4 '())) 4)

(define (average ne-l)
  (/ (sum ne-l)
     (how-many ne-l)))

(check-expect (sum (cons 2 '())) 2)
(check-expect (sum (cons 23 (cons 1 (cons -2 '())))) 22)

(define (sum ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (+ (first ne-l) (sum (rest ne-l)))]))

(check-expect (how-many (cons 2 '())) 1)
(check-expect (how-many (cons 5 (cons -12 (cons 2 '())))) 3)

(define (how-many ne-l)
  (cond
    [(empty? (rest ne-l)) 1]
    [else (+ (how-many (rest ne-l)) 1)]))

(define ne-l1 (cons 4 '()))
(define ne-l2 (cons 10 (cons -2 '())))