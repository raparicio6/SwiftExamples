import Foundation
func address(of object: UnsafeRawPointer) -> String {
    let addr = Int(bitPattern: object)
    return String(format: "%p", addr)
}

var myInt = 3
var myInt2 = myInt
//Con enteros, se hace la copia directamente en la asignacion..
print("Address of ints")
print(address(of:&myInt)) //prints 0x55b3a7bcb1b0
print(address(of:&myInt2)) //prints 0x55b3a7bcb1b8

//Con arrays:

var myArray = [1,2,3,4,5]
var myArray2 = myArray
print("Address of arrays")
print(address(of:&myArray)) //prints 0x556260e8c0c8
print(address(of:&myArray2)) //prints 0x556260e8c0c8

myArray2[0] = 6
print(address(of:&myArray2)) //prints 0x556f7e06c520

2
3
4
	
struct User {
    var identifier = 1
}
 
var myUser = User(identifier: 1)
var myUser2 = myUser
print ("Address of User")
print(address(of:&myUser)) //prints 0x55cd9234f278
print(address(of:&myUser2)) //prints 0x55cd9234f280

/*We must start creating a class, with a generic
 property T, which wraps our value type:*/
	
final class Ref<T> {
    var value: T
    init(value: T) {
        self.value = value
    }
}

/*Usamos una clase (Que trabaja por referencia) 
porque cuando copiemos esa variable, se va a seguir utilizando
la misma referencia */
var ref1 = Ref(value: User(identifier: 1))
var ref2 = ref1

print("Addresses of ref")
print(address(of:&ref1)) 
print(address(of:&ref2)) 
//No entiendo por que esto imprime direcciones de memoria distintas, capaz esta funcion no anda muy bien

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
 
var myBox = Box(value: User(identifier: 3))
var myBox2 = myBox 

//Ahora estas dos cajas, guardan la misma referencia a usuario (ref):

print("box.value addresses without changes")
print(address(of:&(myBox.value))) //prints 0x7ffe628ea040
print(address(of:&(myBox2.value))) //prints 0x7ffe628ea040


//creamos un nuevo objeto para box2.ref

myBox2.value.identifier = 5

print(address(of:&(myBox2.value)))

print(myBox2.value.identifier)
print(myBox.value.identifier)

//

/*source: https://marcosantadev.com/copy-write-swift-value-types/
*/
