#lang racket

(define WORD1 '())
(define W-ED (list "e" "d"))
(define W-CAT (list "c" "a" "t"))
(define W-RAT (list "r" "a" "t"))

(define LOW1 '())
(define L-ED (list (list "e" "d") (list "d" "e")))
(define L-CAT (list
               (list "c" "a" "t")
               (list "a" "c" "t")
               (list "a" "t" "c")
               (list "c" "t" "a")
               (list "t" "c" "a")
               (list "t" "a" "c")))


(check-member-of (alternative-words "cat") (list "act" "cat") (list "cat" "act"))

(define (alternative-words s)
  (in-dictionary
    (words->strings (arrangements (string->word s)))))

(check-expect (arrangements '()) (list '()))
(check-expect (arrangements W-ED) L-ED)
(check-expect (arrangements W-CAT) L-CAT)

(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words (first w)
            (arrangements (rest w)))]))

(check-expect (insert-everywhere/in-all-words "a" (list '())) (list (list "a")))
(check-expect (insert-everywhere/in-all-words "a" (list (list "b"))) (list (list "a" "b") (list "b" "a")))
(check-expect (insert-everywhere/in-all-words "c" (list (list "a" "t") (list "t" "a"))) L-CAT)

(define (insert-everywhere/in-all-words ch low)
  (cond [(empty? low) '()]
        [else
         (append (insert-everywhere '() ch (first low))
                 (insert-everywhere/in-all-words ch (rest low)))]))

; Lo1s 1String Lo1s  -> LoLo1s
; takes a word char and a word and returns a list of words with char inserted
(check-expect (insert-everywhere (list "h") "e" (list "l" "l" "o"))
              (list (list "h" "e" "l" "l" "o")
                    (list "h" "l" "e" "l" "o")
                    (list "h" "l" "l" "e" "o")
                    (list "h" "l" "l" "o" "e")))

(define (insert-everywhere pre ch post)
  (cond [(empty? post) (list (append pre (list ch)))]
        [else
         (append (list (append pre (list ch) post))
                 (insert-everywhere (append pre (list (first post)))
                                    ch
                                    (rest post)))]))


; Dictionary location
(define DICTIONARY-LOCATION "dictionary.txt")

; A Dictionary is a List-of-strings.
(define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))

; pick out all those Strings that occur in the dictionary
(check-expect (in-dictionary '()) '())
(check-expect (in-dictionary (list "apple")) (list "apple"))
(check-expect (in-dictionary (list "asdfg")) '())
(check-expect (in-dictionary (list "apple" "grape")) (list "apple" "grape"))
(check-expect (in-dictionary (list "apple" "asdfg" "grape")) (list "apple" "grape"))

(define (in-dictionary los)
  (cond
    [(empty? los) '()]
    [else (if (string-in-los? (first los) DICTIONARY-AS-LIST)
              (cons (first los) (in-dictionary (rest los)))
              (in-dictionary (rest los)))]))

(check-expect (string-in-los? "cat" '()) #false)
(check-expect (string-in-los? "a" (list "q" "w" "e" "r" "t" "y")) #false)
(check-expect (string-in-los? "rat" (list "dog" "rat" "cat")) #true)
(check-expect (string-in-los? "apple" DICTIONARY-AS-LIST) #true)

(define (string-in-los? s los)
  (cond
    [(empty? los) #false]
    [(string=? s (first los)) #true]
    [else (string-in-los? s (rest los))]))


(check-expect (string->word "") '())
(check-expect (string->word "cat") (list "c" "a" "t"))

(define (string->word s)
  (explode s))

(check-expect (words->strings '()) '())
(check-expect (words->strings (list (list "abcd"))) (list "abcd"))
(check-expect (words->strings (list (list "c" "a" "t") (list "r" "a" "t"))) (list "cat" "rat"))

(define (words->strings low)
  (cond
    [(empty? low) '()]
    [else (cons (word->string (first low)) (words->strings (rest low)))]))


(check-expect (word->string '()) "")
(check-expect (word->string (list "c" "a" "t")) "cat")

(define (word->string w)
  (cond
    [(empty? w) ""]
    [else (string-append (first w) (word->string (rest w)))]))