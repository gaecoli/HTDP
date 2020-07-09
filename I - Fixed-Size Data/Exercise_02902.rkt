#lang racket

(define (profit price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price) (* 1.50 (+ 120 (* (/ 15 0.1)
            (- 5.0 price))))))

(profit 3)
(profit 4)
(profit 5)
