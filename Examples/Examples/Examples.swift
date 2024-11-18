import SwiftUI
import Sankey

#Preview(traits: .landscapeRight) {
    SankeyDiagram(.preview)
}

#Preview {
    // Modern API usage
    @Previewable @State var sankeyData = SankeyData(
        nodes: [
            SankeyNode("a", color: Color.green.hex),
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
        // Modern usage
        SankeyDiagram(data: sankeyData)
            .nodeAlignment(.right)
            .nodeWidth(10)
            .nodeOpacity(0.7)
            .nodePadding(30)
            .linkColorMode(.sourceTarget)
            .linkOpacity(0.5)
            .labelFontSize(14)
            .labelFontFamily("Arial")
            .labelOpacity(0.3)
            .labelColor(Color.black.hex)
            .labelPadding(5)
            .frame(height: 200)
            .padding(5)
        
        Button("Update Data") {
            print(sankeyData)
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
