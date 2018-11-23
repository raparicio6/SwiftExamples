class HTMLElement {
    let name: String
    let text: String?

    // Define lazy property referencing a closure
    // Lazy indicates that it is executed only when needed.
    // 'self' can be passed to the closure, because it is lazy
    // and it wont be accessed until initialization is finished.
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

// Define and Create instance of type HTMLElement
let heading = HTMLElement(name: "h1")

let defaultText = "some default text"

// Create custom closure for the HTMLElement instance
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}

print(heading.asHTML())
// Prints "<h1>some default text</h1>"


// Now to show the strong reference cycle with a closure

// Define and Create instance of type HTMLElement?
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")

print(paragraph!.asHTML())
// Prints "<p>hello, world</p>"

// Break the strong reference to the instance
paragraph = nil

// No deinitializers are called because 
// there is a strong reference cycle
