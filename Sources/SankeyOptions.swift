import Foundation
import SwiftUI

/// A struct representing the configurable options for a Sankey diagram
/// These options control the appearance and layout of nodes, links, and labels
struct SankeyOptions {
    var nodeAlignment: SankeyNodeAlignment = .justify
    var nodeWidth: Double = 8
    var nodeOpacity: Double = 0.6
    var nodeColor: String = "#666666"
    var nodePadding: Double = 24
    var linkColorMode: SankeyLinkColorMode? = nil
    var linkOpacity: Double = 0.2
    var linkColor: String = "#888888"
    var labelFontSize: Double = 12
    var labelFontFamily: String = "sans-serif"
    var labelOpacity: Double = 0.8
    var labelColor: String = "#222222"
    var labelPadding: Double = 8
}

/// An enumeration of link color modes in a Sankey diagram
/// Specifies how link colors are determined
public enum SankeyLinkColorMode: String, CustomStringConvertible {
    /// Link color is determined by the source node's color
    case source
    
    /// Link color is determined by the target node's color
    case target
    
    /// Link color is a combination of the source and target node colors
    case sourceTarget = "source-target"
    
    /// A textual description of the color mode
    public var description: String {
        rawValue
    }
}

/// An enumeration of node alignment options in a Sankey diagram
/// Specifies how nodes are aligned horizontally
public enum SankeyNodeAlignment: String, CustomStringConvertible {
    /// Nodes are aligned to the left
    case left
    
    /// Nodes are aligned to the right
    case right
    
    /// Nodes are aligned to the center
    case center
    
    /// Nodes are justified across the diagram
    case justify
    
    /// A textual description of the alignment
    public var description: String {
        rawValue.capitalized
    }
}
