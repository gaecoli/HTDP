#lang racket

(define HEIGHT 20) ; the height of the editor 
(define WIDTH 200) ; its width 
(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color 
 
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))

(check-expect (editor-text '()) (text "" FONT-SIZE FONT-COLOR))
(check-expect (editor-text (cons "p" (cons "o" (cons "s" (cons "t" '()))))) (text "post" FONT-SIZE FONT-COLOR))

(define (editor-text s)
  (text (cts s) FONT-SIZE FONT-COLOR))


(check-expect (cts '()) "")
(check-expect (cts (cons "p" (cons "o" (cons "s" (cons "t" '()))))) "post")

(define (cts s)
  (cond
    [(empty? cts) ""]
    [else (string-append (first cts) (editor-text (rest cts)))]))