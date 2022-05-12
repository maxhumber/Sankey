import Foundation

extension SankeyOptions.Sankey.Link {
    public enum ColorMode: String, Codable {
        case source
        case target
        case gradient
    }
}
