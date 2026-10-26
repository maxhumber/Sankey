import Sankey
import SwiftUI

struct InvalidDataView: View {
    @State private var problem = Problem.circular

    var body: some View {
        Form {
            Section {
                SankeyDiagram(problem.data)
                    .frame(height: 250)
            } footer: {
                Text("Data that can't be laid out shows \"Diagram unavailable\" instead of crashing.")
            }
            Picker("Problem", selection: $problem) {
                ForEach(Problem.allCases) { problem in
                    Text(problem.rawValue)
                }
            }
        }
    }

    private enum Problem: String, CaseIterable, Identifiable {
        case circular = "Circular link"
        case duplicate = "Duplicate node"
        case missing = "Missing node"
        case negative = "Negative value"
        case noLinks = "No links"

        var id: Self {
            self
        }

        var data: SankeyData {
            let nodes = [SankeyNode("A"), SankeyNode("B")]
            switch self {
            case .circular:
                return SankeyData(
                    nodes: nodes,
                    links: [SankeyLink(5, from: "A", to: "B"), SankeyLink(3, from: "B", to: "A")]
                )
            case .duplicate:
                return SankeyData(
                    nodes: nodes + [SankeyNode("A")], links: [SankeyLink(5, from: "A", to: "B")]
                )
            case .missing:
                return SankeyData(nodes: nodes, links: [SankeyLink(5, from: "A", to: "C")])
            case .negative:
                return SankeyData(nodes: nodes, links: [SankeyLink(-5, from: "A", to: "B")])
            case .noLinks:
                return SankeyData(nodes: nodes, links: [])
            }
        }
    }
}

#Preview {
    InvalidDataView()
}
