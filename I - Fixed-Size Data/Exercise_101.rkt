#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
(define-struct tank [loc vel])
(define BACKGROUND
  (scene+curve
   (scene+curve
    (rectangle 200 200 "outline" "black")
    0 195 10 1/2
    100 195 10 1/3
    "purple")
   100 195 10 1/2
   200 195 10 1/3
   "purple"))

(define UFO
  (overlay (circle 4 "solid" "green")
           (rectangle 20 2 "solid" "green")))
(define UFO-DELTA-Y 2)
(define UFO-DELTA-X 5)

(define TANK (rectangle 30 15 "solid" "blue"))
(define TANK-Y (- (image-height BACKGROUND) (* 3/5 (image-height TANK))))
(define TANK-DELTA-X 3)

(define MISSILE (triangle 7 "solid" "red"))
(define POSN-Y-OFFSET 10)

(define REACH 5)

(define (si-move w)
  (si-move-proper w (create-random-number w)))

(check-expect (si-move-proper (make-aim (make-posn 50 25)
                                        (make-tank 50 (- TANK-DELTA-X)))
                              3)
              (make-aim (make-posn 53 (+ 25 UFO-DELTA-Y))
                        (make-tank (+ 50 (- TANK-DELTA-X)) (- TANK-DELTA-X))))
(check-expect (si-move-proper (make-fired
                               (make-posn 50 25)
                               (make-tank 50 (- TANK-DELTA-X))
                               (make-posn 50 100))
                              4)
              (make-fired
               (make-posn 54 (+ 25 UFO-DELTA-Y))
               (make-tank 47 (- TANK-DELTA-X))
               (make-posn 50 (- (* 2 UFO-DELTA-Y) 100))))
(define (si-move-proper w n)
  (cond [(aim? w)
         (make-aim
          (make-posn (+ n (posn-x (aim-ufo w)))
                     (+ UFO-DELTA-Y (posn-y (aim-ufo w))))
          (make-tank (+ (tank-vel (aim-tank w)) (tank-loc (aim-tank w)))
                     (tank-vel (aim-tank w))))]
        [else
         (make-fired
          (make-posn (+ n (posn-x (fired-ufo w)))
                     (+ UFO-DELTA-Y (posn-y (fired-ufo w))))
          (make-tank (+ (tank-vel (fired-tank w))
                        (tank-loc (fired-tank w)))
                     (tank-vel (fired-tank w)))
          (make-posn (posn-x (fired-missile w))
                     (- (* 2 UFO-DELTA-Y)
                        (posn-y (fired-missile w)))))]))

(check-random (create-random-number (make-aim (make-posn 45 67)
                                              (make-tank 54 76)))
              (random UFO-DELTA-X))
(define (create-random-number w)
  (random UFO-DELTA-X) )

(check-expect (tank-render (make-tank 20 TANK-DELTA-X) BACKGROUND)
              (place-image TANK 20 TANK-Y BACKGROUND))
(define (tank-render t img)
  (place-image TANK (tank-loc t) TANK-Y img))


(check-expect (ufo-render (make-posn 66 33) BACKGROUND)
              (place-image UFO 66 33 BACKGROUND))
(define (ufo-render u img)
  (place-image UFO (posn-x u) (posn-y u) img))

(check-expect (missile-render (make-posn 100 100) BACKGROUND)
              (place-image MISSILE 100 100 BACKGROUND))
(define (missile-render m img)
  (place-image MISSILE (posn-x m) (posn-y m) img))

(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s)
     (tank-render (fired-tank s)
                  (ufo-render (fired-ufo s)
                              (missile-render (fired-missile s) BACKGROUND)))]))
(place-images
 (list UFO TANK)
 (list (make-posn (* 1/2 (image-width BACKGROUND)) (image-height UFO))
       (make-posn (* 1/2 (image-width BACKGROUND)) TANK-Y))
 BACKGROUND)

(check-expect ;; aim, moving right, ke left
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 TANK-DELTA-X))
  "left")
 (make-aim (make-posn 50 25)
           (make-tank 50 (- TANK-DELTA-X))))
(check-expect ;; aim, moving left, ke left
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 (- TANK-DELTA-X)))
  "left")
 (make-aim (make-posn 50 25)
           (make-tank 50 (- TANK-DELTA-X))))
(check-expect ;; aim, moving right, ke right
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 TANK-DELTA-X))
  "right")
 (make-aim (make-posn 50 25)
           (make-tank 50 TANK-DELTA-X)))
(check-expect ;; aim, moving right, ke left
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 TANK-DELTA-X))
  "left")
 (make-aim (make-posn 50 25)
           (make-tank 50 (- TANK-DELTA-X))))
(check-expect ;; aim, ke space
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 TANK-DELTA-X))
  "space")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 (- TANK-Y POSN-Y-OFFSET))))
(check-expect ;; fired, change right to left
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 50 100))
  "left")
 (make-fired (make-posn 50 25)
             (make-tank 50 (- TANK-DELTA-X))
             (make-posn 50 100)))
(check-expect ;; fired, left is still left
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 (- TANK-DELTA-X))
              (make-posn 50 100))
  "left")
 (make-fired (make-posn 50 25)
             (make-tank 50 (- TANK-DELTA-X))
             (make-posn 50 100)))
(check-expect ;; fired, change left to right
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 (- TANK-DELTA-X))
              (make-posn 50 100))
  "right")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 100)))
(check-expect ;; fired, right is still right
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 50 100))
  "right")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 100)))
(check-expect ;; fired, space does nothing
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 50 100))
  "space")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 100)))
(check-expect ;; fired, garbage ke
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 50 100))
  "x")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 100)))
(define (si-control w ke)
  (if (aim? w)
      (if (eq? ke "space")
          ; aim + space => fired missile
          (make-fired (make-posn (posn-x (aim-ufo w)) (posn-y (aim-ufo w)))
                      (make-tank (tank-loc (aim-tank w))
                                 (tank-vel (aim-tank w)))
                      (make-posn (tank-loc (aim-tank w))
                                 (- TANK-Y POSN-Y-OFFSET)))
          (make-aim (make-posn (posn-x (aim-ufo w)) (posn-y (aim-ufo w)))
                    (make-tank (tank-loc (aim-tank w))
                               (cond [(eq? ke "left") (- TANK-DELTA-X)]
                                     [(eq? ke "right") TANK-DELTA-X]
                                     [else (tank-vel (aim-tank w))]))))
      (make-fired (make-posn (posn-x (fired-ufo w)) (posn-y (fired-ufo w)))
                  (make-tank (tank-loc (fired-tank w))
                             (cond [(eq? ke "left") (- TANK-DELTA-X)]
                                   [(eq? ke "right") TANK-DELTA-X]
                                   [else (tank-vel (fired-tank w))]))
                  (make-posn (posn-x (fired-missile w))
                             (posn-y (fired-missile w))))))

(check-expect ;; in-reach? should be #t
 (si-game-over?
  (make-fired (make-posn 75 100)
              (make-tank 50 TANK-DELTA-X)
              (make-posn (+ 75 (* .5 REACH))
                         (+ 100 (* .5 REACH))))) #t)
(check-expect ;; in-reach? should be #f
 (si-game-over?
  (make-fired (make-posn 75 100)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 5 5))) #f)
(check-expect ;; TODO: check land condition
 (si-game-over?
  (make-aim (make-posn 75 100)
            (make-tank 50 TANK-DELTA-X))) #f)
(define (si-game-over? w)
  (cond [(>= (posn-y (if (aim? w) (aim-ufo w) (fired-ufo w))) (image-height BACKGROUND)) #t]
        [(and (fired? w) (in-reach? (fired-ufo w) (fired-missile w))) #t]
        [else #f]))

(check-expect
 (in-reach? (make-posn 50 50)
            (make-posn 50 (+ 50 (* .5 REACH))))
 #t)
(check-expect
 (in-reach? (make-posn 50 50) (make-posn (- 50 (* .5 REACH))
                                         (+ 50 (* .5 REACH))))
 #t)
(check-expect
 (in-reach? (make-posn 50 50)
            (make-posn 50 50))
 #t)
(check-expect
 (in-reach? (make-posn 50 50)
            (make-posn (+ 50 (+ 10 REACH)) (+ 50 (+ 10 REACH))))
 #f)
(check-expect (in-reach? (make-posn 50 50) (make-posn 50 50)) #t)
(define (in-reach? p1 p2)
   (<= (disty p1 p2) REACH))

(check-expect (disty (make-posn 0 5) (make-posn 0 0))
              5)
(check-expect (disty (make-posn 5 0) (make-posn 0 0))
              5)
(check-expect (disty (make-posn 3 0) (make-posn 0 4))
              5)
(check-expect (disty (make-posn -5 -5) (make-posn -5 -5))
              0)
(define (disty p1 p2)
  (sqrt (+ (sqr (- (posn-x p2) (posn-x p1))) (sqr (- (posn-y p2) (posn-y p1))))))


(check-expect (si-render-final
               (make-aim (make-posn 20 10) (make-tank 28 -3)))
              (overlay
               (text "GAME OVER" 24 "red") BACKGROUND))
(define (si-render-final w)
  (overlay (text "GAME OVER" 24 "red") BACKGROUND))

(define (si-main w)
  (big-bang (make-aim (make-posn (/ (image-width BACKGROUND) 2) 10)
                      (make-tank (/ (image-width BACKGROUND) 2) TANK-Y))
            [on-tick si-move]
            [to-draw si-render]
            [on-key si-control]
            [stop-when si-game-over? si-render-final]))

(si-main 0)