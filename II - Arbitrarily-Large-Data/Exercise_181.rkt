#lang racket

(check-expect (list "a" "b" "c" "d") (cons "a" (cons "b" (cons "c" (cons "d" '())))))

(check-expect (list (list 1 2)) (cons (cons 1 (cons 2 '())) '()))

(check-expect (list "a" (list 1) #false) (cons "a" (cons (cons 1 '()) (cons #false '()))))

(check-expect (list (list "a" 2) "hello") (cons (cons "a" (cons 2 '())) (cons "hello" '())))


(check-expect (list (list 1 2) (list 2)) (cons (cons 1 (cons 2 '())) (cons (cons 2 '()) '())))