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

;; Definir la version iterativa de la siguiente funcion:

(define (suma lista)
  (if (null? (cdr lista))
      (car lista)
      (+ (car lista) (suma (cdr lista)))))

(define (suma-fun lista)
  (suma-fun-iter lista 0))

(define (suma-fun-iter lista resul)
  (if (null? lista)
      resul
      (suma-fun-iter (cdr lista) (+ resul (car lista)))))

;; Funcion elimina-elem elem lista que devuelve la lista dada
;; sin las ocurrencias de elem

(define (elimina-elem elem lista)
  (elimina-elem-iter elem lista '()))

(define (elimina-elem-iter elem lista resul)
  (if (null? lista)
      resul
      (elimina-elem-iter elem (cdr lista) (append resul (if (equal? (car lista) elem)
                                                            '()
                                                            (list (car lista)))))))

;; (primero lista) que devuelve la primera hoja de una lista estructuradda
(define (primero lista)
  (if (hoja? lista)
      lista
      (primero (car lista))))

;; (ultimo lista) devuelve la ultima hoja de una lista
(define (ultimo lista)
  (if (hoja? lista)
      lista
      (if (null? (cdr lista))
          (ultimo (car lista))
          (ultimo (cdr lista)))))

(define lista1  '((1 2 (3)) 7 (5 (6))))
;;ordenada? comprueba si una lista de numeros tiene sus hojas ordenadas, una lista esta ordenada
;; si el primero es menos que el ultimo respectivamente

(define (ordenada? lista)
  (cond
    ((null? lista) #t)
    ((hoja? lista) #t)
    ((> (primero lista) (ultimo lista)) #f)
    (else (and (ordenada? (car lista))
               (ordenada? (cdr lista))))))


;; sustituye-elem lista elem-old elem-new
(define (sustituye-elem lista elem-old elem-new)
  (cond
    ((null? lista) '())
    ((hoja? lista) (if (equal? lista elem-old) elem-new lista))
    (else (cons (sustituye-elem (car lista) elem-old elem-new)
                (sustituye-elem (cdr lista) elem-old elem-new)))))

(define lista  '(1 2 (3 4 (5 3)) 3 (8 (3) 10)))

(define (sustituye-elem-fos lista elem-old elem-new)
  (map (lambda (elem)
         (if (hoja? elem)
             (if (equal? elem elem-old)
                 elem-new
                 elem)
             (sustituye-elem-fos elem elem-old elem-new))) lista))

;; sustituye elem pero en un arbol

(define (sustituye-elem-arbol arbol elem-old elem-new)
  (construye-arbol (if (equal? (dato-arbol arbol) elem-old)
                       elem-new
                       (dato-arbol arbol))
                   (sustituye-elem-bosque (hijos-arbol arbol) elem-old elem-new)))

(define (sustituye-elem-bosque bosque elem-old elem-new)
  (if (null? bosque)
      '()
      (cons (sustituye-elem-arbol (car bosque) elem-old elem-new)
            (sustituye-elem-bosque (cdr bosque) elem-old elem-new))))

(define arbol '(4 (5 (2) (3)) (10) (20 (40) (15 (13) (3)) (17) (19 (18)))))

;; sustituye elem fos

(define (sustituye-elem-arbol-fos arbol elem-old elem-new)
  (construye-arbol (if (equal? (dato-arbol arbol) elem-old)
                       elem-new
                       (dato-arbol arbol)) (map (lambda (x)
                                            (sustituye-elem-arbol-fos x elem-old elem-new)) (hijos-arbol arbol))))

;; mayor-dato-tree tree que devuelve el mayor numero de un arbol

(define (mayor-dato-tree arbol)
  (max (dato-arbol arbol)
       (mayor-dato-tree-bosque (hijos-arbol arbol))))

(define (mayor-dato-tree-bosque bosque)
  (if (null? bosque)
      0
      (max (mayor-dato-tree (car bosque))
           (mayor-dato-tree-bosque (cdr bosque)))))

;; FOS

(define (mayor-dato-tree-fos arbol)
  (fold-right (lambda (x y)
                (if (> x y)
                    x
                    y)) (dato-arbol arbol) (map (lambda (x)
                                                  (mayor-dato-tree-fos x)) (hijos-arbol arbol))))

