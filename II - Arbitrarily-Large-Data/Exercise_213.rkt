(define WORD1 '())
(define W-ED (list "e" "d"))
(define W-CAT (list "c" "a" "t"))
(define W-RAT (list "r" "a" "t"))

; A List-of-Words is one of:
; - '()
; - (cons Word List-of-Words)
(define LOW1 '())
(define L-ED (list (list "e" "d") (list "d" "e")))
(define L-CAT (list
               (list "c" "a" "t")
               (list "a" "c" "t")
               (list "a" "t" "c")
               (list "c" "t" "a")
               (list "t" "c" "a")
               (list "t" "a" "c")))



; Word -> List-of-words
; creates all rearrangements of the letters in w
(check-expect (arrangements '()) (list '()))
(check-expect (arrangements W-ED) L-ED)
(check-expect (arrangements W-CAT) L-CAT)

(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words (first w)
            (arrangements (rest w)))]))

; 1String Low -> Low
; Consumes a 1String and a list of words.
; The result is a list of words like its second argument, but with the first argument
; inserted at the beginning, between all letters, and at the end of all words of the given list.
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

; List-of-strings -> List-of-strings
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

; String List-of-Strings -> Boolean
; Search a String inside a Los and returns a Boolean
(check-expect (string-in-los? "cat" '()) #false)
(check-expect (string-in-los? "a" (list "q" "w" "e" "r" "t" "y")) #false)
(check-expect (string-in-los? "rat" (list "dog" "rat" "cat")) #true)
(check-expect (string-in-los? "apple" DICTIONARY-AS-LIST) #true)

(define (string-in-los? s los)
  (cond
    [(empty? los) #false]
    [(string=? s (first los)) #true]
    [else (string-in-los? s (rest los))]))

; String -> Word
; converts s to the chosen word representation
(check-expect (string->word "") '())
(check-expect (string->word "cat") (list "c" "a" "t"))

(define (string->word s)
  (explode s))

; List-of-Words -> List-of-Strings
; turns all Words in low into Strings
(check-expect (words->strings '()) '())
(check-expect (words->strings (list (list "abcd"))) (list "abcd"))
(check-expect (words->strings (list (list "c" "a" "t") (list "r" "a" "t"))) (list "cat" "rat"))

(define (words->strings low)
  (cond
    [(empty? low) '()]
    [else (cons (word->string (first low)) (words->strings (rest low)))]))

; Word -> String
; converts w to a string
(check-expect (word->string '()) "")
(check-expect (word->string (list "c" "a" "t")) "cat")

(define (word->string w)
  (cond
    [(empty? w) ""]
    [else (string-append (first w) (word->string (rest w)))]))