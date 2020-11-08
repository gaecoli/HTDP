#lang racket

(check-expect (extract < (cons 6 (cons 4 '())) 5) (list 4))
(check-expect (extract > (cons 6 (cons 4 '())) 5) (list 6))

(define (extract R l t)
  (cond
    [(empty? l) '()]
    [else (cond
            [(R (first l) t)
             (cons (first l)
                   (extract R (rest l) t))]
            [else
             (extract R (rest l) t)])]))

(extract < (cons 8 (cons 4 '())) 5)