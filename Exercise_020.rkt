#lang racket

(define (string-delete str i)
  (if (string=? str "")
      "Error: Empty string; no string to delete."
      (if (or (= i 0) (< i (string-length str)))
          (string-append (substring str 0 i) (substring str (+ i 1) (string-length str)))
          "Error: Position indicated by i exceeds length of string.")))