#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define WHEEL-RADIUS 10)                    
(define WHEEL-DISTANCE (* WHEEL-RADIUS 2))
(define CAR-LENGTH (* WHEEL-RADIUS 4))
(define Y-CAR (* WHEEL-RADIUS 3))
(define ROAD-LENGTH (* 7 (* WHEEL-RADIUS 8)))
(define SCENE-HEIGHT (* WHEEL-RADIUS 5))
(define SPEED 3)                           

(define WHEEL                                                         
  (circle WHEEL-RADIUS "solid" "black"))    
(define SPACE                             
  (rectangle WHEEL-DISTANCE (/ WHEEL-RADIUS 8) "solid" "white"))
(define BOTH-WHEELS                       
  (beside WHEEL SPACE WHEEL))

(define CHASSIS
  (above
   (rectangle (* WHEEL-DISTANCE 2) WHEEL-RADIUS "solid" "red")
   (rectangle (* WHEEL-DISTANCE 4) (* WHEEL-RADIUS 2) "solid" "red")))

(define CAR
  (overlay/align/offset "middle" "bottom"
                        BOTH-WHEELS
                        0 (* WHEEL-RADIUS -1)
                        CHASSIS))

(define BACKGROUND
  (empty-scene ROAD-LENGTH SCENE-HEIGHT))

(define TREE
  (underlay/xy (circle WHEEL-RADIUS "solid" "green")
               (- WHEEL-RADIUS 1) (* WHEEL-RADIUS 1.5)
               (rectangle (/ WHEEL-RADIUS 5) (* WHEEL-RADIUS 2) "solid" "brown")))

(define BACKGROUND-TREE
  (place-image TREE (* .75 ROAD-LENGTH) (- SCENE-HEIGHT (/ (image-height TREE) 2)) BACKGROUND))

(define (render as)
  (place-image/align CAR (distance as) (- Y-CAR (wave-car as)) "right" "center" BACKGROUND-TREE))


(check-expect (distance 4) 12)
(check-expect (distance 100) 300)
(define (distance as)
  (* SPEED as))


(check-expect (wave-car 0) 0)
(define (wave-car as)
  (* (/ SCENE-HEIGHT 4) (sin as)))

(check-expect (tock 0) 1)
(check-expect (tock 100) 101)
(define (tock as)
  (+ as 1))


(check-expect (last-world? 0) false)
(check-expect (last-world? (/ (/ ROAD-LENGTH 2) SPEED)) false)
(check-expect (last-world? (+ ROAD-LENGTH (* 4 WHEEL-DISTANCE))) true)
(define (last-world? as)
 (> (distance as) (+ ROAD-LENGTH (* 4 WHEEL-DISTANCE))))

(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]
    [stop-when last-world?]))
