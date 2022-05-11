import SwiftUI
import WebKit

public struct SankeyDiagram: UIViewRepresentable {
    @Binding public var links: [SankeyLink]
    public var options: SankeyOptions

    public init(
        _ links: Binding<[SankeyLink]>,
        nodeColors: [String]? = nil,
        nodeLabelColor: String = "black",
        nodeLabelFontSize: Double = 30,
        linkColorMode: SankeyOptions.Sankey.Link.ColorMode? = nil,
        tooltipValueLabel: String = "",
        tooltipTextColor: String = "black",
        tooltipTextFontSize: Double = 30
    ) {
        self._links = links
        self.options = .init(
            nodeColors: nodeColors,
            nodeLabelColor: nodeLabelColor,
            nodeLabelFontSize: nodeLabelFontSize,
            linkColorMode: linkColorMode,
            tooltipValueLabel: tooltipValueLabel,
            tooltipTextColor: tooltipTextColor,
            tooltipTextFontSize: tooltipTextFontSize
        )
    }
    
    public init(_ links: Binding<[SankeyLink]>, options: SankeyOptions) {
        self._links = links
        self.options = options
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
