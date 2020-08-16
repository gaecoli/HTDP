#lang racket

(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))

(define mat1 (cons row1 (cons row2 '())))
(define tam1 (cons wor1 (cons wor2 '())))

(check-expect (transpose mat1) tam1)
 
(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
    [else (cons (first* lln) (transpose (rest* lln)))]))

(check-expect (first* '()) '())
(check-expect (first* mat1) wor1)

(define (first* mat)
  (cond
    [(empty? mat) '()]
    [else (cons (first (first mat)) (first* (rest mat)))]))

(check-expect (rest* '()) '())
(check-expect (rest* mat1) (cons (cons 12 '()) (cons (cons 22 '()) '())))

(define (rest* mat)
  (cond
    [(empty? mat) '()]
    [else (cons (rest (first mat)) (rest* (rest mat)))]))