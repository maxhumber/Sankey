import Foundation

extension SankeyOptions {
    public init(
        nodeColors: [String]? = nil, // Commmon
        nodeColorMode: SankeyOptions.Sankey.Node.ColorMode = .unique,
        nodeWidth: Double? = nil,
        nodePadding: Double? = nil,
        nodeLabelColor: String = "black", // Commmon
        nodeLabelFontSize: Double = 30, // Commmon
        nodeLabelFontName: String? = nil,
        nodeLabelBold: Bool = false,
        nodeLabelItalic: Bool = false,
        nodeLabelPadding: Double? = nil,
        nodeInteractivity: Bool = false,
        linkColors: [String]? = nil,
        linkColorMode: SankeyOptions.Sankey.Link.ColorMode? = nil, // Commmon
        linkColorFillOpacity: Double? = nil,
        linkColorFill: String? = nil,
        linkColorStroke: String? = nil,
        linkColorStrokeWidth: Double = 0,
        tooltipValueLabel: String = "", // Custom
        tooltipTextColor: String = "black", // Commmon
        tooltipTextFontSize: Double = 30, // Commmon
        tooltipTextFontName: String? = nil,
        tooltipTextBold: Bool = false,
        tooltipTextItalic: Bool = false,
        layoutIterations: Int = 32
    ) {
        self.sankey = .init(
            iterations: layoutIterations,
            node: .init(
                colors: nodeColors,
                colorMode: nodeColorMode,
                width: nodeWidth,
                nodePadding: nodePadding,
                label: .init(
                    color: nodeLabelColor,
                    fontSize: nodeLabelFontSize,
                    fontName: nodeLabelFontName,
                    bold: nodeLabelBold,
                    italic: nodeLabelItalic
                ),
                labelPadding: nodeLabelPadding,
                interactivity: nodeInteractivity
            ),
            link: .init(
                colors: linkColors,
                colorMode: linkColorMode,
                color: .init(
                    fillOpacity: linkColorFillOpacity,
                    fill: linkColorFill,
                    stroke: linkColorStroke,
                    strokeWidth: linkColorStrokeWidth
                )
            )
        )
        self.tooltip = .init(
            valueLabel: tooltipValueLabel,
            textStyle: .init(
                color: tooltipTextColor,
                fontSize: tooltipTextFontSize,
                fontName: tooltipTextFontName,
                bold: tooltipTextBold,
                italic: tooltipTextItalic
            ),
            showColorCode: false,
            isHtml: false
        )
        self.height = nil
        self.width = nil
        self.forceIFrame = false
    }
}
