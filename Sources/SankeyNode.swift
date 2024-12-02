import Foundation
import SwiftUI

/// Node in a Sankey diagram
public struct SankeyNode: Codable, Identifiable {
    public var id: String
    /// An optional color for the node, represented as a hexadecimal string
    public var color: String?
    
    /// Initializes a new instance of `SankeyNode`
    ///
    /// - Parameters:
    ///   - id: A unique identifier for the node that will be used as its label
    ///   - color: An optional `Color` for the node. Defaults to `nil`
    public init(_ id: String, color: Color? = nil) {
        self.id = id
        self.color = color?.hex
    }
}
