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

(define (cuadrado-lista lista)
  (cuadrado-lista-iter lista '()))

(define (cuadrado-lista-iter lista resul)
  (if (null? lista)
      resul
      (cuadrado-lista-iter (cdr lista) (append resul (list (* (car lista) (car lista)))))))

(define (max-lista lista)
  (max-lista-iter (cdr lista) (car lista)))

(define (max-lista-iter lista resul)
  (if (null? lista)
      resul
      (max-lista-iter (cdr lista) (max (car lista) resul))))

(define (expande-pareja pareja)
  (expande-pareja-iter pareja '()))

(define (expande-pareja-iter pareja resul)
  (if (= (cdr pareja) 0)
      resul
      (expande-pareja-iter (cons (car pareja) (- (cdr pareja) 1)) (append resul (list (car pareja))))))

(define (expande-lista lista)
  (expande-lista-iter lista '()))

(define (expande-lista-iter lista resul)
  (if (null? lista)
      resul
      (expande-lista-iter (cdr lista) (append resul (expande-pareja (car lista))))))                                              

(define (aplica-funciones lista-parejas)
  (aplica-funciones-iter lista-parejas '()))

(define (aplica-funciones-iter lista-parejas resul)
  (if (null? lista-parejas)
      resul
      (aplica-funciones-iter (cdr lista-parejas) (append resul (list ((caar lista-parejas) (cdar lista-parejas)))))))

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

(define (cumplen-predicado-arbol pred arbol)
  (append (if (pred (dato-arbol arbol))
              (list (dato-arbol arbol))
              '())
          (cumplen-predicado-bosque pred (hijos-arbol arbol))))

(define (cumplen-predicado-bosque pred bosque)
  (if (null? bosque)
      '()
      (append (cumplen-predicado-arbol pred (car bosque))
              (cumplen-predicado-bosque pred (cdr bosque)))))

(define (cumplen-predicado-arbol-fos pred arbol)
  (fold-left append (if (pred (dato-arbol arbol))
                         (list (dato-arbol arbol))
                         '()) (map (lambda (x)
                                     (cumplen-predicado-arbol-fos pred x)) (hijos-arbol arbol))))

(define (cumplen-predicado-arbol-fos1 pred arbol)
  (fold-right (lambda (x y)
                (append y x)) (if (pred (dato-arbol arbol))
                                  (list (dato-arbol arbol))
                                  '()) (map (lambda (x)
                                              (cumplen-predicado-arbol-fos1 pred x)) (hijos-arbol arbol))))

(define arbol '(1 (1 (1)) (2 (3) (2)) (1 (2) (3))))
(define arbo2 '(10 (11 (12)) (2 (3) (2)) (1 (21) (3))))

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

(define (sustituye-elem-arbol arbol elem-old elem-new)
  (construye-arbol (if (equal? (dato-arbol arbol) elem-old)
                       elem-new
                       (dato-arbol arbol))
                   (sustituye-elem-bosque (hijos-arbol arbol) elem-old elem-new)))

(define (sustituye-elem-bosque bosque elem-old elem-new)
  (if (null? bosque)
      '()
      (cons (sustituye-elem-arbol (car bosque) elem-old elem-new)
            (sustituye-elem-bosque (cdr bosque) elem-old elem-new))))

(define (sustituye-elem-arbol-fos arbol elem-old elem-new)
  (construye-arbol (if (equal? (dato-arbol arbol) elem-old)
                       elem-new
                       (dato-arbol arbol))
                   (map (lambda (x)
                          (sustituye-elem-arbol-fos x elem-old elem-new)) (hijos-arbol arbol))))

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


(define (diff-arbol arbol1 arbol2)
  (append (if (equal? (dato-arbol arbol1) (dato-arbol arbol2))
              '()
              (list (cons (dato-arbol arbol1) (dato-arbol arbol2))))
          (diff-bosque (hijos-arbol arbol1) (hijos-arbol arbol2))))

(define (diff-bosque bosque1 bosque2)
  (if (null? bosque1)
      '()
      (append (diff-arbol (car bosque1) (car bosque2))
              (diff-bosque (cdr bosque1) (cdr bosque2)))))

(define (diff-arbol-fos arbol1 arbol2)
  (fold-left append (if (equal? (dato-arbol arbol1) (dato-arbol arbol2))
                        '()
                        (list (cons (dato-arbol arbol1) (dato-arbol arbol2))))
             (map (lambda (x y)
                    (diff-arbol-fos x y)) (hijos-arbol arbol1) (hijos-arbol arbol2))))

(define (muestra-hojas-debajo-nivel lista n)
  (cond
    ((null? lista) '())
    ((hoja? lista) (if (< n 0) (list lista) '()))
    (else (append (muestra-hojas-debajo-nivel (car lista) (- n 1))
                  (muestra-hojas-debajo-nivel (cdr lista) n)))))

(define (cuenta-hojas-debajo-nivel lista n)
  (cond
    ((null? lista) 0)
    ((hoja? lista) (if (< n 0) 1 0))
    (else (+ (cuenta-hojas-debajo-nivel (car lista) (- n 1))
             (cuenta-hojas-debajo-nivel (cdr lista) n)))))
            
(define (cuenta-hojas-debajo-nivel-fos lista n)
  (+ (if (< n 0) 1 0)
     (fold-right + 0 (map (lambda (x)
                            (if (hoja? x)
                                (if (< n 0)
                                    1
                                    0)
                                (cuenta-hojas-debajo-nivel x (- n 1)))) lista))))

(define (max-cdr p1 p2)
  (if (> (cdr p1) (cdr p2))
      p1
      p2))

(define (nivel-elemento lista)
  (cond
    ((null? lista) (cons 0 0))
    ((hoja? lista) (cons lista 0))
    (else (max-cdr (cons (car (nivel-elemento (car lista))) (+ (cdr (nivel-elemento (car lista))) 1))
                   (nivel-elemento (cdr lista))))))

(define (nivel-elemento-fos lista)
  (max-cdr (if (hoja? lista)
               (cons lista 0)
               (cons 0 0))
           (fold-right (lambda (x y)
                         (max-cdr (cons (car x)
                                        (+ (cdr x) 1))
                                   y))
                       (cons 0 0) (map (lambda (x)
                                         (if (hoja? x)
                                             (cons x 0)
                                             (nivel-elemento-fos x))) lista))))

(define arbol2 '(a (b (c (d)) (e)) (f)))
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

(define (lista-hijos bosque)
  (if (null? bosque)
      '()
      (cons (dato-arbol (car bosque)) (lista-hijos (cdr bosque)))))

(define (ordenada-lista? lista)
  (cond
    ((null? (cdr lista)) #t)
    ((< (car lista) (cadr lista)) (ordenada-lista? (cdr lista)))
    (else #f)))

(define (ordenado-arbol? arbol)
  (and (ordenada-lista? (append (lista-hijos (hijos-arbol arbol))
                                (list (dato-arbol arbol))))
       (ordenado-bosque? (hijos-arbol arbol))))

(define (ordenado-bosque? bosque)
  (if (null? bosque)
      #t
      (and (ordenado-arbol? (car bosque))
           (ordenado-bosque? (cdr bosque)))))

(define (ordenado-arbol-fos? arbol)
  (and (ordenada-lista? (append (lista-hijos (hijos-arbol arbol))
                                (list (dato-arbol arbol))))
       (fold-right (lambda (x y)
                     (and x y)) #t (map (lambda (x)
                                          (ordenado-arbol-fos? x)) (hijos-arbol arbol)))))
(define (ordenado-arbol-fos arbol)
  (fold-right (lambda (x y)
                (and x y)) (ordenada-lista? (append (lista-hijos (hijos-arbol arbol))
                                                    (list (dato-arbol arbol))))
                           (map (lambda (x)
                                  (ordenado-arbol-fos x)) (hijos-arbol arbol))))

(define (suma-pareja p1 p2)
  (cons (+ (car p1) (car p2))
        (+ (cdr p1) (cdr p2))))

(define (analiza-dato a b dato)
  (cond
    ((equal? a dato) (cons 1 0))
    ((equal? b dato) (cons 0 1))
    (else (cons 0 0))))

(define (veces a b arbol)
  (suma-pareja (analiza-dato a b (dato-arbol arbol))
               (veces-bosque a b (hijos-arbol arbol))))

(define (veces-bosque a b bosque)
  (if (null? bosque)
      (cons 0 0)
      (suma-pareja (veces a b (car bosque))
                   (veces-bosque a b (cdr bosque)))))

(define (veces-fos a b arbol)
  (suma-pareja (analiza-dato a b (dato-arbol arbol))
               (fold-right suma-pareja (cons 0 0) (map (lambda (x)
                                                         (veces-fos a b x)) (hijos-arbol arbol)))))

(define arbolCamino '(a (a (a) (b)) (b (a) (c)) (c)))

(define (es-camino? lista arbol)
  (and (equal? (dato-arbol arbol) (car lista))
       (es-camino-bosque? (cdr lista) (hijos-arbol arbol))))

(define (es-camino-bosque? lista bosque)
  (cond
    ((and (null? lista) (null? bosque)) #t)
    ((or (null? lista) (null? bosque)) #f)
    (else (or (es-camino? lista (car bosque))
              (es-camino-bosque? lista (cdr bosque))))))

(define arbolNivel '(1 (2 (3 (4) (2)) (5)) (6 (7))))
(define (nodos-nivel nivel arbol)
  (append (if (= 0 nivel)
              (list (dato-arbol arbol))
              '())
          (nodos-nivel-bosque (- nivel 1) (hijos-arbol arbol))))

(define (nodos-nivel-bosque nivel bosque)
  (if (null? bosque)
      '()
      (append (nodos-nivel nivel (car bosque))
              (nodos-nivel-bosque nivel (cdr bosque)))))

(define (nodos-nivel-fos nivel arbol)
  (append (if (= 0 nivel)
              (list (dato-arbol arbol))
              '())
          (fold-right append '() (map (lambda (x)
                                        (nodos-nivel-fos (- nivel 1) x)) (hijos-arbol arbol)))))

