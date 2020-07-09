#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define-struct editor [txt cur])
(define SCENE (rectangle 200 20 "outline" "black"))
(define HORIZ-ALIGN "left")
(define VERT-ALIGN "middle")
(define X-ADJUST -3)
(define Y-ADJUST -1)

(define (render ed)
  (overlay/align/offset
   HORIZ-ALIGN VERT-ALIGN
   (draw-text ed)
   X-ADJUST Y-ADJUST
   SCENE))

(check-expect (draw-text (make-editor "hello" 4))
              (beside/align "bottom"
                            (text "hell" 16 "black")
                            (rectangle 1 20 "solid" "red")
                            (text "o" 16 "black")))
(define (draw-text ed)
  (beside/align
   "bottom"
   (text (substring (editor-txt ed) 0 (editor-cur ed)) 16 "black")
   (rectangle 1 20 "solid" "red")
   (text (substring (editor-txt ed) (editor-cur ed)) 16 "black")))

(check-expect (edit (make-editor "hello" 4) "o") (make-editor "helloo" 5))
(check-expect (edit (make-editor "hell" 4) "o") (make-editor "hello" 5))
(check-expect (edit (make-editor "ello" 0) "j") (make-editor "jello" 1))
(check-expect (edit (make-editor "hello world" 4) "\t") (make-editor "hello world" 4))
(check-expect (edit (make-editor "hello world" 4) "\r") (make-editor "hello world" 4))
(check-expect (edit (make-editor "helloworld" 5) "left") (make-editor "helloworld" 4))
(check-expect (edit (make-editor "helloworld" 5) "right") (make-editor "helloworld" 6))
(define (edit ed ke)
  (cond
    [(string=? ke "left") (cursor-left ed)]
    [(string=? ke "right") (cursor-right ed)]
    [(string=? ke "\b") (bksp ed)]
    [(string=? ke "\r") ed]
    [(string=? ke "\t") ed]
    [(and (string? ke) (= 1 (string-length ke))
          (> (image-width SCENE) (image-width (draw-text (insert-char ed ke)))))
     (insert-char ed ke)]
    [else ed]))

(check-expect (bksp (make-editor "helloworld" 5)) (make-editor "hellworld" 4))
(check-expect (bksp (make-editor "hello" 5)) (make-editor "hell" 4))
(check-expect (bksp (make-editor "world" 0)) (make-editor "world" 0))
(check-expect (bksp (make-editor "" 0)) (make-editor "" 0))
(define (bksp ed)
  (if (<= (editor-cur ed) 0)
      (make-editor (editor-txt ed) 0)
      (make-editor
       (string-append
        (substring (editor-txt ed) 0 (- (editor-cur ed) 1))
        (substring (editor-txt ed) (editor-cur ed)))
       (- (editor-cur ed) 1))))

(check-expect (insert-char (make-editor "hello" 4) "o") (make-editor "helloo" 5))
(check-expect (insert-char (make-editor "hell" 4) "a") (make-editor "hella" 5))
(check-expect (insert-char (make-editor "" 0) "y") (make-editor "y" 1))
(define (insert-char ed ch)
  (make-editor
   (string-append
    (substring (editor-txt ed) 0 (editor-cur ed))
    ch
    (substring (editor-txt ed) (editor-cur ed)))
   (+ (editor-cur ed) 1)))

(check-expect (cursor-left (make-editor "helloworld" 5))
              (make-editor "helloworld" 4))
(check-expect (cursor-left (make-editor "hello" 0)) (make-editor "hello" 0))
(define (cursor-left ed)
  (make-editor
   (editor-txt ed)
   (if (= (editor-cur ed) 0)
       0
       (- (editor-cur ed) 1))))

(check-expect (cursor-right (make-editor "hello" 4)) (make-editor "hello" 5))
(check-expect (cursor-right (make-editor "hello" 5)) (make-editor "hello" 5))
(check-expect (cursor-right (make-editor "" 0)) (make-editor "" 0))
(define (cursor-right ed)
  (make-editor
   (editor-txt ed)
   (if (= (editor-cur ed) (string-length (editor-txt ed)))
       (editor-cur ed)
       (+ (editor-cur ed) 1))))

(define (run str)
  (big-bang (make-editor str (string-length str))
            [to-draw render]
            [on-key edit]))

(run "wo")