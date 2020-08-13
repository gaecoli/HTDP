#lang racket

(check-expect (translate '()) '())
(check-expect (translate (cons (make-posn 3 2) (cons (make-posn 8 1) '()))) (cons (make-posn 3 3) (cons (make-posn 8 2) '())))

(define (translate lop)
  (cond
    [(empty? lop) '()]
    [else (cons (make-posn (posn-x (first lop)) (add1 (posn-y (first lop)))) (translate (rest lop)))]))

(define lop1 '())
(define lop2 (cons (make-posn 2 1) '()))