#lang racket

(define-struct movie [title producer year])
(define-struct t-l
  (make-movie "Thelma & Louise" "Pathé Entertainment" "1991"))
(movie-title t-l)    
(movie-producer t-l) 
(movie-year t-l)      
(movie? t-l)          

(define-struct person [name hair eyes phone])
(define-struct me (make-person "reese" #t #t #t))
(person-name me)   
(person-hair me)  
(person-eyes me)   
(person-phone me)  
(person? me)       

(define-struct pet [name number])
(define-struct a-cat (make-pet "raisins" 1))
(pet-name a-cat)   
(pet-number a-cat) 
(pet? a-cat)       

(define-struct CD [artist title price])
(define-struct my-first-cd (make-CD
  "Smash Mouth" "Astro Lounge" 19.99))
(CD-artist my-first-cd)  
(CD-title my-first-cd)   
(CD-price my-first-cd) 
(CD? my-first-cd)       

(define-struct sweater [material size producer])
(define-struct fancy-sw
  (make-sweater "wool" "small" "a tiny nordic island"))
(sweater-material fancy-sw) 
(sweater-size fancy-sw)     
(sweater-producer fancy-sw) 
(sweater? fancy-sw)         