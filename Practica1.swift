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

// Ejercicio 2
func compruebaParejas(_ valores: [Int], funcion f: (Int) -> Int) -> [(Int, Int)] {
    if let primero = valores.first, let segundo = valores.dropFirst().first {
        let resto = Array(valores.dropFirst())
        if f(primero) == segundo {
            return [(primero, segundo)] + compruebaParejas(resto, funcion: f)
        } else {
            return compruebaParejas(resto, funcion: f)
        }
    } else {
        return []
    }
}

// DEMOSTRACIÓN

func cuadrado(x: Int) -> Int {
   return x * x
}
let array2a = [2, 4, 16, 5, 10, 100, 105]
print("\nEjercicio 2")
print("============\n")
print("compruebaParejas(\(array2a), cuadrado): \(compruebaParejas(array2a, funcion: cuadrado))")

// Ejercicio 3

// Ejercicio 4



let array = [(2,4), (4,14), (4,16), (5,25), (10,100)]


func coinciden(parejas: [(Int, Int)], funcion f: (Int) -> Int) -> [Bool] {
    if let (x,y) = parejas.first {
        let resto = Array(parejas.dropFirst())
        return [f(x) == y] + coinciden(parejas: resto, funcion: f)
    }
    else
    {
        return []
    }
}

// DEMOSTRACIÓN

print("\nEjercicio 4)")
print("============\n")
let array4: [(Int,Int)] = [(2,4), (4,14), (4,16), (5,25), (10,100)]
print("coinciden(\(array4), cuadrado):  \(coinciden(parejas: array4, funcion: cuadrado))\n")
// Imprime: Resultado coinciden:  [true, false, true, true, true]


