import SwiftUI
import WebKit

/// A SwiftUI-compatible Sankey Diagram (powered by Google Charts)
/// - Important: Requires an Internet connection
public struct SankeyDiagram: UIViewRepresentable {
    public let data: [SankeyLink]
    public let options: SankeyOptions

    public class Coordinator: NSObject {
        var parent: SankeyDiagram

        init(parent: SankeyDiagram) {
            self.parent = parent
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.isOpaque = false
        webview.scrollView.isScrollEnabled = false
        webview.loadHTMLString(html(), baseURL: nil)
        return webview
    }
    
    public func updateUIView(_ webview: WKWebView, context: Context) {
        let dataString = data.map { $0.description }.joined(separator: ", ")

        do {
            let optionsData = try JSONEncoder().encode(options)
            let optionsString = String(data: optionsData, encoding: .utf8) ?? "{}"

            let updateScript = """
            if (typeof drawChart === 'function') {
                drawChart([\(dataString)], \(optionsString));
            } else {
                console.log("drawChart function is not defined yet.");
            }
            """
            webview.evaluateJavaScript(updateScript, completionHandler: { (result, error) in
                if let error = error {
                    print("JavaScript error: \(error)")
                }
            })
        } catch {
            print("Failed to encode options: \(error)")
        }
    }
    
    private func html() -> String {
        """
        <html>
          <head>
            <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
            <script type="text/javascript">
              google.charts.load('current', {'packages':['sankey']});
              google.charts.setOnLoadCallback(initializeChart);
              function initializeChart() {
                window.drawChart = function(data, options) {
                  var dataTable = new google.visualization.DataTable();
                  dataTable.addColumn('string', 'source');
                  dataTable.addColumn('string', 'target');
                  dataTable.addColumn('number', options.tooltip.valueLabel);
                  dataTable.addRows(data);
                  var chart = new google.visualization.Sankey(document.getElementById('chart'));
                  chart.draw(dataTable, options);
                };
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