#lang racket

(define-struct editor [pre post])

(define lo1s1 '())
(define lo1s2 (cons "a" (cons "b" (cons "c" '()))))

(check-expect (editor-lft (create-editor "" "")) (create-editor "" ""))
(check-expect (editor-lft (create-editor "" "asd")) (create-editor "" "asd"))
(check-expect (editor-lft (create-editor "a" "")) (create-editor "" "a"))
(check-expect (editor-lft (create-editor "abc" "def")) (create-editor "ab" "cdef"))

(define (editor-lft ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [else (make-editor (rest (editor-pre ed))
                  (cons (first (editor-pre ed))
                        (editor-post ed)))]))


(check-expect (editor-rgt (create-editor "cde" "")) (create-editor "cde" ""))
(check-expect (editor-rgt (create-editor "cd" "fgh")) (create-editor "cdf" "gh"))

(define (editor-rgt ed)
  (cond [(empty? (editor-post ed)) ed]
        [else
         (make-editor (cons (first (editor-post ed))
                            (editor-pre ed))
                      (rest (editor-post ed)))]))

(check-expect (editor-del (create-editor "" "fgh")) (create-editor "" "fgh"))
(check-expect (editor-del (create-editor "cd" "fgh")) (create-editor "c" "fgh"))

(define (editor-del ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [else (make-editor (rest (editor-pre ed))
                       (editor-post ed))]))

(check-expect (create-editor "hello" "world") (make-editor (cons "o" (cons "l" (cons "l" (cons "e" (cons "h" '()))))) (cons "w" (cons "o" (cons "r" (cons "l" (cons "d" '())))))))

(define (create-editor s1 s2)
  (make-editor (rev (explode s1)) (explode s2)))

(check-expect
 (rev (cons "a" (cons "b" (cons "c" '()))))
 (cons "c" (cons "b" (cons "a" '()))))

(define (rev l)
  (cond
    [(empty? l) '()]
    [else (add-at-end (rev (rest l)) (first l))]))

(check-expect (add-at-end '() "z") (cons "z" '()))
(check-expect (add-at-end (cons "c" (cons "b" '())) "a") (cons "c" (cons "b" (cons "a" '()))))

(define (add-at-end l s)
  (cond
    [(empty? l) (cons s '())]
    [else (cons (first l) (add-at-end (rest l) s))]))