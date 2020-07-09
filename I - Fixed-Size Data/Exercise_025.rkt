#lang racket

(define (image-classify img)
  (cond
     [(>= (image-height img) (image-width img)) "tall"]
     [(= (image-height img) (image-width img)) "square"]
     [(<= (image-height img) (image-width img)) "wide"]))
