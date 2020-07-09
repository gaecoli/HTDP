#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define-struct cat [x hap])
(define cat1 (bitmap "images/cat1.png"))
(define cat2 (bitmap "images/cat2.png"))

(define CAT-Y 250)
(define HAP-DECAY 0.4)

(define WORLD-WIDTH (* 10 (image-width cat1)))
(define WORLD-HEIGHT (* 3 (image-height cat1)))

(define BACKGROUND
  (rectangle WORLD-WIDTH WORLD-HEIGHT "outline" "black"))

(define HAPG-WIDTH 50)
(define HAPG-HEIGHT 100)
(define HAPG-MAX 100)

(define (render vc)
  (place-image
   (cond [(odd? (cat-x vc)) cat1] [else cat2])
   (modulo (* 3 (cat-x vc)) WORLD-WIDTH)
   CAT-Y
   (draw-guage-on-bg (cat-hap vc))))

(define (draw-guage-on-bg h)
  (place-image/align
   (rectangle HAPG-WIDTH h "solid" "blue")
   (- WORLD-WIDTH (/ HAPG-WIDTH 2)) HAPG-HEIGHT
   "middle" "bottom"
   BACKGROUND))


(define (tock vc)
  (cond [(<= (cat-hap vc) 0)
         (make-cat (cat-x vc) 0)]
        [else
         (make-cat (+ (cat-x vc) 1) (min (- (cat-hap vc) HAP-DECAY) HAPG-MAX))]))

(define (hyper vc ke)
  (cond
    [(string=? "down" ke)
     (make-cat (cat-x vc) (min HAPG-HEIGHT (* 1.2 (cat-hap vc))))]
    [(string=? "up" ke)
     (make-cat (cat-x vc) (min HAPG-HEIGHT (* 1.3333 (cat-hap vc))))]
    [else vc]))

(define (main x)
  (big-bang (make-cat x 100)
            [on-tick tock]
            [to-draw render]
            [on-key hyper]))


(main 13)