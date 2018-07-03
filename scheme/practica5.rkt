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

;; Ejercicio 1
(define (cuadrado num)
  (* num num))

(define (cuadrado-lista lista)
  (cuadrado-lista-iter lista '()))

(define (cuadrado-lista-iter lista resul)
  (if (null? lista)
      resul
      (cuadrado-lista-iter (cdr lista) (append resul (list (cuadrado (car lista)))))))

(define (max-lista lista)
  (max-lista-iter lista 0))

(define (max-lista-iter lista resul)
  (if (null? lista)
      resul
      (max-lista-iter (cdr lista) (if (> (car lista) resul)
                                      (car lista)
                                      resul))))

;; Ejercicio 2
(define (expande-pareja pareja)
  (expande-pareja-iter pareja '()))

(define (expande-pareja-iter pareja resul)
  (if (= (cdr pareja) 0)
      resul
      (expande-pareja-iter (cons (car pareja) (- (cdr pareja) 1)) (append resul (list (car pareja))))))

(define (expande lista)
  (expande-iter lista '()))

(define (expande-iter lista resul)
  (if (null? lista)
      resul
      (expande-iter (cdr lista) (append resul (expande-pareja (car lista))))))

;; Ejercicio 3
(define (aplica-funciones lista-parejas)
  (aplica-funciones-iter2 lista-parejas '()))

(define (aplica-funciones-iter1 lista resul)
  (if (null? lista)
      resul
      (aplica-funciones-iter1 (cdr lista) (append resul (list ((car (car lista)) (cdr (car lista))))))))

(define (aplica-funciones-iter2 lista resul)
  (if (null? lista)
      resul
      (aplica-funciones-iter2 (cdr lista) (append resul (list ((lambda (x)
                                                          ((car x) (cdr x))) (car lista)))))))








