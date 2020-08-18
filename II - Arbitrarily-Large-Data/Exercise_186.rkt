#lang racket

(check-expect (sort> '()) '())
(check-satisfied (sort> (list 2)) sorted>?)
(check-satisfied (sort> (list 5 10 2 1 9 4 22 3)) sorted>?)

(define (sort> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort> (rest l)))]))


(check-expect (insert 4 '()) (list 4))
(check-expect (insert 5 (list 4 2 1)) (list 5 4 2 1))
(check-expect (insert 2 (list 10 6 4)) (list 10 6 4 2))
(check-expect (insert 8 (list 10 9 7 5 1)) (list 10 9 8 7 5 1))

(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))

(check-expect (sorted>? (cons 5 '())) #true)
(check-expect (sorted>? (cons 10 (cons 6 (cons 2 '())))) #true)
(check-expect (sorted>? (cons 3 (cons 10 '()))) #false)

(define (sorted>? l)
  (cond
    [(empty? (rest l)) #true]
    [else (and (> (first l) (first (rest l)))
               (sorted>? (rest l)))]))