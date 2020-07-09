#lang racket

(define (string-last x)
  (if (>= (string-length x) 1)
      (substring x (- (string-length x) 1) (string-length x))
      "The string is empty"))