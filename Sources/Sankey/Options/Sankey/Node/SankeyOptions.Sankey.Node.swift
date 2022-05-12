import Foundation

extension SankeyOptions.Sankey {
    public struct Node: Codable {
        public var colors: [String]?
        public var colorMode: ColorMode
        public var width: Double?
        public var nodePadding: Double?
        public var label: Label
        public var labelPadding: Double?
        public var interactivity: Bool
    }
}
