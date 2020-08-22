#lang racket

(check-expect (search-sorted 5 '()) #false)
(check-expect (search-sorted 20 (list 2 7 18 20 25 35)) #true)
(check-expect (search-sorted 5 (list 2 3 4 6 7 8)) #false)
(check-expect (search-sorted 7 (list 12 15 28 351)) #false)

(define (search-sorted n alon)
  (cond
    [(empty? alon) #false]
    [(< n (first alon)) #false]
    [else (or (= (first alon) n)
              (search-sorted n (rest alon)))]))