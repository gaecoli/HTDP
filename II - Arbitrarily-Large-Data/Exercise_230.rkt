#lang racket

(define-struct fsm [initial transitions final])
(define-struct transition [current key next])

(define trans1
  (list (make-transition "white" "a" "yellow")
        (make-transition "yellow" "b" "yellow")
        (make-transition "yellow" "c" "yellow")
        (make-transition "yellow" "d" "green")))

; A Transition.v3 is a structure: 
;   (make-transition FSM-State KeyEvent FSM-State)
(define TRANS1 (make-transition "white" "a" "yellow"))


; FSM.v2 -> Image
; Renders the rectangle of the desired color
(check-expect (render (make-fsm "white" trans1 "green")) (rectangle 100 100 "solid" "white"))
(check-expect (render (make-fsm "yellow" trans1 "green")) (rectangle 100 100 "solid" "yellow"))
(check-expect (render (make-fsm "red" trans1 "red")) (rectangle 100 100 "solid" "red"))
(check-expect (render (make-fsm "green" trans1 "red")) (rectangle 100 100 "solid" "green"))

(define (render fsm)
  (square 100 "solid" (fsm-initial fsm)))

; FSM.v2 KeyEvent -> FSM.v2
; Finds the next state from ke and cs
(check-expect (keyh (make-fsm "white" trans1 "red") "a") (make-fsm "yellow" trans1 "red"))
(check-expect (keyh (make-fsm "white" trans1 "green") "z") (make-fsm "red" trans1 "green"))
(check-expect (keyh (make-fsm "yellow" trans1 "red") "b") (make-fsm "yellow" trans1 "red"))
(check-expect (keyh (make-fsm "yellow" trans1 "green") "c") (make-fsm "yellow" trans1 "green"))
(check-expect (keyh (make-fsm "yellow" trans1 "red") "d") (make-fsm "green" trans1 "red"))
(check-expect (keyh (make-fsm "yellow" trans1 "green") "z") (make-fsm "red" trans1 "green"))

(define (keyh fsm ke)
  (make-fsm (find (fsm-transitions fsm) (fsm-initial fsm) ke) (fsm-transitions fsm) (fsm-final fsm)))

; LOT FSM-State Key -> FSM-State
; Finds the next state of the FSM
(check-expect (find trans1 "white" "a") "yellow")
(check-expect (find trans1 "white" "z") "red")
(check-expect (find trans1 "yellow" "b") "yellow")
(check-expect (find trans1 "yellow" "c") "yellow")
(check-expect (find trans1 "yellow" "d") "green")
(check-expect (find trans1 "yellow" "z") "red")
(check-expect (find trans1 "green" "a") "green")
(check-expect (find trans1 "red" "b") "red")

(define (find lot initial ke)
  (cond
    [(empty? lot) "red"]
    [(state=? initial "green") "green"]
    [(state=? initial "red") "red"]
    [else (if (and (state=? initial (transition-current (first lot)))
                   (key=? ke (transition-key (first lot))))
              (transition-next (first lot))
              (find (rest lot) initial ke))]))

; FSM-State -> Boolean
; Equality predicate for states
(check-expect (state=? "green" "blue") #false)
(check-expect (state=? "red" "red") #true)

(define (state=? a b)
  (string=? a b))

; FSM.v2 -> Boolean
; Stops the fsm-simulate if the final state equals the initial one
(check-expect (last-world? (make-fsm "red" trans1 "red")) #true)
(check-expect (last-world? (make-fsm "green" trans1 "green")) #true)
(check-expect (last-world? (make-fsm "yellow" trans1 "green")) #false)

(define (last-world? fsm)
  (state=? (fsm-initial fsm) (fsm-final fsm)))

(define (fsm-simulate fsm)
  (big-bang fsm
    [to-draw render]
    [on-key keyh]
    [stop-when last-world?]))