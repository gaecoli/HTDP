#lang racket

(define AS-LIST (read-lines "dictionary.txt")) 
(define LITTLE-DICT (list "this" "is" "a" "little" "dictionary" "to" "test" "functions"))
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))


(check-expect (starts-with# "z" LITTLE-DICT) 0)
(check-expect (starts-with# "a" LITTLE-DICT) 1)
(check-expect (starts-with# "t" LITTLE-DICT) 3)

(define (starts-with# l d)
  (cond
    [(empty? d) 0]
    [else (+ (countletter (first d) l) (starts-with# l (rest d)))]))


(check-expect (countletter "cat" "c") 1)
(check-expect (countletter "dog" "b") 0)

(define (countletter s l)
  (if
    (string=? l (first (explode s)))
    1
    0))