import Sankey
import SwiftUI

struct DefaultSankeyView: View {
    let data = SankeyData(
        nodes: [
            SankeyNode("A"),
            SankeyNode("B"),
            SankeyNode("X"),
            SankeyNode("Y"),
            SankeyNode("Z")
        ],
        links: [
            SankeyLink(5, from: "A", to: "X"),
            SankeyLink(7, from: "A", to: "Y"),
            SankeyLink(6, from: "A", to: "Z"),
            SankeyLink(2, from: "B", to: "X"),
            SankeyLink(9, from: "B", to: "Y"),
            SankeyLink(4, from: "B", to: "Z")
        ]
    )
    
    var body: some View {
        SankeyDiagram(data)
            .padding(10)
            .frame(height: 250)
    }
}

#Preview {
    DefaultSankeyView()
}
