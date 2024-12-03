import Foundation

extension SankeyLink: ExpressibleByArrayLiteral {
    /// Initializes a `SankeyLink` using source, target, and value directly
    ///
    /// **Deprecated**: Use `SankeyLink(_:from:to:)` initializer instead
    ///
    /// - Parameters:
    ///   - source: The identifier of the source node
    ///   - target: The identifier of the target node
    ///   - value: The magnitude of the link between the source and target nodes
    @available(*, deprecated, message: "Use SankeyLink(_:from:to:) initializer instead")
    public init(source: String, target: String, value: Double) {
        self.source = source
        self.target = target
        self.value = value
    }
    
    /// Initializes a `SankeyLink` using an array literal
    ///
    /// The array must contain exactly three elements:
    /// - Element 0: A `CustomStringConvertible` representing the source node identifier
    /// - Element 1: A `CustomStringConvertible` representing the target node identifier
    /// - Element 2: A `CustomStringConvertible` representing the link value (converted to `Double`)
    ///
    /// **Deprecated**: Use `SankeyLink(_:from:to:)` initializer instead
    ///
    /// - Parameters:
    ///   - arrayLiteral: An array literal with source, target, and value
    @available(*, deprecated, message: "Use SankeyLink(_:from:to:) initializer instead")
    public init(arrayLiteral: CustomStringConvertible...) {
        self.init(Double("\(arrayLiteral[2])") ?? 0, from: "\(arrayLiteral[0])", to: "\(arrayLiteral[1])")
    }
}
