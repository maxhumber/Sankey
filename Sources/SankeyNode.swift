public import SwiftUI

/// A node in a Sankey diagram, sized by the larger of its incoming and outgoing flows.
public struct SankeyNode: Identifiable, Sendable {
    public var id: String
    public var label: String?
    public var color: Color?

    /// Creates a node.
    ///
    /// - Parameters:
    ///   - id: A unique ID that links refer to, and the label when `label` is nil.
    ///   - label: The displayed label.
    ///   - color: The node's color, or the diagram's default when nil.
    public init(_ id: String, label: String? = nil, color: Color? = nil) {
        self.id = id
        self.label = label
        self.color = color
    }
}
