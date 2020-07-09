#lang racket

(require 2htdp/image) ;;支持图像处理

;;树
(define TREE-SIZE 400)

(overlay/xy    (triangle (/ TREE-SIZE 2) "solid" "seagreen")
               (/ TREE-SIZE 5) (/ TREE-SIZE 10)
               (rectangle (/ TREE-SIZE 10)(/ TREE-SIZE 2) "solid" "brown"))


;;船体

(define BOAT-SIZE 100)

(above (overlay/xy    (triangle (* BOAT-SIZE 1.5) "solid" "red")
                      (* BOAT-SIZE .75) (/ BOAT-SIZE 10)
                      (rectangle (/ BOAT-SIZE 25) (* BOAT-SIZE 1.25) "solid" "brown"))

       (beside (triangle/sas (/ BOAT-SIZE 4) 90 (/ BOAT-SIZE 4) "solid" "blue")
               (rectangle (* BOAT-SIZE 1.25) (/ BOAT-SIZE 4) "solid" "blue")
               (triangle/ass 90 (/ BOAT-SIZE 4) (/ BOAT-SIZE 4) "solid" "blue")))