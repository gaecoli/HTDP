#lang racket

(define WIDTH 10) ; # of blocks, horizontall
(define SIZE 10) ; blocks are squares
(define HSIZE (/ SIZE 2))
(define SCENE-SIZE (* WIDTH SIZE))
(define LIMIT (- SIZE 1))

(define BLOCK ; red squares with black rims
  (overlay
    (square LIMIT "solid" "red")
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

; Block -> Boolean
; Determines if a block landed on the bottom of the scene
(check-expect (blockfall? (make-block 5 1)) #false)
(check-expect (blockfall? (make-block 5 LIMIT)) #true)

(define (blockfall? b)
  (cond
    [(>= (block-y b) LIMIT) #true]
    [else #false]))



;; KEY HANDLER

; Tetris KeyEvent -> Tetris
; Controls the horizontal movement of the dropping block
(check-expect (keyh (make-tetris (make-block 5 6) '()) "left") (make-tetris (make-block 4 6) '()))
(check-expect (keyh (make-tetris (make-block 2 3) '()) "right") (make-tetris (make-block 3 3) '()))
(check-expect (keyh (make-tetris (make-block 0 8) '()) "left") (make-tetris (make-block 0 8) '()))
(check-expect (keyh (make-tetris (make-block LIMIT 6) '()) "right") (make-tetris (make-block LIMIT 6) '()))
(check-expect (keyh (make-tetris (make-block 3 5) (list (make-block 4 5))) "right") (make-tetris (make-block 3 5) (list (make-block 4 5))))
(check-expect (keyh (make-tetris (make-block 7 6) (list (make-block 6 6))) "left") (make-tetris (make-block 7 6) (list (make-block 6 6))))
(check-expect (keyh (make-tetris (make-block 7 6) (list (make-block 6 6))) "r") (make-tetris (make-block 7 6) (list (make-block 6 6))))

(define (keyh t ke)
  (cond
    [(string=? "right" ke) (move-right (tetris-block t) (tetris-landscape t) "right")]
    [(string=? "left" ke) (move-left (tetris-block t) (tetris-landscape t) "left")]
    [else t]))

; Block Landscape String -> Tetris
; Moves right or left if there's nothing there
(check-expect (move-right (make-block 2 3) '() "right") (make-tetris (make-block 3 3) '()))
(check-expect (move-right (make-block LIMIT 4) '() "right") (make-tetris (make-block LIMIT 4) '()))
(check-expect (move-right (make-block 3 5) (list (make-block 4 5)) "right") (make-tetris (make-block 3 5) (list (make-block 4 5))))
(check-expect (move-left (make-block 5 6) '() "left") (make-tetris (make-block 4 6) '()))
(check-expect (move-left (make-block 0 8) '() "left") (make-tetris (make-block 0 8) '()))
(check-expect (move-left (make-block 7 6) (list (make-block 6 6)) "left") (make-tetris (make-block 7 6) (list (make-block 6 6))))

(define (move-right b l s)
  (cond
    [(= (block-x b) LIMIT) (make-tetris b l)]
    [(something-right? b l) (make-tetris b l)]
    [else (make-tetris (make-block (+ (block-x b) 1) (block-y b)) l)]))

(define (move-left b l s)
  (cond
    [(= (block-x b) 0) (make-tetris b l)]
    [(something-left? b l) (make-tetris b l)]
    [else (make-tetris (make-block (- (block-x b) 1) (block-y b)) l)]))

; Block Landscape -> Boolean
; Determines if there's something to the right or left of the block
(check-expect (something-right? (make-block 3 5) '()) #false)
(check-expect (something-right? (make-block 3 5) (list (make-block 7 7))) #false)
(check-expect (something-right? (make-block 3 5) (list (make-block 1 9) (make-block 4 5))) #true)
(check-expect (something-left? (make-block 3 5) '()) #false)
(check-expect (something-left? (make-block 3 5) (list (make-block 7 7))) #false)
(check-expect (something-left? (make-block 3 5) (list (make-block 1 9) (make-block 2 5))) #true)

(define (something-right? b l)
  (cond
    [(empty? l) #false]
    [(and (= (+ (block-x b) 1) (block-x (first l)))
          (= (block-y b) (block-y (first l)))) #true]
    [else (something-right? b (rest l))]))

(define (something-left? b l)
  (cond
    [(empty? l) #false]
    [(and (= (- (block-x b) 1) (block-x (first l)))
          (= (block-y b) (block-y (first l)))) #true]
    [else (something-left? b (rest l))]))



;; STOP WHEN

; Tetris -> Boolean
; Stops the program when a block reaches the top of the scene
(check-expect (last-world? (make-tetris (make-block 2 0) '())) #false)
(check-expect (last-world? (make-tetris (make-block 2 0) (list (make-block 5 7)))) #false)
(check-expect (last-world? (make-tetris (make-block 2 0) (list (make-block 5 0)))) #true)

(define (last-world? t)
  (last-world?* (tetris-block t) (tetris-landscape t)))

; Block Landscape -> Boolean
; Determines if a Block of a Given Landscape reached the top of the scene
(check-expect (last-world?* (make-block 2 0) '()) #false)
(check-expect (last-world?* (make-block 2 0) (list (make-block 5 7))) #false)
(check-expect (last-world?* (make-block 2 0) (list (make-block 5 0))) #true)

(define (last-world?* b l)
  (cond
    [(empty? l) #false]
    [else (if (= (block-y (first l)) 0)
              #true
              (last-world?* b (rest l)))]))



;; MAIN

(define (main x)
  (big-bang x
    [to-draw render]
    [on-tick tock 0.2]
    [on-key keyh]
    [stop-when last-world?]))