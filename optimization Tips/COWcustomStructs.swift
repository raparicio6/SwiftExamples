import Foundation

func address(of object: UnsafeRawPointer) -> String {
    let addr = Int(bitPattern: object)
    return String(format: "%p", addr)
}


func addressOf<T: AnyObject>(_ o: T) -> String {
    let addr = unsafeBitCast(o, to: Int.self)
    return String(format: "%p", addr)
}


var myInt = 3
var myInt2 = myInt
//Con enteros, se hace la copia directamente en la asignacion..
print("\nAddress of ints")
print(address(of:&myInt)) //prints 0x55b3a7bcb1b0
print(address(of:&myInt2)) //prints 0x55b3a7bcb1b8
//Con arrays:
var myArray = [1,2,3,4,5]
var myArray2 = myArray
print("\nAddress of arrays")
print(address(of:&myArray)) //prints 0x556260e8c0c8
print(address(of:&myArray2)) //prints 0x556260e8c0c8
myArray2[0] = 6
print("After changing a value..")
print(address(of:&myArray2)) //prints 0x556f7e06c520

struct User {
    var identifier = 1
}
 
var myUser = User(identifier: 1)
var myUser2 = myUser
print ("\nAddress of user without wrapper")
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
print("\nbox.ref addresses without changes")
print(addressOf(myBox.ref)) //prints 0x7ffe628ea040
print(addressOf(myBox2.ref)) //prints 0x7ffe628ea040
print("Addresses of user with wrapper")
print(address(of:&(myBox.ref.value)))
print(address(of:&(myBox2.ref.value)))


//creamos un nuevo objeto para box2.ref
myBox2.value.identifier = 5
print("box2.ref address after changing value")
print(addressOf(myBox2.ref))
print("box2.ref.value address after changing value")
print(address(of:&(myBox2.ref.value)))

print("\nmyBox2.value.identifier: " + String(myBox2.value.identifier))
print("myBox.value.identifier: " + String(myBox.value.identifier))

//
/*source: https://marcosantadev.com/copy-write-swift-value-types/
*/
