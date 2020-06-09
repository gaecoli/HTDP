#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define TrafficLightRadius 10)

(define RedLight (circle TrafficLightRadius "solid" "red"))
(define YellowLight (circle TrafficLightRadius "solid" "yellow"))
(define GreenLight (circle TrafficLightRadius "solid" "green"))

(check-expect (render 0) RedLight)
(check-expect (render 1) GreenLight)
(check-expect (render 2) YellowLight)
(define (render s)
   (cond
     [(= 0 s) RedLight]
     [(= 1 s) GreenLight]
     [(= 2 s) YellowLight]))

(check-expect (tock 0) 1)
(check-expect (tock 1) 2)
(check-expect (tock 2) 0)
(define (tock s)
  (modulo (+ s 1) 3))


(define (TrafficLight s)
  (big-bang 0
    [on-tick tock 2 9] 
    [on-draw render]))