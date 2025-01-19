import XCTest
import SwiftUI
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
    
    func testHexStringToColor() {
        guard let color1 = convertHexStringToColor("0xFF3B30"),
        let color2 = convertHexStringToColor("#FF3B30"),
        let color3 = Color(hex: "#FF3B30") else {
            XCTAssert(false)
            return
        }
        let color = convertUInt64HexToColor(16726832)
        
        XCTAssert(color == color1 
                  && color1 == color2
                  && color2 == color3)
    }
    
    func testHexToColor() {
        let color = convertUInt64HexToColor(16726832)
        print(color.description)
        XCTAssert(true)
    }
    
    func testColorToHex() {
        guard let hex = convertColorToUInt64Hex(.black) else {
            XCTAssert(false)
            return
        }
        
        print(hex)
        XCTAssert(true)
    }
    
    func testDarkenColor() {
        let color = Color(hex: "#FBCAB1")
        guard let darkenedColor = color?.darken(120) else {
            XCTAssert(false)
            return
        }
        let color2 = Color(hex: "#835239")
        XCTAssert(color == color2)
    }
}
