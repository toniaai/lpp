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

;; Funcion cumple-predicados que recibe una lista de predicados y un numero y
;; devuelve una lista con los resultados de aplicar cada predicado al numero

(define (cumple-predicados lista-preds n)
  (if (null? lista-preds)
      '()
      (cons ((car lista-preds) n) (cumple-predicados (cdr lista-preds) n))))

;; Definir las funciones:
;; n-ultimos lista n recibe una lista y un numero y devuelve la lista que
;; contiene los n ultimos elementosm de la lista

(define (n-ultimos lista n)
  (if (> n 0)
      (n-ultimos (cdr lista) (- n 1))
      (cdr lista)))

;; n-primeros igual pero con los n primeros numeros
(define (n-primeros lista n)
  (if (> n 0)
      (append (list (car lista)) (n-primeros (cdr lista) (- n 1)))
      '()))

;; define la funcion mover-n lista n que devuelve una lista con el
;; resultado de mover los n ultimos elementos al principio

(define (mover-n lista n)
  (append (n-ultimos lista n) (n-primeros lista (- (length lista) n))))


;; funcion construye poli lista-x lista-y que recibe dos listas que representan
;; cada una de las coordenadas x e y de los vertices de un poligono
;; y devuelve la lista de parejas donde cada preja representa la coordenada (x,y)

(define (construye-poli lista-x lista-y)
  (if (null? lista-x)
      '()
      (cons (cons (car lista-x) (car lista-y)) (construye-poli (cdr lista-x) (cdr lista-y)))))

;; funcino que recibe una lista como la obtenida en el ejercicio anterior y devuelve
;; el valor mas bajo encontrado para cada coordenada

(define (coords-min1 poli)
  (cond
    ((null? (cdr poli)) (car poli))
    ((and (< (car (car poli)) (car (coords-min (cdr poli))))
          (< (cdr (car poli)) (cdr (coords-min (cdr poli))))) (car poli))
    ((and (< (car (car poli)) (car (coords-min (cdr poli))))
          (> (cdr (car poli)) (cdr (coords-min (cdr poli))))) (cons (car (car poli))
                                                                    (cdr (coords-min (cdr poli)))))
    ((and (> (car (car poli)) (car (coords-min (cdr poli))))
          (< (cdr (car poli)) (cdr (coords-min (cdr poli))))) (cons (car (coords-min (cdr poli)))
                                                                    (cdr (car poli))))
    (else (coords-min (cdr poli)))))

;; (coords-min (construye-poli '(3 7 5 9) '(-2 -6 4 6)))

(define (min-x poli)
  (cond
    ((null? (cdr poli)) (car (car poli)))
    ((< (car (car poli)) (min-x (cdr poli))) (car (car poli)))
    (else (min-x (cdr poli)))))

(define (min-y poli)
  (cond
    ((null? (cdr poli)) (cdr (car poli)))
    ((< (cdr (car poli)) (min-y (cdr poli))) (cdr (car poli)))
    (else (min-y (cdr poli)))))

(define (coords-min poli)
  (cons (min-x poli) (min-y poli)))

(define poli (construye-poli '(3 7 5 9) '(-2 -6 4 6)))


