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

(define (max-arbol arbol)
  (max (dato-arbol arbol)
       (max-bosque (hijos-arbol arbol))))

(define (max-bosque bosque)
  (if (null? bosque)
      0
      (max (max-arbol (car bosque))

           
(define (max-arbol-fos arbol)
  (fold-right (lambda (x y)
                (if (> x y)
                    x
                    y)) (dato-arbol arbol) (map (lambda (x)
                                                  (max-arbol-fos x)) (hijos-arbol arbol))))

(define arbolMax '(10 (20 (4) (3)) (12 (1) (2)) (15 (21) (2))))


(define (lista-nivel-tree nivel arbol)
  (if (= nivel 0)
      (list (dato-arbol arbol))
      (lista-nivel-bosque (- nivel 1) (hijos-arbol arbol))))

(define (lista-nivel-bosque nivel bosque)
  (if (null? bosque)
      '()
      (append (lista-nivel-tree nivel (car bosque))
              (lista-nivel-bosque nivel (cdr bosque)))))

(define (lista-nivel-tree-fos nivel arbol)
  (fold-right append '() (map (lambda (x)
                                (if (<= nivel 0)
                                    x
                                    (lista-nivel-tree-fos (- nivel 1) x))) (hijos-arbol arbol))))


(define arbolNivel '(1 (2 (3 (4) (2)) (5)) (6 (7))))
