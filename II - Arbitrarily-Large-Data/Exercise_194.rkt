#lang racket

(define MT (empty-scene 100 100))

(define poly1 (cons (make-posn 20 40) (cons (make-posn 40 40) (cons (make-posn 20 60) '()))))
(define poly2 (cons (make-posn 7 11) poly1))


(define (render-polygon img p)
  (connect-dots img p (first p)))
 
(define (connect-dots img p p2)
  (cond
    [(empty? (rest p)) (render-line img (first p) p2)]
    [else (render-line (connect-dots img (rest p) p2)
                       (first p)
                       (second p))]))
 

(define (render-line im p q)
  (scene+line
    im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))

(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))