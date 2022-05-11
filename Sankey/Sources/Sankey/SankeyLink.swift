import Foundation

//public protocol SankeyNode: CustomStringConvertible {}

public struct SankeyLink<SankeyNode: CustomStringConvertible> {
    public var source: SankeyNode
    public var target: SankeyNode
    public var weight: Double
    
    public init(source: SankeyNode, target: SankeyNode, weight: Double) {
        self.source = source
        self.target = target
        self.weight = weight
    }
}

extension SankeyLink: CustomStringConvertible {
    public var description: String {
        "['\(source)', '\(target)', \(weight)]"
    }
}
