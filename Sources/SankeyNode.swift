import Foundation
import SwiftUI

public struct SankeyNode: Codable, Identifiable {
    public var id: String
    public var label: String?
    var hex: String? // stored hex color value
    
    public var color: Color? { // computed SwiftUI color
        get { hex.flatMap { Color(hex: $0) } }
        set { hex = newValue?.hex }
    }
    
    /// Initializes a new instance of `SankeyNode`
    ///
    /// - Parameters:
    ///   - id: A unique id that will be used as its label and as a reference for SankeyLinks
    ///   - label: An optional display label. If nil, id will be used as the label
    ///   - color: An optional `Color` for the node. Defaults to `nil`
    public init(_ id: String, label: String? = nil, color: Color? = nil) {
        self.id = id
        self.label = label
        self.hex = color?.hex
    }
}
