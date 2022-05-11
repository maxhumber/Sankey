import Foundation

extension SankeyOptions: CustomStringConvertible {
    public var description: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(self), let output = String(data: data, encoding: .utf8) {
            return output
        }
        return "Error converting \(self) to JSON string"
    }
}
