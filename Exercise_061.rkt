#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define TL-GREEN (bitmap "images/tl-green.png"))
(define TL-RED (bitmap "images/tl-red.png"))
(define TL-YELLOW (bitmap "images/tl-yellow.png"))

(check-expect (tl-next "red") "green")
(check-expect (tl-next "yellow") "red")
(check-expect (tl-next "green") "yellow")
(define (tl-next current-state)
  (cond
    [(string=? current-state "red") "green"]
    [(string=? current-state "yellow") "red"]
    [(string=? current-state "green") "yellow"]))


(check-expect (tl-render "red") (bitmap "images/tl-red.png"))
(define (tl-render current-state)
  (cond
    [(string=? current-state "green") TL-GREEN]
    [(string=? current-state "yellow") TL-YELLOW]
    [else TL-RED]))
(check-expect (tl-render "red") (bitmap "images/tl-red.png"))
(check-expect (tl-render "yellow") (bitmap "images/tl-yellow.png"))
(check-expect (tl-render "green") (bitmap "images/tl-green.png"))

(define (traffic-light-simulation initial-state)
  (big-bang initial-state
            [to-draw tl-render]
            [on-tick tl-next 1]))

(traffic-light-simulation "red")