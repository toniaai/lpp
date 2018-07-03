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

;; Ejercicio 2
(define (cuenta-pares lista)
  (cond
    ((null? lista) 0)
    ((hoja? lista) (if (even? lista) 1 0))
    (else (+ (cuenta-pares (car lista))
             (cuenta-pares (cdr lista))))))

;; Ejercicio 3
(define (cumplen-predicado pred lista)
  (cond
    ((null? lista) '())
    ((hoja? lista) (if (pred lista) (list lista) '()))
    (else (append (cumplen-predicado pred (car lista))
                (cumplen-predicado pred (cdr lista))))))

;; Ejercicio 4
(define (sustituye-elem lista elem-old elem-new)
  (cond
    ((null? lista) '())
    ((hoja? lista) (if (equal? elem-old lista) elem-new lista))
    (else (cons (sustituye-elem (car lista) elem-old elem-new)
                (sustituye-elem (cdr lista) elem-old elem-new)))))

;; Ejercicio 5
(define (diff-listas l1 l2)
  (cond
    ((null? l1) '())
    ((hoja? l1) (if (equal? l1 l2) '() (list (cons l1 l2))))
    (else (append (diff-listas (car l1) (car l2))
                  (diff-listas (cdr l1) (cdr l2))))))
 

(check-equal? (diff-listas-fos '(a (b ((c)) d e) f) '(1 (b ((2)) 3 4) f)) '((a . 1) (c . 2) (d . 3) (e . 4)))
;; Ejercicio 6

(define (cuenta-hojas-debajo-nivel lista n)
  (cond
    ((null? lista) 0)
    ((hoja? lista) (if (< n 0) 1 0))
    (else (+ (cuenta-hojas-debajo-nivel (car lista) (- n 1))
             (cuenta-hojas-debajo-nivel (cdr lista) n)))))

(define (cuenta-hojas-debajo-nivel-fos lista n)
  (fold-right + 0 (map (lambda (x)
                         (if (hoja? x)
                             (if (<= n 0)
                                 1
                                 0)
                             (cuenta-hojas-debajo-nivel-fos x (- n 1)))) lista)))

(define (max-cdr pareja1 pareja2)
  (if (> (cdr pareja1)
         (cdr pareja2))
         pareja1
         pareja2))

(define (nivel-elemento lista)
  (cond
    ((null? lista) (cons 0 0))
    ((hoja? lista) (cons lista 0))
    (else (max-cdr (cons (car (nivel-elemento (car lista))) (+ (cdr (nivel-elemento (car lista))) 1))
                   (nivel-elemento (cdr lista))))))



(define (nivel-elemento-fos lista nivel)
  (fold-right max-cdr (cons 0 0) (map (lambda (x)
                                        (if (hoja? x)
                                            (cons x nivel)
                                            (nivel-elemento-fos x (+ nivel 1)))) lista)))

(define (en-nivel lista nivel)
  (cond
    ((null? lista) '())
    ((hoja? lista) nivel)
    (else (cons (en-nivel (car lista) (+ nivel 1))
                (en-nivel (cdr lista) nivel)))))



