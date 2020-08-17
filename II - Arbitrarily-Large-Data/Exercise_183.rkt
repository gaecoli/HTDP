#lang racket

(check-expect (cons "a" (cons 0 (cons #false '())))
              (cons "a" (list 0 #false)))

(check-expect (list "a" 0 #false)
              (cons "a" (list 0 #false)))

(check-expect (cons (cons 1 (cons 13 '())) '())
              (list (cons 1 (cons 13 '()))))

(check-expect (list (list 1 13))
              (list (cons 1 (cons 13 '()))))

(check-expect (cons (cons 1 (cons (cons 13 (cons '() '())) '())) '())
              (cons (list 1 (list 13 '())) '()))

(check-expect (list (list 1 (list 13 '())))
              (cons (list 1 (list 13 '())) '()))

(check-expect (cons '() (cons '() (cons (cons 1 '()) '())))
              (list '() '() (cons 1 '())))

(check-expect (list '() '() (list 1))
              (list '() '() (cons 1 '())))

(check-expect (cons "a" (cons (cons 1 '()) (cons #false (cons '() '())) ))
              (cons "a" (cons (list 1) (list #false '()))))

(check-expect (list "a" (list 1) #false '())
              (cons "a" (cons (list 1) (list #false '()))))