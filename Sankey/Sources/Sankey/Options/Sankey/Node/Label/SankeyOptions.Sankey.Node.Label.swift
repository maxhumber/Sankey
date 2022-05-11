import Foundation

extension SankeyOptions.Sankey.Node {
    public struct Label: Codable {
        public var color: String
        public var fontSize: Double
        public var fontName: String?
        public var bold: Bool
        public var italic: Bool
    }
}
