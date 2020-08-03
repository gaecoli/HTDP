#lang racket

(check-error (checked-average '()) "Invalid input")
(check-expect (checked-average (cons 10 (cons 20 '()))) 15)
(check-expect (checked-average (cons -10 (cons 9 (cons 25 '())))) 8)
(check-expect (checked-average (cons 4 '())) 4)

(define (checked-average alot)
  (if
   (equal? alot '())
   (error "Invalid input")
   (/ (sum alot) (how-many alot))))

(check-expect (sum '()) 0)
(check-expect (sum (cons 2 '())) 2)
(check-expect (sum (cons 23 (cons 1 (cons -2 '())))) 22)

(define (sum alot)
  (cond
    [(empty? alot) 0]
    [else (+ (first alot) (sum (rest alot)))]))

(check-expect (how-many '()) 0)
(check-expect (how-many (cons 2 '())) 1)
(check-expect (how-many (cons 5 (cons -12 (cons 2 '())))) 3)

(define (how-many alot)
  (cond
    [(empty? alot) 0]
    [else (+ (how-many (rest alot)) 1)]))

(define list-of-temperatures1 '())
(define list-of-temperatures2 (cons 2 (cons -32 '())))