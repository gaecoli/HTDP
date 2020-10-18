#lang racket

(define-struct ktransition [current key next])

(define ktrans
  (list (make-ktransition "white" "a" "yellow")
        (make-ktransition "yellow" "b" "yellow")
        (make-ktransition "yellow" "c" "yellow")
        (make-ktransition "yellow" "d" "green")))

(define-struct fs [fsm current])
; Simulate.v2 is a structure:
; (make-fs FSM FSM-State)
(define START (make-fs ktrans "white"))


; Simulate.v2 -> Image
; Renders the rectangle of the desired color
(check-expect (render (make-fs ktrans "white")) (rectangle 100 100 "solid" "white"))
(check-expect (render (make-fs ktrans "yellow")) (rectangle 100 100 "solid" "yellow"))
(check-expect (render (make-fs ktrans "green")) (rectangle 100 100 "solid" "green"))
(check-expect (render (make-fs ktrans "red")) (rectangle 100 100 "solid" "red"))

(define (render sim)
  (square 100 "solid" (fs-current sim)))

; Simulate.v2 KeyEvent -> Simulate.v2
; Finds the next state from ke and cs
(check-expect (keyh (make-fs ktrans "white") "a") (make-fs ktrans "yellow"))
(check-expect (keyh (make-fs ktrans "white") "z") (make-fs ktrans "red"))
(check-expect (keyh (make-fs ktrans "yellow") "b") (make-fs ktrans "yellow"))
(check-expect (keyh (make-fs ktrans "yellow") "c") (make-fs ktrans "yellow"))
(check-expect (keyh (make-fs ktrans "yellow") "d") (make-fs ktrans "green"))
(check-expect (keyh (make-fs ktrans "yellow") "z") (make-fs ktrans "red"))
(check-expect (keyh (make-fs ktrans "red") " ") START)

(define (keyh sim ke)
  (if (key=? ke " ")
      START
      (make-fs (fs-fsm sim) (find (fs-fsm sim) (fs-current sim) ke))))

; FSM FSM-State Key -> FSM-State
; Finds the next state of the FSM
(check-expect (find ktrans "white" "a") "yellow")
(check-expect (find ktrans "white" "z") "red")
(check-expect (find ktrans "yellow" "b") "yellow")
(check-expect (find ktrans "yellow" "c") "yellow")
(check-expect (find ktrans "yellow" "d") "green")
(check-expect (find ktrans "yellow" "z") "red")
(check-expect (find ktrans "green" "a") "green")
(check-expect (find ktrans "red" "b") "red")

(define (find fsm current ke)
  (cond
    [(empty? fsm) "red"]
    [(state=? current "green") "green"]
    [(state=? current "red") "red"]
    [else (if (and (state=? current (ktransition-current (first fsm)))
                   (key=? ke (ktransition-key (first fsm))))
              (ktransition-next (first fsm))
              (find (rest fsm) current ke))]))

; FSM-State -> Boolean
; Equality predicate for states
(check-expect (state=? "green" "blue") #false)
(check-expect (state=? "red" "red") #true)

(define (state=? a b)
  (string=? a b))


(define (main x)
  (big-bang x
    [to-draw render]
    [on-key keyh]))

(main START)