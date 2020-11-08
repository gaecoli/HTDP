#lang racket

(define LO-N1 (list 1 2 3 4 5 6))
(define LO-POSN1 (list (make-posn 20 30) (make-posn 40 70) (make-posn 50 50)))
  
(define emt
  (empty-scene 100 100))
(define dot
  (circle 3 "solid" "red"))


(check-expect (fold2 LO-N1 1 *) (product LO-N1))
(check-expect (fold2 LO-POSN1 emt place-dot) (image* LO-POSN1))

(define (fold2 l i g)
  (cond
    [(empty? l) i]
    [else
     (g (first l)
        (fold2 (rest l) i g))]))


(check-expect (fold2-product LO-N1) (product LO-N1))

(define (fold2-product l)
  (fold2 l 1 *))


(check-expect (fold2-image* LO-POSN1) (image* LO-POSN1))

(define (fold2-image* l)
  (fold2 l emt place-dot))
