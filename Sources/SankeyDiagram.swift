import SwiftUI
import WebKit

public enum SankeyDiagramPhase {
    case empty
    case loading
    case success
    case failure(Error)
}

/// SwiftUI Sankey diagram rendered using D3 via dynamically generated HTML
public struct SankeyDiagram<Loading: View, Failure: View>: UIViewRepresentable {
    public var data: SankeyData
    var options = SankeyOptions()
    let loading: () -> Loading
    let failure: (Error) -> Failure
    
    /// Initializes a new `SankeyDiagram` with the provided data and state views
    public init(
        _ data: SankeyData,
        @ViewBuilder loading: @escaping () -> Loading,
        @ViewBuilder failure: @escaping (Error) -> Failure
    ) {
        self.data = data
        self.loading = loading
        self.failure = failure
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = context.coordinator
        context.coordinator.phase = .loading
        context.coordinator.updateOverlay(for: webView)
        loadHTML(webView)
        return webView
    }
    
    public func updateUIView(_ webView: WKWebView, context: Context) {
        context.coordinator.phase = .loading
        context.coordinator.updateOverlay(for: webView)
        loadHTML(webView)
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension SankeyDiagram {
    public class Coordinator: NSObject, WKNavigationDelegate {
        var parent: SankeyDiagram
        var phase: SankeyDiagramPhase = .empty
        var overlay: UIView?
        
        init(_ parent: SankeyDiagram) {
            self.parent = parent
        }
        
        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            phase = .loading
            updateOverlay(for: webView)
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            phase = .success
            overlay?.removeFromSuperview()
            overlay = nil
        }
        
        public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            phase = .failure(error)
            updateOverlay(for: webView)
        }
        
        public func updateOverlay(for webView: WKWebView) {
            overlay?.removeFromSuperview()
            let hostingController: UIHostingController<AnyView>
            switch phase {
            case .loading:
                hostingController = UIHostingController(rootView: AnyView(parent.loading()))
            case .failure(let error):
                hostingController = UIHostingController(rootView: AnyView(parent.failure(error)))
            default:
                return
            }
            hostingController.view.backgroundColor = .clear
            hostingController.view.frame = webView.bounds
            hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            webView.addSubview(hostingController.view)
            overlay = hostingController.view
        }
    }
}

// MARK: - Convenience Initializers

extension SankeyDiagram where Loading == EmptyView, Failure == EmptyView {
    /// Creates a Sankey diagram with default loading and failure views
    public init(_ data: SankeyData) {
        self.init(data, loading: { EmptyView() }, failure: { _ in EmptyView() } )
    }
}

// MARK: - Public Modifiers

extension SankeyDiagram {
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
    
    public func nodeDefaultColor(_ color: Color) -> SankeyDiagram {  // Changed from nodeColor
        var new = self
        new.options.nodeDefaultColor = color.hex
        return new
    }
    
    public func nodePadding(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.nodePadding = value
        return new
    }
    
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
    
    public func linkDefaultColor(_ color: Color) -> SankeyDiagram {  // Changed from linkColor
        var new = self
        new.options.linkDefaultColor = color.hex
        return new
    }
    
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
    
    public func labelColor(_ color: Color) -> SankeyDiagram {
        var new = self
        new.options.labelColor = color.hex
        return new
    }
    
    public func labelPadding(_ value: Double) -> SankeyDiagram {
        var new = self
        new.options.labelPadding = value
        return new
    }
}

// MARK: - Private Implementation Details

extension SankeyDiagram {
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
                    if (mode === "source") return link.source.color || "\(options.nodeDefaultColor)";
                    if (mode === "target") return link.target.color || "\(options.nodeDefaultColor)";
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
                            .attr("stop-color", link.source.color || "\(options.nodeDefaultColor)");
                        gradient.append("stop")
                            .attr("offset", "100%")
                            .attr("stop-color", link.target.color || "\(options.nodeDefaultColor)");
                        return `url(#${gradientId})`;
                    }
                    return link.color || "\(options.linkDefaultColor)";
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
                    .style("fill", node => node.color || "\(options.nodeDefaultColor)")
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
                    .text(node => node.id);
            </script>
        </body>
        """
    }
}
