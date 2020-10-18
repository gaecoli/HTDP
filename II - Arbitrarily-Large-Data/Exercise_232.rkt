#lang racket

(define title "ratings")  ; Where (define title "ratings").

(check-expect `(1 "a" 2 #false 3 "c")
              (list 1 "a" 2 #false 3 "c"))


(check-expect `(("alan" ,(* 2 500))
                ("barb" 2000)
                (,(string-append "carl" " , the great") 1500)
                ("dawn" 2300))
              (list (list "alan" 1000)
                    (list "barb" 2000)
                    (list "carl , the great" 1500)
                    (list "dawn" 2300)))


(check-expect `(html
                (head
                 (title ,title))
                (body
                 (h1 ,title)
                 (p "A second web page")))
              (list 'html
                    (list 'head
                          (list 'title "ratings"))
                    (list 'body
                          (list 'h1 "ratings")
                          (list 'p "A second web page"))))