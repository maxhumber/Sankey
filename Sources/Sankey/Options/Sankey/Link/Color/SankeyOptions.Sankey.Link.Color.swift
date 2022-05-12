import Foundation

extension SankeyOptions.Sankey.Link {
    public struct Color: Codable {
        public var fill: String?
        public var fillOpacity: Double?
        public var stroke: String?
        public var strokeWidth: Double
    }
}
