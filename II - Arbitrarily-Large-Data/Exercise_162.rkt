#lang racket

(define SALARY 14)

(check-expect (wage* (cons 2 (cons 5 (cons 8 '())))) (cons (* 2 SALARY) (cons (* 5 SALARY) (cons (* 8 SALARY) '()))))
(check-error (wage* (cons 13 (cons 187 '()))) "Too much hours")

(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [(< (first whrs) 100) (cons (wage (first whrs)) (wage* (rest whrs)))]
    [else (error "Too much hours")]))
 
(check-expect (wage 5) (* 5 SALARY))

(define (wage h)
  (* SALARY h))