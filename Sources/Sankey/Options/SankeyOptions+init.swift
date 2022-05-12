import Foundation

extension SankeyOptions {
    public init(
        nodeColors: [String]? = nil,
        nodeColorMode: SankeyOptions.Sankey.Node.ColorMode = .unique,
        nodeWidth: Double? = nil,
        nodePadding: Double? = nil,
        nodeLabelColor: String = "black",
        nodeLabelFontSize: Double = 24,
        nodeLabelFontName: String? = nil,
        nodeLabelBold: Bool = false,
        nodeLabelItalic: Bool = false,
        nodeLabelPadding: Double? = nil,
        nodeInteractivity: Bool = false,
        linkColors: [String]? = nil,
        linkColorMode: SankeyOptions.Sankey.Link.ColorMode? = nil,
        linkColorFill: String? = nil,
        linkColorFillOpacity: Double? = nil,
        linkColorStroke: String? = nil,
        linkColorStrokeWidth: Double = 0,
        tooltipValueLabel: String = "",
        tooltipTextColor: String = "black",
        tooltipTextFontSize: Double = 24,
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
                    fill: linkColorFill,
                    fillOpacity: linkColorFillOpacity,
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
