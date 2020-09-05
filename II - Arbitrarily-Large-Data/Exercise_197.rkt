#lang racket

(define AS-LIST (read-lines "dictionary.txt")) ; I downloaded a dictionary.txt
(define LITTLE-DICT (list "this" "is" "a" "little" "dictionary" "to" "test" "functions"))

(define-struct lettercounts (letter counts))

(define lettercounts1 (make-lettercounts "a" 25)) ; Letter "a" is used 25 times as the first letter of a word

(define lolc1 '())
(define lolc2 (cons lettercounts1 '()))


(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))


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

; List-of-letters Dictionary -> List-of-Letter-Counts
; Auxilar function for count-by-letter
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
