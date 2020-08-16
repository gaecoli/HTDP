#lang racket

(define-struct editor [pre post])

(check-expect (create-editor "hello" "world") (make-editor (cons "o" (cons "l" (cons "l" (cons "e" (cons "h" '()))))) (cons "w" (cons "o" (cons "r" (cons "l" (cons "d" '())))))))

(define (create-editor s1 s2)
  (make-editor (rev (explode s1)) (explode s2)))


(check-expect
 (rev (cons "a" (cons "b" (cons "c" '()))))
 (cons "c" (cons "b" (cons "a" '()))))

(define (rev l)
  (cond
    [(empty? l) '()]
    [else (add-at-end (rev (rest l)) (first l))]))

(check-expect (add-at-end '() "z") (cons "z" '()))
(check-expect (add-at-end (cons "c" (cons "b" '())) "a") (cons "c" (cons "b" (cons "a" '()))))

(define (add-at-end l s)
  (cond
    [(empty? l) (cons s '())]
    [else (cons (first l) (add-at-end (rest l) s))]))