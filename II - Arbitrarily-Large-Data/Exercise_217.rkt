#lang racket

(define BACKGROUND-W 600)
(define HBACKGROUND-W (/ BACKGROUND-W 2))
(define BACKGROUND-H 600)
(define HBACKGROUND-H (/ BACKGROUND-H 2))
(define WORM-RAD 10)
(define 2WORM-RAD (* WORM-RAD 2))
(define TEXT-SIZE 30)
(define TEXT-COLOR "black")
(define TEXT-MESSAGE "worm hit border")


(define SEGMENT (circle WORM-RAD "solid" "red"))
(define FOOD (circle WORM-RAD "solid" "green"))
(define BACKGROUND (empty-scene BACKGROUND-W BACKGROUND-H))
(define FINAL-TEXT (text TEXT-MESSAGE TEXT-SIZE TEXT-COLOR))
(define FINAL-PIC (place-image FINAL-TEXT (+ (/ (image-width FINAL-TEXT) 2) 10) (- BACKGROUND-H TEXT-SIZE) BACKGROUND))

(define-struct worm (direction tail))

(define WORM1 (make-worm "right" (list (make-posn 20 30))))
(define WORM2 (make-worm "left" (list (make-posn 10 100) (make-posn 30 100))))

(define TAIL1 '())
(define TAIL2 (list (make-posn 100 100) (make-posn 80 100) (make-posn 60 100)))

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

(check-expect (delpos '()) '())
(check-expect (delpos (list (make-posn 20 30))) '())
(check-expect (delpos (list (make-posn 60 30) (make-posn 40 30))) (list (make-posn 60 30)))
(check-expect (delpos (list (make-posn 60 30) (make-posn 40 30) (make-posn 20 30))) (list (make-posn 60 30) (make-posn 40 30)))

(define (delpos t)
  (cond
    [(empty? t) '()]
    [(empty? (rest t)) '()]
    [else (cons (first t) (delpos (rest t)))]))

(check-expect (keyh (make-worm "right" (list (make-posn 20 30))) "left") (make-worm "left" (list (make-posn 20 30))))
(check-expect (keyh (make-worm "left" (list (make-posn 20 30))) "up") (make-worm "up" (list (make-posn 20 30))))
(check-expect (keyh (make-worm "up" (list (make-posn 20 30))) "down") (make-worm "down" (list (make-posn 20 30))))
(check-expect (keyh (make-worm "down" (list (make-posn 20 30))) "right") (make-worm "right" (list (make-posn 20 30))))
(check-expect (keyh (make-worm "right" (list (make-posn 20 30))) "r") (make-worm "right" (list (make-posn 20 30))))

(define (keyh w ke)
  (cond
    [(string=? "right" ke) (make-worm "right" (worm-tail w))]
    [(string=? "left" ke) (make-worm "left" (worm-tail w))]
    [(string=? "up" ke) (make-worm "up" (worm-tail w))]
    [(string=? "down" ke) (make-worm "down" (worm-tail w))]
    [else w]))

; Worm -> Boolean
; Stops the program when the worm reach any border of the scene
(check-expect (last-world? (make-worm "right" (list (make-posn 8000 20)))) #true)
(check-expect (last-world? (make-worm "down" (list (make-posn 20 8000)))) #true)
(check-expect (last-world? (make-worm "left" (list (make-posn 0 20)))) #true)
(check-expect (last-world? (make-worm "up" (list (make-posn 20 -10)))) #true)
(check-expect (last-world? (make-worm "right" (list (make-posn 20 20)))) #false)

(define (last-world? w)
  (cond
    [(>= (posn-x (first (worm-tail w))) BACKGROUND-W) #true]
    [(>= (posn-y (first (worm-tail w))) BACKGROUND-H) #true]
    [(<= (posn-x (first (worm-tail w))) 0) #true]
    [(<= (posn-y (first (worm-tail w))) 0) #true]
    [else #false]))

; Worm -> Image
; Renders the last picture of the worm game
(check-expect (last-picture (make-worm "right" (list (make-posn 8000 20)))) FINAL-PIC)
(check-expect (last-picture (make-worm "right" (list (make-posn 20 20)))) #false)

(define (last-picture w)
  (if (last-world? w)
      FINAL-PIC
      #false))


(define (main x)
  (big-bang x
    [to-draw renderworm]
    [on-tick wormtock 0.1]
    [on-key keyh]
    [stop-when last-world? last-picture]))