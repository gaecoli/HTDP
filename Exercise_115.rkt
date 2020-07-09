#lang racket

(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))


(define MESSAGE1
  "First value is not a TrafficLight value")
(define MESSAGE2
  "Second value is not a TrafficLight value")

(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)
(check-error (light=? "blue" "yellow") MESSAGE1)
(check-error (light=? "yellow" 2) MESSAGE2)
 
(define (light=? a-value another-value)
  (if (and (light? a-value) (light? another-value))
      (string=? a-value another-value)
      (if
       (light? a-value)
       (error MESSAGE2)
       (error MESSAGE1))))