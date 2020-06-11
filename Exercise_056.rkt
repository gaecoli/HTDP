(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (+ 1 x)]
    [(>= x 0) (+ x YDELTA)]))