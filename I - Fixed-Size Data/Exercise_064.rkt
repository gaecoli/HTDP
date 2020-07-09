#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(check-expect (door-actions "locked" "u") "closed")
(check-expect (door-actions "locked" "a") "locked")
(check-expect (door-actions "closed" "l") "locked")
(check-expect (door-actions "closed" " ") "open")
(check-expect (door-actions "closed" "u") "closed")
(check-expect (door-actions "open" "u") "open")
(check-expect (door-actions "open" " ") "open")
(check-expect (door-actions "open" "x") "open")
(define (door-actions state-of-door event-key)
  (cond
    [(and (string=? "locked" state-of-door)
          (string=? "u" event-key)) "closed"]
    [(and (string=? "closed" state-of-door)
          (string=? "l" event-key)) "locked"]
    [(and (string=? "closed" state-of-door)
          (string=? " " event-key)) "open"]
    [else state-of-door]))

(check-expect (door-closer "locked") "locked")
(check-expect (door-closer "closed") "closed")
(check-expect (door-closer "open") "closed")
(define (door-closer state-of-door)
  (cond
    [(string=? "locked" state-of-door) "locked"]
    [(string=? "closed" state-of-door) "closed"]
    [(string=? "open" state-of-door) "closed"]))

(check-expect (door-render "closed") (text "closed" 40 "blue"))
(define (door-render s) (text s 40 "blue"))

(define (door-simulation initial-state)
  (big-bang initial-state
            [on-tick door-closer 3]
            [on-key door-actions]
            [to-draw door-render]))

(door-simulation "closed")