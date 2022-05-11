import Foundation

extension SankeyOptions.Sankey.Link {
    public struct Color: Codable {
        public var fillOpacity: Double?
        public var fill: String?
        public var stroke: String?
        public var strokeWidth: Double
    }
}
