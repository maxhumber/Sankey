import Foundation
import SwiftUI

/// A struct representing a link in a Sankey diagram
/// Each link connects a source node to a target node with an associated value and optional color
public struct SankeyLink: Codable {
    /// The value or weight of the link, representing the magnitude of the flow
    public var value: Double
    
    /// The identifier of the source node
    public var source: String
    
    /// The identifier of the target node
    public var target: String
    
    /// An optional color for the link, represented as a hexadecimal string
    public var color: String?
    
    /// Initializes a new instance of `SankeyLink`
    ///
    /// - Parameters:
    ///   - value: The magnitude of the link between the source and target nodes
    ///   - source: The identifier of the source node
    ///   - target: The identifier of the target node
    ///   - color: An optional `Color` to represent the link's color. Defaults to `nil`
    public init(_ value: Double, from source: String, to target: String, color: Color? = nil) {
        self.source = source
        self.target = target
        self.value = value
        self.color = color?.hex
    }
}
