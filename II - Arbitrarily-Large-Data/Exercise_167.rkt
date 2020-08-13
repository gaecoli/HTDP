#lang racket

(check-expect (sum '()) 0)
(check-expect (sum (cons (make-posn 3 2) (cons (make-posn 1 9) '()))) (+ 3 2 1 9))

(define (sum lop)
  (cond
    [(empty? lop) 0]
    [else (+ (posn-x (first lop)) (posn-y (first lop)) (sum (rest lop)))]))


(define lop1 '())
(define lop2 (cons (make-posn 2 1) '()))