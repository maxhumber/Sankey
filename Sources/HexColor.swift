import SwiftUI

struct HexColor: Encodable {
    var light: String
    var dark: String
    
    init(_ color: Color) {
        self.light = color.light.hex
        self.dark = color.dark.hex
    }
}
