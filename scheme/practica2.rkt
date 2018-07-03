#lang r6rs
(import (rnrs)
        (schemeunit))


;; Ejercicio 1
(define (mayor n1 n2)
  (if (> n1 n2)
      n1
      n2))

(define (maximo lista)
  (if (null? lista)
  0
  (mayor (car lista) (maximo (cdr lista)))))


;; Ejercicio 2
(define (pertenece? elem lista)
  (cond
    ((null? lista) #f)
    ((equal? elem (car lista)) #t)
    (else (pertenece? elem (cdr lista)))))


(define (repetidos? lista)
  (cond
    ((null? lista) #f)
    ((pertenece? (car lista) (cdr lista)) #t)
    (else (repetidos? (cdr lista)))))

;; Ejercicio 4
(define (binario-a-decimal lista-bits)
  (if (null? lista-bits)
      0
      (+ (* (car lista-bits) (expt 2 (length (cdr lista-bits))))
         (binario-a-decimal (cdr lista-bits)))))


;; Ejercicio 5
(define (ordenada-creciente? lista-nums)
  (cond
    ((null? (cdr lista-nums)) #t)
    ((< (car lista-nums) (cadr lista-nums)) (ordenada-creciente? (cdr lista-nums)))
    (else #f)))

;; Ejercicio 6
(define (inc-izq pareja)
  (cons (+ (car pareja) 1) (cdr pareja)))

(define (inc-der pareja)
  (cons (car pareja) (+ (cdr pareja) 1)))

(define (cuenta-impares-pares lista-num)
  (cond
    ((null? lista-num) (cons 0 0))
    ((even? (car lista-num)) (inc-der (cuenta-impares-pares (cdr lista-num))))
    ((odd? (car lista-num)) (inc-izq (cuenta-impares-pares (cdr lista-num))))
    (else (cuenta-impares-pares (cdr lista-num)))))

;; Ejercicio 7
(define (cadena-mayor lista)
  (cond
    ((null? lista) (cons "" 0))
    ((> (string-length (car lista)) (cdr (cadena-mayor (cdr lista)))) (cons (car lista) (string-length (car lista))))
    (else (cadena-mayor (cdr lista)))))



