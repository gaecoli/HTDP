(define-struct email [from date message])

; A List-of-email or loe is one of:
; - '()
; - (cons email loe)


; List-of-email -> List-of-email
; Sorts lists of emails by date
#lang racket

(check-expect (sortmaild '()) '())
(check-expect (sortmaild (list (make-email "Sam" 50 "hellow"))) (list (make-email "Sam" 50 "hellow")))
(check-expect (sortmaild (list (make-email "Sam" 50 "hellow") (make-email "Andreu" 2 "abcde") (make-email "Pau" 25 "ab")))
              (list (make-email "Andreu" 2 "abcde") (make-email "Pau" 25 "ab") (make-email "Sam" 50 "hellow")))

(define (sortmaild loe)
  (cond
    [(empty? loe) '()]
    [(cons? loe) (sortdate (first loe) (sortmaild (rest loe)))]))

(check-expect (sortdate (make-email "Sam" 50 "hellow") '()) (list (make-email "Sam" 50 "hellow")))
(check-expect (sortdate (make-email "Sam" 10 "hellow") (list (make-email "Andreu" 30 "abcde"))) (list (make-email "Sam" 10 "hellow") (make-email "Andreu" 30 "abcde")))
(check-expect (sortdate (make-email "Sam" 10 "hellow") (list (make-email "Andreu" 5 "abcde") (make-email "Abc" 40 "qwe"))) (list (make-email "Andreu" 5 "abcde") (make-email "Sam" 10 "hellow") (make-email "Abc" 40 "qwe")))

(define (sortdate em loe)
  (cond
    [(empty? loe) (cons em '())]
    [else (if (<= (email-date em) (email-date (first loe)))
          (cons em loe)
          (cons (first loe) (sortdate em (rest loe))))]))

(check-expect (sortmailn '()) '())
(check-expect (sortmailn (list (make-email "Sam" 50 "hellow"))) (list (make-email "Sam" 50 "hellow")))
(check-expect (sortmailn (list (make-email "Sam" 50 "hellow") (make-email "Andreu" 2 "abcde") (make-email "Pau" 25 "ab")))
              (list (make-email "Andreu" 2 "abcde") (make-email "Pau" 25 "ab") (make-email "Sam" 50 "hellow")))

(define (sortmailn loe)
  (cond
    [(empty? loe) '()]
    [(cons? loe) (sortname (first loe) (sortmailn (rest loe)))]))


(check-expect (sortname (make-email "Sam" 50 "hellow") '()) (list (make-email "Sam" 50 "hellow")))
(check-expect (sortname (make-email "Sam" 10 "hellow") (list (make-email "Andreu" 30 "abcde"))) (list (make-email "Andreu" 30 "abcde") (make-email "Sam" 10 "hellow")))
(check-expect (sortname (make-email "Sam" 10 "hellow") (list (make-email "Andreu" 5 "abcde") (make-email "Tom" 40 "qwe"))) (list (make-email "Andreu" 5 "abcde") (make-email "Sam" 10 "hellow") (make-email "Tom" 40 "qwe")))

(define (sortname em loe)
  (cond
    [(empty? loe) (cons em '())]
    [else (if (string<? (email-from em) (email-from (first loe)))
          (cons em loe)
          (cons (first loe) (sortname em (rest loe))))]))