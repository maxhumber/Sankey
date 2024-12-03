import SwiftUI

@main
struct ExamplesApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

enum Page: String, CaseIterable, Identifiable {
    case first = "Default Example"
    case second = "Google Charts Simple Example"
    case third = "Google Charts Colors Example"
    case fourth = "D3 Sankey-o-Matic Example"
    case fifth = "Claude 3.5 Example"
    case sixth = "Customizable Example"
    
    var id: String {
        rawValue
    }
}

struct MainView: View {
    @State private var path = [Page]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(Page.allCases) { page in
                Button(page.rawValue) {
                    path.append(page)
                }
            }
            .navigationTitle("Examples")
            .navigationDestination(for: Page.self) { page in
                switch page {
                case .first: DefaultSankeyView()
                case .second: GoogleChartsSimpleExampleView()
                case .third: GoogleChartsControllingColorsView()
                case .fourth: D3FlowOMaticView()
                case .fifth: ClaudeExampleView()
                case .sixth: CustomizableView()
                }
            }
        }
    }
}

#Preview {
    MainView()
}
