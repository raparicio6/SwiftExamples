import XCTest
@testable import Fac

class FacTests: XCTestCase {

    func testFactorial() {
        let number = factorial(4)
        print("\nEl factorial de 4 es: \(number)\n")
        assert(number == 24)
    }

    static var allTests : [(String, (FacTests) -> () throws -> Void)] {
        return [
            ("testFactorial", testFactorial),
        ]
    }
}
