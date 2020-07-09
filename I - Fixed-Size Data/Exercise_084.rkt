#lang racket

(define-struct editor [pre post])

(check-expect (edit (make-editor "hell" "o") "o") (make-editor "hello" "o"))
(check-expect (edit (make-editor "hell" "") "o") (make-editor "hello" ""))
(check-expect (edit (make-editor "" "ello") "j") (make-editor "j" "ello"))
(check-expect (edit (make-editor "" "orld") "\b") (make-editor "" "orld"))
(check-expect (edit (make-editor "hello " "world") "\t") (make-editor "hello " "world"))
(check-expect (edit (make-editor "hello " "world") "\r") (make-editor "hello " "world"))
(check-expect (edit (make-editor "hello" "world") "left") (make-editor "hell" "oworld"))
(check-expect (edit (make-editor "hello" "world") "right") (make-editor "hellow" "orld"))
(define (edit ed ke)
  (cond
    [(string=? ke "left") (cursor-left ed)]
    [(string=? ke "right") (cursor-right ed)]
    [(string=? ke "\b") (bksp ed)]
    [(string=? ke "\r") ed]
    [(string=? ke "\t") ed]
    [(and (string? ke) (= 1 (string-length ke)))
     (insert-char ed ke)]
    [else ed]))

(check-expect (bksp (make-editor "hello" "world"))
              (make-editor "hell" "world"))
(check-expect (bksp (make-editor "" "world")) (make-editor "" "world"))
(define (bksp ed)
  (make-editor
   (chop-last (editor-pre ed))
   (editor-post ed)))

(check-expect (insert-char (make-editor "hell" "o") "o") (make-editor "hello" "o"))
(check-expect (insert-char (make-editor "hell" "") "a") (make-editor "hella" ""))
(define (insert-char ed ch)
  (make-editor
   (string-append (editor-pre ed) ch)
   (editor-post ed)))


(check-expect
 (cursor-left (make-editor "hello" "world"))
 (make-editor "hell" "oworld"))
(define (cursor-left ed)
  (make-editor
   (chop-last (editor-pre ed))
   (string-append
    (get-last (editor-pre ed)) (editor-post ed))))

(check-expect
 (cursor-right (make-editor "hello" "world"))
 (make-editor "hellow" "orld"))
(define (cursor-right ed)
  (make-editor
   (string-append (editor-pre ed) (get-first (editor-post ed)))
   (chop-first (editor-post ed))))

(check-expect (get-first "hello") "h")
(check-expect (get-first "") "")
(define (get-first str)
  (if (> (string-length str) 1) (substring str 0 1) str))


(check-expect (chop-first "") "")
(check-expect (chop-first "hello") "ello")
(check-expect (chop-first "a") "")
(define (chop-first str)
  (if (> (string-length str) 0) (substring str 1) str))

(check-expect (get-last "hello") "o")
(check-expect (get-last "z") "z")
(check-expect (get-last "") "")
(define (get-last str)
  (if (> (string-length str) 1) (substring str (- (string-length str) 1)) str))

(check-expect (chop-last "jelly") "jell")
(check-expect (chop-last "") "")
(define (chop-last str)
  (if (> (string-length str) 1)
      (substring str 0 (- (string-length str) 1))
      str))