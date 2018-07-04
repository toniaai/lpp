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

;; EJERCICIOS EXAMENES 2014 2015

;; Dada la función:

(define (f x)
  (lambda (y)
    (* x y)))

;; Escribe una expresión de scheme correcta en la que se invoque a f
;; y devuelva 12

((f 3) 4)

;; Triangulo n.

(define (linea-triangulo n)
  (if (= n 0)
      '()
      (cons '* (linea-triangulo (- n 1)))))

(define (triangulo n)
  (if (= n 0)
      '()
      (cons (linea-triangulo n) (triangulo (- n 1)))))

;; Dada una lista con al menos dos numeros escribe una funcion recursiva
;; que devuelva la pareja de numeros consecutivos cuya suma es la mayor de todas

(define (suma-pareja pareja)
  (+ (car pareja) (cdr pareja)))

(define (mayor-pareja lista)
  (cond
    ((null? (cdr lista)) (cons (car lista) 0))
    ((> (suma-pareja (cons (car lista) (cadr lista))) (suma-pareja (mayor-pareja (cdr lista)))) (cons (car lista) (cadr lista)))
    (else (mayor-pareja (cdr lista)))))


;; Escribe la funcion expande lista-parejas utilizando funciones de orden superior.
;; la funcion recibe una lista de parejas que contiene un dato y un numero
;; y devuelve una lista donde se han expandido las parejas, repitiendo tantos elementos
;; como el numero que indica cada pareja

(define (expande-pareja pareja)
  (if (= (cdr pareja) 0)
      '()
      (cons (car pareja) (expande-pareja (cons (car pareja) (- (cdr pareja) 1))))))

(define (expande lista-parejas)
  (fold-right append '() (map (lambda (x)
                                (expande-pareja x)) lista-parejas)))


;; Implementa las funciones suma-izq y suma-der de forma que reciben un numero
;; y una pareja y le suman el numero al lado respecivo de cada funcion

(define (suma-izq n pareja)
  (cons (+ (car pareja) n) (cdr pareja)))

(define (suma-der n pareja)
  (cons (car pareja) (+ (cdr pareja) 1)))

;; Implementa la funcion recursiva filtra-cadenas de forma que recibe una lista
;; de cadenas y una lista de numero enteros y devuelve una lista de parejas
;; donde cada pareja es una cadena que tenga la misma longitud que el entero
;; en la misma posicion de cada lista.

(define (filtra-cadenas lista-cadenas lista-num)
  (cond
    ((null? lista-cadenas) '())
    ((equal? (string-length (car lista-cadenas)) (car lista-num)) (cons (cons (car lista-cadenas) (car lista-num))
                                                                        (filtra-cadenas (cdr lista-cadenas) (cdr lista-num))))
    (else (filtra-cadenas (cdr lista-cadenas) (cdr lista-num)))))

;; (filtra-cadenas '("estamos" "en" "el" "examen" "de" "LPP") '(4 2 3 6 1 3))  

(define (filtra-cadenas-fos lista-cadenas lista-num)
  (filter (lambda (pareja)
            (if (equal? (string-length (car pareja))
                        (cdr pareja))
                #t
                #f)) (map (lambda (cadena num)
                            (cons cadena num)) lista-cadenas lista-num)))

;; Define la funcion aplica-func f lista-parejas que recibe una funcion f
;; de dos argumentos y una lista de parejas, y devuelve una lista con los
;; resultados de aplicar la funcion f con los dos argumentos que vienen
;; dados en cada una de las parejas

(define (aplica-pareja f pareja)
  (f (car pareja) (cdr pareja)))

(define (aplica-func f lista-parejas)
  (if (null? lista-parejas)
      '()
      (cons (aplica-pareja f (car lista-parejas)) (aplica-func f (cdr lista-parejas)))))

;; fos
(define (aplica-func-fos f lista-parejas)
  (map (lambda (pareja)
         (aplica-pareja f pareja)) lista-parejas))

;; make-saludos: funcion que se pasa una lista de cadenas y devuelve una lista de funciones
;; de un argumento que concatenan el saludo con el argumento.
;; aplica-lista-funcs: funcion que se pasa una lista de funciones y un dato y devuelve
;; el resultado de aplicar cada elemento de la lista de funciones al dato.

(define (make-saludos lista-saludos)
  (if (null? lista-saludos)
      '()
      (cons (lambda (x)
              (string-append (car lista-saludos) x)) (make-saludos (cdr lista-saludos)))))

(define (aplica-lista-funcs lista-funcs dato)
  (if (null? lista-funcs)
      '()
      (cons ((car lista-funcs) dato) (aplica-lista-funcs (cdr lista-funcs) dato))))

;; FOS

(define (make-saludos-fos lista-saludos)
  (map (lambda (elemento)
         (lambda (x)
           (string-append elemento x))) lista-saludos))

(define (aplica-lista-funcs-fos lista-funcs dato)
  (map (lambda (funcion)
         (funcion dato)) lista-funcs))


