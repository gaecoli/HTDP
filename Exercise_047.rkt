#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(check-expect (tock 100) 99.9)
(check-expect (tock 50) 49.9)
(check-expect (tock 0) 0)

(define (tock hs)
  (cond
    [(> hs 0) (- hs .1)]
    [else 0]))

(check-expect (pet 100 "down") 100)
(check-expect (pet 50 "down") 60)
(check-expect (pet 0 "down") 0)
(check-expect (pet 100 "up") 100)
(check-expect (pet 30 "up") 40)
(check-expect (pet 0 "up") 0)

(define (pet hs ke)
  (cond
    [(= hs 100) 100]
    [(= hs 0) 0]
    [else (cond
    [(string=? ke "down") (+ hs (/ hs 5))]
    [(string=? ke "up") (+ hs (/ hs 3))])]))

(check-expect (render 0) (place-image/align (rectangle 0 20 "solid" "red") 0 0 "left" "top" BACKGROUND)) 
(check-expect (render 50) (place-image/align (rectangle 50 20 "solid" "red") 0 0 "left" "top" BACKGROUND)) 
(check-expect (render 100) (place-image/align (rectangle 100 20 "solid" "red") 0 0 "left" "top" BACKGROUND))

(define (render hs)
  (place-image/align (rectangle hs 20 "solid" "red") 0 0 "left" "top" BACKGROUND))

(define (gauge-prog hs)
  (big-bang 100
    [on-tick tock]
    [on-draw render]
    [on-key pet]
    [stop-when zero?]))