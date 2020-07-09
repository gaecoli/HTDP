#lang racket

(define standardticketprice 5.0)
(define averageattendance 120)
(define changeinticketprice .10)
(define changeinaverageattendance 15)
(define fixedcostperperformance 180)
(define variablecostperattendee .04)

(define (attendees ticket-price)
  (- averageattendance (* (- ticket-price standardticketprice) (/ changeinaverageattendance changeinticketprice))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ fixedcostperperformance (* variablecostperattendee (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))