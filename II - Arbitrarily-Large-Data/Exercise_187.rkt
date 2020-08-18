#lang racket

(define-struct gp [name score])

(check-expect (sortlog> '()) '())
(check-expect (sortlog> (list (make-gp "Sam" 52))) (list (make-gp "Sam" 52)))
(check-expect (sortlog> (list (make-gp "Sam" 52) (make-gp "Pau" 99) (make-gp "Andreu" 12))) (list (make-gp "Pau" 99) (make-gp "Sam" 52) (make-gp "Andreu" 12)))

(define (sortlog> log)
  (cond
    [(empty? log) '()]
    [(cons? log) (sortscore (first log) (sortlog> (rest log)))]))


(check-expect (sortscore (make-gp "Sam" 5) '()) (list (make-gp "Sam" 5)))
(check-expect (sortscore (make-gp "Sam" 23) (list (make-gp "Andreu" 50))) (list (make-gp "Andreu" 50) (make-gp "Sam" 23)))
(check-expect (sortscore (make-gp "Sam" 40) (list (make-gp "Andreu" 50) (make-gp "Pau" 10))) (list (make-gp "Andreu" 50) (make-gp "Sam" 40) (make-gp "Pau" 10)))

(define (sortscore gp log)
  (cond
    [(empty? log) (cons gp '())]
    [else (if (>= (gp-score gp) (gp-score (first log)))
              (cons gp log)
              (cons (first log) (sortscore gp (rest log))))]))