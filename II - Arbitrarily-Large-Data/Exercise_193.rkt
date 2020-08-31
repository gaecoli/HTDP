#lang racket

(define MT (empty-scene 100 100))

(define poly1 (cons (make-posn 20 40) (cons (make-posn 40 40) (cons (make-posn 20 60) '()))))
(define poly2 (cons (make-posn 7 11) poly1))

(define (render-polygon1 img p)
  (connect-dots img (lastp poly1)))


(define (render-polygon2 img p)
  (connect-dots img (add-at-end (first p) p)))

(check-expect (add-at-end (first poly1) poly1) (cons (make-posn 20 40) (cons (make-posn 40 40) (cons (make-posn 20 60) (cons (make-posn 20 40) '())))))

(define (add-at-end pos p)
  (cond
    [(empty? (rest p)) (cons (first p) (cons  pos '()))]
    [else (cons (first p) (add-at-end pos (rest p)))]))


(check-expect (lastp poly1) (cons (last* poly1) poly1))

(define (lastp p)
  (cons (last* p) p))


(check-expect (last* (list (make-posn 2 3))) (make-posn 2 3))
(check-expect (last* (list (make-posn 1 3) (make-posn 4 3) (make-posn 7 0))) (make-posn 7 0))
(check-expect (last* poly1) (make-posn 20 60))
(check-expect (last* poly2) (make-posn 20 60))

(define (last* p)
  (cond
    [(empty? (rest p)) (first p)]
    [else (last* (rest p))]))


(define (connect-dots img p)
  (cond
    [(empty? (rest p)) MT]
    [else (render-line (connect-dots img (rest p))
                       (first p)
                       (second p))]))

(define (render-line im p q)
  (scene+line
    im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))