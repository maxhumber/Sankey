import Foundation

public struct SankeyOptions: Codable {
    public var height: Double?
    public var width: Double?
    public var sankey: Sankey
    public var tooltip: Tooltip
    public var forceIFrame: Bool
}

extension SankeyOptions {
    public init(
        height: Double? = nil,
        width: Double? = nil,
        sankeyIterations: Int = 32,
        sankeyLinkColors: [String]? = nil,
        sankeyLinkColorMode: SankeyOptions.Sankey.Link.ColorMode? = nil,
        sankeyLinkColorFill: String? = nil,
        sankeyLinkColorFillOpacity: Double? = nil,
        sankeyLinkColorStroke: String? = nil,
        sankeyLinkColorStrokeWidth: Double = 0,
        sankeyNodeWidth: Double? = nil,
        sankeyNodePadding: Double? = nil,
        sankeyNodeColors: [String]? = nil,
        sankeyNodeColorMode: SankeyOptions.Sankey.Node.ColorMode = .unique,
        sankeyNodeLabelColor: String = "black",
        sankeyNodeLabelFontSize: Double = 30,
        sankeyNodeLabelFontName: String? = nil,
        sankeyNodeLabelBold: Bool = false,
        sankeyNodeLabelItalic: Bool = false,
        sankeyNodeLabelPadding: Double? = nil,
        sankeyNodeInteractivity: Bool = true,
        tooltipTextStyleColor: String = "black",
        tooltipTextStyleFontSize: Double = 30,
        tooltipTextStyleFontName: String? = nil,
        tooltipTextStyleBold: Bool = false,
        tooltipTextStyleItalic: Bool = false,
        tooltipShowColorCode: Bool = false,
        tooltipIsHtml: Bool = false,
        forceIFrame: Bool = false
    ) {
        self.height = height
        self.width = width
        self.sankey = .init(
            iterations: sankeyIterations,
            link: .init(
                colors: sankeyLinkColors,
                colorMode: sankeyLinkColorMode,
                color: .init(
                    fill: sankeyLinkColorFill,
                    fillOpacity: sankeyLinkColorFillOpacity,
                    stroke: sankeyLinkColorStroke,
                    strokeWidth: sankeyLinkColorStrokeWidth
                )
            ),
            node: .init(
                width: sankeyNodeWidth,
                nodePadding: sankeyNodePadding,
                colors: sankeyNodeColors,
                colorMode: sankeyNodeColorMode,
                label: .init(
                    color: sankeyNodeLabelColor,
                    fontSize: sankeyNodeLabelFontSize,
                    fontName: sankeyNodeLabelFontName,
                    bold: sankeyNodeLabelBold,
                    italic: sankeyNodeLabelItalic
                ),
                labelPadding: sankeyNodeLabelPadding,
                interactivity: sankeyNodeInteractivity
            )
        )
        self.tooltip = .init(
            textStyle: .init(
                color: tooltipTextStyleColor,
                fontSize: tooltipTextStyleFontSize,
                fontName: tooltipTextStyleFontName,
                bold: tooltipTextStyleBold,
                italic: tooltipTextStyleItalic
            ),
            showColorCode: tooltipShowColorCode,
            isHtml: tooltipIsHtml
        )
        self.forceIFrame = forceIFrame
    }
}

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

extension SankeyOptions {
    public struct Sankey: Codable {
        public var iterations: Int
        public var link: Link
        public var node: Node
    }
}

extension SankeyOptions.Sankey {
    public struct Link: Codable {
        public var colors: [String]?
        public var colorMode: ColorMode?
        public var color: Color?
    }
}

extension SankeyOptions.Sankey.Link {
    public struct Color: Codable {
        public var fill: String?
        public var fillOpacity: Double?
        public var stroke: String?
        public var strokeWidth: Double
    }
}

extension SankeyOptions.Sankey.Link {
    public enum ColorMode: String, Codable {
        case source
        case target
        case gradient
    }
}

extension SankeyOptions.Sankey {
    public struct Node: Codable {
        public var width: Double?
        public var nodePadding: Double?
        public var colors: [String]?
        public var colorMode: ColorMode
        public var label: Label
        public var labelPadding: Double?
        public var interactivity: Bool
    }
}

extension SankeyOptions.Sankey.Node {
    public struct Label: Codable {
        public var color: String = "black"
        public var fontSize: Double = 30
        public var fontName: String?
        public var bold: Bool = false
        public var italic: Bool = false
    }
}

extension SankeyOptions.Sankey.Node {
    public enum ColorMode: String, Codable {
        case unique
    }
}

extension SankeyOptions {
    public struct Tooltip: Codable {
        public var textStyle: TextStyle
        public var showColorCode: Bool
        public var isHtml: Bool
    }
}

extension SankeyOptions.Tooltip {
    public struct TextStyle: Codable {
        public var color: String
        public var fontSize: Double
        public var fontName: String?
        public var bold: Bool
        public var italic: Bool
    }
}
