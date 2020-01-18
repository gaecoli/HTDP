#lang racket
(define str "helloworld")
(define ind "0123456789")	;;字符串下标索引
(define i 5)

(string-append (substring str 0 i)
               (substring str (+ i 1) 10))