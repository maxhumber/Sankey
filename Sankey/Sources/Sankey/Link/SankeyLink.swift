import Foundation

public struct SankeyLink {
    public var source: SankeyNode
    public var target: SankeyNode
    public var value: Double
    
    public init(source: SankeyNode, target: SankeyNode, value: Double) {
        self.source = source
        self.target = target
        self.value = value
    }
}
