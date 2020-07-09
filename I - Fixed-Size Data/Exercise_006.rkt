#lang racket

(require 2htdp/image) ;;支持图像处理

(define cat <cat1.png>)

(define (image-area img)
  (* (image-width img) (image-height img)))

(image-area cat)