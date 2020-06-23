#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define cat (bitmap "images/cat.png"))
(define-struct cat [x hap])