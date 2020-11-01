#lang racket

(define NELT1 (cons 20 '()))
(define NELT2 (cons 5 (cons 10 '())))

(define NELB1 (cons #true '()))
(define NELB2 (cons #true (cons #false '())))


(define NEL-T1 NELT1)
(define NEL-T2 NELT2)


(define NEL-B1 NELB1)
(define NEL-B2 NELB2)