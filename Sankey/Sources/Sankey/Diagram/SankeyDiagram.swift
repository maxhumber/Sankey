import SwiftUI
import WebKit

public struct SankeyDiagram: UIViewRepresentable {
    @Binding public var links: [SankeyLink]
    public var options: SankeyOptions
    
    public init(
        _ links: Binding<[SankeyLink]>,
        nodeColors: [String]? = nil,
        nodeColorMode: SankeyOptions.Sankey.Node.ColorMode = .unique,
        nodeWidth: Double? = nil,
        nodePadding: Double? = nil,
        nodeLabelColor: String = "black",
        nodeLabelFontSize: Double = 30,
        nodeLabelFontName: String? = nil,
        nodeLabelBold: Bool = false,
        nodeLabelItalic: Bool = false,
        nodeLabelPadding: Double? = nil,
        nodeInteractivity: Bool = false,
        linkColors: [String]? = nil,
        linkColorMode: SankeyOptions.Sankey.Link.ColorMode? = nil,
        linkColorFillOpacity: Double? = nil,
        linkColorFill: String? = nil,
        linkColorStroke: String? = nil,
        linkColorStrokeWidth: Double = 0,
        tooltipValueLabel: String = "",
        tooltipTextColor: String = "black",
        tooltipTextFontSize: Double = 30,
        tooltipTextFontName: String? = nil,
        tooltipTextBold: Bool = false,
        tooltipTextItalic: Bool = false,
        layoutIterations: Int = 32
    ) {
        self._links = links
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
            linkColorFillOpacity: linkColorFillOpacity,
            linkColorFill: linkColorFill,
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
    
    public func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.isOpaque = false
        webview.scrollView.isScrollEnabled = false
        return webview
    }
    
    public func updateUIView(_ webview: WKWebView, context: Context) {
        webview.loadHTMLString(html(), baseURL: nil)
    }
    
    private func html() -> String {
        """
        <html>
          <head>
            <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
            <script type="text/javascript">
              google.charts.load('current', {'packages':['sankey']});
              google.charts.setOnLoadCallback(drawChart);
              function drawChart() {
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'source');
                data.addColumn('string', 'target');
                data.addColumn('number', '\(options.tooltip.valueLabel)');
                data.addRows(\(links));
                var chart = new google.visualization.Sankey(document.getElementById('chart'));
                var options = \(options);
                chart.draw(data, options);
              }
            </script>
          </head>
          <body>
            <div id="chart" style="width: 100%; height: 100%"></div>
          </body>
        </html>
        """
    }
}

struct SankeyDiagram_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var links: [SankeyLink] = [
            ["A", "X", "5"],
            ["A", "Y", "7"],
            ["A", "Z", "6"],
            ["B", "X", "2"],
            ["B", "Y", "9"],
            ["B", "Z", "4"]
        ]
        
        var body: some View {
            GeometryReader { geo in
                VStack {
                    addButton
                    diagram(in: geo)
                    Text("More Content")
                }
            }
        }
        
        func diagram(in geo: GeometryProxy) -> some View {
            SankeyDiagram(
                $links,
                nodeLabelFontSize: 40,
                linkColorMode: .source,
                tooltipTextFontSize: 40
            )
            .frame(height: geo.size.height * 0.5)
        }
    
        var addButton: some View {
            Button {
                links.append(["C", "X", "5"])
            } label: {
                Text("Add")
            }
        }
    }
}
