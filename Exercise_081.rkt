#lang racket

(define-struct time [hours minutes seconds])

(check-expect (time->seconds (make-time 12 30 2)) 45002)
(define (time->seconds t)
  (+
   (* 60 60 (time-hours t))
   (* 60 (time-minutes t))
   (time-seconds t)))