#lang racket

(check-expect (substitute "abc" "qwe" '()) '())
(check-expect (substitute "black" "white" (cons "orange" (cons "black" (cons "white" '())))) (cons "orange" (cons "white" (cons "white" '()))))

(define (substitute old new los)
  (cond
    [(empty? los) '()]
    [else (cons (if (equal? old (first los)) new (first los)) (substitute old new (rest los)))]))

(define los1 '())
(define los2 (cons "orange" (cons "laptop" '())))

(check-expect (subst-robot '()) '())
(check-expect (subst-robot (cons "lego" (cons "robot" (cons "spiderman" (cons "robot" '()))))) (cons "lego" (cons "r2d2" (cons "spiderman" (cons "r2d2" '())))))

(define (subst-robot lot)
  (cond
    [(empty? lot) '()]
    [else (cons (sconv (first lot)) (subst-robot (rest lot)))]))

(check-expect (sconv "robot") "r2d2")
(check-expect (sconv "lego") "lego")

(define (sconv s)
  (if
   (string=? "robot" s)
   "r2d2"
   s))

(define lot1 '())
(define lot2 (cons "lego" (cons "robot" '())))