#lang racket

(define-struct vehicle [passenger lcs-plt fuel-con])
(define automobile
  (make-vehicle 4 "B5230" 20))
(define van
  (make-vehicle 8 "EA403" 15))
(define bus
  (make-vehicle 30 "J2007" 10))
(define SUV
  (make-vehicle 6 "EA304" 15))
(define truck
  (make-vehicle 2 "EJ3320" 12))

(check-expect (decide-car 20) bus)
(check-expect (decide-car 2) truck)
(check-expect (decide-car 8) van)
(check-expect (decide-car 5) SUV)
(check-expect (decide-car 3) automobile)
(check-expect (decide-car 100) #false)

(define (decide-car par-num)
  (cond [(<= par-num 2) truck]
        [(<= par-num 4) automobile]
        [(<= par-num 6) SUV]
        [(<= par-num 8) van]
        [(<= par-num 30) bus]
        [else #false]))