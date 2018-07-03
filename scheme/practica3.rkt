#lang r6rs
(import (rnrs)
        (schemeunit))

;; Ejercicio 1
(define (multiplo-de n lista)
  (cond
    ((null? lista) '())
    (( = (mod (car lista) n) 0) (cons #t (multiplo-de n (cdr lista))))
    (else (cons #f (multiplo-de n (cdr lista))))))

(define (multiplos-de n lista)
  (cond
    ((null? lista) '())
    ((= (mod (car lista) n) 0) (cons (car lista) (multiplos-de n (cdr lista))))
    (else (multiplos-de n (cdr lista)))))


                               