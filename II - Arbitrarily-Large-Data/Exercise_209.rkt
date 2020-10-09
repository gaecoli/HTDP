#lang racket

(check-expect (string->word "") '())
(check-expect (string->word "cat") (list "c" "a" "t"))

(define (string->word s)
  (explode s))


(check-expect (word->string '()) "")
(check-expect (word->string (list "c" "a" "t")) "cat")

(define (word->string w)
  (cond
    [(empty? w) ""]
    [else (string-append (first w) (word->string (rest w)))]))


(define LOW1 '())
(define LOW2 (list (list "a" "b" "c") (list "r" "a" "t")))

(define WORD1 '())
(define WORD2 (cons "c" (cons "a" (cons "t" '()))))
(define WORD3 (list "r" "a" "t"))