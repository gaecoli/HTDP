#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

(define CANVAS
  (scene+curve
   (scene+curve
    (rectangle 200 200 "outline" "black")
    0 195 10 1/2
    100 195 10 1/3
    "purple")
   100 195 10 1/2
   200 195 10 1/3
   "purple"))
(define HEIGHT (image-height CANVAS))

(define TANK (rectangle 30 15 "solid" "blue"))
(define TANK-HEIGHT (image-height TANK))
(define TANK-Y (- (image-height CANVAS) (* 3/5 (image-height TANK))))

(define MISSILE (triangle 12 "solid" "tan"))

(define UFO
  (overlay (circle 4 "solid" "green")
           (rectangle 20 2 "solid" "green")))

(define REACH 3)

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
(define-struct tank [loc vel])

(check-expect
 (si-game-over? (make-aim
                 (make-posn 50 (image-height CANVAS))
                 (make-tank 25 3)))
              #t)
(check-expect (si-game-over? (make-aim
                              (make-posn 50 10)
                              (make-tank 25 3)))
              #f)
(define (si-game-over? s)
  (cond
    [(>= (posn-y (if (aim? s)
                     (aim-ufo s)
                     (fired-ufo s)))
         (image-height CANVAS))
     #t] 
    [(and
      (fired? s)
      (in-reach? (fired-ufo s) (fired-missile s)))
     #t] 
    [else #f]))

(check-expect (in-reach? (make-posn 10 10) (make-posn 100 100)) #f)
(check-expect (in-reach? (make-posn 100 100) (make-posn 100 100)) #t)
(define (in-reach? p1 p2)
  (if (>= REACH
          (sqrt
           (+
            (sqr (- (posn-x p2) (posn-x p1)))
            (sqr (- (posn-y p2) (posn-y p1))))))
      #t #f))


(check-expect (si-render-final
               (make-aim (make-posn 20 10) (make-tank 28 -3)))
              (overlay
               (text "GAME OVER" 24 "red") CANVAS))
(define (si-render-final w)
  (overlay (text "GAME OVER" 24 "red") CANVAS))

(si-render-final (make-aim (make-posn 20 10) (make-tank 28 -3)))