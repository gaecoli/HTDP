#lang racket

(check-expect (encode-file "ttt.txt") (write-file (string-append "encoded-" "ttt.txt") (collapse (encode-lines (read-words/line "ttt.txt")))))

(define (encode-file fn)
  (write-file (string-append "encoded-" fn)
              (collapse (encode-lines (read-words/line fn)))))


(check-expect (encode-lines '()) '())
(check-expect (encode-lines (cons (cons "aa" '()) '())) (cons (cons "097097" '()) '()))

(define (encode-lines lls)
  (cond [(empty? lls) '()]
        [else
         (cons (encode-line (first lls))
               (encode-lines (rest lls)))]))

(check-expect (encode-line '()) '())
(check-expect (encode-line (cons "aa" (cons "bb" '()))) (cons "097097" (cons "098098" '())))

(define (encode-line los)
  (cond [(empty? los) '()]
        [else
         (cons (encode-word (explode (first los)))
               (encode-line (rest los)))]))

(check-expect (encode-word '()) "")
(check-expect (encode-word (cons "a" (cons "b" '()))) "097098")

(define (encode-word los)
  (cond [(empty? los) ""]
        [else
         (string-append (encode-letter (first los))
                        (encode-word (rest los)))]))

(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t") (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a") (string-append "0" (code1 "a")))

(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10)
     (string-append "00" (code1 s))]
    [(< (string->int s) 100)
     (string-append "0" (code1 s))]))

(check-expect (code1 "z") "122")

(define (code1 c)
  (number->string (string->int c)))

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

(define lo1s1 '())
(define lo1s2 (cons "b" '()))


(define lls1 '())
(define lls2 (cons los2 (cons los1 '())))