#lang racket

(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello")
              (cons "hello" (cons "hello" '())))

(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons s (copier (sub1 n) s))]))


(copier 5 "abc")
(copier 3 #true)
(copier 4 (circle 10 "solid" "black"))