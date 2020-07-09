#lang racket

(require 2htdp/image)

(define cat .)

(define (image-area cat)
  (* (image-height cat) (image-width cat)))