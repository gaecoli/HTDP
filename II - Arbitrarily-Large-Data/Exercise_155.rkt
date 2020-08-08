#lang racket

(check-expect (inner "yellow") "yellow")
(check-expect (inner (make-layer "yellow" "green")) "green")
(check-expect (inner (make-layer "yellow" (make-layer "green" (make-layer "red" "black")))) "black")

(define (inner rd)
  (cond
    [(string? rd) rd]
    [(layer? rd) (inner (layer-doll rd))]))

(define-struct layer [color doll])

(define RD1 "orange")
(define RD2 (make-layer "black" (make-layer "red" "green")))