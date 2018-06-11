// Ejercicio 1

func obtenerFrecuencias(respuestas: [Int]) -> [Int] {
    var frecuencias = Array(repeating: 0, count: 10)
    for puntuacion in respuestas {
        frecuencias[puntuacion] += 1
    }
    return frecuencias
}

func mayorFrecuencia(frecuencias: [Int]) -> Int {
    var mayor = frecuencias[0]
    for frec in frecuencias[1..<frecuencias.count] {
        if frec > mayor {
            mayor = frec;
        }
    }
    return mayor
}

func imprimir(frecuencias: [Int], maxAsteriscos: Int) {
    let mayor = mayorFrecuencia(frecuencias: frecuencias)
    var i = 0
    for frec in frecuencias {
        let numEscalado = frec * maxAsteriscos / mayor
        print("\(i): " + String(repeating: "*", count: numEscalado))
        i += 1
    }
}

let respuestas = [0,0,1,1,2,1,2,3,5,1,2,2,2,6]
print("Valores: \(respuestas)" )
let frec = obtenerFrecuencias(respuestas: respuestas)
print("Frecuencias: \(frec)")
print("\nHistograma")
print("----------")
imprimir(frecuencias: frec, maxAsteriscos: 10)

