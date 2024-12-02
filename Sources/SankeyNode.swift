import Foundation
import SwiftUI

public struct SankeyNode: Codable, Identifiable {
    public var id: String
    var hex: String? // stored hex color value
    
    public var color: Color? { // computed SwiftUI color
        get { hex.flatMap { Color(hex: $0) } }
        set { hex = newValue?.hex }
    }
    
    /// Initializes a new instance of `SankeyNode`
    ///
    /// - Parameters:
    ///   - id: A unique id that will be used as its label and as a reference for SankeyLinks
    ///   - color: An optional `Color` for the node. Defaults to `nil`
    public init(_ id: String, color: Color? = nil) {
        self.id = id
        self.hex = color?.hex
    }
}
