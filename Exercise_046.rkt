#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define CAT1 "insert CAT1 image here")

(define CAT2 "insert CAT2 image here")

(define CAT-BUFFER 10) ;to avoid any unwanted overlapping of edges

(define Y-CAT1 (/ (+ (image-height CAT1) CAT-BUFFER) 2))

(define BACKGROUND (empty-scene (* 10 (image-width CAT1)) (+ (image-height CAT1) CAT-BUFFER)))

(check-expect (render 3) (place-image/align CAT1 3 Y-CAT1 "right" "center" BACKGROUND))
(check-expect (render 100) (place-image/align CAT2 100 Y-CAT1 "right" "center" BACKGROUND))
(define (render ws)
  (cond
  [(odd? ws) (place-image/align CAT1 ws Y-CAT1 "right" "center" BACKGROUND)] ;Y-CAT1 is also valid for CAT2
  [else (place-image/align CAT2 ws Y-CAT1 "right" "center" BACKGROUND)]))

(check-expect (tock 0) 3) ;test for left edge
(check-expect (tock (+ (image-width BACKGROUND) (image-width CAT1))) 3) ;test for right edge
(check-expect (tock (/ (image-width BACKGROUND) 2)) (+ (/ (image-width BACKGROUND) 2) 3)) ;test for middle
(define (tock ws)
    (modulo (+ ws 3) (+ (image-width BACKGROUND) (image-width CAT1))))

(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]))
