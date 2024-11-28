import Foundation
import SwiftUI

/// A struct representing a node in a Sankey diagram
public struct SankeyNode: Codable {
    /// A unique identifier for the node
    public var id: String
    
    /// A label for the node. Defaults to the value of `id` if not provided
    public var label: String
    
    /// An optional color for the node, represented as a hexadecimal string
    public var color: String?
    
    /// Initializes a new instance of `SankeyNode`
    ///
    /// - Parameters:
    ///   - id: A unique identifier for the node
    ///   - label: An optional label for the node. Defaults to the value of `id` if not provided
    ///   - color: An optional `Color` for the node. Defaults to `nil`
    public init(_ id: String, label: String? = nil, color: Color? = nil) {
        self.id = id
        self.label = label ?? id
        self.color = color?.hex
    }
}
