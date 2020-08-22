#lang racket

(define MT (empty-scene 100 100))
(define triangle-p (list (make-posn 20 0) (make-posn 10 10) (make-posn 30 10)))


(check-expect (connect-dots MT triangle-p)
              (scene+line
               (scene+line MT 20 0 10 10 "red")
               10 10 30 10 "red"))

(define (connect-dots img p)
  (cond
    [(empty? (rest p)) img]
    [else (render-line
           (connect-dots img (rest p))
           (first p)
           (second p))]))


(check-expect (render-line MT (make-posn 10 10) (make-posn 20 30))
              (scene+line MT 10 10 20 30 "red"))

(define (render-line img p q)
  (scene+line
   img
   (posn-x p) (posn-y p) (posn-x q) (posn-y q)
   "red"))