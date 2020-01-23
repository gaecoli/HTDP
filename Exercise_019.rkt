#lang racket

(define (string-insert str i)
  (if (and (string=? str "") (= i 0))
      "-"
      (if (and (string=? str "") (> i 0))
          "Error: The string is empty. Only possible argument is 0."
               (if (and (>= (string-length str) 1) (< i (string-length str)))
                   (string-append (substring str 0 i) "_" (substring str i (string-length str)))
                    "Error: position indicated by i exceeds length of string."))))