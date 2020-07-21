#lang racket

(define (contains? str alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) str)
         (contains? str (rest alon)))]))

(check-expect (contains? "Samuel" '()) #false)
(check-expect (contains? "Jane" (cons "Find" '()))
              #false)
(check-expect (contains? "Flatt" (cons "Flatt" '()))
              #true)
(check-expect (contains? "Flatt" (cons "A" (cons "Flatt" (cons "C" '()))))
              #true)
(check-expect (contains? "Ochoa"
               (cons "Findler"
                     (cons "Felleisen"
                           (cons "Krishnamurthi"
                                 (cons "Ochoa" '())))))
              #true)

(check-expect (contains? "Flatt"
               (cons "Fagan"
                     (cons "Findler"
                           (cons "Fisler"
                                 (cons "Flanagan"
                                       (cons "Flatt"
                                             (cons "Felleisen"
                                                   (cons "Friedman" '()))))))))
              #true)