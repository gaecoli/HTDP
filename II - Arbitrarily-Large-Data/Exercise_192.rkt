#lang racket

(define poly1 (cons (make-posn 1 4) (cons (make-posn 6 10) (cons (make-posn 10 30) '()))))
(define poly2 (cons (make-posn 7 11) poly1))

(check-expect (last* (list (make-posn 2 3))) (make-posn 2 3))
(check-expect (last* (list (make-posn 1 3) (make-posn 4 3) (make-posn 7 0))) (make-posn 7 0))
(check-expect (last* poly1) (make-posn 10 30))
(check-expect (last* poly2) (make-posn 10 30))

(define (last* p)
  (cond
    [(empty? (rest p)) (first p)]
    [else (last* (rest p))]))


(check-expect (last poly1) (make-posn 10 30))
(check-expect (last poly2) (make-posn 10 30))

(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))