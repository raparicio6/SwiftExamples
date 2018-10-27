#!/usr/bin/env swift

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

// Defining varibales of type Person?
var reference1: Person?
var reference2: Person?
var reference3: Person?

// Create a new instance of Person, and assign it to a variable
reference1 = Person(name: "John Appleseed")
// Prints "John Appleseed is being initialized"

// Assign the same isntance of Person to two more variables
reference2 = reference1
reference3 = reference1

// Break two of the three strong references to the instance
reference1 = nil
reference2 = nil

// Break the last storng reference to the instance
reference3 = nil
// Prints "John Appleseed is being deinitialized"
