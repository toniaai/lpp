#lang r6rs
(import (rnrs)
        (schemeunit))

;; Funcion recursiva ordenada-lista-parejas? lista-parejas que
;; recibe una lista con parejas de numeros y comprueba si están en
;; orden creciente una pareja de numeros es mayor que otra cuando
;; sus numeros suman más

(define (suma-pareja pareja)
  (+ (car pareja) (cdr pareja)))

(define (ordenada-lista-parejas lista-parejas)
  (cond
    ((null? (cdr lista-parejas)) #t)
    ((< (suma-pareja (car lista-parejas)) (suma-pareja (cadr lista-parejas)))
     (ordenada-lista-parejas (cdr lista-parejas)))
    (else #f)))

;; Funcino suma-lista-parejas fos lista-parejas que use la funcion de
;; orden superior fold-right para sumar todos los numeros de una lista de
;; parejas

(define (suma-lista-parejas-fos lista-parejas)
  (fold-right (lambda (x y)
                (+ (suma-pareja x) y)) 0 lista-parejas))

;; Funcion recursiva pertenece? dato lista que devuelve #t o #~f
;; dependiendo si un dato esta o no en la lista

(define (pertenece? dato lista)
  (if (null? lista)
      #f
      (if (equal? (car lista) dato)
          #t
          (pertenece? dato (cdr lista)))))

;; implementa la funcion recursiva (listas-contiene-elem elem lista)
;; que recibe una lista de lsitas y devuelve las listas que contienen
;; el elemento elem

(define (listas-contiene-elem1 elem lista)
  (if (null? lista)
      '()
      (if (pertenece? elem (car lista))
          (cons (car lista) (listas-contiene-elem1 elem (cdr lista)))
          (listas-contiene-elem1 elem (cdr lista)))))

(define (listas-contiene-elem elem lista)
  (if (null? lista)
      '()
      (append (if (pertenece? elem (car lista))
                (list (car lista))
                '()) (listas-contiene-elem elem (cdr lista)))))

(define (listas-contiene-elem-fos elem lista)
  (filter (lambda (x)
            (pertenece? elem x)) lista))

 (define lista1 (list '(s i) '(h e) '(h e c h o) '(p r a c t i c a s) '(a p r o b a r e)))

;; Funcion dias-mes n mes que devuelve una lista de parejas que
;; representan los dias de un determinado mes desde el dia 1
;; hasta el dia n indicado como parametro

(define (dias-mes n mes)
  (if (= n 0)
      '()
      (append (dias-mes (- n 1) mes) (list (cons n mes)))))

;; Funcion calendario-fijo n lista-meses utilizando funciones de orden superior
;; que devuelva una lista de parejas que representan los dias de todos los meses
;; indicados en lista-meses y con los primeros n días de cada mes. Todos los meses
;; tienen el mismo numero de dias

(define (calendario-fijo n lista-meses)
  (fold-right append '() (map (lambda (x)
                                (dias-mes n x)) lista-meses)))