import SwiftUI
import WebKit

public struct SankeyDiagram: UIViewRepresentable {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    public var data: SankeyData
    var options = SankeyOptions()

    public init(_ data: SankeyData) {
        self.data = data
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.scrollView.isScrollEnabled = false
        loadHTML(webView)
        return webView
    }
    
    public func updateUIView(_ webView: WKWebView, context: Context) {
        loadHTML(webView)
    }
    
    // MARK: - View Modifiers
    
    /// Sets the horizontal alignment of nodes
    public func nodeAlignment(_ value: SankeyNodeAlignment) -> SankeyDiagram {
        var new = self
        new.options.nodeAlignment = value
        return new
    }
    
    /// Sets the width of nodes
    public func nodeWidth(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.nodeWidth = value
        return new
    }
    
    /// Sets the vertical padding between nodes
    public func nodePadding(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.nodePadding = value
        return new
    }
    
    /// Sets the default color for nodes
    public func nodeDefaultColor(_ color: Color) -> SankeyDiagram {
        var new = self
        new.options.nodeDefaultColor = color
        return new
    }
    
    /// Sets the opacity of nodes
    public func nodeOpacity(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.nodeOpacity = value
        return new
    }
    
    /// Sets the default color for links
    public func linkDefaultColor(_ color: Color) -> SankeyDiagram {
        var new = self
        new.options.linkDefaultColor = color
        return new
    }
    
    /// Sets the opacity of links
    public func linkOpacity(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.linkOpacity = value
        return new
    }
    
    /// Sets how link colors are determined
    public func linkColorMode(_ value: SankeyLinkColorMode?) -> SankeyDiagram {
        var new = self
        new.options.linkColorMode = value
        return new
    }
    
    /// Sets the padding between nodes and labels
    public func labelPadding(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.labelPadding = value
        return new
    }
    
    /// Sets the color of labels
    public func labelColor(_ color: Color) -> SankeyDiagram {
        var new = self
        new.options.labelColor = color
        return new
    }
    
    /// Sets the opacity of labels
    public func labelOpacity(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.labelOpacity = value
        return new
    }
    
    /// Sets the font size of labels
    public func labelFontSize(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.labelFontSize = value
        return new
    }
    
    /// Sets the font family of labels
    public func labelFontFamily(_ value: String) -> SankeyDiagram {
        var new = self
        new.options.labelFontFamily = value
        return new
    }

    // MARK: - Private Implementation Details
    
    private func loadHTML(_ webView: WKWebView) {
        webView.loadHTMLString(generateHTML(), baseURL: nil)
    }

    private func generateHTML() -> String {
        """
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                body { margin: 0; }
                svg { width: 100%; height: 100%; }
            </style>
        </head>
        <body>
            <svg></svg>
            <script>
                \(SankeyResources.d3minjs)
                \(SankeyResources.d3sankeyminjs)
        
                const width = window.innerWidth;
                const height = window.innerHeight;
                const isDark = \(colorScheme == .dark);
        
                const svg = d3.select("svg")
                    .attr("width", width)
                    .attr("height", height);
        
                const sankey = d3.sankey()
                    .nodeId(d => d.id)
                    .nodeWidth(\(options.nodeWidth))
                    .nodePadding(\(options.nodePadding))
                    .nodeAlign(d3.sankey\(options.nodeAlignment.rawValue))
                    .size([width, height]);
        
                const { nodes, links } = sankey(\(data));
        
                const defaultNodeColor = "\(options.nodeDefaultColor.hex(for: colorScheme))";
                const defaultLinkColor = "\(options.linkDefaultColor.hex(for: colorScheme))";
        
                const getColor = (colorData, fallback) =>
                    colorData ? (isDark ? colorData.dark : colorData.light) : fallback;
        
                const getLinkColor = link => {
                    const mode = "\(options.linkColorMode?.rawValue ?? "")";
                    if (!mode) return getColor(link.hex, defaultLinkColor);
        
                    const sourceColor = getColor(link.source.hex, defaultNodeColor);
                    const targetColor = getColor(link.target.hex, defaultNodeColor);
        
                    if (mode === "source") return sourceColor;
                    if (mode === "target") return targetColor;
                    if (mode === "source-target") {
                        const gradientId = `gradient-${link.index}`;
                        const gradient = svg.append("defs")
                            .append("linearGradient")
                            .attr("id", gradientId)
                            .attr("gradientUnits", "userSpaceOnUse")
                            .attr("x1", link.source.x1)
                            .attr("x2", link.target.x0);
                        gradient.append("stop").attr("offset", "0%").attr("stop-color", sourceColor);
                        gradient.append("stop").attr("offset", "100%").attr("stop-color", targetColor);
                        return `url(#${gradientId})`;
                    }
                    return defaultLinkColor;
                };
        
                const link = svg.append("g")
                    .attr("fill", "none")
                    .selectAll(".link")
                    .data(links)
                    .enter().append("path")
                    .attr("class", "link")
                    .attr("d", d3.sankeyLinkHorizontal())
                    .style("stroke", getLinkColor)
                    .style("stroke-opacity", \(options.linkOpacity))
                    .style("stroke-width", link => Math.max(1, link.width));
        
                const node = svg.append("g")
                    .selectAll(".node")
                    .data(nodes)
                    .enter().append("g")
                    .attr("class", "node");
        
                node.append("rect")
                    .attr("x", d => d.x0).attr("y", d => d.y0)
                    .attr("width", d => d.x1 - d.x0).attr("height", d => d.y1 - d.y0)
                    .style("fill", d => getColor(d.hex, defaultNodeColor))
                    .style("opacity", \(options.nodeOpacity))
                    .style("stroke", d => getColor(d.hex, defaultNodeColor))
                    .style("stroke-opacity", \(options.nodeOpacity))
                    .style("stroke-width", 0);
        
                node.append("text")
                    .attr("font-family", "\(options.labelFontFamily)")
                    .attr("font-size", \(options.labelFontSize))
                    .attr("fill", isDark ? "\(options.labelColor.dark.hex)" : "\(options.labelColor.light.hex)")
                    .style("opacity", \(options.labelOpacity))
                    .attr("x", d => d.x0 < width / 2 ? d.x1 + \(options.labelPadding) : d.x0 - \(options.labelPadding))
                    .attr("y", d => (d.y1 + d.y0) / 2)
                    .attr("dy", "0.35em")
                    .attr("text-anchor", d => d.x0 < width / 2 ? "start" : "end")
                    .text(d => d.label || d.id);
            </script>
        </body>
        """
    }
}
