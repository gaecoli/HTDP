#lang racket

(define A-DATE1 (create-date 2011 1 7 10 25 35))
(define A-DATE2 (create-date 2014 11 18 20 11 50))
(define A-DATE3 (create-date 2015 12 27 30 0 1))
(define A-DATE4 (create-date 2016 12 28 20 10 1))
(define P-DATE1 (create-date 2018 5 17 20 20 34))
(define P-DATE2 (create-date 2018 8 23 30 40 50))
(define P-DATE3 (create-date 2018 9 11 12 13 14))
(define P-DATE4 (create-date 2018 10 2 10 0 0))

(define TRACK1
  (create-track "Brass in Pocket" "Chrissie Hynde" "The Pretenders"
                37000 10 A-DATE1 12 P-DATE1))
(define TRACK2
  (create-track "I Love Rock'N Roll" "Joan Jett" "I Love Rock'N Roll"
                32000 1 A-DATE2 14 P-DATE2))
(define TRACK3
  (create-track "Suzanne" "Leonard Cohen" "Songs by Leonard Cohen"
                48000 3 A-DATE3 20 P-DATE3))
(define TRACK4
  (create-track "Crimson and Clover" "Joan Jet" "I Love Rock'N Roll"
                45000 5 A-DATE4 21 P-DATE4))
(define TRACK5
  (create-track "Precious" "Chrissie Hynde" "The Pretenders"
                35000 10 A-DATE2 10 P-DATE2))

(define LTRACK0 '())
(define LTRACK1 (list TRACK1))
(define LTRACK2 (list TRACK1 TRACK2 TRACK3))
(define LTRACK3 (list TRACK1 TRACK2 TRACK3 TRACK4 TRACK5))

(check-expect (select-album-titles/unique LTRACK0) '())
(check-expect (select-album-titles/unique (list TRACK1)) (list (track-album TRACK1)))
(check-expect (select-album-titles/unique LTRACK3) (list "The Pretenders" "I Love Rock'N Roll" "Songs by Leonard Cohen"))

(define (select-album-titles/unique lt)
  (create-set (select-all-album-titles lt)))


(check-expect (select-all-album-titles LTRACK0) '())
(check-expect (select-all-album-titles (list TRACK1)) (list (track-album TRACK1)))
(check-expect (select-all-album-titles (list TRACK1 TRACK2 TRACK3)) (list (track-album TRACK1) (track-album TRACK2) (track-album TRACK3)))

(define (select-all-album-titles lt)
  (cond
    [(empty? lt) '()]
    [else (cons (track-album (first lt)) (select-all-album-titles (rest lt)))]))

(check-expect (create-set '()) '())
(check-expect (create-set (list "abcde")) (list "abcde"))
(check-expect (create-set (list "aa" "bb" "aa" "aa" "cc" "bb" "cc" "aa" "bb" "cc" "dd" "dd")) (list "aa" "bb" "cc" "dd"))

(define (create-set los)
  (cond
    [(empty? los) '()]
    [else (cons (first los) (create-set (create-set* (first los) (rest los))))]))


(check-expect (create-set* "aa" '()) '())
(check-expect (create-set* "aa" (list "aa" "bb" "cc" "aa" "aa" "bb" "dd")) (list "bb" "cc" "bb" "dd"))

(define (create-set* s los)
  (cond
    [(empty? los) '()]
    [else (if (equal? s (first los))
              (create-set* s (rest los))
              (cons (first los) (create-set* s (rest los))))]))


(check-expect (total-time LTRACK0) 0)
(check-expect (total-time (list TRACK1)) (track-time TRACK1))
(check-expect (total-time (list TRACK1 TRACK2 TRACK3)) (+ (track-time TRACK1) (track-time TRACK2) (track-time TRACK3)))

(define (total-time lt)
  (cond
    [(empty? lt) 0]
    [else (+ (track-time (first lt)) (total-time (rest lt)))]))