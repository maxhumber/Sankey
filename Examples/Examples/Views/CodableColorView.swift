import SwiftUI
import UIKit

extension Color {
    var light: Color {
        var environment = EnvironmentValues()
        environment.colorScheme = .light
        return Color(resolve(in: environment))
    }
    
    var dark: Color {
        var environment = EnvironmentValues()
        environment.colorScheme = .dark
        return Color(resolve(in: environment))
    }
}

struct CodableColor: Codable {
    private let lightData: Data
    private let darkData: Data
    
    func callAsFunction(_ colorScheme: ColorScheme) -> Color {
        let uiColorData = colorScheme == .dark ? darkData : lightData
        guard let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: uiColorData) else { return .clear }
        return Color(uiColor)
    }
    
    func color(for colorScheme: ColorScheme) -> Color {
        let uiColorData = colorScheme == .dark ? darkData : lightData
        guard let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: uiColorData) else { return .clear }
        return Color(uiColor)
    }
    
    init(color: Color) {
        self.lightData = try! NSKeyedArchiver.archivedData(withRootObject: UIColor(color.light), requiringSecureCoding: true)
        self.darkData = try! NSKeyedArchiver.archivedData(withRootObject: UIColor(color.dark), requiringSecureCoding: true)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lightData = try container.decode(Data.self, forKey: .lightData)
        self.darkData = try container.decode(Data.self, forKey: .darkData)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lightData, forKey: .lightData)
        try container.encode(darkData, forKey: .darkData)
    }
    
    private enum CodingKeys: String, CodingKey {
        case lightData
        case darkData
    }
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
    
    var hex: String {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
    }
}


struct Node: Codable, DynamicProperty {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    let label: String
    private var codableColor: CodableColor
    
    var color: Color {
        get { codableColor.color(for: colorScheme) }
        set { codableColor = CodableColor(color: newValue) }
    }
    
    var hex: (light: String, dark: String) {
        (light: codableColor(.light).hex, dark: codableColor(.dark).hex)
    }
    
    init(label: String, color: Color) {
        self.label = label
        self.codableColor = CodableColor(color: color)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(label, forKey: .label)
        try container.encode(codableColor, forKey: .codableColor)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.label = try container.decode(String.self, forKey: .label)
        self.codableColor = try container.decode(CodableColor.self, forKey: .codableColor)
    }
    
    private enum CodingKeys: String, CodingKey {
        case label
        case codableColor
    }
}

struct CodableColorView: View {
    @Environment(\.colorScheme) var colorScheme
    let node = Node(label: "Red", color: .primary)
    
    var body: some View {
        VStack {
            Text(node.hex.light)
            Text(node.hex.dark)
            Rectangle().fill(node.color)
        }
    }
}

#Preview {
    CodableColorView()
}
