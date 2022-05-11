import Foundation

extension SankeyOptions {
    public struct Sankey: Codable {
        public var iterations: Int
        public var node: Node
        public var link: Link
    }
}
