#lang racket

(check-expect (prefixes '()) '())
(check-expect (prefixes (list "a")) (list (list "a")))
(check-expect (prefixes (list "a" "b")) (list (list "a") (list "a" "b")))
(check-expect (prefixes (list "a" "b" "c")) (list (list "a") (list "a" "b") (list "a" "b" "c")))

(define (prefixes lo1s)
  (prefixes-aux lo1s lo1s))


(define (prefixes-aux lo1s save)
  (cond [(empty? lo1s) '()]
        [else
         (cons (sl (first lo1s) save)
               (prefixes-aux (rest lo1s) save))]))


(check-expect (sl "a" (list "a" "b" "c")) (list "a"))
(check-expect (sl "b" (list "a" "b" "c")) (list "a" "b"))
(check-expect (sl "c" (list "a" "b" "c")) (list "a" "b" "c"))

(define (sl s l)
  (cond
    [(string=? s (first l)) (list s)]
    [else (cons (first l) (sl s (rest l)))]))