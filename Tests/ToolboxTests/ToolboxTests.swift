import XCTest
@testable import Toolbox

final class ToolboxTests: XCTestCase {
    func testValidateEmail() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssert(validateEmail(enteredEmail: "abc@gmail.com"))
        XCTAssert(!validateEmail(enteredEmail: "abc!gmail.com"))
    }
}
