import Foundation
import SwiftUI

public struct SankeyLink: Encodable {
    public var value: Double
    public var source: String
    public var target: String
    public var color: Color?
    
    var hex: HexColor? {
        color.map { HexColor($0) }
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
        self.color = color
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value, forKey: .value)
        try container.encode(source, forKey: .source)
        try container.encode(target, forKey: .target)
        try container.encode(hex, forKey: .hex)
    }
    
    enum CodingKeys: String, CodingKey {
        case value
        case source
        case target
        case hex
    }
}
