#lang racket

(check-expect (contains-atom? '("abcd" "efgh" "ijkl")) #false)
(check-expect (contains-atom? '("abcd" "atom" "efgh")) #true)

(define (contains-atom? l)
  (contains? "atom" l))

(check-expect (contains-basic? '("abcd" "efgh" "ijkl")) #false)
(check-expect (contains-basic? '("abcd" "basic" "efgh")) #true)

(define (contains-basic? l)
  (contains? "basic" l))

(check-expect (contains-zoo? '("abcd" "efgh" "ijkl")) #false)
(check-expect (contains-zoo? '("abcd" "zoo" "efgh")) #true)

(define (contains-zoo? l)
  (contains? "zoo" l))


(define (contains? s l)
  (cond
    [(empty? l) #false]
    [else (or (string=? (first l) s)
              (contains? s (rest l)))]))
