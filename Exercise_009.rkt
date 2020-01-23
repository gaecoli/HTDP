#lang racket

(require 2htdp/image)

(define in 2)

(if (and (number? in) (negative? in))
    ;(+ (* in -2) in)
    (string->number (substring (number->string in) 1 (string-length (number->string in))))
    (if (string? in)
        (string-length in)
        ( if (image? in)
             (* (image-width in) (image-height in))
             (if (and (number? in) (> in 0))
                 (- in 1)
                 (if (and (boolean? in) in)
                     10
                     20)))))
