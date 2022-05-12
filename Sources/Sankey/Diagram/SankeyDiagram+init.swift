import Foundation

extension SankeyDiagram {
    /// Creates a Sankey Diagram
    /// - Parameters:
    ///   - data: Array of SankeyLink objects
    ///   - nodeColors: Custom color (hexcodes) palette to cycle through for sankey nodes
    ///   - nodeColorMode: Coloring mode for the sankey nodes
    ///   - nodeWidth: Thickness of the node
    ///   - nodePadding: Vertical distance between nodes
    ///   - nodeLabelColor: Node label color (hexcode/html)
    ///   - nodeLabelFontSize: Node label font size (pixels)
    ///   - nodeLabelFontName: Node label font name
    ///   - nodeLabelBold: Bold node label
    ///   - nodeLabelItalic: Italicize node label
    ///   - nodeLabelPadding: Horizontal distance between the label and the node
    ///   - nodeInteractivity: Allow users to select node
    ///   - linkColors: Custom color (hexcode) palette to cycle through for sankey links
    ///   - linkColorMode: Coloring mode for the links between nodes (this option will override any linkColor+ argument)
    ///   - linkColorFill: Color of the link
    ///   - linkColorFillOpacity: Transparency of the link
    ///   - linkColorStroke: Color of the link border
    ///   - linkColorStrokeWidth: Thickness of the link border
    ///   - tooltipValueLabel: Name of the link value to be displayed in the tooltip
    ///   - tooltipTextColor: Tooltip text color (html/hexcode)
    ///   - tooltipTextFontSize: Tooltip text font size (pixels)
    ///   - tooltipTextFontName: Tooltip text font name
    ///   - tooltipTextBold: Bold tooltip label text
    ///   - tooltipTextItalic: Italicize tooltip label text
    ///   - layoutIterations: D3 layout engine layout search attempts to find the most optimal node positions (increasing this number may lead to more pleasing layouts of complex sankeys, at some cost)
    /// - Note: See the [Google Charts documentation](https://developers.google.com/chart/interactive/docs/gallery/sankey) for more info
    public init(
        _ data: [SankeyLink],
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
        self.data = data
        self.options = .init(
            nodeColors: nodeColors,
            nodeColorMode: nodeColorMode,
            nodeWidth: nodeWidth,
            nodePadding: nodePadding,
            nodeLabelColor: nodeLabelColor,
            nodeLabelFontSize: nodeLabelFontSize,
            nodeLabelFontName: nodeLabelFontName,
            nodeLabelBold: nodeLabelBold,
            nodeLabelItalic: nodeLabelItalic,
            nodeLabelPadding: nodeLabelPadding,
            nodeInteractivity: nodeInteractivity,
            linkColors: linkColors,
            linkColorMode: linkColorMode,
            linkColorFill: linkColorFill,
            linkColorFillOpacity: linkColorFillOpacity,
            linkColorStroke: linkColorStroke,
            linkColorStrokeWidth: linkColorStrokeWidth,
            tooltipValueLabel: tooltipValueLabel,
            tooltipTextColor: tooltipTextColor,
            tooltipTextFontSize: tooltipTextFontSize,
            tooltipTextFontName: tooltipTextFontName,
            tooltipTextBold: tooltipTextBold,
            tooltipTextItalic: tooltipTextItalic,
            layoutIterations: layoutIterations
        )
    }
}
