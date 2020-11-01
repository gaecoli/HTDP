#lang racket

(define-struct layer [stuff])

(define LSTR0 "abcd")
(define LSTR1 (make-layer "abcd"))
(define LSTR2 (make-layer (make-layer (make-layer "abcd"))))

(define LNUM0 4)
(define LNUM1 (make-layer 10))
(define LNUM2 (make-layer (make-layer (make-layer 2))))


(define LITEM1 (make-layer "abcd"))
(define LITEM2 (make-layer 10))