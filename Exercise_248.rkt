#lang racket
(define (squared>? x c)
  (> (* x x) c))


(squared>? 3 10)

(squared>? 4 10)