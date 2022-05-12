import Foundation

extension SankeyLink: ExpressibleByArrayLiteral {
    /// Quickly instantiate a link between two nodes
    ///
    /// - Note: Use sparingly, and make sure all values are encoded as strings:
    /// ```swift
    /// let link = ["A", "B", "3"]
    /// ```
    public init(arrayLiteral: String...) {
        source = arrayLiteral[0]
        target = arrayLiteral[1]
        value = Double(arrayLiteral[2]) ?? 0
    }
}
