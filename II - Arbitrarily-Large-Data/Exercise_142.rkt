#lang racket

(check-expect (ill-sized? '() 5) #false)
(check-expect (ill-sized? (cons (square 8 "solid" "red") '()) 8) #false)
(check-expect (ill-sized? (cons (rectangle 2 5 "solid" "red") '()) 2) (rectangle 2 5 "solid" "red"))
(check-expect (ill-sized? (cons (square 4 "solid" "black") (cons (circle 1 "solid" "white") '())) 4) (circle 1 "solid" "white"))

(define (ill-sized? loi n)
  (cond
    [(empty? loi) #false]
    [else (if (and (not (= (image-width (first loi)) (image-height (first loi)) n)) (not (empty? loi)))
              (first loi)
              (ill-sized? (rest loi) n))]))

(define list-of-images1 '())
(define list-of-images2 (cons (rectangle 5 2 "solid" "white") '()))

(define imageorfalse1 (circle 2 "solid" "red"))
(define imageorfalse2 #false)