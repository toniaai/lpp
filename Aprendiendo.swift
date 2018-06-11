// var es para una variable, let para una constante
var variable = 10
variable = 11
let constante = 10
// constante = 11 no puedo hacer esto por que es una constante y daría error!

print("variable es \(variable) mientras que constante es \(constante)")
// -> variable es 11 mientras que constante es 10

// podemos especificar tipos aun que no hayamos definido anteriormente nada:
let string1 = "soy una string"
let numero1 = 123
// let stringynumero = string1 + numero aquí tenemos un error por que los valores no se convierten implicitamente
let stringynumero = string1 + String(numero1)
print("stringynumero deberia ser \(string1)\(numero1) y es: \(stringynumero)")
// -> stringynumero deberia ser soy una string123 y es: soy una string123
// tambien podría hacer esto
print("stringynumero deberia ser \(string1)\(numero1) y es: \(string1 + String(numero1))")
// -> stringynumero deberia ser soy una string123 y es: soy una string123

// Puedo crear un array tal que 
var array1 = [String]()
print(array1)
// -> []
// puedo añadirle cosas así 
array1.append("hola")                           // añado en la última posición
let array2 = ["array2: 1", "array2: 2"] 
array1 += array2                                // añado otro array del mismo tipo tal cual
array1[1] = "yo era array2: 1"                  // cambio el valor de la posicion 1
array1.insert("aquí estaba array2: 2", at: 2)   // meto algo en un indice, moviendo lo demás  
array1.append("ahora array2: ")                 // meto ultima posicion
array1.append(contentsOf: array2)               // meto ultima posicion los contenidos de otro array
array1.insert("soy el final", at: 7)            // meto en la ultima posicion manualmente
print(array1)
// -> ["hola", "yo era array2: 1", "aquí estaba array2: 2", "array2: 2", "ahora array2: ", "array2: 1", "array2: 2", "soy el final"]

// var array3 = Array(repeating: "algo", count: 2)
let array3 = Array(repeating: "algo", count: 2)
print("En el siguiente array algo se repite dos veces: \(array3)")
// -> En el siguiente array algo se repite dos veces: ["algo", "algo"]

// Puedo iterar un array a partir del indice que yo quiera tal que:
let array4 = Array(0...10)
print(array4)
// -> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

let array5 = Array(0..<10)
print(array5)
// -> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

// Operaciones con rangos.. 
print(array4[4...8])

var array6 = [Int]()
for numero in array4[4...8] {
    array6.append(numero)
}
print(array6)
print("array6 tiene de count: \(array6.count)")
print(array6[1..<array6.count])
print(array6[1..<array6.count-1])
// -> array6 tiene de count: 5
// -> [5, 6, 7, 8]
// -> [5, 6, 7]

var cadenaOpcional: String? = "Hola"
print(cadenaOpcional == nil)

var nombreOpcional: String? = nil
var saludo = "Hola!"
print(saludo)

if let nombre = nombreOpcional {
    saludo = "Hola, \(nombre)"
} else {
    saludo = "Hola, desconocido"
}
print(saludo)

let nombrePila: String? = nil
let nombreCompleto: String = "John Appleseed"
let saludoInformal = "¿Qué tal, \(nombrePila ?? nombreCompleto)?"

print(saludoInformal)

let verdura = "pimiento rojo"
switch verdura {
    case "zanahoria":
        print("Buena para la vista.")
    case "lechuga", "tomates":
        print("Podrías hacer una buena ensalada.")
    default:
        print("Siempre puedes hacer una buena sopa.")
}

var trabajos = [
    "Malcolm": "Capitán",
    "Kaylee": "Mecánico",
]
print(trabajos)

trabajos["Jayne"] = "Relaciones públicas"
print(trabajos)

let numerosInteresantes = [
    "Primos": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Cuadrados": [1, 4, 9, 16, 25],
]

print(numerosInteresantes)

var mayor = 0
for (clase, numeros) in numerosInteresantes {
    for numero in numeros {
        if numero > mayor {
            mayor = numero
        }
    }
}
print(mayor)


func calculaEstadisticas(puntuaciones: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = puntuaciones[0]
    var max = puntuaciones[0]
    var sum = 0
    
    for puntuacion in puntuaciones {
        if puntuacion > max {
            max = puntuacion
        } else if puntuacion < min {
            min = puntuacion
        }
        sum += puntuacion
    }
    
    return (min, max, sum)
}

let estadisticas = calculaEstadisticas(puntuaciones: [5, 3, 100, 3, 9])
print(estadisticas)
print(estadisticas.sum)
print(estadisticas.2)
/*
(min: 3, max: 100, sum: 120)
120
120
*/

func media(numeros: Int...) -> Int {
    var suma = 0
    var i = 0
    for num in numeros {
        i += 1
        suma += num
    }

    return suma / i
}
print(media(numeros: 42, 597, 12))
// -> 217

func construyeIncrementador() -> ((Int) -> Int) {
    func sumaUno(numero: Int) -> Int {
        return 1 + numero
    }
    return sumaUno
}
var incrementa = construyeIncrementador()
print(incrementa(7))
// -> 8

func cumpleCondicion(lista: [Int], condicion: (Int) -> Bool) -> Bool {
    for item in lista {
        if condicion(item) {
            return true
        }
    }
    return false
}
func menorQueDiez(numero: Int) -> Bool {
    return numero < 10
}
var numeros = [20, 19, 7, 12]
print(cumpleCondicion(lista: numeros, condicion: menorQueDiez))
// -> true
print(
numeros.map({
    (numero: Int) -> Int in
    let resultado = 3 * numero
    return resultado
}))

print(
    numeros.map({
        numero in 3 * numero
    })
)

print(
    numeros.map({
        (numero: Int) -> Int in 
        if numero % 2 == 0 {
            return numero
        } else {
            return 0
        }
    })
)
/*
[60, 57, 21, 36]
[60, 57, 21, 36]
[20, 0, 0, 12]
*/