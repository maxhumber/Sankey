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
                svg { 
                    width: 100%; 
                    height: 100%;
                }
            </style>
        </head>
        <body>
            <svg></svg>
            <script>\(SankeyResources.d3minjs)</script>
            <script>\(SankeyResources.d3sankeyminjs)</script>
            <script>
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
        
                function getLinkColor(link) {
                    const mode = "\(options.linkColorMode?.rawValue ?? "")";
                    if (mode === "source") {
                        const sourceColor = link.source.hex && (isDark ? link.source.hex.dark : link.source.hex.light);
                        return sourceColor || "\(options.nodeDefaultColor.hex)";
                    }
                    if (mode === "target") {
                        const targetColor = link.target.hex && (isDark ? link.target.hex.dark : link.target.hex.light);
                        return targetColor || "\(options.nodeDefaultColor.hex)";
                    }
                    if (mode === "source-target") {
                        const gradientId = `gradient-${link.index}`;
                        const gradient = svg.append("defs")
                            .append("linearGradient")
                            .attr("id", gradientId)
                            .attr("gradientUnits", "userSpaceOnUse")
                            .attr("x1", link.source.x1)
                            .attr("x2", link.target.x0);
                        gradient.append("stop")
                            .attr("offset", "0%")
                            .attr("stop-color", (link.source.hex && (isDark ? link.source.hex.dark : link.source.hex.light)) || "\(options.nodeDefaultColor.hex)");
                        gradient.append("stop")
                            .attr("offset", "100%")
                            .attr("stop-color", (link.target.hex && (isDark ? link.target.hex.dark : link.target.hex.light)) || "\(options.nodeDefaultColor.hex)");
                        return `url(#${gradientId})`;
                    }
                    return (link.hex && (isDark ? link.hex.dark : link.hex.light)) || "\(options.linkDefaultColor.hex)";
                }
                
                function getNodeColor(node) {
                    return (node.hex && (isDark ? node.hex.dark : node.hex.light)) || "\(options.nodeDefaultColor.hex)";
                }
                
                function getLabelColor() {
                    return isDark ? "\(options.labelColor.dark)" : "\(options.labelColor.light)";
                }
                
                const link = svg.append("g")
                    .attr("fill", "none")
                    .selectAll(".link")
                    .data(links)
                    .enter()
                    .append("path")
                    .attr("class", "link")
                    .attr("d", d3.sankeyLinkHorizontal())
                    .style("stroke", getLinkColor)
                    .style("stroke-opacity", \(options.linkOpacity))
                    .style("stroke-width", link => Math.max(1, link.width));
        
                const node = svg.append("g")
                    .selectAll(".node")
                    .data(nodes)
                    .enter()
                    .append("g")
                    .attr("class", "node");
        
                node.append("rect")
                    .attr("x", node => node.x0)
                    .attr("y", node => node.y0)
                    .attr("width", node => node.x1 - node.x0)
                    .attr("height", node => node.y1 - node.y0)
                    .style("fill", getNodeColor)
                    .style("opacity", \(options.nodeOpacity))
                    .style("stroke", getNodeColor)
                    .style("stroke-width", 0)
                    .style("stroke-opacity", \(options.nodeOpacity));
        
                node.append("text")
                    .attr("font-family", "\(options.labelFontFamily)")
                    .attr("font-size", \(options.labelFontSize))
                    .attr("fill", getLabelColor)
                    .style("opacity", \(options.labelOpacity))
                    .attr("x", node => node.x0 < width / 2 ? node.x1 + \(options.labelPadding) : node.x0 - \(options.labelPadding))
                    .attr("y", node => (node.y1 + node.y0) / 2)
                    .attr("dy", "0.35em")
                    .attr("text-anchor", node => node.x0 < width / 2 ? "start" : "end")
                    .text(node => node.label || node.id);
            </script>
        </body>
        """
    }
}

// MARK: - Public View Modifiers

extension SankeyDiagram {
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
}

struct SankeyResources {
    static let d3minjs: String = loadResource(named: "d3.min", type: "js")
    static let d3sankeyminjs: String = loadResource(named: "d3-sankey.min", type: "js")
    
    private static func loadResource(named name: String, type: String) -> String {
        guard let path = Bundle.module.path(forResource: name, ofType: type), let content = try? String(contentsOfFile: path) else {
            print("\(name).\(type) not found in the bundle")
            return ""
        }
        return content
    }
}
