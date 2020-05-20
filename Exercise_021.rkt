#lang racket

(define (ff a) (* 10 a))

(ff (ff 1))

(+ (ff 1) (ff 1))