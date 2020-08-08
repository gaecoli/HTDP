#lang racket

(check-expect (colors "yellow") "yellow")
(check-expect (colors (make-layer "yellow" "green")) "yellow, green")
(check-expect (colors (make-layer "yellow" (make-layer "green" "red"))) "yellow, green, red")

(define (colors rd)
  (cond
    [(string? rd) rd]
    [(layer? rd) (string-append (layer-color rd) ", " (colors (layer-doll rd)))]))

(define-struct layer [color doll])

(define RD1 "orange")
(define RD2 (make-layer "black" (make-layer "red" "green")))