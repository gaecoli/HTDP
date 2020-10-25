#lang racket

(check-expect (squared>? 3 10) #false)
(check-expect (squared>? 4 10) #true)
(check-expect (squared>? 5 10) #true)

(define (squared>? x c)
  (> (* x x) c))