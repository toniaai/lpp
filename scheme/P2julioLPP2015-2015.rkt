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

(define (elimina-elem elem lista)
  (elimina-elem-iter elem lista '()))

(define (elimina-elem-iter elem lista resul)
  (if (null? lista)
      resul
      (elimina-elem-iter elem (cdr lista) (append resul (if (equal? (car lista) elem)
                                                                          '()
                                                                          (list (car lista)))))))


(define (primero lista)
  (if (hoja? lista)
      lista
      (primero (car lista))))

(define (ultimo l)
  (cond ((null? (cdr l)) (car l))
        (else (ultimo (cdr l)))))
