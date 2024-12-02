import Foundation
import SwiftUI

public struct SankeyLink: Codable {
    public var value: Double
    public var source: String
    public var target: String
    var hex: String? // stored hex color value
    
    public var color: Color? { // computed SwiftUI color
        get { hex.flatMap { Color(hex: $0) } }
        set { hex = newValue?.hex }
    }
    
    /// Initializes a new instance of `SankeyLink`
    ///
    /// - Parameters:
    ///   - value: The magnitude of the link between the source and target nodes
    ///   - from: The id of the source node
    ///   - to: The id of the target node
    ///   - color: An optional `Color` to represent the link's color. Defaults to `nil`
    public init(_ value: Double, from source: String, to target: String, color: Color? = nil) {
        self.source = source
        self.target = target
        self.value = value
        self.hex = color?.hex
    }
}
