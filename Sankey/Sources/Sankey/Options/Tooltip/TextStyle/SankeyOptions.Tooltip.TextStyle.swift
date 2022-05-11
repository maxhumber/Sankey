import Foundation

extension SankeyOptions.Tooltip {
    public struct TextStyle: Codable {
        public var color: String
        public var fontSize: Double
        public var fontName: String?
        public var bold: Bool
        public var italic: Bool
    }
}
