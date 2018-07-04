// Ejercicio 1
// Indica que devuelven la siguientes expresiones: 
// a) 
let nums = [1,2,3,4,5,6,7,8,9,10]
print(nums.filter{$0 % 3 == 0}.count)
// [3, 6, 9] NO -> solo 3 (es el count. coje solo 3 numeros, no que solo el 3)

let nums2 = [1,2,3,4,5,6,7,8,9,10]
print(nums2.map{$0+100}.filter{$0 % 5 == 0}.reduce(0,+))
//  105 NO -> 215, el 110 tambien lo coje

let cadenas = ["En", "un", "lugar", "de", "La", "Mancha"]
print(cadenas.sorted{$0.count < $1.count}.map{$0.count})
// ["en", "un", "de", "la", "lugar", "mancha"] 
// NO -> NO AGRUPA, TRANSFORMA!!! [2, 2, 2, 2, 5, 6]

// b) explica que hacen las siguientes funciones y pon un ejemplo

func f(nums: [Int], n: Int) -> Int {
    return nums.filter{$0 == n}.count
}

// Esta funcion recibe una lista de numeros y un numero n, y cuenta cuantas ocurrencias
// de n hay en la lista:

print(f(nums: [1, 2, 3, 4, 1, 5], n: 1))

// -> devuelve 2

func g(nums: [Int]) -> [Int] {
    return nums.reduce([], {(res: [Int], n: Int) -> [Int] in
                        if !res.contains(n) {
                            return res + [n]
                        } else {
                            return res
                        }
                    })
}

// pasamos unos numeros a un array y devolvemos como array los numeros que no están en este
// NO -> ALMACENA NUMEROS, Y SI YA EXISTE LO ALMACENAMOS, SINO, DEVOLVEMOS EL ARRAY SIN ALMACENAR EL
// NUMERO DE NUEVO

func h(nums: [Int], n: Int) -> ([Int], [Int]) {
   return nums.reduce(([],[]), {(res: ([Int],[Int]), num: Int ) -> ([Int],[Int]) in
                            if (num >= n) {
                                return (res.0, res.1 + [num])
                            } else {
                                return ((res.0 + [num], res.1))
                            }
                        })
}

//divide un array en dos partes, mayores que n y menores que n

// c)
// Implementa las siguientes funciones: 

func suma(palabras: [String], contienen: Character) -> Int {
    return palabras.filter() {$0.contains(contienen)}.reduce(0) {$0 + $1.count}
}

func sumaMenoresMayores(nums: [Int], pivote: Int) -> (Int, Int) {
    return nums.reduce((0,0)) {($1<pivote) ? ($0.0+$1, $0.1) : ($0.0, $0.1+$1)}
}

// Ejercicio 2
