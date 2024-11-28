import Foundation

/// A struct representing the data required to construct a Sankey diagram
public struct SankeyData: Codable {
    /// The nodes in the Sankey diagram
    public var nodes: [SankeyNode]
    
    /// The links between nodes in the Sankey diagram
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
}

extension SankeyData: CustomStringConvertible {
    /// A JSON string representation of the Sankey diagram data
    ///
    /// Converts the `SankeyData` instance into a JSON string without escaping slashes
    /// Returns an empty JSON object (`{}`) if encoding fails
    public var description: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .withoutEscapingSlashes
        guard let data = try? encoder.encode(self), let string = String(data: data, encoding: .utf8) else { return "{}" }
        return string
    }
}
