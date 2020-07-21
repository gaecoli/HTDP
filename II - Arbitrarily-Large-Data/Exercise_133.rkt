#lang racket

;(or (string=? (first alon) "Flatt")
;    (contains-flatt? (rest alon)))

; If the first expression is true (the first item is "Flatt"),
; the whole (or ...) is replaced with #true (short-circuited evaluation).
; Otherwise, the result of the (or ...) will be determined by the
; result of the second expression.

;(cond
;  [(string=? (first alon) "Flatt") #true]
;  [else (contains-flatt? (rest alon))])

; Likewise, if the first clause's condition is true, then the whole
; (cond ...) is replaced with #true and the rest is discarded.
; Otherwise (else), the result will be the result of the
; second expression.

; The first version is clearer because someone searching for "Flatt" in a list
; basically thinks that either it's the first element of the list, or
; they have to keep looking.