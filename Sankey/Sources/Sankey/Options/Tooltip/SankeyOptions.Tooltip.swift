import Foundation

extension SankeyOptions {
    public struct Tooltip: Codable {
        public var valueLabel: String // Custom
        public var textStyle: TextStyle
        public var showColorCode: Bool
        public var isHtml: Bool
    }
}
