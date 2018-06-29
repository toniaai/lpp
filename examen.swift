// ejercicio 1
// suponiendo el siguiente enumerado, define dos variablesque contengan dos valores del enumerado
// uno del caso a y uno del caso b

enum A {
    case a(Bool, String, Int)
    case b(Int)
}

let varA = A.a(true, "Hola", 2)
let varB = A.b(10)


// ejercicio 2
// supongamos el siguiente codigo de scheme ¿que aparece en pantalla?

let x = [(10, -2), (3, 40), (-5, 26), (22, -3), (10, 8)]
// print (x.map{$0.0 + $0.1}.reduce(a[0]){             
//            if $0 < $1 {return $0} else {return $1}}) 

//un error xd

// ejercicio 3
// dada la siguiente defición del tipo enumerado que representa un árbol genérico
indirect enum Arbol<T> {
    case nodo(T, [Arbol<T>])
    case hoja(T)
}
let hoja1 = Arbol<String>.hoja("que")
let hoja2 = Arbol<String>.hoja("tal")
let arbolString = Arbol<String>.nodo("hola", [hoja1, hoja2])
print(arbolString)




// ejercicio 4
// dada la definicion del tipo generico anterior define la funcion generica esHoja(arbol: )
// que recibe un arbol generico y devuelve true si es un árbol hoja y false en el caso contrario

func esHoja<T>(arbol: Arbol<T>) -> Bool {
    switch arbol {
        case .hoja: return true
        default: return false
    }
}

print(esHoja(arbol: hoja1))         // true
print(esHoja(arbol: arbolString))   // false

// ejercicio 5
// indica que muestra por pantalla la funcion print
let posiciones = [(2,1), (3,4), (2,4), (8,4), (4,3)] 

print(posiciones.filter{$0.0 % $0.1 == 0}.map{($0.1, $0.0)}.reduce(0){$0 + $1.0}) 

print(posiciones.filter{$0.0 % $0.1 == 0}) // [(2, 1), (8, 4)]
// ahora el map aplicaria .map({$0.1, $0.0}) => [(1, 2), (4, 8)]
// y ahora el reduce que me sumaria el primer elemento d cada pareja d la lista al caso base
// .reduce(0){$0 + $1.0} => 5

print(posiciones.filter{$0.0 % $0.1 == 0}.map{($0.1, $0.0)}) // => [(1, 2), (4, 8)]  como habiamos dicho


// ejercicio 6
// supongamos la funcion foo que recibe un etnero y devuelve un entero opcional
// completa la deficion de la funcino indicando el tipo devuelvo y escribe el codigo en swift
// que llame a la funcion foo con el paramtro 10 y que imprime el doble del resultado
// devuelto. si el valor devuleto es nil se debe imprimir sin resultado

func foo(x: Int) -> Int? {
    return x
}

if let IntTest: Int = foo(x: 10) {
    print(IntTest * 2)
} else {
    print("Sin resultado")
}

// ejercicio 7 
//dado el siguiente codigo en swift:

enum Dispositivo {
        case iPad, iPhone, AppleTV, AppleWatch
            
        func lanzamiento() -> String {
            switch self {
                case .AppleTV: return "\(self) salió en 2006"  
                case .iPhone: return "\(self) salió en 2007"  
                case .iPad: return "\(self) salió en 2010"  
                case .AppleWatch: return "\(self) salió en 2014"
            }     
        } 
}

// queremos imprimir por pantalla "iPhone salió en 2007" utilizando el codigo anterior.
// en el caso que creas que es poisble completar la sentencia print, escribe cual seria.
// en el caso en que creas que se genera un error, escribelo.

print(Dispositivo.iPhone.lanzamiento())

// ejercicio 8
// dado el siguiente codigo en swift:

var x = 1 
 
func foo(_ b: Int) -> ((Int) -> Int, (Int) -> Int) {     
    var x = 1 + b 
 
    func bar1(_ a: Int) -> Int{         
        x = x + a         
        return x     
    } 
 
    func bar2(_ a: Int) -> Int {         
        x = x + a + 1         
        return x     
    }     return (bar1, bar2) 
}

// rellena los juevos con lo que se imprime por pantalla:
// let f = foo(x)
// f.0(x)
// print(f.1(x)) => ___________
// let g = foo(x+2)
// print(g.0(x)) => ___________

