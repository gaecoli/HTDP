#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "blue"))

(define (main p0)
  (big-bang p0
            [on-tick x+]
            ;[on-mouse reset-dot]
            [to-draw scene+dot]))

(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))
(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))

(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))
(define (x+ p)
  (make-posn (+ (posn-x p) 3) (posn-y p)))

(check-expect (posn-up-x (make-posn 47 10) 0)
              (make-posn 0 10))
(define (posn-up-x p n)
  (make-posn n (posn-y p)))