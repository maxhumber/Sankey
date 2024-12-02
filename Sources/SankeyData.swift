import Foundation

public struct SankeyData: Codable, CustomStringConvertible {
    public var nodes: [SankeyNode]
    public var links: [SankeyLink]
    
    /// Initializes a new instance of `SankeyData`
    ///
    /// - Parameters:
    ///   - nodes: An array of `SankeyNode` representing the nodes in the diagram
    ///   - links: An array of `SankeyLink` representing the links between nodes
    public init(nodes: [SankeyNode], links: [SankeyLink]) {
        self.nodes = nodes
        self.links = links
    }
    
    public var description: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .withoutEscapingSlashes
        guard let data = try? encoder.encode(self), let string = String(data: data, encoding: .utf8) else { return "{}" }
        return string
    }
}
