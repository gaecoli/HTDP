#lang racket

(check-expect (list (string=? "a" "b") #false)
              (list #false #false))

(check-expect (list (string=? "a" "b") #false)
              (cons #false (cons #false '())))

(check-expect (list (+ 10 20) (* 10 20) (/ 10 20))
              (list 30 200 0.5))

(check-expect (list (+ 10 20) (* 10 20) (/ 10 20))
              (cons 30 (cons 200 (cons 0.5 '()))))

(check-expect (list "dana" "jane" "mary" "laura")
              (cons "dana" (cons "jane" (cons "mary" (cons "laura" '())))))