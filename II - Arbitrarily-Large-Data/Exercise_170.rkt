#lang racket

(check-expect (replace '()) '())
(check-expect (replace (cons (make-phone 123 321 2314) (cons (make-phone 713 713 6823) '()))) (cons (make-phone 123 321 2314) (cons (make-phone 281 713 6823) '())))

(define (replace loph)
  (cond
    [(empty? loph) '()]
    [else (cons (replace* (first loph))
                (replace (rest loph)))]))

(check-expect (replace* (make-phone 713 536 6987)) (make-phone 281 536 6987))
(check-expect (replace* (make-phone 654 456 9874)) (make-phone 654 456 9874))

(define (replace* ph)
  (make-phone (if (equal? (phone-area ph) 713)
                  281
                  (phone-area ph))
              (phone-switch ph) (phone-four ph)))

(define-struct phone [area switch four])

(define phoneex1 (make-phone 581 397 8162))

(define loph1 '())
(define loph2 (cons (make-phone 123 456 7890) '()))