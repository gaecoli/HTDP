#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define-struct tank [loc vel])
(define-struct sigs [ufo tank missile])
(define TREE
  (underlay/xy (circle 10 "solid" "darkgreen")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define UFO  (overlay (circle 10 "solid" "green")          
                      (rectangle 40 2 "solid" "green")))

(define TANK (overlay/align "center" "bottom"
                            (rectangle 10 17 "solid" "DarkKhaki")
                            (rectangle 40 10 "solid" "DarkKhaki")))

(define MISSILE (triangle 5 "solid" "red"))
(define WIDTH        200)
(define HEIGHT       200)
(define Y-TREE       (- HEIGHT (/ (image-height TREE) 2)))
(define Y-TANK       (- HEIGHT (/ (image-height TANK) 2)))
(define TANK-HEIGHT  (+ 5 (image-height TANK)))
(define UFO-DIA      10)
(define X-TANK-DISPL (/ (image-width TANK) 2))
(define Y-UFO-DISPL  (/ (image-height UFO) 2))
(define DELTA-X      3)
(define VEL-UFO      1)
(define VEL-MISSILE  (* 2 VEL-UFO))

(define BACKGROUND
  (place-images (list TREE TREE TREE TREE TREE)
                (list(make-posn 10 Y-TREE)
                     (make-posn 20 Y-TREE)
                     (make-posn 25 Y-TREE)
                     (make-posn 180 Y-TREE)
                     (make-posn 190 Y-TREE))
                (empty-scene WIDTH HEIGHT "aliceblue")))