//EJERCICIO 1
print("\nEjercicio 1")
enum A {     
    case a(Bool, String, Int)     
    case b(Int) 
}

let casoa = A.a(true, "hola", 1)
let casob = A.b(10)

// print(casoa) => a(true, "hola", 1)
// print(casob) => b(10)

//EJERCICIO 3
print("\nEjercicio 3")
indirect enum Arbol<T> {     
    case nodo(T, [Arbol<T>])     
    case hoja(T) 
    func esHoja() -> Bool {
        switch self {
        case .hoja:
            return true
            
        default: return false
            
        }
    }
} 
//EJERCICIO 4
print("\nEjercicio 4")
let hoja1 = Arbol.hoja("que")
let hoja2 = Arbol.hoja("tal")
let arbolString = Arbol.nodo("hola", [hoja1, hoja2])
print(arbolString)

print(hoja1.esHoja())

//EJERCICIO 5
print("\nEjercicio 5")
let posiciones = [(2,1), (3,4), (2,4), (8,4), (4,3)]
print(posiciones.filter{$0.0 % $0.1 == 0}.map{($0.1, $0.0)}.reduce(0){$0 + $1.0})
// Prints: 5
print(posiciones.filter{$0.0 % $0.1 == 0}) // => [(2, 1), (8, 4)]
print(posiciones.map{($0.1, $0.0)}) // => [(1, 2), (4, 8)]
print(posiciones.reduce(0){$0 + $1.0}) // => 5 (1 + 4)

//EJERCICIO 6
print("\nEjercicio 6: ")

func foo(x: Int) -> Int? {
    
    return x + x
}

var posibleNumero = foo(x: 10)
print(posibleNumero ?? "caca")

//EJERCICIO 7
print("\nEejercicio 7: ")
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

print(Dispositivo.iPhone.lanzamiento())

//EJERCICIO 8
print("\nEjercicio 8")
var x = 1 
 
func foo(_ b: Int) -> ((Int) -> Int, (Int) -> Int) {  
    print("1: \(b)")   
    var x = 1 + b 
    print("2: \(x)")  
    
    func bar1(_ a: Int) -> Int{
        x = x + a 
        print("bar1: \(x)")        
        return x     
    } 
    print("3: \(x)")  
    func bar2(_ a: Int) -> Int {
        x = x + a + 1    
        print("bar2: \(x)")        
        return x     
    }   
    print("4: \(x)")    
    return (bar1, bar2) 
}
print("f = foo(x) -> ")
let f = foo(x) 
print("\nprint(f.0(x)) -> \(f.0(x))")
print("\nprint(f.1(x)) -> \(f.1(x))")
let g = foo(x+2)
print("\nprint(g.0(x)) -> \(g.0(x))")