#lang racket

(define BACKGROUND-W 600)
(define HBACKGROUND-W (/ BACKGROUND-W 2))
(define BACKGROUND-H 600)
(define HBACKGROUND-H (/ BACKGROUND-H 2))
(define WORM-RAD 10)

; Graphical constants
(define WORM (circle WORM-RAD "solid" "red"))
(define FOOD (circle WORM-RAD "solid" "green"))
(define BACKGROUND (empty-scene BACKGROUND-W BACKGROUND-H))


; Worm is a struct
; (make-worm (Posn String))
(define-struct worm (pos direction))

(define WORM1 (make-worm (make-posn HBACKGROUND-W HBACKGROUND-H) "right"))
(define WORM2 (make-worm (make-posn 10 100) "right"))


; Worm -> Image
; Renders the worm into the scene
(check-expect (render (make-worm (make-posn 40 100) "right")) (place-image WORM 40 100 BACKGROUND))

(define (render w)
  (place-image WORM (posn-x (worm-pos w)) (posn-y (worm-pos w)) BACKGROUND))



; Worm -> Worm
; Moves the worm per clock tick
(check-expect (tock (make-worm (make-posn 20 30) "right")) (make-worm (make-posn (+ 20 WORM-RAD) 30) "right"))
(check-expect (tock (make-worm (make-posn 20 30) "left")) (make-worm (make-posn (- 20 WORM-RAD) 30) "left"))
(check-expect (tock (make-worm (make-posn 20 30) "up")) (make-worm (make-posn 20 (- 30 WORM-RAD)) "up"))
(check-expect (tock (make-worm (make-posn 20 30) "down")) (make-worm (make-posn 20 (+ 30 WORM-RAD)) "down"))

(define (tock w)
  (make-worm (tock* (make-posn (posn-x (worm-pos w)) (posn-y (worm-pos w))) (worm-direction w)) (worm-direction w)))

; Posn String -> Posn
; Auxiliar Function for tock
(check-expect (tock* (make-posn 20 30) "right") (make-posn (+ 20 WORM-RAD) 30))
(check-expect (tock* (make-posn 50 50) "left") (make-posn (- 50 WORM-RAD) 50))
(check-expect (tock* (make-posn 40 60) "up") (make-posn 40 (- 60 WORM-RAD)))
(check-expect (tock* (make-posn 90 100) "down") (make-posn 90 (+ 100 WORM-RAD)))

(define (tock* pos s)
  (cond
    [(string=? s "right") (make-posn (+ (posn-x pos) WORM-RAD) (posn-y pos))]
    [(string=? s "left") (make-posn (- (posn-x pos) WORM-RAD) (posn-y pos))]
    [(string=? s "up") (make-posn (posn-x pos) (- (posn-y pos) WORM-RAD))]
    [(string=? s "down") (make-posn (posn-x pos) (+ (posn-y pos) WORM-RAD))]))



; Worm KeyEvent -> Worm
; Changes the direction of the worm
(check-expect (keyh (make-worm (make-posn 20 30) "right") "left") (make-worm (make-posn 20 30) "left"))
(check-expect (keyh (make-worm (make-posn 20 30) "left") "up") (make-worm (make-posn 20 30) "up"))
(check-expect (keyh (make-worm (make-posn 20 30) "up") "down") (make-worm (make-posn 20 30) "down"))
(check-expect (keyh (make-worm (make-posn 20 30) "down") "right") (make-worm (make-posn 20 30) "right"))
(check-expect (keyh (make-worm (make-posn 20 30) "right") "r") (make-worm (make-posn 20 30) "right"))

(define (keyh w ke)
  (cond
    [(string=? "right" ke) (make-worm (worm-pos w) "right")]
    [(string=? "left" ke) (make-worm (worm-pos w) "left")]
    [(string=? "up" ke) (make-worm (worm-pos w) "up")]
    [(string=? "down" ke) (make-worm (worm-pos w) "down")]
    [else w]))

(define (main x)
  (big-bang x
    [to-draw render]
    [on-tick tock]
    [on-key keyh]))