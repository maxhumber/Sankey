import SwiftUI

@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            DemoHomeView()
        }
    }
}

struct DemoHomeView: View {
    var body: some View {
        NavigationStack {
            List(Page.allCases) { page in
                NavigationLink(page.rawValue, value: page)
            }
            .navigationTitle("Sankey Demo")
            .navigationDestination(for: Page.self) { page in
                Group {
                    switch page {
                    case .playground: PlaygroundView()
                    case .budget: BudgetView()
                    case .invalid: InvalidDataView()
                    }
                }
                .navigationTitle(page.rawValue)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

    private enum Page: String, CaseIterable, Identifiable {
        case playground = "Playground"
        case budget = "Budget"
        case invalid = "Invalid data"

        var id: String {
            rawValue
        }
    }
}

#Preview {
    DemoHomeView()
}
