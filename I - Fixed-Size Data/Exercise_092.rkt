#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define-struct cham [x color happy])

(define CHAM (bitmap "images/chameleon.png"))
(define CANVAS (rectangle
                (* 9 (image-width CHAM))
                (* 2 (image-height CHAM))
                "outline" "black"))
(define CHAM-Y (* 0.6667 (image-height CANVAS)))

(define GUAGE-FRAME (rectangle 42 100 "outline" "black"))

(check-expect (render (make-cham 13 "green" 57))
              (place-images
               (list (draw-cham "green") (fill-guage 57))
               (list (make-posn 13 CHAM-Y)
                     (make-posn (/ (image-width GUAGE-FRAME) 2)
                                (/ (image-height GUAGE-FRAME) 2)))
              CANVAS))
(define (render vc)
  (place-images
   (list (draw-cham (cham-color vc)) (fill-guage (cham-happy vc)))
   (list (make-posn (cham-x vc) CHAM-Y)
         (make-posn (/ (image-width GUAGE-FRAME) 2)
                    (/ (image-height GUAGE-FRAME) 2)))
   CANVAS))

(check-expect (fill-guage 13)
              (overlay/align
               "middle" "bottom"
               GUAGE-FRAME
               (rectangle (image-width GUAGE-FRAME) 13 "solid" "blue")))
(define (fill-guage h)
  (overlay/align "middle" "bottom" GUAGE-FRAME
           (rectangle (image-width GUAGE-FRAME) h "solid" "blue")))

(check-expect (draw-cham "blue")
              (overlay
               CHAM
               (rectangle (image-width CHAM)
                          (image-height CHAM) "solid" "blue")))
(define (draw-cham color)
  (overlay
   CHAM (rectangle (image-width CHAM) (image-height CHAM) "solid" color)))

(define DELTA-X 3)
(define DELTA-H -0.1)
(check-expect (tock (make-cham 13 "green" 99))
              (make-cham
               (modulo (+ DELTA-X 13) (image-width CANVAS))
               "green"
               (+ DELTA-H 99)))

(check-expect (tock (make-cham (image-width CANVAS)
                               "green"
                               42))
              (make-cham
               (modulo (+ DELTA-X (image-width CANVAS)) (image-width CANVAS))
               "green"
               (+ DELTA-H 42)))
(define (tock vc)
  (make-cham
   (modulo (+ DELTA-X (cham-x vc)) (image-width CANVAS))
   (cham-color vc)
   (+ DELTA-H (cham-happy vc))))

(check-expect (hyper (make-cham 13 "red" 99) "g")
              (make-cham 13 "green" 99))
(check-expect (hyper (make-cham 13 "blue" 99) "b")
              (make-cham 13 "blue" 99))
(check-expect (hyper (make-cham 13 "blue" 99) "a")
              (make-cham 13 "blue" 99))
(check-expect (hyper (make-cham 13 "blue" 42) "down")
              (make-cham 13 "blue" (+ 2 42)))
(define (hyper vc ke)
  (make-cham (cham-x vc)
             (cond [(string=? ke "r") "red"]
                   [(string=? ke "b") "blue"]
                   [(string=? ke "g") "green"]
                   [else (cham-color vc)])
             (+ (cham-happy vc) (if (string=? ke "down") 2 0))))

(define (main x)
  (big-bang (make-cham x "green" 100)
            [to-draw render]
            [on-tick tock]
            [on-key hyper]))

(main 13)