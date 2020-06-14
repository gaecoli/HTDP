#lang racket
(define RED 0)
(define GREEN 1)
(define YELLOW 2)

(define (tl-next-symbolic cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))