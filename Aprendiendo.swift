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

// A continuacion dos prints iguales
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