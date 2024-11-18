import SwiftUI
import WebKit

// MARK: - Diagram

public struct SankeyDiagram: UIViewRepresentable {
    public var data: SankeyData
    private var options = SankeyOptions()
    
    public init(data: SankeyData) {
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
    
    private func loadHTML(_ webView: WKWebView) {
        guard
            let pathD3 = Bundle.module.path(forResource: "d3.min", ofType: "js"),
            let pathSankey = Bundle.module.path(forResource: "d3-sankey.min", ofType: "js")
        else {
            print("JavaScript files not found in the bundle")
            return
        }
        let temp = FileManager.default.temporaryDirectory
        let tempPathD3 = temp.appendingPathComponent("d3.min.js")
        let tempPathSankey = temp.appendingPathComponent("d3-sankey.min.js")
        let fileManager = FileManager.default
        do {
            if !fileManager.fileExists(atPath: tempPathD3.path) {
                try fileManager.copyItem(atPath: pathD3, toPath: tempPathD3.path)
            }
            if !fileManager.fileExists(atPath: tempPathSankey.path) {
                try fileManager.copyItem(atPath: pathSankey, toPath: tempPathSankey.path)
            }
        } catch {
            print("Failed to copy JavaScript files: \(error)")
            return
        }
        let htmlString = generateHTML(from: data, options: options)
        webView.loadHTMLString(htmlString, baseURL: temp)
    }
    
    private func generateHTML(from data: SankeyData, options: SankeyOptions) -> String {
        """
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <script src="d3.min.js"></script>
            <script src="d3-sankey.min.js"></script>
            <style>
                body { margin: 0; }
                svg { width: 100%; height: 100%; }
            </style>
        </head>
        <body>
            <svg></svg>
            <script>
                const width = window.innerWidth;
                const height = window.innerHeight;
        
                const svg = d3.select("svg")
                    .attr("width", width)
                    .attr("height", height);
        
                const sankey = d3.sankey()
                    .nodeId(d => d.id)
                    .nodeWidth(\(options.nodeWidth))
                    .nodePadding(\(options.nodePadding))
                    .nodeAlign(d3.sankey\(options.nodeAlignment))
                    .size([width, height]);
        
                const { nodes, links } = sankey(\(data));
        
                function getLinkColor(link) {
                    const mode = "\(options.linkColorMode?.description ?? "")";
                    if (mode === "source") return link.source.color || "\(options.linkColor)";
                    if (mode === "target") return link.target.color || "\(options.linkColor)";
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
                            .attr("stop-color", link.source.color || "\(options.nodeColor)");
                        gradient.append("stop")
                            .attr("offset", "100%")
                            .attr("stop-color", link.target.color || "\(options.nodeColor)");
                        return `url(#${gradientId})`;
                    }
                    return link.color || "\(options.linkColor)";
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
                    .style("fill", node => node.color || "\(options.nodeColor)")
                    .style("opacity", \(options.nodeOpacity));
        
                node.append("text")
                    .attr("font-family", "\(options.labelFontFamily)")
                    .attr("font-size", \(options.labelFontSize))
                    .attr("fill", "\(options.labelColor)")
                    .style("opacity", \(options.labelOpacity))
                    .attr("x", node => node.x0 < width / 2 ? node.x1 + \(options.labelPadding) : node.x0 - \(options.labelPadding))
                    .attr("y", node => (node.y1 + node.y0) / 2)
                    .attr("dy", "0.35em")
                    .attr("text-anchor", node => node.x0 < width / 2 ? "start" : "end")
                    .text(node => node.label);
            </script>
        </body>
        """
    }
}

extension SankeyDiagram {
    // Node modifiers
    public func nodeAlignment(_ value: SankeyNodeAlignment) -> SankeyDiagram {
        var new = self
        new.options.nodeAlignment = value
        return new
    }
    
    public func nodeWidth(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.nodeWidth = value
        return new
    }
    
    public func nodeOpacity(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.nodeOpacity = value
        return new
    }
    
    public func nodeColor(_ value: String) -> SankeyDiagram {
        var new = self
        new.options.nodeColor = value
        return new
    }
    
    public func nodePadding(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.nodePadding = value
        return new
    }
    
    // Link modifiers
    public func linkColorMode(_ value: SankeyLinkColorMode?) -> SankeyDiagram {
        var new = self
        new.options.linkColorMode = value
        return new
    }
    
    public func linkOpacity(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.linkOpacity = value
        return new
    }
    
    public func linkColor(_ value: String) -> SankeyDiagram {
        var new = self
        new.options.linkColor = value
        return new
    }
    
    // Label modifiers
    public func labelFontSize(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.labelFontSize = value
        return new
    }
    
    public func labelFontFamily(_ value: String) -> SankeyDiagram {
        var new = self
        new.options.labelFontFamily = value
        return new
    }
    
    public func labelOpacity(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.labelOpacity = value
        return new
    }
    
    public func labelColor(_ value: String) -> SankeyDiagram {
        var new = self
        new.options.labelColor = value
        return new
    }
    
    public func labelPadding(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.labelPadding = value
        return new
    }
}

extension SankeyDiagram {
    @available(*, deprecated, message: "Use SankeyDiagram(data:) with modifiers instead")
    public init(
        _ links: [SankeyLink],
        nodeColors: [String]? = nil,
        nodeColorMode: String = "unique",
        nodeWidth: Double? = nil,
        nodePadding: Double? = nil,
        nodeLabelColor: String = "black",
        nodeLabelFontSize: Double = 14,
        nodeLabelFontName: String? = nil,
        nodeLabelBold: Bool = false,
        nodeLabelItalic: Bool = false,
        nodeLabelPadding: Double? = nil,
        nodeInteractivity: Bool = false,
        linkColors: [String]? = nil,
        linkColorMode: String? = nil,
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
        let nodeIds = Set(links.flatMap { [$0.source, $0.target] })
        let nodes = nodeIds.map { SankeyNode($0) }
        self.data = SankeyData(nodes: nodes, links: links)
        var options = SankeyOptions()
        options.nodeWidth = nodeWidth ?? options.nodeWidth
        options.nodePadding = nodePadding ?? options.nodePadding
        options.labelPadding = nodeLabelPadding ?? options.labelPadding
        options.labelColor = nodeLabelColor
        options.labelFontSize = nodeLabelFontSize
        options.labelFontFamily = nodeLabelFontName ?? options.labelFontFamily
        options.linkColor = linkColorFill ?? options.linkColor
        options.linkOpacity = linkColorFillOpacity ?? options.linkOpacity
        self.options = options
    }
}
