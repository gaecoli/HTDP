#lang racket
(define x 3)
(define y 4)
(define ret (+ (* x x) (* y y)))	;求解举例原点之间的距离平方

(sqrt ret)	;求平方根
