#lang racket

(check-within (tabulate sin 5) (tab-sin 5) 0.000001)
(check-within (tabulate sqrt 5) (tab-sqrt 5) 0.000001)

(define (tabulate g n)
  (cond
    [(= n 0) (list (g 0))]
    [else
     (cons
      (g n)
      (tabulate g (sub1 n)))]))


(check-expect (tab-sqr 3) (list 9 4 1 0))

(define (tab-sqr n)
  (tabulate sqr n))

(check-within (tab-tan 3) (list (tan 3) (tan 2) (tan 1) (tan 0)) 0.000001)

(define (tab-tan n)
  (tabulate tan n))


(define (tab-sin n)
  (cond
    [(= n 0) (list (sin 0))]
    [else
     (cons
      (sin n)
      (tab-sin (sub1 n)))]))

(define (tab-sqrt n)
  (cond
    [(= n 0) (list (sqrt 0))]
    [else
     (cons
      (sqrt n)
      (tab-sqrt (sub1 n)))]))