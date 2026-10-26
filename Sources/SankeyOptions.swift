import SwiftUI

struct SankeyOptions: Sendable {
    var nodeAlignment: SankeyNodeAlignment = .justify
    var nodeWidth: Double = 8
    var nodePadding: Double = 24
    var nodeDefaultColor: Color = .primary.opacity(0.6)
    var linkDefaultColor: Color = .primary
    var linkOpacity: Double = 0.2
    var linkColorMode: SankeyLinkColorMode? = nil
    var labelPadding: Double = 8
}

/// How links are colored when they have no color of their own.
public enum SankeyLinkColorMode: CaseIterable, Sendable {
    /// The source node's color.
    case source
    /// The target node's color.
    case target
    /// A gradient from the source node's color to the target node's.
    case gradient
}

/// Which column each node is placed in.
public enum SankeyNodeAlignment: CaseIterable, Sendable {
    /// Each node in the column of its longest path from a source.
    case left
    /// Each node in the column of its longest path to a sink.
    case right
    /// Like `left`, but sources move next to their first target.
    case center
    /// Like `left`, but sinks move to the last column.
    case justify
}
