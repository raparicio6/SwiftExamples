import XCTest
@testable import Fac

class FacTests: XCTestCase {

    func testFactorial() {
        let number = factorial(4)
        print("el factorial de 4 es: \(number)")
    }

    static var allTests : [(String, (FacTests) -> () throws -> Void)] {
        return [
            ("testFactorial", testFactorial),
        ]
    }
}
