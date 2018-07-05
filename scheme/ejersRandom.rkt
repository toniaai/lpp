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

;; sustituir en un arbol
(define (arbol-sust arbol elem-old  elem-new)
  (construye-arbol (if (equal? (dato-arbol arbol) elem-old)
            elem-new
            (dato-arbol arbol))
        (arbol-sust-bosque (hijos-arbol arbol) elem-old elem-new)))

(define (arbol-sust-bosque bosque elem-old elem-new)
  (if (null? bosque)
      '()
      (cons (arbol-sust (car bosque) elem-old elem-new)
              (arbol-sust-bosque (cdr bosque) elem-old elem-new))))

(define arbolSust '(a (b (c) (d)) (c (e)) (f (c) (c))))

(define (arbol-sust-fos arbol elem-old elem-new)
  (construye-arbol (if (equal? (dato-arbol arbol) elem-old)
                       elem-new
                       (dato-arbol arbol)) (map (lambda (x)
                                                  (arbol-sust-fos x elem-old elem-new)) (hijos-arbol arbol))))

;; maximo de un arbol
(define (max-arbol arbol)
  (max (dato-arbol arbol)
       (max-bosque (hijos-arbol arbol))))

(define (max-bosque bosque)
  (if (null? bosque)
      0
      (max (max-arbol (car bosque)))))

           
(define (max-arbol-fos arbol)
  (fold-right (lambda (x y)
                (if (> x y)
                    x
                    y)) (dato-arbol arbol) (map (lambda (x)
                                                  (max-arbol-fos x)) (hijos-arbol arbol))))

(define arbolMax '(10 (20 (4) (3)) (12 (1) (2)) (15 (21) (2))))

;; lista-nivel
(define (lista-nivel-tree nivel arbol)
  (if (= nivel 0)
      (list (dato-arbol arbol))
      (lista-nivel-bosque (- nivel 1) (hijos-arbol arbol))))

(define (lista-nivel-bosque nivel bosque)
  (if (null? bosque)
      '()
      (append (lista-nivel-tree nivel (car bosque))
              (lista-nivel-bosque nivel (cdr bosque)))))

(define (lista-nivel-tree-fos nivel arbol)
  (fold-right append '() (map (lambda (x)
                                (if (<= nivel 0)
                                    x
                                    (lista-nivel-tree-fos (- nivel 1) x))) (hijos-arbol arbol))))


(define arbolNivel '(1 (2 (3 (4) (2)) (5)) (6 (7))))

;; cumplen-pred arbol

(define (cumplen-pred-arbol pred arbol)
  (construye-arbol (if (pred (dato-arbol arbol))
                       #t
                       #f)
                   (cumplen-pred-bosque pred (hijos-arbol arbol))))

(define (cumplen-pred-bosque pred bosque)
  (if (null? bosque)
      '()
      (cons (cumplen-pred-arbol pred (car bosque))
            (cumplen-pred-bosque pred (cdr bosque)))))

(define (cumplen-pred-arbol-fos pred arbol)
  (construye-arbol (if (pred (dato-arbol arbol))
                       #t
                       #f)
                   (map (lambda (x)
                          (cumplen-pred-arbol-fos pred x)) (hijos-arbol arbol))))

;; cuenta pares arbol
(define (suma-parejas p1 p2)
  (cons (+ (car p1) (car p2))
        (+ (cdr p1) (cdr p2))))

(define (cuenta-pares-impares-arbol arbol)
  (suma-parejas (if (even? (dato-arbol arbol))
         (cons 1 0)
         (cons 0 1))
     (cuenta-pares-impares-bosque (hijos-arbol arbol))))

(define (cuenta-pares-impares-bosque bosque)
  (if (null? bosque)
      (cons 0 0)
      (suma-parejas (cuenta-pares-impares-arbol (car bosque))
         (cuenta-pares-impares-bosque (cdr bosque)))))


(define (cuenta-pares-impares-arbol-fos arbol)
  (fold-right (lambda (x y)
                (suma-parejas x y)) (if (even? (dato-arbol arbol))
                                        (cons 1 0)
                                        (cons 0 1)) (map (lambda (x)
                                                           (cuenta-pares-impares-arbol-fos x)) (hijos-arbol arbol))))

;; diffs arbol
(define arbolDiff1 '(1 (2 (3 (4) (40)) (5)) (6 (7))))
(define arbolDiff2 '(1 (2 (10 (4) (2)) (21)) (6 (7))))

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
  (fold-right append (if (equal? (dato-arbol arbol1) (dato-arbol arbol2))
                         '()
                         (list (cons (dato-arbol arbol1) (dato-arbol arbol2))))
              (map (lambda (x y)
                     (diff-arbol-fos x y)) (hijos-arbol arbol1) (hijos-arbol arbol2))))

;; funcion que suma solo los numeros pares de un arbol
(define (suma-pares-arbol arbol)
  (+ (if (even? (dato-arbol arbol))
         (dato-arbol arbol)
         0)
     (suma-pares-bosque (hijos-arbol arbol))))

(define (suma-pares-bosque bosque)
  (if (null? bosque)
      0
      (+ (suma-pares-arbol (car bosque))
         (suma-pares-bosque (cdr bosque)))))

(define (suma-pares-arbol-fos arbol)
  (fold-right (lambda (x y)
                (if (even? x)
                    (+ x y)
                    y)) (if (even? (dato-arbol arbol))
                            (dato-arbol arbol)
                            0) (map (lambda (x)
                                      (suma-pares-arbol-fos x)) (hijos-arbol arbol))))

(define (suma-pares-arbol-fos1 arbol)
  (+ (if (even? (dato-arbol arbol))
         (dato-arbol arbol)
         0)
     (fold-right (lambda (x y)
                   (if (even? x)
                       (+ x y)
                       y)) 0 (map (lambda (x)
                                    (suma-pares-arbol-fos1 x)) (hijos-arbol arbol)))))
                                
                    
