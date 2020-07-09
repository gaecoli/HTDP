#lang racket
;(require 2htdp/image)

;等立方体的体积
(define (cvolume x)
  (expt x 3))


;等立方体的面积
(define (csurface x)
  (* (sqr x) 6))
