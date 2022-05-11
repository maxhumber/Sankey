import Foundation

public struct SankeyOptions: Codable {
    public var sankey: Sankey
    public var tooltip: Tooltip
    public var height: Double?
    public var width: Double?
    public var forceIFrame: Bool
}
