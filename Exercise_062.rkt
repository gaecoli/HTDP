#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define TL-GREEN (bitmap "images/tl-green.png"))
(define TL-RED (bitmap "images/tl-red.png"))
(define TL-YELLOW (bitmap "images/tl-yellow.png"))

(check-expect (tl-next-numeric 0) 1)
(check-expect (tl-next-numeric 1) 2)
(check-expect (tl-next-numeric 2) 0)
(define (tl-next-numeric current-state)
  (modulo (+ current-state 1) 3))

(check-expect (tl-render 0) (bitmap "images/tl-red.png"))
(check-expect (tl-render 1) (bitmap "images/tl-green.png"))
(check-expect (tl-render 2) (bitmap "images/tl-yellow.png"))
(define (tl-render current-state)
  (cond
    [(= current-state 0) TL-RED]
    [(= current-state 1) TL-GREEN]
    [(= current-state 2) TL-YELLOW]))

(define (traffic-light-simulation initial-state)
  (big-bang initial-state
            [to-draw tl-render]
            [on-tick tl-next-numeric 1]))