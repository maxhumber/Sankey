import Foundation

extension SankeyDiagram {
    /// Initializes a `SankeyDiagram` with a wide array of customizable options
    ///
    /// **Deprecated**: Use `SankeyDiagram(data:)` with modifiers instead
    ///
    /// This initializer allows you to customize various visual and interactive properties of the diagram,
    /// but has been deprecated to encourage a more modular and SwiftUI-consistent approach
    ///
    /// - Parameters:
    ///   - links: An array of `SankeyLink` objects representing the links in the diagram
    ///   - nodeColors: **Deprecated**. An optional array of hexadecimal strings representing node colors
    ///   - nodeColorMode: **Deprecated**. A string specifying the mode for node colors
    ///   - nodeWidth: The width of nodes. Defaults to the value in `SankeyOptions`
    ///   - nodePadding: The vertical padding between nodes. Defaults to the value in `SankeyOptions`
    ///   - nodeLabelColor: The color of node labels, represented as a hexadecimal string
    ///   - nodeLabelFontSize: The font size of node labels
    ///   - nodeLabelFontName: The font family of node labels
    ///   - nodeLabelBold: **Deprecated**. A Boolean indicating whether node labels should be bold
    ///   - nodeLabelItalic: **Deprecated**. A Boolean indicating whether node labels should be italicized
    ///   - nodeLabelPadding: The padding between labels and their corresponding nodes
    ///   - nodeInteractivity: **Deprecated**. A Boolean indicating whether nodes are interactive
    ///   - linkColors: **Deprecated**. An optional array of hexadecimal strings representing link colors
    ///   - linkColorMode: **Deprecated**. A string specifying the mode for link colors
    ///   - linkColorFill: The fill color for links, represented as a hexadecimal string
    ///   - linkColorFillOpacity: The opacity of the link fill color (0.0 to 1.0)
    ///   - linkColorStroke: **Deprecated**. The stroke color for links
    ///   - linkColorStrokeWidth: **Deprecated**. The stroke width for links
    ///   - tooltipValueLabel: **Deprecated**. A label for values shown in tooltips
    ///   - tooltipTextColor: **Deprecated**. The text color of tooltips
    ///   - tooltipTextFontSize: **Deprecated**. The font size of tooltip text
    ///   - tooltipTextFontName: **Deprecated**. The font family of tooltip text
    ///   - tooltipTextBold: **Deprecated**. A Boolean indicating whether tooltip text should be bold
    ///   - tooltipTextItalic: **Deprecated**. A Boolean indicating whether tooltip text should be italicized
    ///   - layoutIterations: **Deprecated**. The number of iterations for the layout algorithm
    @available(*, deprecated, message: "Use SankeyDiagram(data:) with modifiers instead")
    public init(
        _ links: [SankeyLink],
        nodeColors: [String]? = nil,
        nodeColorMode: String? = nil,
        nodeWidth: Double? = nil,
        nodePadding: Double? = nil,
        nodeLabelColor: String? = nil,
        nodeLabelFontSize: Double? = nil,
        nodeLabelFontName: String? = nil,
        nodeLabelBold: Bool? = nil,
        nodeLabelItalic: Bool? = nil,
        nodeLabelPadding: Double? = nil,
        nodeInteractivity: Bool? = nil,
        linkColors: [String]? = nil,
        linkColorMode: String? = nil,
        linkColorFill: String? = nil,
        linkColorFillOpacity: Double? = nil,
        linkColorStroke: String? = nil,
        linkColorStrokeWidth: Double? = nil,
        tooltipValueLabel: String? = nil,
        tooltipTextColor: String? = nil,
        tooltipTextFontSize: Double? = nil,
        tooltipTextFontName: String? = nil,
        tooltipTextBold: Bool? = nil,
        tooltipTextItalic: Bool? = nil,
        layoutIterations: Int? = nil
    ) {
        let nodeIds = Set(links.flatMap { [$0.source, $0.target] })
        let nodes = nodeIds.map { SankeyNode($0) }
        var options = SankeyOptions()
        // nodeColors - Deprecated
        // nodeColorMode - Deprecated
        options.nodeWidth = nodeWidth ?? options.nodeWidth
        options.nodePadding = nodePadding ?? options.nodePadding
        options.labelColor = nodeLabelColor ?? options.labelColor
        options.labelFontSize = nodeLabelFontSize ?? options.labelFontSize
        options.labelFontFamily = nodeLabelFontName ?? options.labelFontFamily
        // nodeLabelBold - Deprecated
        // nodeLabelItalic - Deprecated
        options.labelPadding = nodeLabelPadding ?? options.labelPadding
        // nodeInteractivity - Deprecated
        // linkColors = Deprecated
        // linkColorMode = Deprecated
        options.linkColor = linkColorFill ?? options.linkColor
        options.linkOpacity = linkColorFillOpacity ?? options.linkOpacity
        // linkColorStroke - Deprecated
        // linkColorStrokeWidth - Deprecated
        // tooltipValueLabel - Deprecated
        // tooltipTextColor - Deprecated
        // tooltipTextFontSize - Deprecated
        // tooltipTextFontName - Deprecated
        // tooltipTextBold - Deprecated
        // tooltipTextItalic - Deprecated
        // layoutIterations - Deprecated
        self.data = SankeyData(nodes: nodes, links: links)
        self.options = options
    }
}
