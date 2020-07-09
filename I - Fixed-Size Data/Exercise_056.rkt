#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define width      100)
(define height     300)
(define y_delta    3)
(define background (empty-scene width height))
(define rocket     (rectangle 5 30 "solid" "red"))
(define center     (/ (image-width rocket) 2))

(define (show x)
  (cond
    [(string? x) (place-image rocket 10 (- height center) background)]
    [(<= -3 x -1) (place-image (text (number->string x) 20 "red")
                               10 (* 3/4 width)
                               (place-image rocket 10 (- height center) background))]
    [(>= x 0) (place-image rocket 10 (- x center) background)]))

(define (launch x ke) x)

(define (fly x) x)