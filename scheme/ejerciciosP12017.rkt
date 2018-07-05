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

;; Funcion que devuelve true si una lista con una serie de numeros pasan por 0 entre uno y otro.
(define (cruza-cero lista)
  (cond
    ((null? (cdr lista)) #f)
    ((and (< (car lista) 0)
          (> (cadr lista) 0)) #t)
    ((and (> (car lista) 0)
          (< (cadr lista) 0)))
    (else (cruza-cero (cdr lista)))))

(define listaCruza '(-20 -10 5 10 20))
(define listaCruzaInv '(20 4 -2 -9))
(define listaNoCruza '(12 10 9 8 7))

;; Funcion que devuelve una palabra con 1 letra menos cada vez
(define (palabra-menos lista)
  (if (null? lista)
      '()
      (append (list lista) (palabra-menos (cdr lista)))))

;; misma funcion pero si es un simbolo
(define (palabra-menos-string palabra)
  (if (= (string-length palabra) 0)
      '()
      (cons (list palabra) (palabra-menos-string (list->string (cdr (string->list palabra)))))))

;; Funcion que recibe una lista de numeros y devuelve una pareja formada por dos listas tal que:
;; ( Pares . Impares )

(define (pares-impares lista-numeros)
  (cond
    ((null? lista-numeros) (list (list) (list)))
    ((even? (car lista-numeros)) (cons (cons (car lista-numeros) (car (pares-impares (cdr lista-numeros)))) (cadr (pares-impares (cdr lista-numeros)))))
    ((odd? (car lista-numeros)) (cons (car (pares-impares (cdr lista-numeros))) (cons (car lista-numeros) (cadr (pares-impares (cdr lista-numeros))))))))

(define listaPares '(1 2 3 4 5 6 7 8 9 0))

;; con auxiliar

(define (push-izq elemento pareja)
  (list (cons elemento (car pareja)) (cadr pareja)))

(define (push-der elemento pareja)
  (list (car pareja) (cons elemento (cadr pareja))))

(define (pares-impares-aux lista-numeros)
  (cond
    ((null? lista-numeros) (list (list) (list)))
    ((even? (car lista-numeros)) (push-izq (car lista-numeros) (pares-impares-aux (cdr lista-numeros))))
    ((odd? (car lista-numeros)) (push-der (car lista-numeros) (pares-impares-aux (cdr lista-numeros))))))

;; fos

(define (pares-impares-fos lista-numeros)
  (fold-right (lambda (x y)
                (if (even? x)
                    (push-izq x y)
                    (push-der x y))) (list (list) (list)) lista-numeros))

;; rellenar huecos (ya rellenados aquí:
;; d.1
(check-equal?
(filter ;; rellenar aquí
 (lambda (x)
   (> x 100))
 
'(3 8 90 99 100 102 105))
'(102 105))

;; d.2
(check-equal?
(map ;; <= rellenado
(lambda (x)
(+ x 2))
'(1 12 9 4))
'(3 14 11 6))

;; Funcion que dado dos numeros que representan los extremos de un intervalo devuelve la lista de numeros etneros entre esos valores
(define (numeros-en-intervalo a b)
  (if (= (+ a 1) b)
      '()
      (cons (+ a 1) (numeros-en-intervalo (+ a 1) b))))

;; Funcion que recibe lista de parejas que representan puntsos 2D (coords x y) y un simbolo
;; que representa una coordenada y un numero siendo su valor, devuelve la lista de puntos que
;; tienen el mismo valor de coordenada

(define (comprueba-punto pareja coord n)
  (if (equal? coord 'x)
      (if (= (car pareja) n)
             (list pareja)
             '())
      (if (= (cdr pareja n))
             (list pareja)
             '())))

(define (puntos-coordenada lista coord n)
  (if (null? lista)
      '()
      (append (comprueba-punto (car lista) coord n) (puntos-coordenada (cdr lista) coord n))))

(define (en-cuadrante punto)
  (cond
    ((and (>= (car punto) 0) (>= (cdr punto) 0)) 2)
    ((and (< (car punto) 0) (>= (cdr punto) 0)) 1)
    ((and (>= (car punto) 0) (< (cdr punto) 0)) 3)
    ((and (< (car punto) 0) (< (cdr punto) 0)) 4)))

;; con fos implementar una funcion que dado una lista de puntos y un numero que representa un
;; cuadrante devolver la suma de las coordenadas x e y de todos los puntos de ese cuadrante
(define listaCuadrante (list (cons 1 1) (cons -1 2) (cons 3 4) (cons -4 10) (cons -2 -2)))

(define (suma-cuadrante lista cuadrante)
  (fold-right (lambda (x y)
                (cons (+ (car x) (car y))
                      (+ (cdr x) (cdr y)))) (cons 0 0) (filter (lambda (x)
                                                                 (equal? (en-cuadrante x) cuadrante)) lista)))


;; dada las funciones:

(define (suma-p1 pred elem lista)
  (if (pred elem)
      (cons (+ 1 (car lista)) (cdr lista))
      lista))

(define (suma-p2 pred elem lista)
  (if (pred elem)
      (cons (car lista) (cons (+ 1 (cadr lista)) '()))
      lista))

;; expresion para que suma-p1 devuelva {2 3}
(suma-p1 even? 4 '(1 3))

;; expresion para que suma-p2 devuelva {3 1}
(suma-p2 odd? 1 '(3 0))

;; Funcion que recibe 2 predicados y una lista, y devuelve una lista de 2 elementos
;; donde cada uno es el total de elementos de la lista q cumplen cada predicado

(define (cuenta-2 p1 p2 lista)
  (if (null? lista)
      (list 0 0)
      (suma-p1 p1 (car lista) (suma-p2 p2 (car lista) (cuenta-2 p1 p2 (cdr lista))))))