#lang racket

(define one-list
  '("Asia: Heat of the Moment"
    "U2: One"
    "The White Stripes: Seven Nation Army"))

(define (ranking los)
  (reverse (add-ranks (reverse los))))

(define (add-ranks los)
  (cond
    [(empty? los) '()]
    [else (cons (list (length los) (first los))
                (add-ranks (rest los)))]))