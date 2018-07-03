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

(define (cumple-predicados lista n)
  (if (null? lista)
      '()
      (cons ((car lista) n)
            (cumple-predicados (cdr lista) n))))

(define (g f)   (lambda (x) (f (f (f x))))) (define (suma-1 x) (+ x 1))

(define (n-ultimos lista n)
  (cond
    ((null? lista) '())
    ((< (length (n-ultimos (cdr lista) n)) n) (cons (car lista)
                                                           (n-ultimos (cdr lista) n)))
    (else (n-ultimos (cdr lista) n))))

