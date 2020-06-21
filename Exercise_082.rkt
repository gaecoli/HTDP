#lang racket

(define-struct word [fst mid lst])

(check-expect (compare-word
               (make-word "c" "a" "t")
               (make-word "c" "a" "t"))
              (make-word "c" "a" "t"))
(check-expect (compare-word
               (make-word "c" "a" "t")
               (make-word "c" "a" "r"))
              (make-word "c" "a" #f))

(check-expect (compare-word
               (make-word #f #f #f)
               (make-word #f #f #f))
              (make-word #f #f #f))
(define (compare-word w1 w2)
  (make-word
   (cond [(eq? (word-fst w1) (word-fst w2)) (word-fst w1)] [else #f])
   (cond [(eq? (word-mid w1) (word-mid w2)) (word-mid w1)] [else #f])
   (cond [(eq? (word-lst w1) (word-lst w2)) (word-lst w1)] [else #f])))