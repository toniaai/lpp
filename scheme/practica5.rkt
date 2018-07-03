#lang r6rs
(import (rnrs)
        (schemeunit))

(define (dato-arbol arbol)
  (car arbol))

(define (hijos-arbol arbol)
  (cdr arbol))

(define (hoja? dato)
   (not (list? dato)))

(define (construye-arbol dato lista-arboles)
  (cons dato lista-arboles))

(define (cuadrado n)
  (* n n))
; ejercicio 1

(define (cuadrado-lista lista)
  (cuadrado-lista-iter lista '()))

(define (cuadrado-lista-iter lista resul)
  (if (null? lista)
      resul
      (cuadrado-lista-iter (cdr lista) (append resul (list (cuadrado (car lista)))))))