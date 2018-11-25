import Foundation

func address(of object: UnsafeRawPointer) -> String {
    let addr = Int(bitPattern: object)
    return String(format: "%p", addr)
}


func addressOf<T: AnyObject>(_ o: T) -> String {
    let addr = unsafeBitCast(o, to: Int.self)
    return String(format: "%p", addr)
}

print("Que sucede si copiamos Ints?")
let _ = readLine()

var myInt1 = 3
var myInt2 = myInt1
//Con enteros, se hace la copia directamente en la asignacion..
let myInt1Address = address(of:&myInt1)
let myInt2Address = address(of:&myInt2)
print("myInt1 address: \(myInt1Address)") 
print("myInt2 address: \(myInt2Address)")

print("\nQue sucede si copiamos arrays?")
let _ = readLine()

//Con arrays:
var myArray1 = [1,2,3,4,5]
var myArray2 = myArray1
var myArray1Address = address(of:&myArray1)
var myArray2Address = address(of:&myArray2)
print("myArray1 address: \(myArray1Address)") 
print("myArray2 address: \(myArray2Address)") 

myArray2[0] = 6


print("Hacemos myArray2[0] = 6..")
let _ = readLine()

myArray1Address = address(of:&myArray1)
myArray2Address = address(of:&myArray2)

print("myArray1 address: \(myArray1Address)") 
print("myArray2 address: \(myArray2Address)") 

print("\nAhora con un struct creado por nosotros..")
let _ = readLine()

struct User {
    var identifier = 1
}

 
var myUser1 = User(identifier: 1)
var myUser2 = myUser1

var myUser1Address = address(of:&myUser1)
var myUser2Address = address(of:&myUser2)

print("myUser1Address address: \(myUser1Address)") 
print("myUser2Address address: \(myUser2Address)") 

/*Usamos una clase generica que envuelva a un tipo generico T*/
    
final class Ref<T> {
    var value: T
    init(value: T) {
        self.value = value
    }
}

/*Usamos una clase (Que trabaja por referencia) 
porque cuando copiemos esa variable, se va a seguir utilizando
la misma referencia */

struct Box<T> {
    public var ref: Ref<T>
    init(value: T) {
        ref = Ref(value: value)
    }
 
    var value: T {
        get { return ref.value }
        set {
            guard isKnownUniquelyReferenced(&ref) else {
                ref = Ref(value: newValue)
                return
            }
            ref.value = newValue
        }
    }
}
 
var myBox1 = Box(value: User(identifier: 3))
var myBox2 = myBox1 

//Ahora estas dos cajas, guardan la misma referencia a usuario (ref):
print("\nUtilizando un wrapper: ")
let _ = readLine()

var myRef1Address = addressOf(myBox1.ref)
var myRef2Address = addressOf(myBox2.ref)

print("myRef1 address: \(myRef1Address)") 
print("myRef2 address: \(myRef2Address)") 


print("\n¿Direccion de User?")

myUser1Address = address(of:&myBox1.ref.value)
myUser2Address = address(of:&myBox2.ref.value)

print("myUser1Address address: \(myUser1Address)") 
print("myUser2Address address: \(myUser2Address)") 



let _ = readLine()

print("\nMutamos el atributo identifier en box2.ref")

let _ = readLine()
//creamos un nuevo objeto para box2.ref
myBox2.value.identifier = 5

myRef1Address = addressOf(myBox1.ref)
myRef2Address = addressOf(myBox2.ref)

print("myRef1 address: \(myRef1Address)") 
print("myRef2 address: \(myRef2Address)") 

myUser1Address = address(of:&myBox1.ref.value)
myUser2Address = address(of:&myBox2.ref.value)

print("myUser1Address address: \(myUser1Address)") 
print("myUser2Address address: \(myUser2Address)") 

print("\nmyBox2.value.identifier: " + String(myBox2.value.identifier))
print("myBox1.value.identifier: " + String(myBox1.value.identifier))

//
/*source: https://marcosantadev.com/copy-write-swift-value-types/
*/
