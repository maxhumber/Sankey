import SwiftUI
import WebKit

struct SankeyDiagram: UIViewRepresentable {
    @Binding var flows: [SankeyLink<String>]
    
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.isOpaque = false
        webview.scrollView.isScrollEnabled = false
        return webview
    }
    
    func updateUIView(_ webview: WKWebView, context: Context) {
        let htmlString = buildHTMLString(flows)
        webview.loadHTMLString(htmlString, baseURL: nil)
    }
    
    func buildHTMLString(_ flows: [SankeyLink<String>]) -> String {
        """
        <html>
          <head>
            <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
            <script type="text/javascript">
              google.charts.load('current', {'packages':['sankey']});
              google.charts.setOnLoadCallback(drawChart);
              function drawChart() {
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'From');
                data.addColumn('string', 'To');
                data.addColumn('number', 'Value');
                data.addRows(\(flows));
                var chart = new google.visualization.Sankey(document.getElementById('chart'));
                var options = \(SankeyOptions());
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

struct TestView: View {
    @State var flows = [
        SankeyLink(source: "A", target: "X", weight: 5),
        SankeyLink(source: "A", target: "Y", weight: 7),
        SankeyLink(source: "A", target: "Z", weight: 6),
        SankeyLink(source: "B", target: "X", weight: 2),
        SankeyLink(source: "B", target: "Y", weight: 9),
        SankeyLink(source: "B", target: "Z", weight: 6),
    ]
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Button {
                    flows.append(SankeyLink(source: "A", target: "X", weight: 5))
                } label: {
                    Text("Add one")
                }
                SankeyDiagram(flows: $flows)
                    .frame(height: geo.size.height * 0.5)
                Text("Hey")
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
