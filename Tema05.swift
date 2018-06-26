func makeSumador10() -> (Int) -> Int {
  func suma10(x: Int) -> Int {return x+10}
  return suma10
}

var f = makeSumador10()
print(makeSumador10()(20))

var cadenaOpcional: String? = "Hola"
print(cadenaOpcional == nil) // => false

var cadenaOpcional1: String?
print(cadenaOpcional1 == nil) // => true

func suma(hasta x: Int) -> Int {
  if x == 0 {
    return 0
  } else {
    return x + suma(hasta: x - 1)
  }
}

print(suma(hasta: 5))

var posibleNumero = "123"
posibleNumero = "Hola mundo"
if let numeroVerdadero = Int(posibleNumero) {
    print("\"\(posibleNumero)\" tiene un valor entero de \(numeroVerdadero)")
} else {
    print("\"\(posibleNumero)\" no ha podido convertirse en un entero")
}