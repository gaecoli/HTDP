#lang racket

(define WIDTH 100)
(define HEIGHT 100)
(define HWIDTH (/ WIDTH 2))
(define HHEIGHT (/ HEIGHT 2))
(define TANK-SPEED 3)
(define MISSILE-SPEED 4)
(define UFO-SPEED 2)

; Graphical constants
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define TANK (rectangle (/ WIDTH 10) (/ WIDTH 20) "solid" "black"))
(define MISSILE (star (/ (image-width TANK) 2) "solid" "black"))
(define UFO (circle (/ WIDTH 15) "solid" "red"))
(define TANK-Y (- HEIGHT (/ (image-height TANK) 2)))


; A Tank is a structure:
; (make-tank N String)
; Interp:
; - N for Number of pixels between the Tank and left border
; - String for direction: "left" or "right"
(define-struct tank (x direction))

(define TANK1 (make-tank 20 "right"))
(define TANK2 (make-tank 30 "left"))

; A Missile is one of:
; - '()
; - (cons Posn Missile)
; Interp: A list of Posn
(define MISSILE0 '())
(define MISSILE1 (list (make-posn 20 30)))
(define MISSILE2 (list (make-posn 10 20) (make-posn 10 30) (make-posn 20 40)))

; A UFO is a Posn
(define UFO1 (make-posn 10 20))
(define UFO2 (make-posn 20 30))


; A Space Game Invaders (SGI) is a structure:
; (make-sgi Tank Missile Ufo)
(define-struct sgi (tank missile ufo))

(define SGI1 (make-sgi TANK1 MISSILE1 UFO1))
(define SGI2 (make-sgi TANK2 MISSILE2 UFO2))



;; RENDER

; SGI -> Image
; Renders the space game invaders
(check-expect (render SGI1) (renderufo (sgi-ufo SGI1) (rendertank (sgi-tank SGI1) (rendermissile (sgi-missile SGI1) BACKGROUND))))

(define (render s)
  (renderufo (sgi-ufo s) (rendertank (sgi-tank s) (rendermissile (sgi-missile s) BACKGROUND))))

; Tank Image -> Image
; Renders the tank into a given scene
(check-expect (rendertank TANK1 BACKGROUND) (place-image TANK (tank-x TANK1) TANK-Y BACKGROUND))

(define (rendertank t i)
  (place-image TANK (tank-x t) TANK-Y i))

; Missile Image -> Image
; Renders the missile into a given scene
(check-expect (rendermissile (list (make-posn 20 30)) BACKGROUND) (place-image MISSILE 20 30 BACKGROUND))
(check-expect (rendermissile (list (make-posn 10 20) (make-posn 20 30)) BACKGROUND) (place-image MISSILE 10 20 (place-image MISSILE 20 30 BACKGROUND)))

(define (rendermissile m i)
  (cond
    [(empty? m) BACKGROUND]
    [else (place-image MISSILE (posn-x (first m)) (posn-y (first m)) (rendermissile (rest m) i))]))

; UFO Image -> Image
; Renders the UFO into a given scene
(check-expect (renderufo UFO1 BACKGROUND) (place-image UFO (posn-x UFO1) (posn-y UFO1) BACKGROUND))

(define (renderufo u i)
  (place-image UFO (posn-x u) (posn-y u) i))



;; ON TICK


; Missile -> Missile
; Moves the missile
(check-expect (missiletock '()) '())
(check-expect (missiletock (list (make-posn 20 30) (make-posn 40 50))) (list (make-posn 20 (- 30 MISSILE-SPEED)) (make-posn 40 (- 50 MISSILE-SPEED))))
(check-expect (missiletock (list (make-posn 10 20) (make-posn 5 -2) (make-posn 20 0) (make-posn 15 10))) (list (make-posn 10 (- 20 MISSILE-SPEED)) (make-posn 15 (- 10 MISSILE-SPEED))))

(define (missiletock m)
  (cond
    [(empty? m) '()]
    [(<= (posn-y (first m)) 0) (missiletock (rest m))]
    [else (cons (make-posn (posn-x (first m)) (- (posn-y (first m)) MISSILE-SPEED)) (missiletock (rest m)))]))

; Tank -> Tank
; Moves the tank
(check-expect (tanktock (make-tank 4 "right")) (make-tank (+ 4 TANK-SPEED) "right"))
(check-expect (tanktock (make-tank 10 "left")) (make-tank (- 10 TANK-SPEED) "left"))

(define (tanktock t)
  (if (string=? (tank-direction t) "right")
      (make-tank (+ (tank-x t) TANK-SPEED) "right")
      (make-tank (- (tank-x t) TANK-SPEED) "left")))

; UFO -> UFO
; Moves the UFO straight down
(check-expect (ufodown (make-posn 20 30)) (make-posn 20 (+ 30 UFO-SPEED)))

(define (ufodown u)
  (make-posn (posn-x u) (+ (posn-y u) UFO-SPEED)))

; UFO -> UFO
; Moves the UFO randomly left or right

(define (uforandom u)...)