import SwiftUI
import WebKit

/// A SwiftUI-compatible Sankey Diagram (powered by Google Charts)
/// - Important: Requires an Internet connection
public struct SankeyDiagram: UIViewRepresentable {
    public let data: [SankeyLink]
    public let options: SankeyOptions
    
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
                data.addRows(\(data));
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
        ReadMeView()
    }
    
    struct ReadMeView: View {
        // Create some data
        @State var data: [SankeyLink] = [
            // Option A: ExpressibleByArrayLiteral init
            ["A", "X", "5"],
            ["A", "Y", "7"],
            ["A", "Z", "6"],
            ["B", "X", "2"],
            ["B", "Y", "9"],
            ["B", "Z", "4"]
        ]
        
        var body: some View {
            GeometryReader { geo in
                VStack(spacing: 20) {
                    Text("Sankeys in SwiftUI!")
                        .font(.title3.bold())
                        .padding(.top, 20)
                    // Native SwiftUI component
                    SankeyDiagram(
                        data,
                        nodeLabelFontSize: 50,
                        nodeInteractivity: true,
                        linkColorMode: .gradient,
                        tooltipTextFontSize: 50
                    )
                    // Will take up full View, unless you constrain it...
                    .frame(height: geo.size.height * 0.5)
                    Button {
                        data.append(
                            // Option B: Normal init
                            SankeyLink(source: "C", target: "X", value: 3)
                        )
                    } label: {
                        Text("Add a new link")
                    }
                    Text("Lorem Ipsum...")
                }
            }
        }
    }
}
