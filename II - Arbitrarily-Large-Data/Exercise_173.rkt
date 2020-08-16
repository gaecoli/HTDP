#lang racket

(define (remove-articles-file fn)
  (write-file (string-append "no-articles-" fn)
              (collapse (remove-articles (read-words/line fn)))))


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


(check-expect (remove-articles '()) '())
(check-expect (remove-articles (cons (cons "the" '()) '())) (cons '() '()))
(check-expect (remove-articles (cons (cons "idea" '()) '())) (cons (cons "idea" '()) '()))
(check-expect (remove-articles (cons (cons "the" (cons "girl" '())) (cons (cons "with" (cons "an" (cons "idea" '()))) '())))
              (cons (cons "girl" '()) (cons (cons "with" (cons "idea" '())) '())))

(define (remove-articles lls)
  (cond [(empty? lls) '()]
        (else
         (cons (remove-articles-line (first lls))
               (remove-articles (rest lls))))))

(check-expect (remove-articles-line '()) '())
(check-expect (remove-articles-line (cons "a" (cons "man" (cons "and" (cons "an" (cons "idea" '()))))))
              (cons "man" (cons "and" (cons "idea" '()))))

(define (remove-articles-line los)
  (cond [(empty? los) '()]
        [else
         (if (article? (first los))
             (remove-articles-line (rest los))
             (cons (first los)
                   (remove-articles-line (rest los))))]))

(check-expect (article? "and") #false)
(check-expect (article? "a") #true)
(check-expect (article? "an") #true)
(check-expect (article? "the") #true)

(define (article? s)
  (or (string=? s "a")
      (string=? s "an")
      (string=? s "the")))

(define los1 '())
(define los2 (cons "black" '()))

(define lls1 '())
(define lls2 (cons los2 (cons los1 '())))