#lang racket
(require 2htdp/image)

(define-struct editor [pre post])

(define (render ed)
  (overlay/align/offset
   HORIZ-ALIGN VERT-ALIGN
   (draw-text ed)
   X-ADJUST Y-ADJUST
   SCENE))

(define (draw-text ed)
  (beside/align
   "bottom"
   (text (editor-pre ed) 16 "black")
   (rectangle 1 20 "solid" "red")
   (text (editor-post ed) 16 "black")))


(define SCENE (rectangle 200 20 "outline" "black"))
(define HORIZ-ALIGN "left")
(define VERT-ALIGN "middle")
(define X-ADJUST -3)
(define Y-ADJUST -1)

(render (make-editor "he" ""))
(render (make-editor "hello" "world"))
(render (make-editor "hello " "world"))