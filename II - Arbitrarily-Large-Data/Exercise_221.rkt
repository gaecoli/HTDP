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

; A Block is a structure:
;   (make-block N N)
(define-struct block [x y])
; Interpretation:
; (make-block x y) depicts a block whose left 
; corner is (* x SIZE) pixels from the left and
; (* y SIZE) pixels from the top;
(define BLOCKL1 (make-block 0 9))
(define BLOCKL2 (make-block 1 9))
(define BLOCKNB1 (make-block 0 8))
(define BLOCKNB2 (make-block 1 8))
(define BLOCKD1 (make-block 5 1))
(define FIRSTBLOCK (make-block HSIZE 0))

; A Landscape is one of: 
; – '() 
; – (cons Block Landscape)
(define LANDSCAPE0 '())
(define LANDSCAPE1 (list BLOCKL1 BLOCKL2))
(define LANDSCAPEBNB1 (list BLOCKL1 BLOCKNB1))
(define LANDSCAPEBNB2 (list BLOCKL1 BLOCKNB1 BLOCKL2 BLOCKNB2))
 
; A Tetris is a structure:
;   (make-tetris Block Landscape)
(define-struct tetris [block landscape])
; Interpretation:
; (make-tetris b0 (list b1 b2 ...)) means b0 is the
; dropping block, while b1, b2, and ... are resting
(define TETRIS0 (make-tetris FIRSTBLOCK LANDSCAPE0))
(define TETRIS1 (make-tetris BLOCKD1 LANDSCAPE1))
(define TETRIS2 (make-tetris BLOCKD1 LANDSCAPEBNB2))



;; RENDER

; Tetris -> Image
; Renders a Tetris game
(check-expect (render TETRIS1) (renderb BLOCKD1 (renderl LANDSCAPE1)))

(define (render t)
  (renderb (tetris-block t) (renderl (tetris-landscape t))))

; Landscape Image -> Image
; Renders a Landscape
(check-expect (renderl LANDSCAPE0) BACKGROUND)
(check-expect (renderl LANDSCAPE1) (renderb BLOCKL1 (renderb BLOCKL2 BACKGROUND)))

(define (renderl l)
  (cond
    [(empty? l) BACKGROUND]
    [else (renderb (first l) (renderl (rest l)))]))

; Block Image -> Image
; Renders a Block
(check-expect (renderb (make-block 5 3) BACKGROUND) (place-image BLOCK (+ (* 5 SIZE) HSIZE) (+ (* 3 SIZE) HSIZE) BACKGROUND))

(define (renderb b i)
  (place-image BLOCK
               (+ (* SIZE (block-x b)) HSIZE)
               (+ (* SIZE (block-y b)) HSIZE)
               i))



;; ON TICK

; Tetris -> Tetris
; Moves the blocks straight down until they reach the bottom or another block
(check-random (tock (make-tetris (make-block 4 8) (list (make-block 4 9))))
              (make-tetris (block-generate (make-block 4 8)) (list (make-block 4 8) (make-block 4 9))))
(check-random (tock (make-tetris (make-block 6 9) '()))
              (make-tetris (block-generate (make-block 6 9)) (list (make-block 6 9))))
(check-expect (tock (make-tetris (make-block 2 5) '())) (make-tetris (make-block 2 6) '()))

(define (tock t)
  (cond
    [(blockhit? (tetris-block t) (tetris-landscape t)) (blocknext t)]
    [(blockfall? (tetris-block t)) (blocknext t)]
    [else (blockmove t)]))

; Tetris -> Tetris
; Generates a new block and transposes tetris-block to the tetris-landscape
(check-random (blocknext (make-tetris (make-block 4 9) '())) (make-tetris (block-generate (make-block 4 9)) (list (make-block 4 9))))
(check-random (blocknext (make-tetris (make-block 3 7) (list (make-block 3 9) (make-block 2 9) (make-block 3 8))))
              (make-tetris (block-generate (make-block 3 7)) (list (make-block 3 7) (make-block 3 9) (make-block 2 9) (make-block 3 8))))

(define (blocknext t)
  (make-tetris (block-generate (tetris-block t))
               (cons (tetris-block t) (tetris-landscape t))))

; Block -> Block
; Generates a new random block
(check-random (block-generate (make-block 1 9)) (make-block (random SIZE) 0))

(define (block-generate b)
  (make-block (random SIZE) 0))

; Tetris -> Tetris
; Moves a Block straight down until the bottom of the scene
(check-expect (blockmove (make-tetris (make-block 4 6) '())) (make-tetris (make-block 4 7) '()))

(define (blockmove t)
  (make-tetris (make-block (block-x (tetris-block t)) (+ (block-y (tetris-block t)) 1))
               (tetris-landscape t)))

; Block Landscape -> Boolean
; Determines if a block landed over an other block
(check-expect (blockhit? (make-block 3 2) (list (make-block 3 9))) #false)
(check-expect (blockhit? (make-block 4 8) (list (make-block 2 9))) #false)
(check-expect (blockhit? (make-block 4 8) (list (make-block 4 9))) #true)
(check-expect (blockhit? (make-block 3 7) (list (make-block 3 9) (make-block 2 9) (make-block 3 8))) #true)

(define (blockhit? b l)
  (cond
    [(empty? l) #false]
    [(and (= (block-y b) (- (block-y (first l)) 1))
          (= (block-x b) (block-x (first l)))) #true]
    [else (blockhit? b (rest l))]))

(check-expect (blockfall? (make-block 5 1)) #false)
(check-expect (blockfall? (make-block 5 (- SIZE 1))) #true)

(define (blockfall? b)
  (cond
    [(>= (block-y b) (- SIZE 1)) #true]
    [else #false]))


(define (main x)
  (big-bang x
    [to-draw render]
    [on-tick tock]))