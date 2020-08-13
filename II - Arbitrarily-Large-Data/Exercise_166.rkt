#lang racket

(check-expect (wage*.v4 '()) '())
(check-expect (wage*.v4 (cons (make-work (make-employee "Sam" 24) 8 4) (cons (make-work (make-employee "Ralph" 2) 12 8) '()))) (cons (make-paycheck (make-employee "Sam" 24) (* 8 4)) (cons (make-paycheck (make-employee "Ralph" 2) (* 12 8)) '())))

(define (wage*.v4 low)
  (cond
    [(empty? low) '()]
    [(cons? low) (cons (wage.v4 (first low)) (wage*.v4 (rest low)))]))

(check-expect (wage.v4 (make-work (make-employee "Albert" 89) 25 40)) (make-paycheck (make-employee "Albert" 89) (* 25 40)))
(check-error (wage.v4 123) "Invalid Input")

(define (wage.v4 w)
  (if
   (work? w)
   (make-paycheck (work-employee w) (* (work-rate w) (work-hours w)))
   (error "Invalid Input")))
(define-struct employee [name number])

(define EMPLOYEEex1 (make-employee "Sam" 23))
(define-struct work [employee rate hours])

(define WORKex1 (make-work (make-employee "Andreu" 23) 3 5))

(define low1 '())
(define low2 (cons (make-work (make-employee "Andreu" 23) 3 5) '()))

(define-struct paycheck [employee amount])

(define PAYCHECKex1 (make-paycheck (make-employee "Andreu" 23) 15))

(define lop1 '())
(define lop2 (cons (make-paycheck (make-employee "Andreu" 23) 15) '()))