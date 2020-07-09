#lang racket
(require 2htdp/universe)
(require 2htdp/image)

(define WHEEL-RADIUS 10)     
(define WHEEL-DISTANCE (* WHEEL-RADIUS 2))
(define Y-CAR (* WHEEL-RADIUS 3))
(define CAR-LENGTH (* WHEEL-RADIUS 8))
(define ROAD-LENGTH (* 7 CAR-LENGTH))
(define SCENE-HEIGHT (* WHEEL-RADIUS 5))

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

(check-expect (render 0) (place-image/align CAR 0 Y-CAR "right" "center" BACKGROUND-TREE)) 
                                                                  
(check-expect (render 50) (place-image/align CAR 50 Y-CAR "right" "center" BACKGROUND-TREE))
(check-expect (render 200) (place-image/align CAR 200 Y-CAR "right" "center" BACKGROUND-TREE))
(check-expect (render ROAD-LENGTH) (place-image/align CAR ROAD-LENGTH Y-CAR "right" "center" BACKGROUND-TREE)) 
(check-expect (render (+ ROAD-LENGTH (* 4 WHEEL-DISTANCE))) (place-image CAR (+ ROAD-LENGTH CAR-LENGTH) Y-CAR BACKGROUND-TREE)) 

(define (render ws)
  (place-image/align CAR ws Y-CAR "right" "center" BACKGROUND-TREE))

(check-expect (tock 20) 23)
(check-expect (tock 78) 81)
(define (tock ws)
  (+ ws 3))

(check-expect (last-world? 0) false)
(check-expect (last-world? (/ ROAD-LENGTH 2)) false)
(check-expect (last-world? (+ ROAD-LENGTH (* 2 WHEEL-DISTANCE) 5)) true)
(define (last-world? ws)
 (> (tock ws) (+ 5 ROAD-LENGTH (* CAR-LENGTH 2))))

(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]
    [stop-when last-world?]))