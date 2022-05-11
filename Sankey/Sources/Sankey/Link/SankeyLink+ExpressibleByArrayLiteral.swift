import Foundation

extension SankeyLink: ExpressibleByArrayLiteral {
    public init(arrayLiteral: String...) {
        source = arrayLiteral[0]
        target = arrayLiteral[1]
        value = Double(arrayLiteral[2]) ?? 0
    }
}
