#lang racket

(define-struct coordinate [pos])
(define y-coor (make-coordinate 5))
(define y-coor-2 (make-coordinate 12))
(define x-coor (make-coordinate -7))
(define x-coor-2 (make-coordinate -20))
(define coor (make-coordinate (make-posn 20 30)))
(define coor-2 (make-coordinate (make-posn 13 13)))