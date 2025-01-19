import Foundation
import SwiftUI
import UIKit

public func validateEmail(enteredEmail:String) -> Bool {

    let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: enteredEmail)

}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
public func convertHexStringToRGBA(_ hex: String) -> (r: Double, g: Double, b: Double, a: Double)? {
    var h = hex
    if h.hasPrefix("#") {
        h.removeFirst()
    }
    if h.hasPrefix("0x") {
        h.removeFirst(2)
    }
    if let dec = UInt32(h, radix: 16) {
        var red: Double = 0
        var green: Double = 0
        var blue: Double = 0
        var alpha: Double = Double(0xFF) / 255.0
        if h.count == 6 {
            red = Double((dec >> 16) & 0xFF) / 255.0
            green = Double((dec >> 8) & 0xFF) / 255.0
            blue = Double(dec & 0xFF) / 255.0
        }
        else if h.count == 8 {
            red = Double((dec >> 24) & 0xFF) / 255.0
            green = Double((dec >> 16) & 0xFF) / 255.0
            blue = Double((dec >> 8) & 0xFF) / 255.0
            alpha = Double((dec) & 0xFF) / 255.0
        }
        else {
            return nil
        }
        
        return (red, green, blue, alpha)
    }
    return nil
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
public func convertHexStringToColor(_ hex: String) -> Color? {
    var h = hex
    if h.hasPrefix("#") {
        h.removeFirst()
    }
    if h.hasPrefix("0x") {
        h.removeFirst(2)
    }
    if let dec = UInt64(h, radix: 16) {
        return convertUInt64HexToColor(dec)
    }
    return nil
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
public func convertUInt64HexToColor(_ hex: UInt64) -> Color {
    var red = Double((hex >> 24) & 0xFF) / 255.0
    var green = Double((hex >> 16) & 0xFF) / 255.0
    var blue = Double((hex >> 8) & 0xFF) / 255.0
    var alpha = Double(0xFF) / 255.0
    if hex > 16777215 {
        red = Double((hex >> 24) & 0xFF) / 255.0
        green = Double((hex >> 16) & 0xFF) / 255.0
        blue = Double((hex >> 8) & 0xFF) / 255.0
        alpha = Double(hex & 0xFF) / 255.0
    }
    else {
        red = Double((hex >> 16) & 0xFF) / 255.0
        green = Double((hex >> 8) & 0xFF) / 255.0
        blue = Double(hex & 0xFF) / 255.0
    }
    
    return Color(red: red, green: green, blue: blue, opacity: alpha)
}

@available(iOS 14.0, *)
@available(macOS 11, *)
public func convertColorToUInt64Hex(_ color: Color) -> UInt64? {
    var hexColor: UInt64?
    if let components = UIColor(color).cgColor.components {
        let red = lroundf(Float(components[0]) * 255) << 24
        let green = lroundf(Float(components[1] * 255)) << 16
        let blue = lroundf(Float(components[2] * 255)) << 8
        var alpha = 255
        if components.count >= 4 {
            alpha = lroundf(Float(components[3]) * 255)
        }
        
        let pre = red | green | blue | alpha
        
        hexColor = UInt64(pre) & 0x00FFFFFFFFFF
    }
    
    return hexColor
}


@available(iOS 13.0, *)
@available(macOS 10.15, *)
extension Color {
    init?(hex: String) {
        if let rgba = convertHexStringToRGBA(hex) {
            self.init(red: rgba.r, green: rgba.g, blue: rgba.b, opacity: rgba.a)
            return
        }
        
        return nil
    }
}

@available(iOS 14.0, *)
@available(macOS 11, *)
public struct CharacterLimit: ViewModifier {
    @Binding var text: String
    var characterLimit: Int
    
    public init(_ text: Binding<String>, characterLimit: Int) {
        self._text = text
        self.characterLimit = characterLimit
    }
    
    public func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .onChange(of: text, {
                    if text.count > characterLimit {
                        text.removeLast()
                    }
                })
        }
        else {
            content
                .onChange(of: text, perform: { value in
                    if value.count > characterLimit {
                        text.removeLast()
                    }
                })
        }
    }
        
}

@available(iOS 14.0, *)
@available(macOS 11, *)
extension View {
    public func characterLimit(_ limit: Int, text: Binding<String>) -> some View {
        return self.modifier(CharacterLimit(text, characterLimit: limit))
    }
}
