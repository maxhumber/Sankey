import Foundation

extension SankeyOptions.Sankey {
    public struct Link: Codable {
        public var colors: [String]?
        public var colorMode: ColorMode?
        public var color: Color?
    }
}
