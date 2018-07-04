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


;; PRACTICAS PARICAL 2
;; PRACTICA 5 - ITERATIVOS:

;; Implementar mediante recursión por cola la función cuadrado lista
;; que toma como un argumento una lista de números y devuelve una lista
;; con sus cuadrados

(define (cuadrado-lista lista)
  (cuadrado-lista-iter lista '()))

(define (cuadrado-lista-iter lista resul)
  (if (null? lista)
      resul
      (cuadrado-lista-iter (cdr lista) (append resul (list (* (car lista) (car lista)))))))

;; Implementar la funcion max-lista que recibe una lista numerica y
;; devuelve el maximo de sus elementos

(define (max-lista lista)
  (max-lista-iter lista (car lista)))

(define (max-lista-iter lista resul)
  (if (null? lista)
      resul
      (max-lista-iter (cdr lista) (if (> (car lista) resul)
                                      (car lista)
                                      resul))))

;; expande y expande-pareja utilizando recursión por cola

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

;; Utilizando recursión por cola implementar la funcion aplica-funciones lista-parejas
;; que recibe una lista de parejas {{funcion . argumento} ... } y devuelve la lista con
;; los resultados de aplicar cada funcion al elemento de la derecha de la pareja.

(define (aplica-funciones lista-parejas)
  (aplica-funciones-iter lista-parejas '()))

(define (aplica-funciones-iter lista-parejas resul)
  (if (null? lista-parejas)
      resul
      (aplica-funciones-iter (cdr lista-parejas) (append resul (list ((caar lista-parejas) (cdar lista-parejas)))))))

;; Función recursiva cuenta-pares lista que recibe una lista estructurada y cuenta la
;; cantidad de números pares que contiene

(define (cuenta-pares lista)
  (cond
    ((null? lista) 0)
    ((hoja? lista) (if (even? lista) 1 0))
    (else (+ (cuenta-pares (car lista))
             (cuenta-pares (cdr lista))))))

(define (cuenta-pares-fos lista)
  (fold-right + 0 (map (lambda (x)
                         (if (hoja? x)
                             (if (even? x)
                                 1
                                 0)
                             (cuenta-pares-fos x))) lista)))

;; Función cumplen-predicado pred lista que devuelve una lista con todos los elementos de
;; la lista estructurada que cumplen un predicado

(define (cumplen-predicado pred lista)
  (cond
    ((null? lista) '())
    ((hoja? lista) (if (pred lista) (list lista) '()))
    (else (append (cumplen-predicado pred (car lista))
                  (cumplen-predicado pred (cdr lista))))))

(define (cumplen-predicado-fos pred lista)
  (fold-right append '() (map (lambda (x)
                                (if (hoja? x)
                                    (if (pred x)
                                        (list x)
                                        '())
                                    (cumplen-predicado-fos pred x))) lista)))

;; Funcion que recibe una lista y dos elementos, elem-old y elem-new para cada ocurrencia
;; de elem-old en la lista se sustituye por elem-new y se devuelve una lista con la misma
;; estructura pero con las ocurrencias sustituidas

(define (sustituye-elem lista elem-old elem-new)
  (cond
    ((null? lista) '())
    ((hoja? lista) (if (equal? lista elem-old) elem-new lista))
    (else (cons (sustituye-elem (car lista) elem-old elem-new)
                (sustituye-elem (cdr lista) elem-old elem-new)))))

(define (sustituye-elem-fos lista elem-old elem-new)
  (map (lambda (x)
         (if (hoja? x)
             (if (equal? x elem-old)
                 elem-new
                 x)
             (sustituye-elem-fos x elem-old elem-new))) lista))

;; Funcion diff-listas que toma como argumentos dos listas estructuradas con  la misma
;; estructura pero con diferentes elementos y devuelve una lista de parejas que contiene
;; los elementos que son distintos

(define (diff-listas l1 l2)
  (cond
    ((null? l1) '())
    ((hoja? l1) (if (equal? l1 l2) '() (list (cons l1 l2))))
    (else (append (diff-listas (car l1) (car l2))
                  (diff-listas (cdr l1) (cdr l2))))))

(define (diff-listas-fos l1 l2)
  (fold-right append '() (map (lambda (x y)
                                (if (hoja? x)
                                    (if (equal? x y)
                                        '()
                                        (list (cons x y)))
                                    (diff-listas-fos x y))) l1 l2)))

;; Funcion cuenta-hojas-debajo que recibe una lista estructurada y un numero que indica
;; un nivel y devuelve el numero de hojas que hay por debajo de ese nivel

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

;; Funcion nivel-elemento lista que recibe una lista estrucutada y devuelve una pareja
;; (elem . nivel) donde la parte izquierda es el elemento que se encuentra a mayor nivel
;; y la derecha el nivel en el que se encuentra.

(define (nivel-elemento lista)
  (cond
    ((null? lista) (cons 0 0))
    ((hoja? lista) (cons lista 0))
    (else (if (> (cdr (cons (car (nivel-elemento (car lista))) (+ (cdr (nivel-elemento (car lista))) 1)))
                 (cdr (cons (car (nivel-elemento (cdr lista))) (cdr (nivel-elemento (cdr lista))))))
              (cons (car (nivel-elemento (car lista))) (+ (cdr (nivel-elemento (car lista))) 1))
              (cons (car (nivel-elemento (cdr lista))) (cdr (nivel-elemento (cdr lista))))))))

(define (hacer-pareja pareja add)
  (cons (car pareja) (+ (cdr pareja) add)))

(define (pareja-baja pareja1 pareja2)
  (if (> (cdr pareja1) (cdr pareja2))
      pareja1
      pareja2))

(define (nivel-elemento-facil lista)
  (cond
    ((null? lista) (cons 0 0))
    ((hoja? lista) (cons lista 0))
    (else (pareja-baja (hacer-pareja (nivel-elemento (car lista)) 1)
                       (hacer-pareja (nivel-elemento (cdr lista)) 0)))))

;; Funcion que suma los datos de un arbol
(define arbolSuma '(15 (4 (2) (3)) (8 (6)) (12 (9) (10) (11))))

(define (suma-datos-arbol arbol)
  (+ (dato-arbol arbol)
     (suma-datos-bosque (hijos-arbol arbol))))

(define (suma-datos-bosque bosque)
  (if (null? bosque)
      0
      (+ (suma-datos-arbol (car bosque))
         (suma-datos-bosque (cdr bosque)))))

(define (suma-datos-arbol-fos arbol)
  (fold-right + (dato-arbol arbol) (map (lambda (x)
                         (suma-datos-arbol-fos x)) (hijos-arbol arbol))))

;; Funcion to-string-arbol arbol que recibe un arbol de simbolos y devuelve la cadena
;; resultante de concantenar todos los simbolos en recorrido preorden.
(define arbolToString '(a (b (c (d)) (e)) (f)))

(define (to-string-arbol arbol)
  (string-append (symbol->string (dato-arbol arbol))
                 (to-string-bosque (hijos-arbol arbol))))

(define (to-string-bosque bosque)
  (if (null? bosque)
      ""
      (string-append (to-string-arbol (car bosque))
                     (to-string-bosque (cdr bosque)))))

(define (to-string-arbol-fos arbol)
  (fold-left string-append (symbol->string (dato-arbol arbol))
              (map (lambda (x)
                     (to-string-arbol-fos x)) (hijos-arbol arbol))))

(define (to-string-arbol-fos1 arbol)
  (string-append (symbol->string (dato-arbol arbol))
                 (fold-right string-append "" (map (lambda (x)
                                                     (to-string-arbol-fos1 x)) (hijos-arbol arbol)))))


;; Funcion ordenado? arbol que compruebe si un arbol está ordenado.
(define arbolOrden '(50 (10 (4) (6) (8)) (25 (15))))
(define (ordenado-lista? lista)
  (if (null? (cdr lista))
      #t
      (if (< (car lista) (cadr lista))
          (ordenado-lista? (cdr lista))
          #f)))

(define (raiz-arbol hijos)
  (if (null? hijos)
      '()
      (cons (dato-arbol (car hijos))
            (raiz-arbol (cdr hijos)))))

(define (ordenado-arbol? arbol)
  (and (ordenado-lista? (append (raiz-arbol (hijos-arbol arbol))
                                (list (dato-arbol arbol))))
       (ordenado-bosque? (hijos-arbol arbol))))

(define (ordenado-bosque? bosque)
  (if (null? bosque)
      #t
      (and (ordenado-arbol? (car bosque))
           (ordenado-bosque? (cdr bosque)))))

(define (and-lista lista)
  (fold-right (lambda (x y)
                (and x y)) #t lista))

(define (ordenado-arbol?-fos1 arbol)
  (and (ordenado-lista? (append (raiz-arbol (hijos-arbol arbol))
                                (list (dato-arbol arbol))))
       (and-lista (map (lambda (x)
                         (ordenado-arbol?-fos x)) (hijos-arbol arbol)))))


(define (ordenado-arbol?-fos arbol)
  (and (ordenado-lista? (append (raiz-arbol (hijos-arbol arbol))
                                (list (dato-arbol arbol))))
       (fold-right (lambda (x y)
                     (and x y)) #t (map (lambda (x)
                                          (ordenado-arbol?-fos x)) (hijos-arbol arbol)))))


;; Funcion veces a b arbol que devuelve una pareja con el numero de veces que aparece a
;; y el numero de veces que aparece b
(define arbolVeces '(1 (1 (1)) (2 (3) (2)) (1 (2) (3))))

(define (suma-pareja p1 p2)
  (cons (+ (car p1) (car p2))
        (+ (cdr p1) (cdr p2))))

(define (comprueba-dato a b dato)
  (if (equal? dato a)
      (cons 1 0)
      (if (equal? dato b)
          (cons 0 1)
          (cons 0 0))))

(define (veces a b arbol)
  (suma-pareja (comprueba-dato a b (dato-arbol arbol))
               (veces-bosque a b (hijos-arbol arbol))))

(define (veces-bosque a b bosque)
  (if (null? bosque)
      (cons 0 0)
      (suma-pareja (veces a b (car bosque))
                   (veces-bosque a b (cdr bosque)))))

(define (veces-fos a b arbol)
  (fold-right suma-pareja (comprueba-dato a b (dato-arbol arbol))
              (map (lambda (x)
                     (veces-fos a b x)) (hijos-arbol arbol))))


;; Funcion es-camino? lista arbol que debe comprobar si la secuencia de elementos
;; de la lista se corresponde con un camino del arbol que empieza en la raiz
;; y termina exactamente en una hoja.

(define (es-camino? lista arbol)
  (and (equal? (car lista) (dato-arbol arbol))
       (es-camino-bosque? (cdr lista) (hijos-arbol arbol))))

(define (es-camino-bosque? lista bosque)
  (cond
    ((and (null? lista) (null? bosque)) #t)
    ((or (null? lista) (null? bosque)) #f)
    (else (or (es-camino? lista (car bosque))
              (es-camino-bosque? lista (cdr bosque))))))


;; Funcion nodos-nivel nivel arbol que recibe un nivel y un arbol generico y devuelve
;; la lista con todos los nodos que se encuentran en ese nivel

(define arbolNodos '(1 (2 (3 (4) (2)) (5)) (6 (7))))
(define (nodos-nivel nivel arbol)
  (append (if (= nivel 0)
              (list (dato-arbol arbol))
              '())
          (nodos-nivel-bosque (- nivel 1) (hijos-arbol arbol))))

(define (nodos-nivel-bosque nivel bosque)
  (if (null? bosque)
      '()
      (append (nodos-nivel nivel (car bosque))
              (nodos-nivel-bosque nivel (cdr bosque)))))

(define (nodos-nivel-fos nivel arbol)
  (fold-right append (if (= nivel 0)
                         (list (dato-arbol arbol))
                         '()) (map (lambda (x)
                                     (nodos-nivel-fos (- nivel 1) x)) (hijos-arbol arbol))))
          
                      
;; Funcion pertenece? dato arbolb que recibe un dato y un arbol binario ordenado y busca eficientemente el dato
;; para el arbol dado

(define (pertenece? dato arbolb)
  (cond
    ((vacio-arbolb? arbolb) #f)
    ((= (dato-arbolb arbolb) dato) #t)
    ((> (dato-arbolb arbolb) dato) (pertenece? dato (hijo-izq-arbolb arbolb)))
    (else (pertenece? dato (hijo-der-arbolb arbolb)))))


;; Funcion ordenado-arbolb? arbolb que recibe un arbol binario como argumento y devuelve verdadero si está ordenado
;; y falso si no lo está

(define (comprueba-menor dato arbolb)
  (cond
    ((vacio-arbolb? arbolb) #t)
    ((hoja-arbolb? arbolb) (< (dato-arbolb arbolb) dato))
    (else (comprueba-menor dato (hijo-der-arbolb arbolb)))))

(define (comprueba-mayor dato arbolb)
  (cond
    ((vacio-arbolb? arbolb) #t)
    ((hoja-arbolb? arbolb) (> (dato-arbolb arbolb) dato))
    (else (comprueba-mayor dato (hijo-izq-arbolb arbolb)))))

(define (ordenado-arbolb? arbolb)
  (if (or (vacio-arbolb? arbolb)
          (hoja-arbolb? arbolb))
      #t
      (and (comprueba-menor (dato-arbolb arbolb) (hijo-izq-arbolb arbolb))
           (comprueba-mayor (dato-arbolb arbolb) (hijo-der-arbolb arbolb))
           (ordenado-arbolb? (hijo-izq-arbolb arbolb))
           (ordenado-arbolb? (hijo-der-arbolb arbolb)))))

;; Funcion camino-arbolb arbolb camino que devuelva una lista con los datos recogidos por el camino

(define (camino-arbolb arbolb lista)
  (cond
    ((null? lista) '())
    ((equal? (car lista) '=) (cons (dato-arbolb arbolb) (camino-arbolb arbolb (cdr lista))))
    ((equal? (car lista) '<) (camino-arbolb (hijo-izq-arbolb arbolb) (cdr lista)))
    ((equal? (car lista) '>) (camino-arbolb (hijo-der-arbolb arbolb) (cdr lista)))))


                           