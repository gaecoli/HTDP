#lang racket

(define ListOfAmounts1 '())
(define ListOfAmounts2 (cons 5 '()))
(define ListOfAmounts3 (cons 29 (cons 5 (cons 123 '()))))

(check-expect (sum '()) 0)
(check-expect (sum (cons 25 '())) 25)
(check-expect (sum (cons 10 (cons 20 (cons 5 '())))) 35)

(define (sum l)
  (cond
    [(empty? l) 0]
    [else (+ (first l) (sum (rest l)))]))