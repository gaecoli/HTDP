#lang racket

(check-expect (dtel '()) '())
(check-expect (dtel (cons 23 (cons 1528 '()))) (cons (dte 23) (cons (dte 1528) '())))

(define (dtel dl)
  (cond
    [(empty? dl) '()]
    [else (cons (dte (first dl)) (dtel (rest dl)))]))

(check-expect (dte 1) 0.877510118)

(define (dte d)
  (* d 0.877510118))

(define lom1 '())
(define lom2 (cons 23 (cons 1 '())))