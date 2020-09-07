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

(define (create-name str)
  (list "name" str))


(define (create-artist str)
  (list "artist" str))


(define (create-album str)
  (list "album" str))

(define (create-time num)
  (list "time" num))


(define (create-track# num)
  (list "track#" num))


(define (create-added dt)
  (list "added" dt))

(define (create-play# num)
  (list "play#" num))

(define (create-played dt)
  (list "played" dt))


(define A-TRACK1
  (list (create-name "Brass in Pocket")
        (create-artist "Chrissie Hynde")
        (create-album "The Pretenders")
        (create-time 37000)
        (create-track# 10)
        (create-added A-DATE1)
        (create-play# 12)
        (create-played  P-DATE1)))

(define A-TRACK2
  (list (create-name "I Love Rock'N Roll")
        (create-artist "Joan Jett" )
        (create-album "I Love Rock'N Roll")
        (create-time 32000)
        (create-track# 1)
        (create-added A-DATE2)
        (create-play# 14)
        (create-played P-DATE2)))

(define A-TRACK3
  (list (create-name "Suzanne")
        (create-artist "Leonard Cohen")
        (create-album "Songs by Leonard Cohen")
        (create-time 48000)
        (create-track# 3)
        (create-added A-DATE3)
        (create-play# 20)
        (create-played P-DATE3)))

(define A-TRACK4
  (list (create-name "Crimson and Clover")
        (create-artist "Joan Jet")
        (create-album "I Love Rock'N Roll")
        (create-time 45000)
        (create-track# 5)
        (create-added A-DATE4)
        (create-play# 21)
        (create-played P-DATE4)))

(define A-TRACK5
  (list (create-name "Precious")
        (create-artist "Chrissie Hynde")
        (create-album "The Pretenders")
        (create-time 35000)
        (create-track# 10)
        (create-added A-DATE2)
        (create-play# 10)
        (create-played  P-DATE2)))

(define LATRACK1 (list A-TRACK1))
(define LATRACK2 (list A-TRACK1 A-TRACK2 A-TRACK3))
(define LATRACK3 (list A-TRACK1 A-TRACK2 A-TRACK3 A-TRACK4 A-TRACK5))


(check-expect (find-association "name" A-TRACK1 "no") (list "name" "Brass in Pocket"))
(check-expect (find-association "album" A-TRACK1 "no") (list "album" "The Pretenders"))
(check-expect (find-association "played" A-TRACK1 "no") (list "played" P-DATE1))
(check-expect (find-association "abcde" A-TRACK1 "no") "no")

(define (find-association key las default)
  (cond
    [(empty? las) default]
    [(string=? key (first (first las))) (first las)]
    [else (find-association key (rest las) default)]))