#lang r6rs
(import (rnrs)
        (schemeunit))

;; Ejercicio 1
(define (binario-a-decimal b3 b2 b1 b0)
  (+ (* b3 8)
     (* b2 4)
     (* b1 2)
     (* b0 1)))

;; Ejercicio 2
(define (mayor n1 n2)
  (if (> n1 n2)
      n1
      n2))

(define (mayor-de-tres n1 n2 n3)
  (mayor (mayor n1 n2) n3))

;; Ejercicio 4
(define (suma-pareja pareja)
  (+ (car pareja) (cdr pareja)))

(define (tirada-ganadora t1 t2)
  (if (> (suma-pareja t1)
         (suma-pareja t2))
      1
      2))



      


