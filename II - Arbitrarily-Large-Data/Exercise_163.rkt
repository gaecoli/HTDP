#lang racket

(check-expect (convertfc '()) '())
(check-expect (convertfc (cons 86 (cons 59 '()))) (cons 30 (cons 15 '())))

(define (convertfc lot)
  (cond
    [(empty? lot) '()]
    [else (cons (ftc (first lot)) (convertfc (rest lot)))]))

(check-expect (ftc 86) 30)
(check-expect (ftc 14) -10)
(check-expect (ftc 68) 20)

(define (ftc ft)
  (/ (- ft 32) 1.8))

(define lot1 '())
(define lot2 (cons 23 (cons 1 '())))