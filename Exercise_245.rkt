#lang racket

(check-expect (function=at-1.2-3-and-5.775? x y) #false)
(check-expect (function=at-1.2-3-and-5.775? x z) #false)

(define (function=at-1.2-3-and-5.775? f1 f2)
  (and (= (f1 1.2) (f2 1.2))
       (= (f1 3) (f2 3))
       (= (f1 -5.775) (f2 -5.775))))


; Number -> Number
(define (x n)
  (+ n 2))

; Number -> Number
(define (y n)
  (- n 3.5))

; Number -> Number
(define (z n)
  (* n (/ 5 3)))