#lang racket

(require 2htdp/image)

(define (image-classify img)
  (if (> (image-height img) (image-width img))
      "tall"
      (if (< (image-height img) (image-width img))
          "wide"
      (if (= (image-height img) (image-width))
          "square"
          "error"))))