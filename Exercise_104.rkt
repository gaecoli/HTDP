#lang racket

(define-struct name [first last])
(define-struct student [name gpa])

(define-struct professor [name tenure])
 ( ... (professor-name p) ... (professor-tenure p) ... )
(define-struct staff [name group])