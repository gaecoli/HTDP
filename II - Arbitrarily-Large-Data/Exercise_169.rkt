#lang racket

(check-expect (legal '()) '())
(check-expect (legal (cons (make-posn 3 300) (cons (make-posn 40 80) (cons (make-posn 130 50) '())))) (cons (make-posn 40 80) '()))

(define (legal lop)
  (cond
    [(empty? lop) '()]
    [(posl? (first lop)) (cons (first lop) (legal (rest lop)))]
    [else (legal (rest lop))]))

(check-expect (posl? (make-posn 50 50)) #true)
(check-expect (posl? (make-posn 120 40)) #false)
(check-expect (posl? (make-posn 20 250)) #false)

(define (posl? p)
  (and (>= 100 (posn-x p) 0)
       (>= 200 (posn-y p) 0)))


(define lop1 '())
(define lop2 (cons (make-posn 2 1) '()))