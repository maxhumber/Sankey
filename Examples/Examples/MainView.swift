import SwiftUI

enum Page: String, CaseIterable, Identifiable {
    case first = "First Page"
    case second = "Second Page"
    case third = "Third Page"
    case fourth = "Fourth Page"
    case fifth = "Fifth Page"
    
    var id: String { rawValue }
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
                case .second: RussianView()
                case .third: CustomizableSankeyView()
                default: Text(page.id)
                }
            }
        }
    }
}

#Preview {
    MainView()
}
