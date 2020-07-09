#lang racket

(require 2htdp/universe)
(require 2htdp/image)

(define (area-of-disk r)
  (* 3.14 (* r r)))

(define (checked-area-of-disk v)
  (cond
    [(number? v) (area-of-disk v)]
    [else (error "area-of-disk: number expected")]))

(define (PositiveNumber? n)
  (< 0 n))
(define (checked-area-of-disk.v2 v)
  (cond
    [(number? v)
     (cond
       [(PositiveNumber? v) (area-of-disk v)]
       [else (error "area-of-disk: positive number expected")])]
    [else (error "area-of-disk: number expected")]))


(define-struct vec [x y])

(defince (checked-make-vec x y)
  (cond
    [(and (number? x) (PositiveNumber? x)
          (number? y) (PositiveNumber? y))
     (make-vec x y)]
    [else (error "checked-mke-vec: PositiveNumber, PositiveNumber expected")]))

(check-expect (missile-or-not? #false) #true)
(check-expect (missile-or-not? (make-posn 9 2)) #true)
(check-expect (missile-or-not? "yellow") #false)
(define (missile-or-not? a)
  (cond
    [(posn? a) #true]
    [(boolean? a) (not a)]
    [else #false]))