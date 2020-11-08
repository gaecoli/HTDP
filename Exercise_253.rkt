#lang racket

(check-expect (number? 5) #true)

(check-expect (equal? #true "abde") #false)

(check-expect (+ 1 2 3) 6)

(check-expect (list 5) (list 5))

(check-expect (list? '(1 2 3 4)) #true)