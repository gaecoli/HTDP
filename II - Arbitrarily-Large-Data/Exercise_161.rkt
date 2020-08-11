#lang racket

(define SALARY 14)

(check-expect (wage* (cons 2 (cons 5 (cons 8 '())))) (cons (* 2 SALARY) (cons (* 5 SALARY) (cons (* 8 SALARY) '()))))

(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (cons (wage (first whrs)) (wage* (rest whrs)))]))

(check-expect (wage 5) (* 5 SALARY))

(define (wage h)
  (* SALARY h))