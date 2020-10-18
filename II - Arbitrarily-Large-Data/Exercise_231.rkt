#lang racket

(check-expect '(1 "a" 2 #false 3 "c")
              (list 1 "a" 2 #false 3 "c"))


(check-expect '()
              '())


; And this table-like shape:

(check-expect '(("alan" 1000)
                ("barb" 2000)
                ("carl" 1500))
              (list (list "alan" 1000)
                    (list "barb" 2000)
                    (list "carl" 1500)))


; Now eliminate list in favor of cons where needed.

(check-expect (list 1 "a" 2 #false 3 "c")
              (cons 1 (cons "a" (cons 2 (cons #false (cons 3 (cons "c" '())))))))

(check-expect (list (list "allan" 1000)
                    (list "barb" 2000)
                    (list "carl" 1500))
              (cons (cons "allan" (cons 1000 '()))
                    (cons (cons "barb" (cons 2000 '()))
                          (cons (cons "carl" (cons 1500 '())) '()))))