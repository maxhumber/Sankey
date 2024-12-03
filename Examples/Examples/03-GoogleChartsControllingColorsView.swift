@testable import Sankey
import SwiftUI

struct GoogleChartsControllingColorsView: View {
    let data = SankeyData(
        nodes: [
            SankeyNode("Brazil", color: .blue),
            SankeyNode("Portugal", color: .blue),
            SankeyNode("France", color: .green),
            SankeyNode("Spain", color: .green),
            SankeyNode("England", color: .red),
            SankeyNode("Canada", color: .red),
            SankeyNode("Mexico", color: .orange),
            SankeyNode("USA", color: .orange),
            SankeyNode("Angola", color: .purple),
            SankeyNode("Senegal", color: .purple),
            SankeyNode("Morocco", color: .yellow),
            SankeyNode("South Africa", color: .yellow),
            SankeyNode("Mali", color: .blue),
            SankeyNode("China", color: .blue),
            SankeyNode("India", color: .green),
            SankeyNode("Japan", color: .green)
        ],
        links: [
            SankeyLink(5, from: "Brazil", to: "Portugal"),
            SankeyLink(1, from: "Brazil", to: "France"),
            SankeyLink(1, from: "Brazil", to: "Spain"),
            SankeyLink(1, from: "Brazil", to: "England"),
            SankeyLink(1, from: "Canada", to: "Portugal"),
            SankeyLink(5, from: "Canada", to: "France"),
            SankeyLink(1, from: "Canada", to: "England"),
            SankeyLink(1, from: "Mexico", to: "Portugal"),
            SankeyLink(1, from: "Mexico", to: "France"),
            SankeyLink(5, from: "Mexico", to: "Spain"),
            SankeyLink(1, from: "Mexico", to: "England"),
            SankeyLink(1, from: "USA", to: "Portugal"),
            SankeyLink(1, from: "USA", to: "France"),
            SankeyLink(1, from: "USA", to: "Spain"),
            SankeyLink(5, from: "USA", to: "England"),
            SankeyLink(2, from: "Portugal", to: "Angola"),
            SankeyLink(1, from: "Portugal", to: "Senegal"),
            SankeyLink(1, from: "Portugal", to: "Morocco"),
            SankeyLink(3, from: "Portugal", to: "South Africa"),
            SankeyLink(1, from: "France", to: "Angola"),
            SankeyLink(3, from: "France", to: "Senegal"),
            SankeyLink(3, from: "France", to: "Mali"),
            SankeyLink(3, from: "France", to: "Morocco"),
            SankeyLink(1, from: "France", to: "South Africa"),
            SankeyLink(1, from: "Spain", to: "Senegal"),
            SankeyLink(3, from: "Spain", to: "Morocco"),
            SankeyLink(1, from: "Spain", to: "South Africa"),
            SankeyLink(1, from: "England", to: "Angola"),
            SankeyLink(1, from: "England", to: "Senegal"),
            SankeyLink(2, from: "England", to: "Morocco"),
            SankeyLink(7, from: "England", to: "South Africa"),
            SankeyLink(5, from: "South Africa", to: "China"),
            SankeyLink(1, from: "South Africa", to: "India"),
            SankeyLink(3, from: "South Africa", to: "Japan"),
            SankeyLink(5, from: "Angola", to: "China"),
            SankeyLink(1, from: "Angola", to: "India"),
            SankeyLink(3, from: "Angola", to: "Japan"),
            SankeyLink(5, from: "Senegal", to: "China"),
            SankeyLink(1, from: "Senegal", to: "India"),
            SankeyLink(3, from: "Senegal", to: "Japan"),
            SankeyLink(5, from: "Mali", to: "China"),
            SankeyLink(1, from: "Mali", to: "India"),
            SankeyLink(3, from: "Mali", to: "Japan"),
            SankeyLink(5, from: "Morocco", to: "China"),
            SankeyLink(1, from: "Morocco", to: "India"),
            SankeyLink(3, from: "Morocco", to: "Japan")
        ]
    )

    var body: some View {
        GeometryReader { geo in
            VStack {
                SankeyDiagram(data)
                    .nodePadding(6)
                    .nodeOpacity(0.6)
                    .linkColorMode(.sourceTarget)
                    .linkOpacity(0.3)
                    .labelFontSize(12)
                    .padding(10)
                    .frame(height: geo.size.height * 0.8)
                Link("Inspiration", destination: URL(string: "https://developers.google.com/chart/interactive/docs/gallery/sankey#controlling-colors")!)
            }
        }
    }
}

#Preview {
    GoogleChartsControllingColorsView()
}
