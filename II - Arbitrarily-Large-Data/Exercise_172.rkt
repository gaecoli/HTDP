#lang racket

(check-expect (collapse '()) "")
(check-expect (collapse (cons (cons "First line" '()) (cons (cons "Second line" '()) (cons (cons "Third line" '()) '())))) "First line\nSecond line\nThird line")

(define (collapse lls)
  (cond [(empty? lls) ""]
        [else
         (if (= (length (rest lls)) 0)
             (append-strings (first lls))
             (string-append  (append-strings (first lls)) "\n"
                             (collapse (rest lls))))]))

(check-expect (append-strings '()) "")
(check-expect (append-strings (cons "ab" '())) "ab")
(check-expect (append-strings (cons "abc" (cons "def" (cons "ghi" '())))) "abc def ghi")

(define (append-strings los)
  (cond [(empty? los) ""]
        [else
         (if (= (length (rest los)) 0) (first los)
             (string-append (first los) " "
                            (append-strings (rest los))))]))

(define los1 '())
(define los2 (cons "black" '()))

(define lls1 '())
(define lls2 (cons los2 (cons los1 '())))