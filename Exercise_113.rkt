#lang racket

(define-struct tank [loc vel])
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

(define (sigs? a)
  (or (aim? a) (fired? a)))

(define (coordinate? a)
  (or (number? a) (posn? a)))

(define LEFT "left")
(define RIGHT "right")
(define RED "red")
(define GREEN "green")
(define BLUE "blue")

(define-struct vcat [x happiness direction])

(define-struct vcham [x happiness direction color])

(define (vanimal? a)
  (or (vcat? a) (vcham? a)))