#lang racket

(define (end? x)
  (and (number? x) (> x HEIGHT)))     

(define (main s)
  (big-bang s
            [to-draw show]
            [on-key launch]
            [on-tick fly 1]
            [stop-when end?]))