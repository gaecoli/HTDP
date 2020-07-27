#lang racket

(define List-of-numbers1 '())
(define List-of-numbers2 (cons -2 '()))
(define List-of-numbers3 (cons 3 (cons -2 (cons 4 '()))))

(check-expect (pos? '()) #true)
(check-expect (pos? (cons -2 '())) #false)
(check-expect (pos? (cons 3 (cons 2 (cons -1 '())))) #false)
(check-expect (pos? (cons 4 '())) #true)
(check-expect (pos? (cons 2 (cons 4 (cons 5 '())))) #true)

(define (pos? l)
  (cond
    [(empty? l) #true]
    [else (and (positive? (first l))
               (pos? (rest l)))]))

(check-expect (checked-sum '()) 0)
(check-error (checked-sum (cons -2 '())) "Negative Value")
(check-error (checked-sum (cons 4 (cons 2 (cons -8 '())))) "Negative Value")
(check-expect (checked-sum (cons 4 '())) 4)
(check-expect (checked-sum (cons 2 (cons 6 (cons 8 '())))) 16)

(define (checked-sum l)
  (cond
    [(pos? l) (sum l)]
    [else (error "Negative Value")]))

(check-expect (sum '()) 0)
(check-expect (sum (cons 25 '())) 25)
(check-expect (sum (cons 10 (cons 20 (cons 5 '())))) 35)

(define (sum l)
  (cond
    [(empty? l) 0]
    [else (+ (first l) (sum (rest l)))]))