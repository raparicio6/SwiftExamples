class HTMLElement {
    let name: String
    let text: String?

    // Define lazy property referencing a closure
    // with a capture list
    lazy var asHTML: () -> String = {
        // Define capture list
        // capture self as an unowned reference rather than a strong reference
        [unowned self] in
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
 
// Define and Create instance of type HTMLElement?
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")

print(paragraph!.asHTML())
// Prints "<p>hello, world</p>"

// Break the strong reference to the instance
paragraph = nil
// Prints "p is being deinitialized"
