#lang racket

(define HEIGHT 220) ; distances in terms of pixels
(define WIDTH 30)
(define XSHOTS (- (/ WIDTH 2) 8))

(define BACKGROUND (rectangle WIDTH HEIGHT "solid" "green"))
(define SHOT (rectangle 6 10 "solid" "black"))


(define (main w0)
  (big-bang w0
    [on-tick tock]
    [on-key keyh]
    [to-draw to-image]))

(check-expect (tock '()) '())
(check-expect (tock (cons 4 (cons 14 '()))) (cons 3 (cons 13 '())))
(check-expect (tock (cons 25 (cons 18 (cons -12 (cons 1 (cons 4 '())))))) (cons 24 (cons 17 (cons 0 (cons 3 '())))))

(define (tock w)
  (cond
    [(empty? w) '()]
    [(> (first w) 0) (cons (sub1 (first w)) (tock (rest w)))]
    [else (tock (rest w))]))

(check-expect (keyh '() " ") (cons HEIGHT '()))
(check-expect (keyh (cons 6 (cons 9 (cons 14 '()))) " ") (cons HEIGHT (cons 6 (cons 9 (cons 14 '())))))
(check-expect (keyh (cons 12 '()) "e") (cons 12 '()))

(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))

(check-expect (to-image '()) BACKGROUND)
(check-expect (to-image (cons 5 (cons 1 '()))) (place-image SHOT XSHOTS 5 (place-image SHOT XSHOTS 1 BACKGROUND)))

(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOTS (first w)
                       (to-image (rest w)))]))


(define LON1 '())
(define LON2 (cons 2 (cons 6 '())))