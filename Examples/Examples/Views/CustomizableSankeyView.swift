import Sankey
import SwiftUI

struct CustomizableSankeyView: View {
    @State private var nodeAlignment: SankeyNodeAlignment = .justify
    @State private var nodeWidth: Double = 8
    @State private var nodeOpacity: Double = 0.6
    @State private var nodeColor: Color = .red
    @State private var nodePadding: Double = 24
    @State private var linkColorMode: SankeyLinkColorMode? = nil
    @State private var linkOpacity: Double = 0.2
    @State private var linkColor: Color = .gray
    @State private var labelFontSize: Double = 12
    @State private var labelFontFamily: String = "sans-serif"
    @State private var labelOpacity: Double = 0.8
    @State private var labelColor: Color = .black
    @State private var labelPadding: Double = 8
    
    let data = SankeyData(
        nodes: [
            SankeyNode("A", color: .blue),
            SankeyNode("B", color: .purple),
            SankeyNode("X"),
            SankeyNode("Y", color: .yellow),
            SankeyNode("Z", color: .green),
        ],
        links: [
            SankeyLink(5, from: "A", to: "X"),
            SankeyLink(7, from: "A", to: "Y"),
            SankeyLink(6, from: "A", to: "Z"),
            SankeyLink(2, from: "B", to: "X"),
            SankeyLink(9, from: "B", to: "Y", color: .blue),
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
            .nodeOpacity(nodeOpacity)
            .nodeColor(nodeColor)
            .nodePadding(nodePadding)
            .linkColorMode(linkColorMode)
            // linkColor should accept a color or an option
            // .linkColor(.sourceTarget)
            // .linkColor(.source)
            // .linkColor(.target)
            // .linkColor(.red.opacity(0.2))
            .linkOpacity(linkOpacity)
            .linkColor(linkColor)
            .labelFontSize(labelFontSize)
            .labelFontFamily(labelFontFamily)
            .labelOpacity(labelOpacity)
            .labelColor(labelColor)
            .labelPadding(labelPadding)
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
                Text("Node Width")
                Slider(value: $nodeWidth, in: 1...20)
            }
            HStack {
                Text("Node Opacity")
                Slider(value: $nodeOpacity, in: 0...1)
            }
            HStack {
                Text("Node Color")
                ColorPicker("", selection: $nodeColor)
                    .labelsHidden()
            }
            HStack {
                Text("Node Padding")
                Slider(value: $nodePadding, in: 0...50)
            }
            // Link Options
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
            HStack {
                Text("Link Opacity")
                Slider(value: $linkOpacity, in: 0...1)
            }
            HStack {
                Text("Link Color")
                ColorPicker("", selection: $linkColor)
                    .labelsHidden()
            }
            // Lable Options
            HStack {
                Text("Label Font Size")
                Slider(value: $labelFontSize, in: 8...24)
            }
            HStack {
                Text("Label Font Family")
                TextField("", text: $labelFontFamily)
            }
            HStack {
                Text("Label Opacity")
                Slider(value: $labelOpacity, in: 0...1)
            }
            HStack {
                Text("Label Color")
                ColorPicker("", selection: $labelColor)
                    .labelsHidden()
            }
            HStack {
                Text("Label Padding")
                Slider(value: $labelPadding, in: 0...20)
            }
        }
    }
}

#Preview {
    CustomizableSankeyView()
}