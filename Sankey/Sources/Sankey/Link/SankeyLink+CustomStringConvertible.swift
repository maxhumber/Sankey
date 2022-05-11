import Foundation

extension SankeyLink: CustomStringConvertible {
    public var description: String {
        "['\(source)', '\(target)', \(value)]"
    }
}
