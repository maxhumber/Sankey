import Sankey
import SwiftUI

struct CustomizableView: View {
    @State private var nodeAlignment: SankeyNodeAlignment = .justify
    @State private var nodeWidth: Double = 8
    @State private var nodePadding: Double = 24
    @State private var nodeDefaultColor: Color = .red
    @State private var nodeOpacity: Double = 0.6
    @State private var linkDefaultColor: Color = .gray
    @State private var linkOpacity: Double = 0.2
    @State private var linkColorMode: SankeyLinkColorMode? = nil
    @State private var labelPadding: Double = 8
    @State private var labelColor: Color = .primary
    @State private var labelOpacity: Double = 0.8
    @State private var labelFontSize: Double = 14
    @State private var labelFontFamily: String = "Times"
    
    let data = SankeyData(
        nodes: [
            SankeyNode("A", color: .primary),
            SankeyNode("B", color: .blue),
            SankeyNode("X", label: "Toronto"),
            SankeyNode("Y"),
            SankeyNode("Z", color: .green),
        ],
        links: [
            SankeyLink(5, from: "A", to: "X"),
            SankeyLink(7, from: "A", to: "Y"),
            SankeyLink(6, from: "A", to: "Z"),
            SankeyLink(2, from: "B", to: "X"),
            SankeyLink(9, from: "B", to: "Y", color: .primary),
            SankeyLink(4, from: "B", to: "Z"),
        ]
    )
    
    var body: some View {
        ScrollView {
            VStack {
                diagram
                    .frame(height: 250)
                options
            }
            .padding(10)
        }
        .scrollIndicators(.hidden)
    }
    
    private var diagram: some View {
        SankeyDiagram(data)
            .nodeAlignment(nodeAlignment)
            .nodeWidth(nodeWidth)
            .nodePadding(nodePadding)
            .nodeDefaultColor(nodeDefaultColor)
            .nodeOpacity(nodeOpacity)
            .linkDefaultColor(linkDefaultColor)
            .linkOpacity(linkOpacity)
            .linkColorMode(linkColorMode)
            .labelPadding(labelPadding)
            .labelColor(labelColor)
            .labelOpacity(labelOpacity)
            .labelFontSize(labelFontSize)
            .labelFontFamily(labelFontFamily)
    }
    
    private var options: some View {
        VStack(alignment: .leading) {
            // Node Options
            HStack {
                Text("Node Alignment")
                Picker("Alignment", selection: $nodeAlignment) {
                    Text("Left").tag(SankeyNodeAlignment.left)
                    Text("Right").tag(SankeyNodeAlignment.right)
                    Text("Center").tag(SankeyNodeAlignment.center)
                    Text("Justify").tag(SankeyNodeAlignment.justify)
                }
                .labelsHidden()
            }
            HStack {
                Text("Node Padding")
                Slider(value: $nodePadding, in: 0...50)
            }
            HStack {
                Text("Node Width")
                Slider(value: $nodeWidth, in: 1...20)
            }
            HStack {
                Text("Node Opacity")
                Slider(value: $nodeOpacity, in: 0...1)
            }
            HStack {
                Text("Node Default Color")
                ColorPicker("", selection: $nodeDefaultColor)
                    .labelsHidden()
            }
            // Link Options
            HStack {
                Text("Link Default Color")
                ColorPicker("", selection: $linkDefaultColor)
                    .labelsHidden()
            }
            HStack {
                Text("Link Opacity")
                Slider(value: $linkOpacity, in: 0...1)
            }
            HStack {
                Text("Link Color Mode")
                Picker("Color Mode", selection: $linkColorMode) {
                    Text("None").tag(SankeyLinkColorMode?.none)
                    Text("Source").tag(SankeyLinkColorMode.source)
                    Text("Target").tag(SankeyLinkColorMode.target)
                    Text("Source-Target").tag(SankeyLinkColorMode.sourceTarget)
                }
                .labelsHidden()
            }
            // Label Options
            HStack {
                Text("Label Padding")
                Slider(value: $labelPadding, in: 0...20)
            }
            HStack {
                Text("Label Color")
                ColorPicker("", selection: $labelColor)
                    .labelsHidden()
            }
            HStack {
                Text("Label Opacity")
                Slider(value: $labelOpacity, in: 0...1)
            }
            HStack {
                Text("Label Font Size")
                Slider(value: $labelFontSize, in: 8...24)
            }
            HStack {
                Text("Label Font Family")
                TextField("", text: $labelFontFamily)
            }
        }
    }
}

#Preview {
    CustomizableView()
}
