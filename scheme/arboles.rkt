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

(define arbol '(15 (4 (2) (3))
                   (8 (6))
                   (12 (9) (10) (11))))
;     car (dato-arbol (cadr (hijos-arbol (cddr (hijos-arbol arbol)

(define arbolb '(40 (23 (5 () ())
                        (32 (29 () ())
                            ()))
                    (45 ()
                        (56 () ()))))

(define (to-list-arbol-fos arbol)
    (cons (dato-arbol arbol)
          (fold-right append '() (map to-list-arbol-fos (hijos-arbol arbol)))))
(define arbol2 '(a (b (c (d)) (e)) (f)))


(define (to-string-arbol-fos arbol)
    (fold-right string-append
               (symbol->string (dato-arbol arbol))
               (map to-string-arbol-fos (hijos-arbol arbol))))


(define (to-string-arbol-fos1 arbol)
  (string-append (symbol->string (dato-arbol arbol))
                 (fold-right string-append "" (map to-string-arbol-fos1 (hijos-arbol arbol)))))

; > (to-string-arbol-fos1 arbol2)
; "abcdef"
;> (to-string-arbol-fos arbol2)

; funciones auxiliares
(define (ordenada-lista lista)
  (if (null? (cdr lista))
      #t
      (and (< (car lista) (cadr lista))
           (ordenada-lista (cdr lista)))))

(define (raices bosque)
  (if (null? bosque)
      '()
      (cons (dato-arbol (car bosque))
            (raices (cdr bosque)))))

; funciones recursión mutua

(define (ordenado-arbol? arbol)
  (and (ordenada-lista (append (raices (hijos-arbol arbol))
                               (list (dato-arbol arbol))))
       (ordenado-bosque? (hijos-arbol arbol))))

(define (ordenado-bosque? bosque)
  (if (null? bosque)
      #t
      (and (ordenado-arbol? (car bosque))
           (ordenado-bosque? (cdr bosque)))))
(define (cuadrado numero)
  (* numero numero))

(define (cuadrado-arbol arbol)
   (construye-arbol (cuadrado (dato-arbol arbol))
                    (cuadrado-bosque (hijos-arbol arbol))))  

(define (cuadrado-bosque bosque)
   (if (null? bosque)
       '()
       (append (cuadrado-arbol (car bosque))
               (cuadrado-bosque (cdr bosque)))))

(define test (construye-arbol 4 (cons (cons 2 '())
                                      (cons 3 '()))))

(define (repite-arbol arbol)
  (construye-arbol (dato-arbol arbol)
                   (repite-bosque (hijos-arbol arbol))))

(define (repite-bosque bosque)
  (if (null? bosque)
      '()
      (cons (repite-arbol (car bosque))
            (repite-bosque (cdr bosque)))))

(define lista1 '('() '()))
(define (izq lista)
  (cons 1 (car lista)))

(define (num-hojas lista)
  (cond
    ((null? lista) 0)
    ((hoja? lista) 1)
    (else (+ (num-hojas (car lista))
             (num-hojas (cdr lista))))))

(define (aplana-fos lista)
  (fold-right append
              '()
              (map (lambda (elem)
                     (if (hoja? elem)
                         (list elem)
                         (aplana-fos elem))) lista)))

(define (aplana-fos1 lista)
              (map (lambda (elem)
                     (if (hoja? elem)
                         (list elem)
                         (aplana-fos elem))) lista))