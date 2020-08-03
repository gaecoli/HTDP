#lang racket

(define list-of-string1 '())
(define list-of-string2 (cons "abc" (cons "def" '())))

(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect (cat (cons "ab" (cons "cd" (cons "ef" '())))) "abcdef")
 
(define (cat l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l)
                         (cat (rest l)))]))

(cat (cons "a" '()))