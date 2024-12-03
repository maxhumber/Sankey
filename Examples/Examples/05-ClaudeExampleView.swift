import Sankey
import SwiftUI

struct ClaudeExampleView: View {
    let data = SankeyData(
        nodes: [
            SankeyNode("Design", color: .blue),
            SankeyNode("Development", color: .green),
            SankeyNode("Testing", color: .orange),
            SankeyNode("Frontend", color: .purple),
            SankeyNode("Backend", color: .red),
            SankeyNode("Mobile"),
            SankeyNode("Production", label: "Здоровʼя", color: .mint)
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
        VStack {
            SankeyDiagram(data)
                // Node modifiers
                .nodeAlignment(.justify)
                .nodeWidth(15)
                .nodePadding(20)
                .nodeDefaultColor(.gray)
                .nodeOpacity(0.8)
                // Link modifiers
                .linkDefaultColor(.gray.opacity(0.3))
                .linkOpacity(0.7)
                .linkColorMode(nil)
                // Label modifiers
                .labelPadding(8)
                .labelColor(.primary)
                .labelOpacity(0.9)
                .labelFontSize(14)
                .labelFontFamily("Times")
                .padding(10)
                .frame(height: 400)
            Text("Generated by Claude 3.5!")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ClaudeExampleView()
}