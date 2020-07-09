#lang racket

(check-expect (area-of-disk 2) 12.56)

(define (area-of-disk r)
  (* 3.14 (* r r)))

(define (checked-f v)
  (cond
    [(number? v) ...]
    [(boolean? v) ...]
    [(string? v) ...]
    [(image? v) ...]
    [(posn? v) (...(posn-x v) ... (posn-y v) ...)]
    ...
    [(tank? v) ...]
    ...))

(check-expect (checked-area-of-disk 2) 12.56)
(check-error (checked-area-of-disk -2) ERRORMSG)
(check-error (checked-area-of-disk #true) ERRORMSG)
(check-error (checked-area-of-disk (make-posn 2 3)) ERRORMSG)

(define (checked-area-of-disk v)
  (cond
    [(and (number? v) (>= v 0)) (area-of-disk v)]
    [else (error ERRORMSG)]))

(define ERRORMSG "area-of-disk: number expected")