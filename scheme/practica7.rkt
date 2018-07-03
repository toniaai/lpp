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

;; Ejercicio 2
(define (to-string-arbol arbol)
  (string-append (symbol->string (dato-arbol arbol))
                 (to-string-bosque (hijos-arbol arbol))))

(define (to-string-bosque bosque)
  (if (null? bosque)
      ""
      (string-append (to-string-arbol (car bosque))
                     (to-string-bosque (cdr bosque)))))


(define arbol2 '(a (b (c (d)) (e)) (f)))

(define (to-string-arbol-fos arbol)
  (fold-left string-append (symbol->string (dato-arbol arbol)) (map to-string-arbol-fos (hijos-arbol arbol))))

(define (to-string-arbol-fos1 arbol)
  (fold-left string-append (symbol->string (dato-arbol arbol)) (map (lambda (x)
                                                                      (to-string-arbol-fos x)) (hijos-arbol arbol))))

;; Ejercicio 3

(define arbol3 '(35 (5) (10 (1) (6)) (20 (9))))
(define (ordenado? lista)
  (cond
    ((null? (cdr lista)) #t)
    ((> (car lista) (cadr lista)) #f)
    (else (ordenado? (cdr lista)))))

(define (raices arbol)
  (if (null? arbol)
      '()
      (append (list (dato-arbol (car arbol)))
            (raices (cdr arbol)))))

(define (ordenado-arbol? arbol)
  (and (ordenado? (append (raices (hijos-arbol arbol))
                          (list (dato-arbol arbol))))
       (ordenado-bosque? (hijos-arbol arbol))))

(define (ordenado-bosque? bosque)
  (if (null? bosque)
      #t
      (and (ordenado-arbol? (car bosque))
           (ordenado-bosque? (cdr bosque)))))

(define (raices1 bosque)
  (if (null? bosque)
      '()
      (cons (dato-arbol (car bosque))
            (raices (cdr bosque)))))

(define (and-lista lista)
  (fold-right (lambda (x y)
                (and x y)) #t lista))

(define (ordenado-arbol-fos? arbol)
  (and (ordenado? (append (map dato-arbol (hijos-arbol arbol))
                          (list (dato-arbol arbol))))
       (and-lista (map ordenado-arbol-fos? (hijos-arbol arbol)))))

;; Ejercicio 4
(define (ocurrencia a b dato)
  (if (equal? a dato)
      (cons 1 0)
      (if (equal? b dato)
          (cons 0 1)
          (cons 0 0))))

(define (suma-pareja p1 p2)
  (cons (+ (car p1) (car p2)) (+ (cdr p1) (cdr p2))))

(define (veces a b arbol)
  (suma-pareja (ocurrencia a b (dato-arbol arbol))
     (veces-bosque a b (hijos-arbol arbol))))

(define (veces-bosque a b bosque)
  (if (null? bosque)
      (cons 0 0)
      (suma-pareja (veces a b (car bosque))
                   (veces-bosque a b (cdr bosque)))))

(define (veces-fos a b arbol)
  (fold-right suma-pareja
              (ocurrencia a b (dato-arbol arbol))
              (map (lambda (x)
                     (veces-fos a b x)) (hijos-arbol arbol))))



(define (es-camino? lista arbol)
  (and (equal? (car lista) (dato-arbol arbol))
       (es-camino-bosque? (cdr lista) (hijos-arbol arbol))))

(define (es-camino-bosque? lista bosque)
  (cond
    ((and (null? bosque) (null? lista)) #t)
    ((or (null? bosque) (null? lista)) #f)
    (else (or (es-camino? lista (car bosque))
              (es-camino-bosque? lista (cdr bosque))))))


(define (nodos-nivel nivel arbol)
  (if (= nivel 0)
      (list (dato-arbol arbol))
      (nodos-nivel-bosque (- nivel 1) (hijos-arbol arbol))))

(define (nodos-nivel-bosque nivel bosque)
  (if (null? bosque)
      '()
      (append (nodos-nivel nivel(car bosque))
              (nodos-nivel-bosque nivel (cdr bosque)))))

;; Ejercicio 5

(define (pertenece? dato arbolb)
  (cond
    ((vacio-arbolb? arbolb) #f)
    ((= (dato-arbolb arbolb) dato) #t)
    ((> (dato-arbolb arbolb) dato)
     (pertenece? dato (hijo-izq-arbolb arbolb)))
    (else (pertenece? dato (hijo-der-arbolb arbolb)))))

(define (menor dato arbolb)
  (cond
    ((vacio-arbolb? arbolb) #t)
    ((hoja-arbolb? arbolb) (< (dato-arbolb arbolb) dato))
    (else (menor dato (hijo-der-arbolb arbolb)))))

(define (mayor dato arbolb)
  (cond
    ((vacio-arbolb? arbolb) #t)
    ((hoja-arbolb? arbolb) (> (dato-arbolb arbolb) dato))
    (else (mayor dato (hijo-izq-arbolb arbolb)))))

(define (ordenado-arbolb? arbolb)
  (if (or (vacio-arbolb? arbolb)
          (hoja-arbolb? arbolb))
      #t
      (and (menor (dato-arbolb arbolb) (hijo-izq-arbolb arbolb))
           (mayor (dato-arbolb arbolb) (hijo-der-arbolb arbolb))
           (ordenado-arbolb? (hijo-der-arbolb arbolb))
           (ordenado-arbolb? (hijo-izq-arbolb arbolb)))))


(define (camino-b-tree b-tree camino)
  (cond
    ((null? camino) '())
    ((equal? (car camino) '=) (cons (dato-arbolb b-tree) (camino-b-tree b-tree (cdr camino))))
    ((equal? (car camino) '<) (camino-b-tree (hijo-izq-arbolb b-tree) (cdr camino)))
    ((equal? (car camino) '>) (camino-b-tree (hijo-der-arbolb b-tree) (cdr camino)))))


;; Pruebas
(display "Probando 'camino-arbolb'\n")
(define arbolb5 '(9 (5 (3 (1 () ())
                          (4 () ()))
                       (7 () ()))
                    (15 (13 (10 () ())
                            (14 () ()))
                        (20 ()
                            (23 () ())))))
               
(check-equal? (camino-b-tree arbolb5 '(= < < = > =)) '(9 3 4))
(check-equal? (camino-b-tree arbolb5 '(> = < < =)) '(15 10))