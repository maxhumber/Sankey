import Foundation

/// A link, with some weight, between two nodes
public struct SankeyLink {
    public var source: SankeyNode
    public var target: SankeyNode
    public var value: Double
    
    /// Creates a link between two nodes
    /// - Parameters:
    ///   - source: Source node
    ///   - target: Target node
    ///   - value: Weight between source and target nodes
    public init(source: SankeyNode, target: SankeyNode, value: Double) {
        self.source = source
        self.target = target
        self.value = value
    }
}
