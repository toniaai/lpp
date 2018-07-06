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

;;PimerParcialLPPTurnoManyana

;; define la funcion cumple-predicdaos lista-preds n recibe una lista de preds y
;; un numero y devuelve una lista con los resultados de aplicar cada predicado
;; al numero

(define (cumple-predicados lista-preds n)
  (if (null? lista-preds)
      '()
      (cons ((car lista-preds) n) (cumple-predicados (cdr lista-preds) n))))

;; n-ultimos y n-primeros lista n, ambos recibe un numero y ultimos devuelve los n
;; ultimos y primeros los n primeros

(define (n-ultimos lista n)
  (if (> n 0)
      (n-ultimos (cdr lista) (- n 1))
      (cdr lista)))

(define (n-primeros lista n)
  (if (> n 0)
      (cons (car lista) (n-primeros (cdr lista) (- n 1)))
      '()))

(define (mover-n lista n)
  (append (n-ultimos lista n) (n-primeros lista (- (length lista) n))))

;; triangulo

(define (haz-triangulo n)
  (if (> n 0)
      (cons '* (haz-triangulo (- n 1)))
      '()))

(define (triangulo n)
  (if (> n 0)
      (cons (haz-triangulo n) (triangulo (- n 1)))
      '()))

;; expande

(define (expande-pareja pareja)
  (if (> (cdr pareja) 0)
      (cons (car pareja) (expande-pareja (cons (car pareja) (- (cdr pareja) 1))))
      '()))

(define (expande lista-parejas)
  (if (null? lista-parejas)
      '()
      (append (expande-pareja (car lista-parejas)) (expande (cdr lista-parejas)))))

(define (expande-fos lista-parejas)
  (fold-right (lambda (x y)
                (append (expande-pareja x) y)) '() lista-parejas))

;; filtra cadenas

(define (filtra-cadenas lista-cadenas lista-num)
  (if (null? lista-cadenas)
      '()
      (append (if (= (string-length (car lista-cadenas))
                     (car lista-num))
                  (list (cons (car lista-cadenas )
                              (car lista-num)))
                  '()) (filtra-cadenas (cdr lista-cadenas) (cdr lista-num)))))

(define (es-pareja? cadena num)
  (if (= (string-length cadena) num)
      #t
      #f))

(define (haz-pareja cadena num)
  (cons cadena num))

(define (filtra-cadenas1 lista-cadenas lista-num)
  (cond
    ((null? lista-cadenas) '())
    ((es-pareja? (car lista-cadenas) (car lista-num)) (cons (haz-pareja (car lista-cadenas) (car lista-num))
                                                            (filtra-cadenas1 (cdr lista-cadenas) (cdr lista-num))))
    (else (filtra-cadenas1 (cdr lista-cadenas) (cdr lista-num)))))

(define (filtra-cadenas-fos lista-cadenas lista-num)
  (filter (lambda (x)
            (= (string-length (car x)) (cdr x))) (map (lambda (x y)
                                                        (cons x y)) lista-cadenas lista-num)))

(define (aplica-func f lista-parejas)
  (if (null? lista-parejas)
      '()
      (cons ((lambda (x)
              (f (car x) (cdr x)))
             (car lista-parejas)) (aplica-func f (cdr lista-parejas)))))

(define (aplica-func-fos f lista-parejas)
  (map (lambda (x)
         (f (car x) (cdr x))) lista-parejas))

(define (aplica-lista-func lista-func lista-parejas)
  (if (null? lista-func)
      '()
      (append (aplica-func (car lista-func)
                           lista-parejas) (aplica-lista-func (cdr lista-func) lista-parejas))))

(define (aplica-lista-func-fos lista-func lista-parejas)
  (fold-right append '() (map (lambda (x)
                                (aplica-func x lista-parejas)) lista-func)))

(define (make-saludos lista-saludos)
  (if (null? lista-saludos)
      '()
      (cons (lambda (x)
              (string-append (car lista-saludos) x)) (make-saludos (cdr lista-saludos)))))

(define (aplica-lista-func-dato1 lista-func dato)
  (fold-right (lambda (x y)
                (append (list (x dato)) y)) '() lista-func))

(define (aplica-lista-func-dato lista-func dato)
  (map (lambda (x)
         (x dato)) lista-func))

;; suma iterativa

(define (suma lista)
  (suma-iter lista 0))

(define (suma-iter lista resul)
  (if (null? lista)
      resul
      (suma-iter (cdr lista) (+ resul (car lista)))))

;; elimina-elem elem lista

(define (elimina-elem elem lista)
  (elimina-elem-iter elem lista '()))

(define (elimina-elem-iter elem lista resul)
  (if (null? lista)
      resul
      (elimina-elem-iter elem (cdr lista) (append resul (if (equal? (car lista) elem)
                                                            '()
                                                            (list (car lista)))))))


(define (elimina-elem-iter-fos elem lista)
  (filter (lambda (x)
            (not (equal? elem x))) lista))

;; sustituye elem
(define lista  '(1 2 (3 4 (5 3)) 3 (8 (3) 10)))

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

(define arbol '(-4 (-5 (-2) (-3)) (-10) (-20 (-40) (-15 (-13) (-14)) (-17) (-19 (-18)))))

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

(define (mayor-null n1 n2)
  (cond
    ((null? n1) n2)
    ((null? n2) n1)
    (else (max n1 n2))))

(define (mayor-dato-arbol arbol)
  (mayor-null (dato-arbol arbol)
              (mayor-dato-bosque (hijos-arbol arbol))))

(define (mayor-dato-bosque bosque)
  (if (null? bosque)
      '()
      (mayor-null (mayor-dato-arbol (car bosque))
                  (mayor-dato-bosque (cdr bosque)))))

(define (mayor-dato-arbol-fos arbol)
  (fold-right mayor-null (dato-arbol arbol) (map (lambda (x)
                                                   (mayor-dato-arbol-fos x)) (hijos-arbol arbol))))


(define (palabra-arbol arbol lista)
  (and (equal? (dato-arbol arbol) (car lista))
       (palabra-bosque (hijos-arbol arbol) (cdr lista))))

(define (palabra-bosque bosque lista)
  (cond
    ((and (null? lista) (null? bosque)) #t)
    ((or (null? lista) (null? bosque)) #f)
    (else (or (palabra-arbol (car bosque) lista)
              (palabra-bosque (cdr bosque) lista)))))

(define arbolPalabra '(c (a (s (a) (o)) (l)) (o (l (a)) (m (o))) (e (n (a)))))

(define (camino-arbolb arbolb camino)
  (cond
    ((null? camino) '())
    ((vacio-arbolb? arbolb) '())
    ((equal? (car camino) '=) (cons (dato-arbolb arbolb) (camino-arbolb arbolb (cdr camino))))
    ((equal? (car camino) '<) (camino-arbolb (hijo-izq-arbolb arbolb) (cdr camino)))
    (else (camino-arbolb (hijo-der-arbolb arbolb) (cdr camino)))))

(define arbolbCamino '(9 (5 (3 (1 () ())
                              (4 () ()))
                           (7 () ()))
                        (15 (13 (10 () ())
                                (14 () ()))
                            (20 ()
                                (23 () ())))))

(define listaParejas '((1 . 2) (4 . 5) (6 . 4) (4 . 8)))

(define (suma-pareja pareja)
  (+ (car pareja) (cdr pareja)))

(define (ordenada-lista-parejas lista-parejas)
  (cond
    ((null? (cdr lista-parejas)) #t)
    ((< (suma-pareja (car lista-parejas))
        (suma-pareja (cadr lista-parejas))) (ordenada-lista-parejas (cdr lista-parejas)))
    (else #f)))

(define (haz-par p1 p2)
  (cons (suma-pareja p1) (suma-pareja p2)))

(define (haz-lista lista-parejas)
  (if (null? (cdr lista-parejas))
      (list (haz-par (car lista-parejas) (car lista-parejas)))
      (cons (haz-par (car lista-parejas) (cadr lista-parejas)) (haz-lista (cdr lista-parejas)))))

(define (ordenada-lista-parejas-fos lista-parejas)
  (fold-right (lambda (x y)
                (and x y)) #t (map (lambda (x)
                                     (<= (car x) (cdr x))) (haz-lista lista-parejas))))

(define (suma-lista-parejas-fos lista-parejas)
  (fold-right (lambda (x y)
                (+ (+ (car x)
                      (cdr x)) y)) 0 lista-parejas))

(define (resultado-partido partido)
  (cond
    ((> (car partido) (cdr partido)) 1)
    ((< (car partido) (cdr partido)) 2)
    (else 'X)))

(define (resultados-quiniela lista-parejas)
  (if (null? lista-parejas)
      '()
      (cons (resultado-partido (car lista-parejas))
            (resultados-quiniela (cdr lista-parejas)))))

(define (resultados-quiniela-fos lista-parejas)
  (map resultado-partido lista-parejas))

(define (pertenece? dato lista)
  (if (null? lista)
      #f
      (if (equal? dato (car lista))
          #t
          (pertenece? dato (cdr lista)))))

(define (listas-contiene-elem elem lista)
  (if (null? lista)
      '()
      (append (if (pertenece? elem (car lista))
                  (list (car lista))
                  '()) (listas-contiene-elem elem (cdr lista)))))

(define (listas-contiene-elem1 elem lista)
  (cond
    ((null? lista) '())
    ((pertenece? elem (car lista)) (cons (car lista) (listas-contiene-elem1 elem (cdr lista))))
    (else (listas-contiene-elem1 elem (cdr lista)))))

(define (listas-contiene-elem-fos elem lista)
  (filter (lambda (x)
            (pertenece? elem x)) lista))

(define (dias-mes n mes)
  (dias-mes-iter n mes '()))

(define (dias-mes-iter n mes resul)
  (if (= n 0)
      resul
      (dias-mes-iter (- n 1) mes (cons (cons n mes) resul))))

(define (calendario-fijo n lista-meses)
  (fold-right append '() (map (lambda (x)
                                                (dias-mes n x)) lista-meses)))


