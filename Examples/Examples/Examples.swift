import Sankey
import SwiftUI

#Preview(traits: .landscapeRight) {
    SankeyDiagram(.preview)
}

#Preview(traits: .landscapeRight) {
    SankeyDiagram(.preview)
        .nodeAlignment(.right)
        .nodeWidth(20)
        .nodeColor(.red)
        .nodeOpacity(0.6)
        .linkColor(.blue)
        .linkOpacity(0.6)
        .frame(width: 500)
}

#Preview {
    @Previewable @State var sankeyData = SankeyData(
        nodes: [
            SankeyNode("a", color: .green),
            SankeyNode("b", label: "Toronto"),
            SankeyNode("c"),
            SankeyNode("d"),
            SankeyNode("e")
        ],
        links: [
            SankeyLink(200, from: "a", to: "b"),
            SankeyLink(100, from: "a", to: "c"),
            SankeyLink(200, from: "a", to: "d"),
            SankeyLink(100, from: "d", to: "e")
        ]
    )
    
    VStack {
        SankeyDiagram(data: sankeyData)
            .nodeAlignment(.justify)
            .nodeWidth(10)
            .nodeOpacity(0.7)
            .nodePadding(30)
            .linkColorMode(.sourceTarget)
            .linkOpacity(0.3)
            .labelFontSize(14)
            .labelFontFamily("Arial")
            .labelOpacity(0.3)
            .labelColor(.black)
            .labelPadding(5)
            .frame(height: 200)
            .padding(5)
        
        Button("Update Data") {
            print(sankeyData)
        }
    }
}
