#lang racket

(require 2htdp/image) ;;支持图像处理

(define cat .)


(if (> (image-height cat) (image-width cat))
    "tall"
    "wide")



(define rec
  (rectangle 50 50 "outline" "red"))

(if (> (image-height rec) (image-width rec))
      "tall"
      (if (< (image-height rec) (image-width rec))
          "wide"
          (if (= (image-height rec) (image-width rec))
              "equal"
              "error")))