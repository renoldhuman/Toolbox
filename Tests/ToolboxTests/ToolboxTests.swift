import XCTest
@testable import Toolbox

@available(iOS 14.0, *)
final class ToolboxTests: XCTestCase {
    func testValidateEmail() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssert(validateEmail(enteredEmail: "abc@gmail.com"))
        XCTAssert(!validateEmail(enteredEmail: "abc!gmail.com"))
    }
    
    func testHexToColor() {
        let color = convertHexToColor(4282069247)
        print(color.description)
        XCTAssert(true)
    }
    
    func testColorToHex() {
        guard let hex = convertColorToHex(.black) else {
            XCTAssert(false)
            return
        }
        
        print(hex)
        XCTAssert(true)
    }
}
