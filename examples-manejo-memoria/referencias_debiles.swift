class Person {
    let name: String
    var apartment: Apartment?

    init(name: String) { self.name = name 
    }
    deinit { print("\(name) is being deinitialized") 
    }
}

class Apartment {
    let unit: String
    weak var tenant: Person?

    init(unit: String) { 
        self.unit = unit 
    }
    deinit { 
        print("Apartment \(unit) is being deinitialized") 
    }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

// Link the two instances together, 
john!.apartment = unit4A
unit4A!.tenant = john

john = nil
// Prints "John Appleseed is being deinitialized"

unit4A = nil
// Prints "Apartment 4A is being deinitialized"
