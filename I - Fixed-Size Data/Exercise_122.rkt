#lang racket

(define (f x y)
  (+ (* 3 x) (* y y)))


(+ (f 1 2) (f 2 1))

(f 1 (* 2 3))

(f (f 1 (* 2 3)) 19)
