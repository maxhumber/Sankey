public import SwiftUI

/// A flow from one node to another, drawn as wide as its value.
public struct SankeyLink: Sendable {
    public var value: Double
    public var source: String
    public var target: String
    public var color: Color?

    /// Creates a link.
    ///
    /// - Parameters:
    ///   - value: The flow's size.
    ///   - from: The source node's ID.
    ///   - to: The target node's ID.
    ///   - color: The link's color, or the diagram's default when nil.
    public init(_ value: Double, from source: String, to target: String, color: Color? = nil) {
        self.source = source
        self.target = target
        self.value = value
        self.color = color
    }
}
