#lang racket

(define (string-first x)
  (if (>= (string-length x) 1)
      ;如果字符串不为空则接着下面结果
      (substring x 0 1)
      ;如果字符串为空，以下结果
      "The string is empty"))