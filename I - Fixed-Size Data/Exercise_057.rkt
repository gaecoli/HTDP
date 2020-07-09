#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define width      100)
(define height     300)
(define y_delta    3)
(define background (empty-scene width height))
(define rocket     (rectangle 5 30 "solid" "red"))
(define center     (/ (image-width rocket) 2))

(define (draw_rocket height)
  (place-image rocket 10 (- height center) background))

(define (show x)
  (cond
    [(string? x) (draw_rocket height)]
    [(<= -3 x -1) (place-image (text (number->string x) 20 "red")
                               10 (* 3/4 width)
                               (draw_rocket height))]
    [(>= x 0) (draw_rocket x)]))

(define (launch x ke)
  (cond
    [(string? x)  (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0)     x]))

(define (fly x)
  (cond
    [(string? x)  x]
    [(<= -3 x -1) (if (= x -1) height (+ x 1))]
    [(>= x 0)     (- x y_delta)]))

(define (main1 s)
  (big-bang s
    [on-key  launch]
    [to-draw show]))