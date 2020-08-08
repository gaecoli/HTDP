#lang racket

(check-expect (add-balloons '()) LECTURE-HALL)
(check-expect (add-balloons (cons (make-posn 10 20) '())) (place-image BALLOON 10 20 LECTURE-HALL))
(check-expect (add-balloons (cons (make-posn 40 100) (cons (make-posn 10 20) '()))) (place-image BALLOON 40 100 (place-image BALLOON 10 20 LECTURE-HALL)))

(define (add-balloons lp)
  (cond
    [(empty? lp) LECTURE-HALL]
    [else (place-image BALLOON (posn-x (first lp)) (posn-y (first lp)) (add-balloons (rest lp)))]))

(define lp1 '())
(define lp2 (cons (make-posn 10 20) '()))

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

(define W-WIDTH 80)
(define H-W-WIDTH (/ W-WIDTH 2))
(define W-HEIGHT 180)
(define H-W-HEIGHT (/ W-HEIGHT 2))
(define EMSC (empty-scene W-WIDTH W-HEIGHT))
(define SQUARE-SIZE 10)
(define N-ROW 18)
(define N-COL 8)
(define BALLON-RAD 4)

(define BALLOON (circle BALLON-RAD "solid" "red"))
(define SQUARE (square SQUARE-SIZE "outline" "black"))
(define LECTURE-HALL (place-image (col N-ROW (row N-COL SQUARE)) H-W-WIDTH H-W-HEIGHT EMSC))