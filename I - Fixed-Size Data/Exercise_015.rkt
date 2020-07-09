#lang racket

(define sunny #false)
(define friday #true)

(define (==> sunny friday)
  (or (not sunny) friday))

(==> sunny friday)