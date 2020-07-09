#lang racket

(define (string-first s)
  (substring s 0 1))

(string-first "hello world")
