#lang racket

(define STANDARDTICKETPRICE 5)
(define AVERAGEATTENDANCE 120)
(define CHANGEINTICKETPRICE .10)
(define CHANGEINAVERAGEATTENDANCE 15)
(define FIXEDCOSTPERPERFORMANCE 180)
(define VARIABLECOSTPERATTENDEE .04)

(define PRICESENSITIVITY
  (/ CHANGEINAVERAGEATTENDANCE CHANGEINTICKETPRICE))
  

(define (attendees ticket-price)
  (- AVERAGEATTENDANCE (* (- ticket-price STANDARDTICKETPRICE) PRICESENSITIVITY)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXEDCOSTPERPERFORMANCE (* VARIABLECOSTPERATTENDEE (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))
	 
;;
(profit 3)