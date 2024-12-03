import SwiftUI

public struct SankeyNode: Encodable, Identifiable {
    public var id: String
    public var label: String?
    public var color: Color?
    
    var hex: HexColor? {
        color.map { HexColor($0) }
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
        self.color = color
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(hex, forKey: .hex)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case label
        case hex
    }
}
