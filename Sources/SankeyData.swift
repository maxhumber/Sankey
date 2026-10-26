import Foundation

/// The nodes and links a `SankeyDiagram` draws.
public struct SankeyData: Sendable {
    public var nodes: [SankeyNode]
    public var links: [SankeyLink]

    /// Creates diagram data.
    ///
    /// - Parameters:
    ///   - nodes: The nodes, each with a unique ID.
    ///   - links: The flows between nodes, which must not form a cycle.
    public init(nodes: [SankeyNode], links: [SankeyLink]) {
        self.nodes = nodes
        self.links = links
    }
}
