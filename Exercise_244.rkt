#lang racket

(define (f x) (x 10))

(define (f x) (x f))

(define (f x y) (x 'a y 'b))