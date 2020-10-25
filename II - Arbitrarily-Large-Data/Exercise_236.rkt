#lang racket

(check-expect (plus 3 '(0 1 2 3 4)) '(3 4 5 6 7))
(check-expect (plus -2 '(0 1 2 3 4)) '(-2 -1 0 1 2))

(define (plus n l)
  (cond
    [(empty? l) '()]
    [else (cons (+ (first l) n) (plus n (rest l)))]))


; Lon -> Lon
; Substract 2 from each number of a given list
(check-expect (sub2 '(2 3 4 5 6)) '(0 1 2 3 4))

(define (sub2 l)
  (plus -2 l))

(check-expect (plus1 '(0 1 2 3 4)) '(1 2 3 4 5))

(define (plus1 l)
  (plus 1 l))

(check-expect (plus5 '(0 1 2 3 4)) '(5 6 7 8 9))

(define (plus5 l)
  (plus 5 l))


; adds 1 to each item on l
(check-expect (add1* '(0 1 2 3 4)) '(1 2 3 4 5))

(define (add1* l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (add1 (first l))
       (add1* (rest l)))])
	   
(check-expect (plus5* '(0 1 2 3 4)) '(5 6 7 8 9))

(define (plus5* l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (+ (first l) 5)
       (plus5* (rest l)))]))