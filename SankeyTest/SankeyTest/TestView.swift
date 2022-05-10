import SwiftUI
import WebKit

enum Node: String {
    case a = "A"
    case b = "B"
    case x = "X"
    case y = "Y"
    case z = "Z"
}

struct Flow {
    var from: Node
    var to: Node
    var value: Double
}

typealias Flow2 = (from: String, to: String, value: Double)

extension Flow: CustomStringConvertible {
    var description: String {
        "['\(from.rawValue)', '\(to.rawValue)', \(value)]"
    }
}

extension Flow: ExpressibleByArrayLiteral {
    init(arrayLiteral: String...) {
        to = Node(rawValue: arrayLiteral[0])!
        from = Node(rawValue: arrayLiteral[1])!
        value = Double(arrayLiteral[2])!
    }
}

struct SankeyDiagram: UIViewRepresentable {
    @Binding var flows: [Flow]
    
    func makeUIView(context: Context) -> WKWebView {
        let wkwebview = WKWebView()
        wkwebview.isOpaque = false
        wkwebview.scrollView.isScrollEnabled = false
        return wkwebview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let htmlString = buildHTMLString(flows)
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    func buildHTMLString(_ flows: [Flow]) -> String {
        var dataString = ""
        for flow in flows {
            dataString += "\(flow)"
            dataString += ", "
        }
        let htmlString = """
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
                    data.addRows([
                      \(dataString)
                    ]);
                    var chart = new google.visualization.Sankey(document.getElementById('chart'));
                    var options = {
                        sankey: {
                            node: {
                                label: {
                                    fontSize: 28
                                }
                            }
                        },
                        tooltip: { textStyle: { fontName: 'verdana', fontSize: 30 } }
                    };
                    chart.draw(data, options);
                  }
                </script>
              </head>
              <body>
                <div id="chart" style="width: 100%; height: 100%;"></div>
              </body>
            </html>
            """
        return htmlString
    }
}

struct TestView: View {
    @State var flows: [Flow] = [
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
                Button {
                    flows.append(["X", "Z", "4"])
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
