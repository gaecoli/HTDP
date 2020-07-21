#lang racket

(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) "Flatt")
         (contains-flatt? (rest alon)))]))

(check-expect (contains-flatt? '()) #false)
(check-expect (contains-flatt? (cons "Find" '()))
              #false)
(check-expect (contains-flatt? (cons "Flatt" '()))
              #true)
(check-expect (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '()))))
              #true)
(check-expect (contains-flatt?
               (cons "Findler"
                     (cons "Felleisen"
                           (cons "Krishnamurthi"
                                 (cons "Ochoa" '())))))
              #false)

(check-expect (contains-flatt?
               (cons "Fagan"
                     (cons "Findler"
                           (cons "Fisler"
                                 (cons "Flanagan"
                                       (cons "Flatt"
                                             (cons "Felleisen"
                                                   (cons "Friedman" '()))))))))
              #true)