class Person {
    let name: String
    var apartment: Apartment?

    init(name: String) { 
        self.name = name 
    }
    deinit { 
        print("\(name) is being deinitialized") 
    }
}

class Apartment {
    let unit: String
    var tenant: Person?

    init(unit: String) { 
        self.unit = unit 
    }
    deinit { 
        print("Apartment \(unit) is being deinitialized") 
    }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John AppleSeed")
unit4A = Apartment(unit: "4A")

// Link the two instances together, 
// creating the strong reference cycle
john!.apartment = unit4A
unit4A!.tenant = john

// Break the strong reference to both instances
john = nil
unit4A = nil

// No deinitializers are called because 
// the reference count is not zero
