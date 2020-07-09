#lang racket

(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

(define (tock ws)
  (+ ws 3))