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
(define HEIGHT (image-height CANVAS))

(define TANK (rectangle 30 15 "solid" "blue"))
(define TANK-HEIGHT (image-height TANK))
(define TANK-Y (- (image-height CANVAS) (* 3/5 (image-height TANK))))
(define TANK-DELTA-X 3)

(define MISSILE (triangle 12 "solid" "tan"))
(define POSN-Y-OFFSET 10)

(define UFO
  (overlay (circle 4 "solid" "green")
           (rectangle 20 2 "solid" "green")))
(define UFO-DELTA-Y 2)
(define UFO-DELTA-X 5)
(define REACH 3)

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
(define-struct tank [loc vel])

(check-expect ;; aim, moving right, ke left
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 TANK-DELTA-X))
  "left")
 (make-aim (make-posn 50 25)
           (make-tank 50 (- TANK-DELTA-X))))
(check-expect ;; aim, moving left, ke left
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 (- TANK-DELTA-X)))
  "left")
 (make-aim (make-posn 50 25)
           (make-tank 50 (- TANK-DELTA-X))))
(check-expect ;; aim, moving right, ke right
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 TANK-DELTA-X))
  "right")
 (make-aim (make-posn 50 25)
           (make-tank 50 TANK-DELTA-X)))
(check-expect ;; aim, moving right, ke left
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 TANK-DELTA-X))
  "left")
 (make-aim (make-posn 50 25)
           (make-tank 50 (- TANK-DELTA-X))))
(check-expect ;; aim, ke space
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 TANK-DELTA-X))
  "space")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 (- TANK-Y POSN-Y-OFFSET))))
(check-expect ;; fired, change right to left
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 50 100))
  "left")
 (make-fired (make-posn 50 25)
             (make-tank 50 (- TANK-DELTA-X))
             (make-posn 50 100)))
(check-expect ;; fired, left is still left
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 (- TANK-DELTA-X))
              (make-posn 50 100))
  "left")
 (make-fired (make-posn 50 25)
             (make-tank 50 (- TANK-DELTA-X))
             (make-posn 50 100)))
(check-expect ;; fired, change left to right
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 (- TANK-DELTA-X))
              (make-posn 50 100))
  "right")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 100)))
(check-expect ;; fired, right is still right
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 50 100))
  "right")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 100)))
(check-expect ;; fired, space does nothing
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 50 100))
  "space")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 100)))
(check-expect ;; fired, garbage ke
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 50 100))
  "x")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 100)))
(define (si-control s ke)
  (if (aim? s)
      (if (eq? ke "space")
          ; aim + space => fired missile
          (make-fired (make-posn (posn-x (aim-ufo s)) (posn-y (aim-ufo s)))
                      (make-tank (tank-loc (aim-tank s))
                                 (tank-vel (aim-tank s)))
                      (make-posn (tank-loc (aim-tank s))
                                 (- TANK-Y POSN-Y-OFFSET)))
          (make-aim (make-posn (posn-x (aim-ufo s)) (posn-y (aim-ufo s)))
                    (make-tank (tank-loc (aim-tank s))
                               (cond [(eq? ke "left") (- TANK-DELTA-X)]
                                     [(eq? ke "right") TANK-DELTA-X]
                                     [else (tank-vel (aim-tank s))]))))
      (make-fired (make-posn (posn-x (fired-ufo s)) (posn-y (fired-ufo s)))
                  (make-tank (tank-loc (fired-tank s))
                             (cond [(eq? ke "left") (- TANK-DELTA-X)]
                                   [(eq? ke "right") TANK-DELTA-X]
                                   [else (tank-vel (fired-tank s))]))
                  (make-posn (posn-x (fired-missile s))
                             (posn-y (fired-missile s))))))