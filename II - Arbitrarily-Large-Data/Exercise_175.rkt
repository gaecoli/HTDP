#lang racket

(define-struct results [lines words letters])

(define RESULT0 (make-results 0 0 0)) ; no resutls

(define (fun-for-results res)
  (... (results-lines res)
       (results-words res)
       (results-letters res)))

(check-expect (wc '()) (make-results 0 0 0))
(check-expect (wc (cons (cons "aaa" (cons "bb" '()))
                        (cons (cons "cccc" '())
                        '())))
              (make-results 2 3 9))

(define (wc lls)
  (make-results (length lls)
                (count-words lls)
                (count-chars lls)))

(check-expect (count-words '()) 0)
(check-expect (count-words (cons (cons "aaa" (cons "bb" '()))
                                 (cons (cons "cccc" '())
                                       '())))
              3)

(define (count-words lls)
  (cond [(empty? lls) 0]
        [else
         (+ (length (first lls))
            (count-words (rest lls)))]))


(check-expect (count-chars '()) 0)
(check-expect (count-chars (cons (cons "aaa" (cons "bb" '()))
                                 (cons (cons "cccc" '())
                                       '())))
              9)

(define (count-chars lls)
  (cond ([empty? lls] 0)
        [else
         (+ (chars-line (first lls))
            (count-chars (rest lls)))]))

(check-expect (chars-line '()) 0)
(check-expect (chars-line (cons "aaa" (cons "bb" '()))) 5)

(define (chars-line los)
  (cond ([empty? los] 0)
        [else
         (+ (string-length (first los))
            (chars-line (rest los)))]))