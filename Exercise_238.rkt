#lang racket

(check-expect (inf-sup.v2 max (list 10 4 15 23 1 3 12 52 2)) 52)
(check-expect (inf-sup.v2 min (list 10 4 15 23 1 3 12 52 2)) 1)

(define (inf-sup.v2 f l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (f (first l) (inf-sup.v2 f (rest l)))]))

; Determines the smallest number on l
(check-expect (inf-2 (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
              1)
(check-expect (inf-2 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25))
              1)

(define (inf-2 l)
  (inf-sup.v2 min l))


(check-expect (sup-2 (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
              25)
(check-expect (sup-2 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25))
              25)

(define (sup-2 l)
  (inf-sup.v2 max l))

(check-expect (inf-sup > (list 5 4 3 23)) 23)
(check-expect (inf-sup < (list 1 4 2)) 1)

(define (inf-sup f l)
  (cond
    [(empty? (rest l)) (first l)]
    [else
     (if (f (first l)
            (inf-sup f (rest l)))
         (first l)
         (inf-sup f (rest l)))]))

(check-expect (inf-1 (list 5 1 2)) 1)

(define (inf-1 l)
  (inf-sup < l))

(check-expect (sup-1 (list 4 1 6)) 6)

(define (sup-1 l)
  (inf-sup > l))