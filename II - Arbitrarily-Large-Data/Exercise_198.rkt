#lang racket

(define AS-LIST (read-lines "dictionary.txt")) ; I downloaded a dictionary.txt
(define LITTLE-DICT (list "this" "is" "a" "little" "dictionary" "to" "test" "functions"))

(define lod1 (list (list "a") (list "dictionary") (list "functions") (list "is") (list "little") (list "this" "to" "test")))


(define-struct lettercounts (letter counts))

(define lettercounts1 (make-lettercounts "a" 25)) ; Letter "a" is used 25 times as the first letter of a word

(define lolc1 '())
(define lolc2 (cons lettercounts1 '()))

(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))


(check-expect (most-frequent.v2 LITTLE-DICT) (most-frequent LITTLE-DICT))

(define (most-frequent.v2 d)
  (first (sort-lolc (countlist (words-by-first-letter d)))))

(check-expect (countlist '()) '())
(check-expect (countlist (list (list "aa" "aaa" "asd") (list "b" "bbb") (list "cc")))
              (list (make-lettercounts "a" 3) (make-lettercounts "b" 2) (make-lettercounts "c" 1)))

(define (countlist lod)
  (cond
    [(empty? lod) '()]
    [else (cons (make-lettercounts (first (explode (first (first lod)))) (length (first lod))) (countlist (rest lod)))]))


(check-expect (words-by-first-letter LITTLE-DICT) lod1)
(check-expect (words-by-first-letter (list "aa" "b" "cc" "aaa" "d" "dd" "bbb"))
              (list (list "aa" "aaa") (list "b" "bbb") (list "cc") (list "d" "dd")))

(define (words-by-first-letter d)
  (words-by-first-letter* LETTERS d))

(check-expect (words-by-first-letter* LETTERS LITTLE-DICT) lod1)
(check-expect (words-by-first-letter* (list "t" "i" "z") LITTLE-DICT) (list (list "this" "to" "test") (list "is")))

(define (words-by-first-letter* lol d)
  (cond
    [(empty? lol) '()]
    [else (if (equal? (words-by (first lol) d) '())
              (words-by-first-letter* (rest lol) d)
              (cons (words-by (first lol) d) (words-by-first-letter* (rest lol) d)))]))

(check-expect (words-by "z" LITTLE-DICT) '())
(check-expect (words-by "t" LITTLE-DICT) (list "this" "to" "test"))
(check-expect (words-by "i" LITTLE-DICT) (list "is"))
(check-expect (words-by "a" (list "abcd" "abc" "b")) (list "abcd" "abc"))

(define (words-by l d)
  (cond
    [(empty? d) '()]
    [else (if (string=? l (first (explode (first d))))
              (cons (first d) (words-by l (rest d)))
              (words-by l (rest d)))]))

(check-expect (most-frequent LITTLE-DICT) (start-withlc "t" LITTLE-DICT))
(check-expect (most-frequent (list "aa" "aa" "aa" "bb" "cc" "bb")) (make-lettercounts "a" 3))

(define (most-frequent d)
  (first (sort-lolc (count-by-letter d))))

(check-expect (sort-lolc (list (make-lettercounts "a" 8) (make-lettercounts "b" 4) (make-lettercounts "e" 15) (make-lettercounts "z" 0)))
              (list (make-lettercounts "e" 15) (make-lettercounts "a" 8) (make-lettercounts "b" 4) (make-lettercounts "z" 0)))

(define (sort-lolc lolc)
  (cond
    [(empty? lolc) '()]
    [else (sort-lolc* (first lolc) (sort-lolc (rest lolc)))]))


(check-expect (sort-lolc* (make-lettercounts "g" 4) '()) (list (make-lettercounts "g" 4)))
(check-expect (sort-lolc* (make-lettercounts "f" 6) (list (make-lettercounts "a" 10) (make-lettercounts "z" 2)))
              (list (make-lettercounts "a" 10) (make-lettercounts "f" 6) (make-lettercounts "z" 2)))
(check-expect (sort-lolc* (make-lettercounts "f" 1) (list (make-lettercounts "a" 10) (make-lettercounts "z" 2)))
              (list (make-lettercounts "a" 10) (make-lettercounts "z" 2) (make-lettercounts "f" 1)))

(define (sort-lolc* lc lolc)
  (cond
    [(empty? lolc) (cons lc '())]
    [else (if (>= (lettercounts-counts lc) (lettercounts-counts (first lolc)))
              (cons lc lolc)
              (cons (first lolc) (sort-lolc* lc (rest lolc))))]))


(check-expect (count-by-letter LITTLE-DICT) (count-by-letter* LETTERS LITTLE-DICT))

(define (count-by-letter d)
  (count-by-letter* LETTERS d))


(check-expect (count-by-letter* '() LITTLE-DICT) '())
(check-expect (count-by-letter* (list "a" "t" "z") LITTLE-DICT)
              (list (start-withlc "a" LITTLE-DICT) (start-withlc "t" LITTLE-DICT) (start-withlc "z" LITTLE-DICT)))

(define (count-by-letter* ll d)
  (cond
    [(empty? ll) '()]
    [else (cons (start-withlc (first ll) d) (count-by-letter* (rest ll) d))]))


(check-expect (start-withlc "a" LITTLE-DICT) (make-lettercounts "a" (starts-with# "a" LITTLE-DICT)))
(check-expect (start-withlc "t" LITTLE-DICT) (make-lettercounts "t" (starts-with# "t" LITTLE-DICT)))

(define (start-withlc l d)
  (make-lettercounts l (starts-with# l d)))


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