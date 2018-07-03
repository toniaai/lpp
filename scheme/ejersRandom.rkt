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


;;
;; Barrera de abstracción arbol binario
;;

(define (dato-arbolb arbol)
   (car arbol))
   
(define (hijo-izq-arbolb arbol)
   (cadr arbol))

(define (hijo-der-arbolb arbol)
   (caddr arbol))

(define (hoja-arbolb? arbol)
  (and (vacio-arbolb? (hijo-izq-arbolb arbol))
       (vacio-arbolb? (hijo-der-arbolb arbol))))
   
(define (vacio-arbolb? x)
   (null? x))

(define arbolb-vacio '())

(define (arbol-sust arbol elem-old  elem-new)
  (construye-arbol (if (equal? (dato-arbol arbol) elem-old)
            elem-new
            (dato-arbol arbol))
        (arbol-sust-bosque (hijos-arbol arbol) elem-old elem-new)))

(define (arbol-sust-bosque bosque elem-old elem-new)
  (if (null? bosque)
      '()
      (cons (arbol-sust (car bosque) elem-old elem-new)
              (arbol-sust-bosque (cdr bosque) elem-old elem-new))))

(define arbolSust '(a (b (c) (d)) (c (e)) (f (c) (c))))

(define (arbol-sust-fos arbol elem-old elem-new)
  (construye-arbol (if (equal? (dato-arbol arbol) elem-old)
                       elem-new
                       (dato-arbol arbol)) (map (lambda (x)
                                                  (arbol-sust-fos x elem-old elem-new)) (hijos-arbol arbol))))

