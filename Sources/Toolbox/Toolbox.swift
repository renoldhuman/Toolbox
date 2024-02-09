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
public func convertHexToColor(_ hex: UInt64) -> Color {
    let red = Double((hex >> 24) & 0xFF) / 255.0
    let green = Double((hex >> 16) & 0xFF) / 255.0
    let blue = Double((hex >> 8) & 0xFF) / 255.0
    let alpha = Double((hex) & 0xFF) / 255.0
    
    return Color(red: red, green: green, blue: blue, opacity: alpha)
}

@available(iOS 14.0, *)
@available(macOS 11, *)
public func convertColorToHex(_ color: Color) -> UInt64? {
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

@available(iOS 14.0, *)
@available(macOS 11, *)
public struct CharacterLimit: ViewModifier {
    @Binding var text: String
    var characterLimit: Int
    
    init(_ text: Binding<String>, characterLimit: Int) {
        self._text = text
        self.characterLimit = characterLimit
    }
    
    func body(content: Content) -> some View {
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
