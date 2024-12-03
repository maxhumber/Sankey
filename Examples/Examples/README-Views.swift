import Sankey
import SwiftUI

struct QuickStartView: View {
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
        SankeyDiagram(data)
            .nodeOpacity(0.9)
            .linkColorMode(.gradient)
            .padding(10)
            .frame(height: 350)
    }
}

struct OldQuickStartView: View {
    // Create some data
    @State var data: [SankeyLink] = [
        // Option A: ExpressibleByArrayLiteral
        ["A", "X", "5"],
        ["A", "Y", "7"],
        ["A", "Z", "6"],
        ["B", "X", "2"],
        ["B", "Y", "9"],
        ["B", "Z", "4"]
    ]
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20) {
                Text("Sankeys in SwiftUI!")
                    .font(.title3.bold())
                    .padding(.top, 20)
                // Native SwiftUI Component
                SankeyDiagram(
                    data,
                    nodeLabelFontSize: 50,
                    nodeInteractivity: true,
                    linkColorMode: .gradient,
                    tooltipTextFontSize: 50
                )
                // Will take up full View, unless you constrain it...
                .frame(height: geo.size.height * 0.5)
                Button {
                    data.append(
                        // Option B: Struct
                        SankeyLink(source: "C", target: "X", value: 3)
                    )
                } label: {
                    Text("Add a new link")
                }
                Text("Lorem Ipsum...")
            }
        }
    }
}

struct UsageExampleView: View {
    let data = SankeyData(
        nodes: [
            SankeyNode("Design", color: .blue),
            SankeyNode("Development", color: .green),
            SankeyNode("Testing", color: .orange),
            SankeyNode("Frontend", color: .purple),
            SankeyNode("Backend", color: .red),
            SankeyNode("Mobile", label: "iOS"),
            SankeyNode("Production", label: "Prod", color: .mint)
        ],
        links: [
            SankeyLink(30, from: "Design", to: "Frontend", color: .blue),
            SankeyLink(20, from: "Design", to: "Mobile", color: .blue),
            SankeyLink(40, from: "Development", to: "Frontend", color: .green),
            SankeyLink(60, from: "Development", to: "Backend", color: .green),
            SankeyLink(30, from: "Development", to: "Mobile", color: .green),
            SankeyLink(25, from: "Testing", to: "Frontend", color: .orange),
            SankeyLink(35, from: "Testing", to: "Backend"),
            SankeyLink(15, from: "Testing", to: "Mobile"),
            SankeyLink(95, from: "Frontend", to: "Production", color: .purple),
            SankeyLink(95, from: "Backend", to: "Production", color: .red),
            SankeyLink(65, from: "Mobile", to: "Production", color: .yellow)
        ]
    )
    
    var body: some View {
        SankeyDiagram(data)
            // Node modifiers
            .nodeAlignment(.justify)
            .nodeWidth(15)
            .nodePadding(20)
            .nodeDefaultColor(.gray)
            .nodeOpacity(0.8)
            // Link modifiers
            .linkDefaultColor(.gray)
            .linkOpacity(0.7)
            .linkColorMode(nil)
            // Label modifiers
            .labelPadding(8)
            .labelColor(.primary)
            .labelOpacity(0.9)
            .labelFontSize(14)
            .labelFontFamily("Times")
            // Normal view modifiers
            .padding(10)
            .frame(height: 400)
    }
}

#Preview("QuickStart") {
    QuickStartView()
}

#Preview("OldQuickStart") {
    OldQuickStartView()
}

#Preview("Usage") {
    UsageExampleView()
        .preferredColorScheme(.dark)
}
