import Sankey
import SwiftUI

struct GoogleChartsSimpleExampleView: View {
    @State var colorMode: SankeyLinkColorMode? = nil
    
    let data = SankeyData(
        nodes: [
            SankeyNode("A", color: .blue),
            SankeyNode("B", color: .purple),
            SankeyNode("X", color: .red),
            SankeyNode("Y", color: .yellow),
            SankeyNode("Z", color: .green),
        ],
        links: [
            SankeyLink(5, from: "A", to: "X"),
            SankeyLink(7, from: "A", to: "Y"),
            SankeyLink(6, from: "A", to: "Z"),
            SankeyLink(2, from: "B", to: "X"),
            SankeyLink(9, from: "B", to: "Y"),
            SankeyLink(4, from: "B", to: "Z"),
        ]
    )
    
    var body: some View {
        VStack(spacing: 10) {
            SankeyDiagram(data)
                .nodeOpacity(0.9)
                .linkColorMode(colorMode)
                .padding(10)
                .frame(height: 350)
            Button {
                if colorMode == nil {
                    colorMode = .sourceTarget
                } else if colorMode == .sourceTarget {
                    colorMode = nil
                }
            } label: {
                Text("Toggle Colors")
            }
            Link("Inspiration", destination: URL(string:  "https://developers.google.com/chart/interactive/docs/gallery/sankey")!)
        }
    }
}

#Preview {
    GoogleChartsSimpleExampleView()
}
