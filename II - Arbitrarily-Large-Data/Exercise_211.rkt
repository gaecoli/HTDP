#lang racket

(define DICTIONARY-LOCATION "dictionary.txt")

(define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))

(check-expect (in-dictionary '()) '())
(check-expect (in-dictionary (list "apple")) (list "apple"))
(check-expect (in-dictionary (list "asdfg")) '())
(check-expect (in-dictionary (list "apple" "grape")) (list "apple" "grape"))
(check-expect (in-dictionary (list "apple" "asdfg" "grape")) (list "apple" "grape"))

(define (in-dictionary los)
  (cond
    [(empty? los) '()]
    [else (if (string-in-los? (first los) DICTIONARY-AS-LIST)
              (cons (first los) (in-dictionary (rest los)))
              (in-dictionary (rest los)))]))


(check-expect (string-in-los? "cat" '()) #false)
(check-expect (string-in-los? "a" (list "q" "w" "e" "r" "t" "y")) #false)
(check-expect (string-in-los? "rat" (list "dog" "rat" "cat")) #true)
(check-expect (string-in-los? "apple" DICTIONARY-AS-LIST) #true)

(define (string-in-los? s los)
  (cond
    [(empty? los) #false]
    [(string=? s (first los)) #true]
    [else (string-in-los? s (rest los))]))

(check-expect (string->word "") '())
(check-expect (string->word "cat") (list "c" "a" "t"))

(define (string->word s)
  (explode s))

(check-expect (words->strings '()) '())
(check-expect (words->strings (list (list "abcd"))) (list "abcd"))
(check-expect (words->strings (list (list "c" "a" "t") (list "r" "a" "t"))) (list "cat" "rat"))

(define (words->strings low)
  (cond
    [(empty? low) '()]
    [else (cons (word->string (first low)) (words->strings (rest low)))]))

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