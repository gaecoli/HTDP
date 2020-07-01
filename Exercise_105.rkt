#lang racket

(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

(define MESSAGE
  "traffic light expected, given some other value")

(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)
(check-error  (light=? "yes" "blue"))
(check-error  (light=? "red" "yes"))
 
(define (light=? a-value another-value)
  (if (and (light? a-value) (light? another-value))
      (string=? a-value another-value)
      (if (not (light? a-value))
          (error
           "traffic light expected, 'a-value' given some other value")
          (error
           "traffic light expected, 'another-value' given some other value"))))