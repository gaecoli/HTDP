#lang racket

(define BACKGROUND-W 600)
(define HBACKGROUND-W (/ BACKGROUND-W 2))
(define BACKGROUND-H 600)
(define HBACKGROUND-H (/ BACKGROUND-H 2))
(define WORM-RAD 10)
(define 2WORM-RAD (* WORM-RAD 2))
(define TEXT-SIZE 30)
(define TEXT-COLOR "black")
(define TEXT-MESSAGE1 "worm hit border")
(define TEXT-MESSAGE2 "worm hit itself")

; Graphical constants
(define SEGMENT (circle WORM-RAD "solid" "red"))
(define FOOD (circle WORM-RAD "solid" "green"))
(define BACKGROUND (empty-scene BACKGROUND-W BACKGROUND-H))
(define FINAL-TEXT1 (text TEXT-MESSAGE1 TEXT-SIZE TEXT-COLOR))
(define FINAL-TEXT2 (text TEXT-MESSAGE2 TEXT-SIZE TEXT-COLOR))
(define FINAL-PIC1 (place-image FINAL-TEXT1 (+ (/ (image-width FINAL-TEXT1) 2) 10) (- BACKGROUND-H TEXT-SIZE) BACKGROUND))
(define FINAL-PIC2 (place-image FINAL-TEXT2 (+ (/ (image-width FINAL-TEXT2) 2) 10) (- BACKGROUND-H TEXT-SIZE) BACKGROUND))


; Worm is a struct
; (make-worm (String List-of-Posn))
; Direction for the direction the worm is moving
; Tail for a List-of-Posn
(define-struct worm (direction tail))

(define WORM1 (make-worm "right" (list (make-posn 20 30))))
(define WORM2 (make-worm "left" (list (make-posn 10 100) (make-posn 30 100))))

; Tail is one of:
; - '()
; - (cons Posn Tail)
; Interp: A List-of-Posn which represents the position of every segment of the worm
(define TAIL1 '())
(define TAIL2 (list (make-posn 100 100) (make-posn 80 100) (make-posn 60 100)))
(define TAIL3 (list (make-posn 140 100) (make-posn 120 100) (make-posn 100 100) (make-posn 80 100) (make-posn 60 100) (make-posn 40 100) (make-posn 20 100)))



;; RENDER

; Worm -> Image
; Renders the worm into the scene
(check-expect (renderworm (make-worm "right" (list (make-posn 40 100)))) (renderworm* (list (make-posn 40 100))))
(check-expect (renderworm (make-worm "left" TAIL2)) (renderworm* TAIL2))

(define (renderworm w)
  (renderworm* (worm-tail w)))
 
; Tail -> Image
; Renders the worm into the scene
(check-expect (renderworm* '()) BACKGROUND)
(check-expect (renderworm* (list (make-posn 40 100))) (place-image SEGMENT 40 100 BACKGROUND))
(check-expect (renderworm* TAIL2) (place-image SEGMENT 100 100 (place-image SEGMENT 80 100 (place-image SEGMENT 60 100 BACKGROUND))))

(define (renderworm* t)
  (cond
    [(empty? t) BACKGROUND]
    [else (place-image SEGMENT (posn-x (first t)) (posn-y (first t)) (renderworm* (rest t)))]))



;; ON TICK

; Worm -> Worm
; Moves the worm
(check-expect (wormtock (make-worm "right" TAIL2)) (make-worm "right" (tailpos TAIL2 "right")))

(define (wormtock w)
  (make-worm (worm-direction w) (tailpos (worm-tail w) (worm-direction w))))

; Tail Direction -> Tail
; Creates a new posn on the direction of the worm and
; deletes the last posn to create a movement effect
(check-expect (tailpos '() "right") '())
(check-expect (tailpos (list (make-posn 40 40)) "right") (list (genpos (make-posn 40 40) "right")))
(check-expect (tailpos (list (make-posn 100 100) (make-posn 80 100) (make-posn 60 100)) "right") (list (genpos (make-posn 100 100) "right") (make-posn 100 100) (make-posn 80 100)))

(define (tailpos t d)
  (cond
    [(empty? t) '()]
    [else (cons (genpos (first t) d) (delpos t))]))

; Posn String -> Posn
; Generates a new Posn on the direction of the worm
(check-expect (genpos (make-posn 20 30) "right") (make-posn (+ 20 2WORM-RAD) 30))
(check-expect (genpos (make-posn 50 50) "left") (make-posn (- 50 2WORM-RAD) 50))
(check-expect (genpos (make-posn 40 60) "up") (make-posn 40 (- 60 2WORM-RAD)))
(check-expect (genpos (make-posn 90 100) "down") (make-posn 90 (+ 100 2WORM-RAD)))

(define (genpos pos s)
  (cond
    [(string=? s "right") (make-posn (+ (posn-x pos) 2WORM-RAD) (posn-y pos))]
    [(string=? s "left") (make-posn (- (posn-x pos) 2WORM-RAD) (posn-y pos))]
    [(string=? s "up") (make-posn (posn-x pos) (- (posn-y pos) 2WORM-RAD))]
    [(string=? s "down") (make-posn (posn-x pos) (+ (posn-y pos) 2WORM-RAD))]))

; Tail -> Tail
; Removes the last posn of a given Tail
(check-expect (delpos '()) '())
(check-expect (delpos (list (make-posn 20 30))) '())
(check-expect (delpos (list (make-posn 60 30) (make-posn 40 30))) (list (make-posn 60 30)))
(check-expect (delpos (list (make-posn 60 30) (make-posn 40 30) (make-posn 20 30))) (list (make-posn 60 30) (make-posn 40 30)))

(define (delpos t)
  (cond
    [(empty? t) '()]
    [(empty? (rest t)) '()]
    [else (cons (first t) (delpos (rest t)))]))


; Changes the direction of the worm
(check-expect (keyh (make-worm "right" (list (make-posn 20 30))) "left") (make-worm "right" (list (make-posn 20 30))))
(check-expect (keyh (make-worm "down" (list (make-posn 20 30))) "left") (make-worm "left" (list (make-posn 20 30))))
(check-expect (keyh (make-worm "left" (list (make-posn 20 30))) "up") (make-worm "up" (list (make-posn 20 30))))
(check-expect (keyh (make-worm "right" (list (make-posn 20 30))) "down") (make-worm "down" (list (make-posn 20 30))))
(check-expect (keyh (make-worm "down" (list (make-posn 20 30))) "right") (make-worm "right" (list (make-posn 20 30))))
(check-expect (keyh (make-worm "right" (list (make-posn 20 30))) "r") (make-worm "right" (list (make-posn 20 30))))

(define (keyh w ke)
  (cond
    [(and (string=? "right" ke) (not (string=? (worm-direction w) "left"))) (make-worm "right" (worm-tail w))]
    [(and (string=? "left" ke) (not (string=? (worm-direction w) "right"))) (make-worm "left" (worm-tail w))]
    [(and (string=? "up" ke) (not (string=? (worm-direction w) "down"))) (make-worm "up" (worm-tail w))]
    [(and (string=? "down" ke) (not (string=? (worm-direction w) "up"))) (make-worm "down" (worm-tail w))]
    [else w]))


; Stops the program if the worm hit himself or any border of the scene
(check-expect (last-world? (make-worm "right" (list (make-posn 40 40) (make-posn 40 60) (make-posn 40 40)))) #true)
(check-expect (last-world? (make-worm "left" (list (make-posn 0 20)))) #true)
(check-expect (last-world? (make-worm "right" (list (make-posn 20 20)))) #false)

(define (last-world? w)
  (or (hit-itself? w)
      (hit-border? w)))

; Worm -> Boolean
; Determines if the worm has hit himself
(check-expect (hit-itself? (make-worm "right" (list (make-posn 40 40) (make-posn 40 60) (make-posn 40 40)))) #true)
(check-expect (hit-itself? (make-worm "right" TAIL2)) #false)

(define (hit-itself? w)
  (same-posn (worm-tail w)))

(check-expect (same-posn '()) #false)
(check-expect (same-posn (list (make-posn 30 40))) #false)
(check-expect (same-posn (list (make-posn 20 30) (make-posn 40 30) (make-posn 20 30))) #true)

(define (same-posn t)
  (cond
    [(empty? t) #false]
    [else (member? (first t) (rest t))]))


(check-expect (hit-border? (make-worm "right" (list (make-posn 8000 20)))) #true)
(check-expect (hit-border? (make-worm "down" (list (make-posn 20 8000)))) #true)
(check-expect (hit-border? (make-worm "left" (list (make-posn 0 20)))) #true)
(check-expect (hit-border? (make-worm "up" (list (make-posn 20 -10)))) #true)
(check-expect (hit-border? (make-worm "right" (list (make-posn 20 20)))) #false)

(define (hit-border? w)
  (cond
    [(>= (posn-x (first (worm-tail w))) BACKGROUND-W) #true]
    [(>= (posn-y (first (worm-tail w))) BACKGROUND-H) #true]
    [(<= (posn-x (first (worm-tail w))) 0) #true]
    [(<= (posn-y (first (worm-tail w))) 0) #true]
    [else #false]))


(check-expect (last-picture (make-worm "right" (list (make-posn 8000 20)))) FINAL-PIC1)
(check-expect (last-picture (make-worm "right" (list (make-posn 40 40) (make-posn 40 60) (make-posn 40 40)))) FINAL-PIC2)
(check-expect (last-picture (make-worm "right" (list (make-posn 20 20)))) #false)

(define (last-picture w)
  (cond
    [(hit-border? w) FINAL-PIC1]
    [(hit-itself? w) FINAL-PIC2]
    [else #false]))

(define (main x)
  (big-bang x
    [to-draw renderworm]
    [on-tick wormtock 0.1]
    [on-key keyh]
    [stop-when last-world? last-picture]))