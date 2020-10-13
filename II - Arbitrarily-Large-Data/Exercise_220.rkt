#lang racket

(define WIDTH 10) ; # of blocks, horizontall
(define SIZE 10) ; blocks are squares
(define HSIZE (/ SIZE 2))
(define SCENE-SIZE (* WIDTH SIZE))

(define BLOCK ; red squares with black rims
  (overlay
    (square (- SIZE 1) "solid" "red")
    (square SIZE "outline" "black")))

(define BACKGROUND (empty-scene SCENE-SIZE SCENE-SIZE))

(define-struct block [x y])
(define BLOCKL1 (make-block 0 9))
(define BLOCKL2 (make-block 1 9))
(define BLOCKNB1 (make-block 0 8))
(define BLOCKNB2 (make-block 1 8))
(define BLOCKD1 (make-block 5 1))
(define FIRSTBLOCK (make-block HSIZE 0))


(define LANDSCAPE0 '())
(define LANDSCAPE1 (list BLOCKL1 BLOCKL2))
(define LANDSCAPEBNB1 (list BLOCKL1 BLOCKNB1))
(define LANDSCAPEBNB2 (list BLOCKL1 BLOCKNB1 BLOCKL2 BLOCKNB2))
 
(define-struct tetris [block landscape])

(define TETRIS1 (make-tetris BLOCKD1 LANDSCAPE1))
(define TETRIS2 (make-tetris BLOCKD1 LANDSCAPEBNB2))


(check-expect (render TETRIS1) (renderb BLOCKD1 (renderl LANDSCAPE1)))

(define (render t)
  (renderb (tetris-block t) (renderl (tetris-landscape t))))


(check-expect (renderl LANDSCAPE0) BACKGROUND)
(check-expect (renderl LANDSCAPE1) (renderb BLOCKL1 (renderb BLOCKL2 BACKGROUND)))

(define (renderl l)
  (cond
    [(empty? l) BACKGROUND]
    [else (renderb (first l) (renderl (rest l)))]))


(check-expect (renderb (make-block 5 3) BACKGROUND) (place-image BLOCK (+ (* 5 SIZE) HSIZE) (+ (* 3 SIZE) HSIZE) BACKGROUND))

(define (renderb b i)
  (place-image BLOCK
               (+ (* SIZE (block-x b)) HSIZE)
               (+ (* SIZE (block-y b)) HSIZE)
               i))