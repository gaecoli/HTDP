#lang racket

(define standardticketprice 5)
(define averageattendance 120)
(define changeinticketprice .10)
(define changeinaverageattendance 15)
(define variablecostperattendee 1.50)

(define (attendees ticket-price)
  (- averageattendance (* (- ticket-price standardticketprice) (/ changeinaverageattendance changeinticketprice))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (* variablecostperattendee (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

;开始调用计算产生利润
(profit 3)
(profit 4)
(profit 5)