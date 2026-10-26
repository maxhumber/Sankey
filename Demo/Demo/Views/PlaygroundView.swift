import Sankey
import SwiftUI

struct PlaygroundView: View {
    @State private var selectedNodeID: String?
    @State private var nodeAlignment: SankeyNodeAlignment = .justify
    @State private var nodeWidth: Double = 8
    @State private var nodePadding: Double = 24
    @State private var nodeDefaultColor: Color = .primary.opacity(0.6)
    @State private var linkDefaultColor: Color = .primary
    @State private var linkOpacity: Double = 0.2
    @State private var linkColorMode: SankeyLinkColorMode? = nil
    @State private var labelPadding: Double = 8
    @State private var labelColor: Color = .primary
    @State private var labelFontSize: Double = 14

    let data = SankeyData(
        nodes: [
            SankeyNode("A", color: .blue),
            SankeyNode("B", color: .purple),
            SankeyNode("X", label: "Toronto"),
            SankeyNode("Y"),
            SankeyNode("Z", color: .green),
        ],
        links: [
            SankeyLink(5, from: "A", to: "X"),
            SankeyLink(7, from: "A", to: "Y"),
            SankeyLink(6, from: "A", to: "Z"),
            SankeyLink(2, from: "B", to: "X"),
            SankeyLink(9, from: "B", to: "Y", color: .orange),
            SankeyLink(4, from: "B", to: "Z"),
        ]
    )

    var body: some View {
        Form {
            Section {
                diagram
                    .frame(height: 250)
            } footer: {
                Text("Tap a node to highlight its flows.")
            }
            Section("Nodes") {
                Picker("Alignment", selection: $nodeAlignment) {
                    ForEach(SankeyNodeAlignment.allCases, id: \.self) { alignment in
                        Text(String(describing: alignment).capitalized)
                    }
                }
                LabeledContent("Padding") {
                    Slider(value: $nodePadding, in: 0...50)
                }
                LabeledContent("Width") {
                    Slider(value: $nodeWidth, in: 1...20)
                }
                ColorPicker("Default color", selection: $nodeDefaultColor)
            }
            Section("Links") {
                Picker("Color mode", selection: $linkColorMode) {
                    Text("None").tag(SankeyLinkColorMode?.none)
                    ForEach(SankeyLinkColorMode.allCases, id: \.self) { mode in
                        Text(String(describing: mode).capitalized)
                            .tag(Optional(mode))
                    }
                }
                LabeledContent("Opacity") {
                    Slider(value: $linkOpacity, in: 0...1)
                }
                ColorPicker("Default color", selection: $linkDefaultColor)
            }
            Section("Labels") {
                LabeledContent("Padding") {
                    Slider(value: $labelPadding, in: 0...20)
                }
                LabeledContent("Font size") {
                    Slider(value: $labelFontSize, in: 8...24)
                }
                ColorPicker("Color", selection: $labelColor)
            }
        }
    }

    private var diagram: some View {
        SankeyDiagram(data)
            .nodeSelection($selectedNodeID)
            .nodeAlignment(nodeAlignment)
            .nodeWidth(nodeWidth)
            .nodePadding(nodePadding)
            .nodeDefaultColor(nodeDefaultColor)
            .linkDefaultColor(linkDefaultColor)
            .linkOpacity(linkOpacity)
            .linkColorMode(linkColorMode)
            .labelPadding(labelPadding)
            .font(.system(size: labelFontSize))
            .foregroundStyle(labelColor)
    }
}

#Preview {
    PlaygroundView()
}
