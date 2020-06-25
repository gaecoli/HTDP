#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
(define-struct tank [loc vel])

(make-aim (make-posn 20 10) (make-tank 28 -3))
(make-fired (make-posn 20 10)
            (make-tank 28 -3)
            (make-posn 28 (- HEIGHT TANK-HEIGHT )))
(make-fired (make-posn 20 100)
            (make-tank 100 3)
            (make-posn 22 103))