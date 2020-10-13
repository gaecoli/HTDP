#lang racket

(define BACKGROUND-W 400)
(define HBACKGROUND-W (/ BACKGROUND-W 2))
(define BACKGROUND-H 400)
(define HBACKGROUND-H (/ BACKGROUND-H 2))
(define WORM-RAD 10)
(define 2WORM-RAD (* WORM-RAD 2))
(define TEXT-SIZE 30)
(define TEXT-COLOR "black")
(define TEXT-MESSAGE1 "worm hit border")
(define TEXT-MESSAGE2 "worm hit itself")
(define SPEED 0.065)

; Graphical constants
(define SEGMENT (circle WORM-RAD "solid" "red"))
(define FOOD (circle WORM-RAD "solid" "green"))
(define BACKGROUND (empty-scene BACKGROUND-W BACKGROUND-H))
(define FINAL-TEXT1 (text TEXT-MESSAGE1 TEXT-SIZE TEXT-COLOR))
(define FINAL-TEXT2 (text TEXT-MESSAGE2 TEXT-SIZE TEXT-COLOR))
(define FINAL-PIC1 (place-image FINAL-TEXT1 (+ (/ (image-width FINAL-TEXT1) 2) 10) (- BACKGROUND-H TEXT-SIZE) BACKGROUND))
(define FINAL-PIC2 (place-image FINAL-TEXT2 (+ (/ (image-width FINAL-TEXT2) 2) 10) (- BACKGROUND-H TEXT-SIZE) BACKGROUND))
(define START-PIC (place-image (text "WORM GAME" TEXT-SIZE "red") HBACKGROUND-W (/ HBACKGROUND-H 2)
                               (place-image (text "Press space to start" 20 "black") HBACKGROUND-W HBACKGROUND-H BACKGROUND)))


; Worm is a struct
; (make-worm (String List-of-Posn Posn))
; Direction for the direction the worm is moving
; Tail for a List-of-Posn
; Food is a Posn that represents food on the scene
(define-struct worm (direction tail food))

(define WORM1 (make-worm "right" (list (make-posn 20 30)) (make-posn 40 40)))
(define WORM2 (make-worm "left" (list (make-posn 10 100) (make-posn 30 100)) (make-posn 40 40)))
(define WORM0 (make-worm "start" (list (make-posn 20 40)) (make-posn 80 80)))

; Direction is one of:
; - "right"
; - "left"
; - "up"
; - "down"
; - "start"
; Interp: Direction which the worm is moving
(define DIRECTION-R "right")
(define DIRECTION-U "up")

; Tail is one of:
; - '()
; - (cons Posn Tail)
; Interp: A List-of-Posn which represents the position of every segment of the worm
(define TAIL1 '())
(define TAIL2 (list (make-posn 100 100) (make-posn 80 100) (make-posn 60 100)))
(define TAIL3 (list (make-posn 140 100) (make-posn 120 100) (make-posn 100 100) (make-posn 80 100) (make-posn 60 100) (make-posn 40 100) (make-posn 20 100)))

; Food is a posn
; Interp: Position where the food is at a certain moment on the background
(define POS1 (make-posn 60 60))
(define POS2 (make-posn 20 40))



;; RENDER


; Worm -> Image
; Renders the worm and food into the scene
(check-expect (render (make-worm "right" (list (make-posn 40 100)) (make-posn 10 20))) (place-image FOOD 10 20 (renderworm (list (make-posn 40 100)))))
(check-expect (render (make-worm "left" TAIL2 (make-posn 20 30))) (place-image FOOD 20 30 (renderworm TAIL2)))

(define (render w)
  (if (string=? (worm-direction w) "start")
      START-PIC
      (place-image FOOD (posn-x (worm-food w)) (posn-y (worm-food w)) (renderworm (worm-tail w)))))
 
; Tail -> Image
; Renders the worm into the scene
(check-expect (renderworm '()) BACKGROUND)
(check-expect (renderworm (list (make-posn 40 100))) (place-image SEGMENT 40 100 BACKGROUND))
(check-expect (renderworm TAIL2) (place-image SEGMENT 100 100 (place-image SEGMENT 80 100 (place-image SEGMENT 60 100 BACKGROUND))))

(define (renderworm t)
  (cond
    [(empty? t) BACKGROUND]
    [else (place-image SEGMENT (posn-x (first t)) (posn-y (first t)) (renderworm (rest t)))]))

; Food -> Image
; Renders Food into the scene
(check-expect (renderfood (make-posn 50 50)) (place-image FOOD 50 50 BACKGROUND))

(define (renderfood f)
  (place-image FOOD (posn-x f) (posn-y f) BACKGROUND))




;; ON TICK

; Worm -> Worm
; Moves the worm
; Generates food
; Grows the worm's tail when he eats
(check-expect (tock (make-worm "right" (list (make-posn 40 60)) (make-posn 10 20)))
              (make-worm "right" (tailpos (list (make-posn 40 60)) "right") (make-posn 10 20)))   ; Only moves
(check-random (tock (make-worm "right" (list (make-posn 20 30)) (make-posn 40 30)))
              (make-worm "right" (wormgrow (make-worm "right" (list (make-posn 20 30)) (make-posn 40 30))) (food-create (make-posn 40 30))))   ; Eats and generates food

(define (tock w)
  (cond
    [(eating? w) (make-worm (worm-direction w) (wormgrow w) (food-create (worm-food w)))]
    [else (make-worm (worm-direction w) (tailpos (worm-tail w) (worm-direction w)) (worm-food w))]))

; Worm -> Tail
; If the worm eats food, grows his tail
(check-expect (wormgrow (make-worm "right" (list (make-posn 60 60) (make-posn 40 60)) (make-posn 80 60)))
              (list (make-posn 80 60) (make-posn 60 60) (make-posn 40 60)))
(check-expect (wormgrow (make-worm "left" (list (make-posn 20 30)) (make-posn 30 30))) (list (make-posn 20 30)))

(define (wormgrow w)
  (if (eating? w)
      (cons (worm-food w) (worm-tail w))
      (worm-tail w)))


; Determines if the worm is going to eat on the next clock tick
(check-expect (eating? (make-worm "right" (list (make-posn 40 60)) (make-posn 10 20))) #false)
(check-expect (eating? (make-worm "right" (list (make-posn 20 30)) (make-posn 40 30))) #true)

(define (eating? w)
  (cond
    [(equal? (first (tailpos (worm-tail w) (worm-direction w))) (worm-food w)) #true]
    [else #false]))

(check-expect (tailpos '() "right") '())
(check-expect (tailpos (list (make-posn 40 40)) "right") (list (genpos (make-posn 40 40) "right")))
(check-expect (tailpos (list (make-posn 100 100) (make-posn 80 100) (make-posn 60 100)) "right") (list (genpos (make-posn 100 100) "right") (make-posn 100 100) (make-posn 80 100)))

(define (tailpos t d)
  (cond
    [(empty? t) '()]
    [else (cons (genpos (first t) d) (delpos t))]))


(check-expect (genpos (make-posn 20 30) "right") (make-posn (+ 20 2WORM-RAD) 30))
(check-expect (genpos (make-posn 50 50) "left") (make-posn (- 50 2WORM-RAD) 50))
(check-expect (genpos (make-posn 40 60) "up") (make-posn 40 (- 60 2WORM-RAD)))
(check-expect (genpos (make-posn 90 100) "down") (make-posn 90 (+ 100 2WORM-RAD)))
(check-expect (genpos (make-posn 10 20) "r") (make-posn 10 20))

(define (genpos pos s)
  (cond
    [(string=? s "right") (make-posn (+ (posn-x pos) 2WORM-RAD) (posn-y pos))]
    [(string=? s "left") (make-posn (- (posn-x pos) 2WORM-RAD) (posn-y pos))]
    [(string=? s "up") (make-posn (posn-x pos) (- (posn-y pos) 2WORM-RAD))]
    [(string=? s "down") (make-posn (posn-x pos) (+ (posn-y pos) 2WORM-RAD))]
    [else pos]))


(check-expect (delpos '()) '())
(check-expect (delpos (list (make-posn 20 30))) '())
(check-expect (delpos (list (make-posn 60 30) (make-posn 40 30))) (list (make-posn 60 30)))
(check-expect (delpos (list (make-posn 60 30) (make-posn 40 30) (make-posn 20 30))) (list (make-posn 60 30) (make-posn 40 30)))

(define (delpos t)
  (cond
    [(empty? t) '()]
    [(empty? (rest t)) '()]
    [else (cons (first t) (delpos (rest t)))]))



(check-random (food-create (make-posn 30 50)) (make-posn (* 2WORM-RAD (random (/ BACKGROUND-W 2WORM-RAD))) (* 2WORM-RAD (random (/ BACKGROUND-W 2WORM-RAD)))))

(define (food-create p)
  (food-check-create
     p (make-posn (* 2WORM-RAD (random (/ BACKGROUND-W 2WORM-RAD))) (* 2WORM-RAD (random (/ BACKGROUND-W 2WORM-RAD))))))


(check-expect (food-check-create (make-posn 20 30) (make-posn 40 30)) (make-posn 40 30))
(check-random (food-check-create (make-posn 10 20) (make-posn 0 50)) (food-create (make-posn 10 20)))
(check-random (food-check-create (make-posn 10 20) (make-posn 50 0)) (food-create (make-posn 10 20)))
(check-random (food-check-create (make-posn 40 40) (make-posn 40 40)) (food-create (make-posn 40 40)))

(define (food-check-create p candidate)
  (cond
    [(equal? p candidate) (food-create p)]
    [(or (equal? 0 (posn-x candidate))
         (equal? BACKGROUND-W (posn-x candidate))
         (equal? 0 (posn-y candidate))
         (equal? BACKGROUND-W (posn-y candidate))) (food-create p)]
    [else candidate]))



(check-expect (keyh (make-worm "right" (list (make-posn 20 30)) POS1) "left") (make-worm "right" (list (make-posn 20 30)) POS1))
(check-expect (keyh (make-worm "down" (list (make-posn 20 30)) POS1) "left") (make-worm "left" (list (make-posn 20 30)) POS1))
(check-expect (keyh (make-worm "left" (list (make-posn 20 30)) POS1) "up") (make-worm "up" (list (make-posn 20 30)) POS1))
(check-expect (keyh (make-worm "right" (list (make-posn 20 30)) POS1) "down") (make-worm "down" (list (make-posn 20 30)) POS1))
(check-expect (keyh (make-worm "down" (list (make-posn 20 30)) POS1) "right") (make-worm "right" (list (make-posn 20 30)) POS1))
(check-expect (keyh (make-worm "right" (list (make-posn 20 30)) POS1) "r") (make-worm "right" (list (make-posn 20 30)) POS1))
(check-expect (keyh WORM0 " ") START)

(define (keyh w ke)
  (cond
    [(and (string=? "right" ke) (not (or (string=? (worm-direction w) "left") (string=? (worm-direction w) "start")))) (make-worm "right" (worm-tail w) (worm-food w))]
    [(and (string=? "left" ke) (not (or (string=? (worm-direction w) "right") (string=? (worm-direction w) "start")))) (make-worm "left" (worm-tail w) (worm-food w))]
    [(and (string=? "up" ke) (not (or (string=? (worm-direction w) "down") (string=? (worm-direction w) "start")))) (make-worm "up" (worm-tail w) (worm-food w))]
    [(and (string=? "down" ke) (not (or (string=? (worm-direction w) "up") (string=? (worm-direction w) "start")))) (make-worm "down" (worm-tail w) (worm-food w))]
    [(and (string=? " " ke) (string=? (worm-direction w) "start")) START]
    [else w]))


(check-expect (last-world? (make-worm "right" (list (make-posn 40 40) (make-posn 40 60) (make-posn 40 40)) POS1)) #true)
(check-expect (last-world? (make-worm "left" (list (make-posn 0 20)) POS1)) #true)
(check-expect (last-world? (make-worm "right" (list (make-posn 20 20)) POS1)) #false)

(define (last-world? w)
  (or (hit-itself? w)
      (hit-border? w)))


(check-expect (hit-itself? (make-worm "right" (list (make-posn 40 40) (make-posn 40 60) (make-posn 40 40)) POS1)) #true)
(check-expect (hit-itself? (make-worm "right" TAIL2 POS1)) #false)

(define (hit-itself? w)
  (same-posn (worm-tail w)))


(check-expect (same-posn '()) #false)
(check-expect (same-posn (list (make-posn 30 40))) #false)
(check-expect (same-posn (list (make-posn 20 30) (make-posn 40 30) (make-posn 20 30))) #true)

(define (same-posn t)
  (cond
    [(empty? t) #false]
    [else (member? (first t) (rest t))]))


(check-expect (hit-border? (make-worm "right" (list (make-posn 8000 20)) POS1)) #true)
(check-expect (hit-border? (make-worm "down" (list (make-posn 20 8000)) POS1)) #true)
(check-expect (hit-border? (make-worm "left" (list (make-posn 0 20)) POS1)) #true)
(check-expect (hit-border? (make-worm "up" (list (make-posn 20 -10)) POS1)) #true)
(check-expect (hit-border? (make-worm "right" (list (make-posn 20 20)) POS1)) #false)

(define (hit-border? w)
  (cond
    [(>= (posn-x (first (worm-tail w))) BACKGROUND-W) #true]
    [(>= (posn-y (first (worm-tail w))) BACKGROUND-H) #true]
    [(<= (posn-x (first (worm-tail w))) 0) #true]
    [(<= (posn-y (first (worm-tail w))) 0) #true]
    [else #false]))

(check-expect (last-picture (make-worm "right" (list (make-posn 20 20)) POS1)) #false)
(check-expect (last-picture (make-worm "right" (list (make-posn 8000 20)) POS1)) (score (make-worm "right" (list (make-posn 8000 20)) POS1) FINAL-PIC1))
(check-expect (last-picture (make-worm "right" (list (make-posn 40 40) (make-posn 40 40)) POS1)) (score (make-worm "right" (list (make-posn 40 40) (make-posn 40 40)) POS1) FINAL-PIC2))

(define (last-picture w)
  (cond
    [(hit-border? w) (score w FINAL-PIC1)]
    [(hit-itself? w) (score w FINAL-PIC2)]
    [else #false]))


(check-expect (score (make-worm "right" (list (make-posn 40 20)) (make-posn 10 20)) BACKGROUND)
              (place-image (text "SCORE  1" 50 "red") HBACKGROUND-W HBACKGROUND-H BACKGROUND))

(define (score w i)
  (place-image (text (string-append "SCORE  " (number->string (length (worm-tail w)))) 50 "red") HBACKGROUND-W HBACKGROUND-H i))



(define START (make-worm "right" (list (make-posn 20 HBACKGROUND-H)) (food-create (make-posn 20 20))))
(define STARTGAME (make-worm "start" (list (make-posn 20 HBACKGROUND-H)) (food-create (make-posn 20 20))))

(define (main x)
  (big-bang x
    [to-draw render]
    [on-tick tock SPEED]
    [on-key keyh]
    [stop-when last-world? last-picture]))

(main STARTGAME)