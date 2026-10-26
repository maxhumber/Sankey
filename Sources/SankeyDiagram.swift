import OSLog
public import SwiftUI

private let logger = Logger(subsystem: "Sankey", category: "layout")

/// A native SwiftUI Sankey diagram.
///
/// Style it with the modifiers below, then apply standard modifiers like `.frame` after them.
/// Labels follow `.font`, `.foregroundStyle`, `.lineLimit` (default 1), and
/// `.minimumScaleFactor`.
public struct SankeyDiagram: View {
    @Environment(\.lineLimit) private var lineLimit: Int?
    @State private var size = CGSize.zero
    @Binding private var selectedNodeID: String?
    private var isSelectable = false
    public var data: SankeyData
    var options = SankeyOptions()

    /// Creates a diagram. Nodes, links, or cycles that can't be laid out show
    /// "Diagram unavailable".
    public init(_ data: SankeyData) {
        self.data = data
        _selectedNodeID = .constant(nil)
    }

    public var body: some View {
        let layout = layout
        let highlight = layout?.highlight(selectedNodeID)
        Canvas { context, _ in
            if let layout, let highlight {
                draw(layout, highlight: highlight, in: &context)
            }
        }
        .accessibilityHidden(true)
        .overlay { labels(for: layout, highlight: highlight) }
        .onGeometryChange(for: CGSize.self) {
            $0.size
        } action: {
            size = $0
        }
        .contentShape(.rect)
        .gesture(
            SpatialTapGesture().onEnded { select(layout?.node(at: $0.location)?.id) },
            including: isSelectable ? .all : .subviews
        )
        .frame(idealWidth: 300, idealHeight: 300)
    }

    // MARK: - View Modifiers

    /// Binds the selected node ID and enables connected-flow highlighting.
    public func nodeSelection(_ selection: Binding<String?>) -> SankeyDiagram {
        var new = self
        new._selectedNodeID = selection
        new.isSelectable = true
        return new
    }

    /// Sets the horizontal alignment of nodes
    public func nodeAlignment(_ value: SankeyNodeAlignment) -> SankeyDiagram {
        setting(\.nodeAlignment, value)
    }

    /// Sets the width of nodes
    public func nodeWidth(_ value: Double) -> SankeyDiagram {
        setting(\.nodeWidth, value)
    }

    /// Sets the vertical padding between nodes
    public func nodePadding(_ value: Double) -> SankeyDiagram {
        setting(\.nodePadding, value)
    }

    /// Sets the default color for nodes
    public func nodeDefaultColor(_ color: Color) -> SankeyDiagram {
        setting(\.nodeDefaultColor, color)
    }

    /// Sets the default color for links
    public func linkDefaultColor(_ color: Color) -> SankeyDiagram {
        setting(\.linkDefaultColor, color)
    }

    /// Sets the opacity of links
    public func linkOpacity(_ value: Double) -> SankeyDiagram {
        setting(\.linkOpacity, value)
    }

    /// Sets how link colors are determined
    public func linkColorMode(_ value: SankeyLinkColorMode?) -> SankeyDiagram {
        setting(\.linkColorMode, value)
    }

    /// Sets the padding between nodes and labels
    public func labelPadding(_ value: Double) -> SankeyDiagram {
        setting(\.labelPadding, value)
    }

    // MARK: - Drawing

    @ContentBuilder
    private func labels(
        for layout: SankeyLayout?, highlight: SankeyLayout.Highlight?
    ) -> some View {
        if let layout, let highlight {
            ZStack {
                ForEach(layout.nodes) { node in
                    label(for: node, in: layout, highlight: highlight)
                }
            }
        } else if canDraw {
            Text("Diagram unavailable")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    @ContentBuilder
    private func label(
        for node: SankeyLayout.Node, in layout: SankeyLayout, highlight: SankeyLayout.Highlight
    ) -> some View {
        let isSelected = (highlight.id == node.id)
        Text(node.label ?? node.id)
            .opacity(highlight.isLit(node) ? 1 : 0.32)
            .lineLimit(lineLimit ?? 1)
            .multilineTextAlignment(layout.isLeading(node) ? .leading : .trailing)
            .help(node.label ?? node.id)
            .gesture(
                TapGesture().onEnded { select(node.id) },
                including: isSelectable ? .all : .subviews
            )
            .frame(
                width: layout.labelWidth,
                alignment: layout.isLeading(node) ? .leading : .trailing
            )
            .position(layout.labelCenter(for: node))
            .accessibilityAddTraits(isSelectable ? .isButton : [])
            .accessibilityAddTraits(isSelected ? .isSelected : [])
            .accessibilityAction { select(node.id) }
    }

    private func draw(
        _ layout: SankeyLayout,
        highlight: SankeyLayout.Highlight,
        in context: inout GraphicsContext
    ) {
        for link in layout.links {
            context.opacity = options.linkOpacity * (highlight.touches(link) ? 1 : 0.16)
            context.stroke(
                layout.path(for: link),
                with: shading(for: link, in: layout),
                style: StrokeStyle(lineWidth: max(1, link.width))
            )
        }
        for node in layout.nodes {
            context.opacity = highlight.isLit(node) ? 1 : 0.24
            context.fill(Path(node.rect), with: .color(color(of: node)))
        }
    }

    private func shading(
        for link: SankeyLayout.Link, in layout: SankeyLayout
    ) -> GraphicsContext.Shading {
        let source = layout.nodes[link.source]
        let target = layout.nodes[link.target]
        switch options.linkColorMode {
        case .source:
            return .color(color(of: source))
        case .target:
            return .color(color(of: target))
        case .gradient:
            return .linearGradient(
                Gradient(colors: [color(of: source), color(of: target)]),
                startPoint: CGPoint(x: source.x1, y: 0),
                endPoint: CGPoint(x: target.x0, y: 0)
            )
        case nil:
            return .color(link.color ?? options.linkDefaultColor)
        }
    }

    // MARK: - Computed Values

    private var canDraw: Bool {
        !data.nodes.isEmpty && (size.width > 0) && (size.height > 0)
    }

    private var layout: SankeyLayout? {
        guard canDraw, !data.links.isEmpty else { return nil }
        do {
            return try SankeyLayout(data, options: options, size: size)
        } catch {
            logger.error("Sankey diagram unavailable: \(String(describing: error))")
            return nil
        }
    }

    // MARK: - Private Functions

    private func setting<Value>(
        _ keyPath: WritableKeyPath<SankeyOptions, Value>, _ value: Value
    ) -> SankeyDiagram {
        var new = self
        new.options[keyPath: keyPath] = value
        return new
    }

    private func select(_ id: String?) {
        guard isSelectable else { return }
        selectedNodeID = (id == selectedNodeID) ? nil : id
    }

    private func color(of node: SankeyLayout.Node) -> Color {
        node.color ?? options.nodeDefaultColor
    }
}
