#lang racket

(define (string-remove-last strg)
  (substring strg 0 (- (string-length strg) 1)))