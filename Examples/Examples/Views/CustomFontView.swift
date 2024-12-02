import SwiftUI
import WebKit

// Step 1: Create a UIViewRepresentable for WKWebView
struct HTMLView: UIViewRepresentable {
    let text: String
    var font: UIFont = UIFont.systemFont(ofSize: 16)
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // Step 2: Generate HTML content
        let htmlContent = """
        <!doctype html>
        <html>
        <head>
            <meta charset="utf-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style>
                @font-face {
                    font-family: '\(font.fontName)';
                    src: url('\(font.fontName).ttf') format('truetype');
                }
                body {
                    font-family: '\(font.fontName)', -apple-system, BlinkMacSystemFont, sans-serif;
                    font-size: \(font.pointSize)px;
                    text-align: center;
                    margin: 0;
                    padding: 20px;
                }
            </style>
        </head>
        <body>
            \(text)
        </body>
        </html>
        """
        // Load HTML content with baseURL to access local resources
        webView.loadHTMLString(htmlContent, baseURL: Bundle.main.bundleURL)
    }
    
    func labelFont(_ name: String, size: Double) -> HTMLView {
        var new = self
        if let font = UIFont(name: name, size: size) {
            new.font = font
        }
        return new
    }
    
    // .labelFont(.system, size: 16)
    // .labelFont(.custom("LobsterTwo.ttf"), size: 16)
}

// Step 3: Implement the SwiftUI View
struct ContentView: View {
    var body: some View {
        HTMLView(text: "Hello world")
            .labelFont("Papyrus", size: 36)
            .frame(height: 100)
    }
}

#Preview {
    ContentView()
}
