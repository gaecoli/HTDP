#lang racket

(check-expect (argmax second (list (list "a" 4) (list "b" 2) (list "c" 9) (list "d" 5)))
              (list "c" 9))
