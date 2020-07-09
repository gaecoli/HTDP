#lang racket
(define str "helloworld") ;;定义字符串str
(define i 5)  ;;定义追加的位置

;;解决追加问题
(string-append (substring str 0 i)
               "_"
               (substring str i 10))