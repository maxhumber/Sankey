import Foundation
import SwiftUI

/// Configurable options for a Sankey diagram
struct SankeyOptions {
    var nodeAlignment: SankeyNodeAlignment = .justify
    var nodeWidth: Double = 8
    var nodePadding: Double = 24
    var nodeDefaultColor: String = "#666666"
    var nodeOpacity: Double = 0.6
    var linkDefaultColor: String = "#888888"
    var linkOpacity: Double = 0.2
    var linkColorMode: SankeyLinkColorMode? = nil
    var labelPadding: Double = 8
    var labelColor: String = "#222222"
    var labelOpacity: Double = 0.8
    var labelFontSize: Double = 16
    var labelFontFamily: String = "-apple-system, BlinkMacSystemFont, sans-serif"
}

/// Enumaration that specifies how link colors are determined in a Sankey Diagram
public enum SankeyLinkColorMode: String, CustomStringConvertible {
    case source
    case target
    case sourceTarget = "source-target"
    
    public var description: String {
        rawValue
    }
}

/// Enumeration that specifies how nodes are aligned horizontally in a Sankey Diagram
public enum SankeyNodeAlignment: String, CustomStringConvertible {
    case left
    case right
    case center
    case justify
    
    public var description: String {
        rawValue.capitalized
    }
}
