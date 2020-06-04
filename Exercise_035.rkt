#lang racket

(define (string-last strg)
  (substring strg (-(string-length strg) 1)))