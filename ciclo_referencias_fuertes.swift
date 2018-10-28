#!/usr/bin/env swift

class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

// Define variables of type Person?
var john: Person?

// Define variables of type Apartment?
var unit4A: Apartment?

// Create a new instance of Person
john = Person(name: "John AppleSeed")

// Create a new instance of Apartment
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
