class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

// Define variables of type Person?
var john: Person?

// Define variables of type Apartment?
var unit4A: Apartment?

// Create a new instance of Person
john = Person(name: "John Appleseed")

// Create a new instance of Apartment
unit4A = Apartment(unit: "4A")

// Link the two instances together, 
john!.apartment = unit4A
unit4A!.tenant = john

john = nil
// Prints "John Appleseed is being deinitialized"

unit4A = nil
// Prints "Apartment 4A is being deinitialized"
