#lang racket

(check-expect (col 0 (circle 8 "solid" "red")) empty-image)
(check-expect (col 1 (circle 8 "solid" "red")) (circle 8 "solid" "red"))
(check-expect (col 2 (circle 8 "solid" "red")) (above (circle 8 "solid" "red") (circle 8 "solid" "red")))

(define (col n img)
  (cond
    [(equal? n 0) empty-image]
    [else (above img (col (sub1 n) img))]))

(check-expect (row 0 (circle 6 "solid" "red")) empty-image)
(check-expect (row 1 (circle 6 "solid" "red")) (circle 6 "solid" "red"))
(check-expect (row 2 (circle 6 "solid" "red")) (beside (circle 6 "solid" "red") (circle 6 "solid" "red")))

(define (row n img)
  (cond
    [(equal? n 0) empty-image]
    [else (beside img (row (sub1 n) img))]))

(define N1 0)
(define N2 5)