import WebKit
import SwiftUI

//https://stackoverflow.com/questions/70653884/wkwebview-update-html-tags-from-swiftui-textfields

struct ContentView: View {
    @State private var headline = "Initial"
    
    var body: some View {
        VStack {
            TextField("Your headline", text: $headline)
            WebView(headline: $headline)
        }
    }
}

let sankeyHTML = """
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
        data.addColumn('number', 'Weight');
        data.addRows([
          ['A', 'X', 5],
          ['A', 'Y', 7],
          ['A', 'Z', 6],
          ['B', 'X', 2],
          ['B', 'Y', 9],
          ['B', 'Z', 4]
        ]);
        var element = document.getElementById('sankey_basic')
        var chart = new google.visualization.Sankey(element);
        chart.draw(data);
      }
    </script>
  </head>
  <body>
    <div id="sankey_basic" style="width: 800px; height: 500px;"></div>
  </body>
</html>
"""

let bridgeHTML = """
 <!DOCTYPE html>
 <html>
 <head>
 <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1, minimum-scale=1, viewport-fit=cover">
 </head>
 <body>
 <h3 id="headline">Headline</h3>
 <script>
    // to receive messages from native
      webkit.messageHandlers.bridge.onMessage = (msg) => {
        document.getElementById("headline").textContent = msg
      }
    </script>
    </body>
    </html>
"""

struct WebView: UIViewRepresentable {
    @Binding var headline: String
    
    func makeUIView(context: Context) -> WKWebView {
        let userContentController = WKUserContentController()
        userContentController.add(context.coordinator, name: "bridge")
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        let wkwebview = WKWebView(frame: .zero, configuration: configuration)
        wkwebview.navigationDelegate = context.coordinator
        wkwebview.loadHTMLString(sankeyHTML, baseURL: nil)
        return wkwebview
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.evaluateJavaScript("webkit.messageHandlers.bridge.onMessage('\(headline)')")
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        private var owner: WebView
        var webView: WKWebView?
        
        init(_ owner: WebView) {
            self.owner = owner
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        }
    
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.webView = webView
            messageToWebview(msg: owner.headline)
        }
        
        func messageToWebview(msg: String) {
            webView?.evaluateJavaScript("webkit.messageHandlers.bridge.onMessage('\(msg)')")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
