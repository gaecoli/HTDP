#lang racket

(check-expect `(0 ,@'(1 2 3) 4)
              (list 0 1 2 3 4))

(check-expect `(("alan" ,(* 2 500))
                ("barb" 2000)
                (,@'("carl" " , the great")   1500)
                ("dawn" 2300))
              (list (list "alan" 1000)
                    (list "barb" 2000)
                    (list "carl" " , the great" 1500)
                    (list "dawn" 2300)))

(check-expect `(html
                (body
                 (table ((border "1"))
                        (tr ((width "200"))
                            ,@(make-row '( 1  2)))
                        (tr ((width "200"))
                            ,@(make-row '(99 65))))))
              (list 'html
                    (list 'body
                          (list 'table (list (list 'boder "1"))
                                (list 'tr (list (list 'width "200")) (list 'td "1") (list 'td "2"))
                                (list 'tr (list (list 'width "200")) (list 'td "99") (list 'td "65"))))))


(define (make-row l)
  (cond
    [(empty? l) '()]
    [else (cons (make-cell (first l))
                (make-row (rest l)))]))
 

(define (make-cell n)
  `(td ,(number->string n)))