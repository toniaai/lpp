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

let arbolString1: Arbol = .nodo("hola", [.hoja("que"), .hoja("tal")])
print(arbolString1)


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
print("Ejercicio 5: ")
// ejercicio 5
// indica que muestra por pantalla la funcion print
let posiciones = [(2,1), (3,4), (2,4), (8,4), (4,3)] 

print(posiciones.filter{$0.0 % $0.1 == 0}.map{($0.1, $0.0)}.reduce(0){$0 + $1.1}) 

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

// ejercicio 12

class Pasos {
    var contador = 0 {
        willSet {
            Pasos.totalInstancias += newValue - contador
        }
    }
    static var totalInstancias = 0

    func inc(pasos: Int) {
        if (pasos > 0) {
            contador += pasos
        }
    }

    var totalPasos: Int {
        return Pasos.totalInstancias
    }
}

var p1 = Pasos()
var p2 = Pasos()
p1.inc(pasos: 10)
p1.inc(pasos: 5)
p2.inc(pasos: 5)
print(p1.totalPasos)

// el objetivo de este ejercicio es tener la variable static q es la variable estática 
// universal para este tipo y la llamaremos dentro del tipo como Pasos.totalInstancias
// la cosa es que como nos fuerzan a utilizar el willSet tenemos que almacenar solo los pasos
// almacenados y no el contador, por que para los contadores, o mejor dicho, los pasos anteriores
// ya los hemos almacenado, y estaríamos repitiendo, como solo queremos los nuevos pasos restamos al nuevo
// valor el valor antiguo (contador) obteniendo unicamente los nuevos pasos añadidos. Ademas de esto
// tenemos que declarar el tipo estatico. 

// ejercicio 13

// completar el codigo de una estructura MiStruct que adopta un protocolo con tal de que este compile correctamente. 

protocol pA {
    var a: String {get}
    func foo(a: String) -> String?
}

protocol pB {
    mutating func bar()
}

// struct MiStruct: A, B {
    // completa el codigo
//}

struct MiStruct: pA,pB {
    var a: String {
        get {
            return self.a
        }
        set(nuevoA) {
            a = nuevoA
        }
    }

    func foo(a: String) -> String? {
        return a 
    }

    mutating func bar() {
        a = "hola"
    }
}

// la cosa de este ejer es primero, tener que poner las funciones y tipos que nos imponen los protocolos
// por otro lado nos imponen tener un get así como un mutating, en este caso, he querido mutar la propia
// variable que tenía un unico set y ahí tenía un problema, al tener SOLO get es de get only por lo que no
// la puedo mutar y tengo que añadir un set. Esto no tiene nigún problema con el protoclo puesto que el protocolo
// solo requiere el get, puedo añadir más. 

// ejercicio 14

// tenemos una funcion vector2 qur tiene un funcion que devuelve un vector con las propiedades del vector 
// actual multiplicadas por un escalar. Aqui supongo que la clave del problema es que tengo que devolver un nuevo
// vector y no el anterior puesto que al ser un struct no puedo cambiar el valor de las variables. (en este caso)

struct Vector2D {
    var x = 1.0, y = 1.0
    func producto(escalar k: Double) -> Vector2D {
        return Vector2D(x: self.x * k, y: self.y * k)
    }
}



let vect1 = Vector2D(x: 1.0, y: 2.0)
print(vect1)
var vect2 = vect1.producto(escalar: 5)
print(vect2)
print(vect1)

// en efecto la intenction del ejercicio era lo descrito.

// ejercicio 15
// nos dan una funcion copmlete y debemos indicar que se devuelve por pantalla

// esta funcion le pasamos una palabra y hace la cuenta de sus caracteres, 
// si la cuenta de caracteres es igual o mayor a dos guardaremos su indice
// a partir de su indice guardamos end, que es el indice inicial al que sumamos
// el offSet de la longitud total entre dos, es decir, al indice inicial nos movemos
// "media palabra" de indices
func foo(palabra pal: String) -> String {
    let lon = pal.count
    if lon < 2 {
        return pal     
    }    
    else {
        let start = pal.startIndex
        let end =  pal.index(start, offsetBy: lon/2)         
        return String(pal[end])     
    } 
} 
 

// esta clase contiene un tipo que es un array de palabras (string) y las va guardando en este
// segun llamemos a la funcion. además de esto contiene una variable x array de string que contiene un 
// getter, x se verá definida por este getter al ser inicializada (llamada en nuestro codigo mas abajo)
// y aplicará la funcion map para cada palabra de nuestro array, devolviendo el array resultante de
// aplicar la funcion foo a nuestro array.
class MisPalabras {
    var guardadas: [String] = []     
    func guarda(palabra: String) {         
        guardadas.append(palabra)     
    }       
    var x : [String] {         
        get {             
            return guardadas.map(foo)         
        }     
    } 
} 
 
 
let palabras = MisPalabras()
palabras.guarda(palabra: "sal") 
palabras.guarda(palabra: "limon") 
print(palabras.x)

// con la descripción anterior sabemos que vamos a devolver el caracter en la mitad de cada palabra (map de la funcion foo
// para cada palabra guardada), por lo tanto esta función devolverá algo como: ["a", "m"]

// ejercicio 16

// completar el codigo de la siguiente expresion utilizando propiedades calculadas, para que el ejemplo
// funcione correctamente.

extension Int {
    var sum: Int { return self + 10}
    var res: Int { return self - 10}
    var mul: Int { return self * 10}
    var div: Int { return self / 10}
}

let a = 3.sum 
print("a: \(a)")  // a: 13 

let b = 100.res 
print("b: \(b)")  // b: 90 

let c = 30.mul 
print("c: \(c)")  // c: 300 

let d = 24.div 
print("d: \(d)")  // d: 12 

let op = 30.sum + 10.res 
print("op: \(op)") // op: 40 

// la cosa de este ejercicio es saber bien como se añaden las extensiones:
// para empezar:
// no podemos poner un switch tal cual haríamos en un enum por que no sigue las misma sintaxis,
// estamos extendiendo una clase de la libreria estandar y sabemos que no tiene estos añadidos
// así que no podríamos realizarlo del modo switch self { case .sum } 

// por otro lado tampoco podemos añadir la extensión como funciones tal cual por que a pesar de que
// para un unico numero o variable podría funcionar a la hora de utilizar varios parametros o hacer el 
// ultimo ejemplo sobrecargariamos el metodo y daría error

// la forma correcta de extender la clase es añadiendolo como tipos variables con un get simple que sea
// el return junto al self y la operación que deseemos. 

// ejercicio 17

// completa la siguiente implementación para que las pruebas funcionen correctamente:

// nos dan una enumeracion llamada CodigoBarras y que se ajusta al protocolo Equatable de la libreria de clases estandar de swift
// este protocolo nos permite asegurarnos de que nuestro tipo cumpla y defina las operaciones de igualdad. 

enum CodigoBarras : Equatable{     
    case upc(Int, Int)     
    case qrCode(Int) 
 
    // la declaración de la funcion no estaba
    static func == (c1: CodigoBarras, c2: CodigoBarras) -> Bool {         
        switch (c1, c2) {            
            case let (.upc(codeA1, codeB1), .upc(codeA2, codeB2)): 
                // lo que devuelve return no estaba
                return codeA1 == codeA2 && codeB1 == codeB2
 
           case let (.qrCode(code1), .qrCode(code2)): 
                // lo que devuelve return no estaba
                return code1 == code2 
           default:                
                return false        
        }     
    } 
} 

print(CodigoBarras.qrCode(11) == CodigoBarras.qrCode(11)) // true
print(CodigoBarras.upc(1234, 1234) == CodigoBarras.upc(2222, 1111)) // false

// en este ejercicio debemos definir una funcion == para que nuestra enumeracion se adeque al protocolo Equatable
// la funcion == debe ser estática y además tenemos que tener en cuenta como en el enunciado nos imponen un switch con
// un codigo 1, c1, y otro dos c2, que tenemos que incluir en la definicion de la funcion 

// de este ejercicio también podemos sacar el que podemos definir nombres locales para los nombres de las variables que estamos utilizando
// dentro de la funcion, como es el caso de codeA1, codeA2... Para facilitar la ejecución. También podriamos haber hecho c1.upc.0 y c1.upc.1


// ejercicio 18

// debemos corregir un codigo en swift quitando y sustituyendo codigo para que el compilador no lance error y la salida por pantalla sea la indicada.
// en el metodo saluda de la clase Foo no podemos escribir la cadena "soy base".

class Base {     
    func saluda() -> String {         
        return "soy base"     
    } 
} 
 
class Foo: Base {     
    override func saluda() -> String {        
        return super.saluda() + " soy foo"     
    } 
} 
 
// Las siguientes líneas no debes cambiarlas 
 
var arr = [Foo(), Base()]  

for elem in arr {    
    print(elem.saluda()) 
} 
// Imprime  
//    "soy base soy foo"  
//    "soy base"

// este ejercicio, en un principio, la que es clase Base nos lo dan como protocolo, y la resolución de este ejercicio se basa en:
// Base tiene que tener su implementación de saluda para poder devolver soy base, puesto que no lo podemos introducir en Foo.
// Al ser un protocolo inicialmente esta, no puede tener definiciones de funciones, por lo que cambios de protocolo a clase para que
// de este modo, Foo pueda heredar de clase.
// De esta misma manera debemos hacer un override de saluda por que ya tenemos la definición en Base, pero como queremos que salga soy base
// llamamos al metodo Base mediante super, y a eso añadimos "soy foo".

// ejercicio 19

// dado el siguiente codigo en swift debemos completar un bucle para que se imprima lo indicado
protocol P {     
    func saluda() -> String 
} 
 
class A2: P {     
    func saluda() -> String {         
        return "Soy de la clase A"     
    }     
    
    func foo() -> Int {         
        return 0     
    } 
} 
 
class B2: P {     
    func saluda() -> String {         
        return "Soy de la clase B"     
    }    

    func bar() -> Int {         
        return 100     
    } 
} 
 
let instancias: [P] = [A2(), B2()] 
 
for x in instancias {     // Completa el código 
    if let claseA = x as? A2 {
        print ("\(claseA.saluda())\n\(claseA.foo())")
    }
    else if let claseB = x as? B2 {
        print ("\(claseB.saluda())\n\(claseB.bar())")
    }
    
} // Imprime:  // Soy de la clase A // 0 // Hola soy de la clase B // 100

// el objetivo de este ejercicio es ser capaz de hacer el downcasting a cada objeto
// dentro del array [P] que tenemos. El ejercicio nos plantea un array del tipo del Protocolo
// P que contiene diversas clases que se adaptan a este procolo, pero cada una de estas tiene 
// una implementación extra de una funcion. Para poder ejecutar cada uno de los dos objetos
// dentro de este array de protocolos tenemos que hacer el downcasting, o intentar downcastear 
// con un operador de casteo. en el caso de lograrlo imprimimos lo suyo, sino, probamos el otro.


// ejercicio 20

// definir una extension para el tipo array solo cuando sus elementos sean numeros
// que implemente un metodo que sume todos sus elementos


extension Array where Element: Numeric {
    func sum() -> Element {
        return reduce(0, +)
    }
}


let a12 = [Int](0...5) 
print(a12.sum())

let b12 : [String] = ["h", "d", "e"]  
//print(b.sum())  // Error 

// la cosa de este ejercicio es saber como van las extensiones y que a una extension le puedo definir
// parametros como por ejemplo Array where Element: Numeric así nos aseguramos del que tenga que ser int
// y seguimos la sugerencia del enunciado para utilizar el protocolo Numeric definido en swift. 

