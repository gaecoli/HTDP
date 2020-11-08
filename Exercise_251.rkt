#lang racket

(check-expect (fold1 '(1 2 3 4 5) 0 +) (sum '(1 2 3 4 5)))
(check-expect (fold1 '(1 2 3 4 5) 1 *) (product '(1 2 3 4 5)))

(define (fold1 l i g)
  (cond
    [(empty? l) i]
    [else
     (g (first l)
        (fold1 (rest l) i g))]))


(check-expect (fold1-sum '(1 2 3 4 5)) (+ 1 2 3 4 5))

(define (fold1-sum l)
  (fold1 l 0 +))


(check-expect (fold1-product '(1 2 3 4 5)) (* 1 2 3 4 5))

(define (fold1-product l)
  (fold1 l 1 *))
