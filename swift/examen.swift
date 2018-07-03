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

//let x = [(10, -2), (3, 40), (-5, 26), (22, -3), (10, 8)]
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

var x = 1 {
    didSet {
        print("soy la x global y me han cambiao a: \(x) desde: \(oldValue)")
    }
}
 
func foo(_ b: Int) -> ((Int) -> Int, (Int) -> Int) {     
    var x = 1 + b {
        didSet {
           print("soy la x d instancia y me han cambiao a: \(x) desde: \(oldValue)")
        }
    }
    print("esto es el princi: x = \(x) y b = \(b)")
    func bar1(_ a: Int) -> Int{ 
        print("esto en bar1 y a = \(a) y x = \(x)")        
        x = x + a         
        return x     
    } 
 
    func bar2(_ a: Int) -> Int {
       print("esto en bar2 y a = \(a) y x = \(x)")        
        x = x + a + 1         
        return x     
    }     
    return (bar1, bar2) 
}

// rellena los juevos con lo que se imprime por pantalla:
// let f = foo(x)
// f.0(x)
// print(f.1(x)) => ___________ => 5 (bar2 => x = 3 + 1 + 1
// let g = foo(x+2)
// print(g.0(x)) => ___________ => en g var x = 1 + (1 + 2) e invocamos a la funcion del car => x = 4 + 1



let f = foo(x)
// este ejercicio con lo que juega es con el tipo de variables globales y locales. por un lado tenemos la variable global x 
// y por otro lado la variable del tipo x, esta variable del tipo es la que tras cada ejecución cambiará su valor y se mantendrá
// en este valor para la siguiente ejecucion siempre que sea la misma instancia. como se puede comprobar.
// el lio del ejercicio es que para una nueva instancia d foo te hacen la g q es x+2 y al recalcularse la x d esa instancia t hace
// var x = 1 + b siendo esa b (x + 2), osea (xglobal + 2) es decir: para g var x = 1 + (1 + 2)

print("\nEjecucion f.0(x)")
print(f.0(x))
print("\nEjecucion f.1(x)")
print(f.1(x))
let g = foo(x+2)
print("\nEjecucion g.0(x)")
print(g.0(x))

// ejercicio 9
// dado el siguiente codigo en swift, que se imprime por pantalla? 

func foo() -> (Int) -> Int {     
    var y = 10 
 
    func bar(_ a: Int) -> Int {         
        y = a + y        
        return y     
    }     
    return bar 
} 
var y = 1 
let numeros = [Int](0...5) 
let z = foo() 
print(numeros.map(z)) 

// esta funcion es simple, tenemos una y = 1 para marear nada mas empezar q nos da igual pq luego
// cojeremos el valor local del tipo pero bueno, la cosa es que esta funcion devuelve una funcion que devolverá una Int
// y lo que hace basicamente es, tiene su tipo que obtendrá el valor 10 nada mas inicializarse la funcion.
// sobre esa funcion que devuelve, bueno, mas que sobre, podemos decir que mapearemos esa funcion devuelta
// sobre un array de Ints. La funcion lo que hace es recibir un numero y sumarselo a y. Para cada ejecucion, obviamente
// le sumaremos al y resultado de la ultima ejecucion, por eso nos queda algo como:
// [10+0 = 10, 10 + 1 = 11, 11 + 2 = 13, 13 + 3 = 16, 16 + 4 = 20, 20 + 5 = 25]

// ejercicio 10
// con que argumentos hay que llamar a la funcion aplica en el ejemplo para que imprima
// [[4, 5, 6], [4, 5], [1, 2, 3]]

func paraPares(_ par: Int) -> [Int] {
         let n = par / 2     
         return [n,n+1] 
} 

func paraImpares(_ impar: Int) -> [Int] {     
    let n = (impar+1) / 2     
    return [n-1,n,n+1] 
} 

func aplica(_ numeros: [Int] ,_ funciones: [(Int)->[Int]]) -> [[Int]] {
     return numeros.map(){funciones[$0%2]($0)} 
}

// print(aplica(______________________________________________________________))
// Imprime: [[4, 5, 6], [4, 5], [1, 2, 3]] 
print(aplica([9, 8, 3], [paraPares, paraImpares]))

// la gracia de este ejercicio es que para decidir que elemento de la lista funciones coger, 
// es decir, para saber que funcion le voy pasar al elemento actual tomo el resultado de comprobar
// si el elemento que tengo es par o impar, si es par devolverá 0 y ejecutaré la primera funcion
// si es impar devolverá 1 y ejecutaré la segunda. La gracia o la trampa de este ejercicio es que 
// te puedes confundir pensando que el $0 de funciones tambien recorre el vector funciones y no es mas que 
// un indice. por lo que solo tienes que poner en el caso de que $0%2 sea 0, es decir, el numero en $0
// sea par para el indice 0 de funciones tengo que tener la funcionar para pares y para impares es igual pero 
// con el indice 1 puesto que 1 es el resultado de cualquier impar %2. 

// ejercicio 11
// rellena los huecos de la funcion componer para que el ejemplo imprima:
// hgf(x)=2x^2+5 para x=5.0 es 55.0 


func componer(funciones: [(Double) -> Double]) -> Double {

    func compuesta(_ x: Double) -> Double {
        return funciones.reduce(x){$1($0)}
    }
 
}

//Ejemplo: 
func f1(_ x: Double) -> Double {return x*x} 
func g1(_ x: Double) -> Double {return 2.0*x} 
func h1(_ x: Double) -> Double {return x+5.0} 
let hgf = componer(funciones: [f1,g1,h1]) 
print("hgf(x)=2x^2+5 para x=5.0 es \(hgf(5.0))")
// Imprime: 
// hgf(x)=2x^2+5 para x=5.0 es 55.0 