#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define CANVAS
  (scene+curve
   (scene+curve
    (rectangle 200 200 "outline" "black")
    0 195 10 1/2
    100 195 10 1/3
    "purple")
   100 195 10 1/2
   200 195 10 1/3
   "purple"))

(define TANK (rectangle 30 15 "solid" "blue"))
(define TANK-Y (- (image-height CANVAS) (* 3/5 (image-height TANK))))

(define MISSILE (triangle 12 "solid" "tan"))

(define UFO
  (overlay (circle 4 "solid" "green")
           (rectangle 20 2 "solid" "green")))
		   
(place-images
 (list UFO TANK)
 (list (make-posn (* 1/2 (image-width CANVAS)) (image-height UFO))
       (make-posn (* 1/2 (image-width CANVAS)) TANK-Y))
 CANVAS)