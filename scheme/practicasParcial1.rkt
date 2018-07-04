#lang r6rs
(import (rnrs)
        (schemeunit))

;; Ejercicios parcial 1

;; Funcion binnario-a-decimal b3 b2 b1 b0
(define (binario-a-decimal1 b3 b2 b1 b0)
  (+ (* b3 (expt 2 3))
     (* b2 (expt 2 2))
     (* b1 (expt 2 1))
     (* b0 (expt 2 0))))

;; Mayor-de-tres
(define (mayor-de-tres n1 n2 n3)
  (if (and (> n1 n2)
           (> n1 n3))
      n1
      (if (> n2 n3)
          n2
          n3)))

(define (mayor x y)
  (if (> x y)
      x
      y))

(define (mayor-de-tres-v2 n1 n2 n3)
  (mayor n1 (mayor n2 n3)))

;; Funcion que recibe 2 parejas como argumento y devuelve 0 1 o 2 segun cual sea la pareja con
;; la suma mayor

(define (suma-pareja pareja)
  (+ (car pareja) (cdr pareja)))

(define (tirada-ganadora t1 t2)
  (if (> (suma-pareja t1) (suma-pareja t2))
      1
      (if (> (suma-pareja t2) (suma-pareja t1))
          2
          0)))

;; Funcion maximo lista que devuelve el numero mayor de una lista

(define (maximo lista)
  (if (null? (cdr lista))
      (car lista)
      (mayor (car lista) (maximo (cdr lista)))))

;; Funcion pertenece que recibe un dato y una lista y comprueba si el
;; elemento pertenece a la lista

(define (pertenece? elem lista)
  (cond
    ((null? lista) #f)
    ((equal? elem (car lista)) #t)
    (else (pertenece?  elem (cdr lista)))))

;; con el predicado anterior implementar el predicado recursivo repetidos? lista que
;; recibe una lista y devuelve #t si algun elemento está repetido en la lista

(define (repetidos? lista)
  (cond
    ((null? lista) #f)
    ((pertenece? (car lista) (cdr lista)) #t)
    (else (repetidos? (cdr lista)))))

;; funcion que recibe una lista de bits que repesentan un numero en binario y devuelva
;; el numero decimal equivalente

(define (binario-a-decimal lista-bits)
  (if (null? lista-bits)
      0
      (+ (* (car lista-bits) (expt 2 (length (cdr lista-bits)))) (binario-a-decimal (cdr lista-bits)))))

;; implementa las funcoines inc der e inc izq

(define (inc-der pareja)
  (cons (car pareja) (+ (cdr pareja) 1)))

(define (inc-izq pareja)
  (cons (+ (car pareja) 1) (cdr pareja)))


;; implementa la funcion recursiva cuenta-impares lista-num que devuelve una pareja cuya parte izquierda
;; sea la cantidad de numeros impares de la lista y la derecha la cantidad de numeros pares

(define (cuenta-impares-pares lista-num)
  (cond
    ((null? lista-num) (cons 0 0))
    ((even? (car lista-num)) (inc-der (cuenta-impares-pares (cdr lista-num))))
    ((odd? (car lista-num)) (inc-izq (cuenta-impares-pares (cdr lista-num))))))

(define (cuenta-impares-pares-fos lista-num)
  (fold-right (lambda (x y)
                (cons (+ (car x) (car y))
                      (+ (cdr x) (cdr y)))) (cons 0 0) (map (lambda (x)
                                                              (if (even? x)
                                                                  (cons 0 1)
                                                                  (cons 1 0))) lista-num)))

;; Implementa la funcion recursiva cadena-mayor lista que recibe una lista de candeas y devuelve una pareja con
;; la cadena de mayor longitud  y dicha longitud

(define (cadena-mayor1 lista)
  (cond
    ((null? lista) (cons "" 0))
    ((> (string-length (car lista)) (cdr (cadena-mayor1 (cdr lista)))) (cons (car lista) (string-length (car lista))))
    (else (cadena-mayor1 (cdr lista)))))

(define (cadena-mayor-fos lista)
  (fold-right (lambda (x y)
                (if (> (cdr x) (cdr y))
                    x
                    y)) (cons "" 0) (map (lambda (x)
                                           (cons x (string-length x))) lista)))

;; Funcion recursiva multiplo-de n lista-nums que recibe un numero n y una lista de numeros y devuelve
;; una lista de booleanos resultantos de comprobar si cada numero de la lista es multiplo de n

(define (multiplo-de n lista-nums)
  (cond
    ((null? lista-nums) '())
    ((= (mod (car lista-nums) n) 0) (cons #t (multiplo-de n (cdr lista-nums))))
    (else (cons #f (multiplo-de n (cdr lista-nums))))))

(define (multiplo-de-fos n lista-nums)
  (map (lambda (x)
         (if (= (mod x n) 0)
                #t
                #f)) lista-nums))

;; Funcion recursiva que reciba una lista que contiene simbolos operadores  yparejas representando
;; operaciones matematicas del modo (simbolo pareja simbolo pareja) devolver una lista con los resultados
;; de las operaciones


(define (calcula-pareja op pareja)
  (cond ((equal? op '+) (+ (car pareja) (cdr pareja)))
        ((equal? op '-) (- (car pareja) (cdr pareja)))
        ((equal? op '/) (/ (car pareja) (cdr pareja)))
        ((equal? op '*) (* (car pareja) (cdr pareja)))))

(define (calcular-lista lista)
  (if (null? lista)
      '()
      (cons (calcula-pareja (car lista) (cadr lista)) (calcular-lista (cddr lista)))))

;; Funcion recursiva expande que recibe una lista de parejas que contienen un dato y un  numero y devuelve una lista
;; donde se hayan expandido las parejas

(define (expande-pareja pareja)
  (if (= (cdr pareja) 0)
      '()
      (append (list (car pareja)) (expande-pareja (cons (car pareja) (- (cdr pareja) 1))))))

(define (expande lista-parejas)
  (if (null? lista-parejas)
      '()
      (append (expande-pareja (car lista-parejas)) (expande (cdr lista-parejas)))))

;; Funcion recursiva resultados-quiniela lista-parejas
                

(define (resultado-partido partido)
  (cond
    ((> (car partido) (cdr partido))  1)
    ((= (car partido) (cdr partido))  'X)
    (else 2)))

(define (resultados-quiniela lista-parejas)
  (if (null? lista-parejas)
      '()
      (cons (resultado-partido (car lista-parejas)) (resultados-quiniela (cdr lista-parejas)))))

(define (cuenta-resultados resultado lista-resultados)
  (if (null? lista-resultados)
      0
      (+ (if (equal? resultado (resultado-partido
                                (car lista-resultados)))
             1
             0) (cuenta-resultados resultado (cdr lista-resultados)))))

(define (inc-pos n lista)
  (if (= n 0)
      (cons (+ 1 (car lista)) (cdr lista))
      (cons (car lista) (inc-pos (- n 1) (cdr lista)))))

(define (cuenta-resultados-lista lista-resultados)
  (cond
    ((null? lista-resultados) (list 0 0 0))
    ((equal? 1 (resultado-partido (car lista-resultados)))
     (inc-pos 0 (cuenta-resultados-lista (cdr lista-resultados))))    
    ((equal? 'X (resultado-partido (car lista-resultados)))
     (inc-pos 1 (cuenta-resultados-lista (cdr lista-resultados))))
    (else (inc-pos 2 (cuenta-resultados-lista (cdr lista-resultados))))))

;; Funcion recursiva filtra simbolos que recibe una lista de simbolos y una lista de numeros
;; enteros y devuelve una lista de parejas, cada pareja esta formada por el simbolo de la i-esima
;; posicion de lista-simbolos siempre y cuando se corresponda con la longitud de la cadena correspondiente

(define (filtra-simbolos lista-simbolos lista-num)
  (if (null? lista-simbolos)
      '()
      (append (if (= (string-length (symbol->string (car lista-simbolos)))
                     (car lista-num))
                  (list (cons (car lista-simbolos) (car lista-num)))
                  '()) (filtra-simbolos (cdr lista-simbolos) (cdr lista-num)))))

(define (filtra-simbolos1 lista-simbolos lista-num)
  (cond
    ((null? lista-simbolos) '())
    ((= (string-length (symbol->string (car lista-simbolos))) (car lista-num)) (cons (cons (car lista-simbolos)
                                                                                           (car lista-num))
                                                                                     (filtra-simbolos1 (cdr lista-simbolos)
                                                                                                      (cdr lista-num))))
    (else (filtra-simbolos1 (cdr lista-simbolos) (cdr lista-num)))))

(define (filtra-simbolos-fos lista-simbolos lista-num)
  (filter (lambda (x)
            (if (= (string-length (symbol->string (car x)))
                   (cdr x))
                #t
                #f)) (map (lambda (x y)
                            (cons x y)) lista-simbolos lista-num)))
;; mucho ojo en meter cars y tal en el map q eso no tira.

;; Funcion que recibe una lista y devuelve aquellos simbolos con longitud impar

(define (longitud-impar lista-simbolos)
  (filter (lambda (x)
            (if (odd? (string-length (symbol->string x)))
                #t
                #f)) lista-simbolos))

;; Funcion que recibe una lista de simbolos y devuelve la suma de sus longitudes

(define (suma-longitudes1 lista-simbolos)
  (fold-right (lambda (x y)
                (+ (string-length (symbol->string x)) y)) 0 lista-simbolos))

(define (suma-longitudes lista-simbolos)
  (fold-right + 0 (map (lambda (x)
                         (string-length (symbol->string x))) lista-simbolos)))

;; Funcion que recibe una lista de simbolos y los devuelve escritos en mayuscula

(define (mayusculas lista-simbolos)
  (map (lambda (x)
         (string->symbol (string-upcase (symbol->string x)))) lista-simbolos))

;; Funciones de quiniela impmlementadas en fos

;; hacer esta xd
(define (resultados-quiniela-fos1 lista-parejas)
  (map resultado-partido lista-parejas))

(define (resultados-quiniela-fos lista-parejas)
  (fold-right cons '() (map (lambda (x)
                              (resultado-partido x)) lista-parejas)))

(define (cuenta-resultados-fos resultado lista-resultados)
  (length (filter (lambda (x)
                    (equal? (resultado-partido x) resultado)) lista-resultados)))

;; mediante funciones de ordens superior implementa las funciones suma-n-izq n lista parejas

(define (suma-n-izq n lista-parejas)
  (map (lambda (x)
         (cons (+ (car x) n) (cdr x))) lista-parejas))

;; funcion que recibe una funcion y una lista de parejas y devuelve el resltado de aplicar
;; esa funcion a los elementos de la pareja

(define (aplica-2 func lista-parejas)
  (map (lambda (x)
         (func (car x) (cdr x))) lista-parejas))

;; utilizando una composicino de funciones de orden superior fold right y map
;; implementa la funcion cadena-mayor lista que recibe una lista de cadenas y
;; devuelve una pareja con la cadena de mayor longitud y dicha longitud

(define (cadena-mayor lista)
  (fold-right (lambda (x y)
                (if (> (cdr x) (cdr y))
                    x
                    y)) (cons "" 0) (map (lambda (x)
                                           (cons x (string-length x))) lista)))

(define (filtra-simbolos-fos1 lista-simbolos lista-longitudes)
  (filter (lambda (x)
            (= (string-length (symbol->string (car x)))
               (cdr x))) (map cons lista-simbolos lista-longitudes)))
