import SwiftUI

struct SankeyOptions {
    var nodeAlignment: SankeyNodeAlignment = .justify
    var nodeWidth: Double = 8
    var nodePadding: Double = 24
    var nodeDefaultColor: Color = .primary
    var nodeOpacity: Double = 0.6
    var linkDefaultColor: Color = .primary
    var linkOpacity: Double = 0.2
    var linkColorMode: SankeyLinkColorMode? = nil
    var labelPadding: Double = 8
    var labelColor: Color = .primary
    var labelOpacity: Double = 0.8
    var labelFontSize: Double = 16
    var labelFontFamily: String = "-apple-system, BlinkMacSystemFont, sans-serif"
}

/// Specifies how link colors are determined in a Sankey Diagram
public enum SankeyLinkColorMode: String {
    case source
    case target
    case gradient = "source-target"
}

/// Specifies how nodes are aligned horizontally in a Sankey Diagram
public enum SankeyNodeAlignment: String {
    case left = "Left"
    case right = "Right"
    case center = "Center"
    case justify = "Justify"
}
