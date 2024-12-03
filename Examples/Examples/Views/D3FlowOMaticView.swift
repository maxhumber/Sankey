// https://observablehq.com/@mbostock/flow-o-matic

@testable import Sankey
import SwiftUI

struct D3FlowOMaticView: View {
    let data = SankeyData(
        nodes: [
            SankeyNode("Berlin", label: "Berlin 102"),
            SankeyNode("Barcelona", label: "Barcelona 39"),
            SankeyNode("Madrid", label: "Madrid 35"),
            SankeyNode("Amsterdam", label: "Amsterdam 15"),
            SankeyNode("Paris", label: "Paris 14"),
            SankeyNode("London", label: "London 6"),
            SankeyNode("Munich", label: "Munich 5"),
            SankeyNode("Brussels", label: "Brussels 4"),
            SankeyNode("Dubai", label: "Dubai 3"),
            SankeyNode("Dublin", label: "Dublin 3"),
            SankeyNode("Other Cities", label: "Other Cities 12"),
            SankeyNode("Job Applications", label: "Job Applications 238"),
            SankeyNode("No Response", label: "No Response 189"),
            SankeyNode("Responded", label: "Responded 49"),
            SankeyNode("Rejected", label: "Rejected 38"),
            SankeyNode("Interviewed", label: "Interviewed 11"),
            SankeyNode("No Offer", label: "No Offer 8"),
            SankeyNode("Declined Offer", label: "Declined Offer 2"),
            SankeyNode("Accepted Offer", label: "Accepted Offer 1")
        ],
        links: [
            SankeyLink(102, from: "Berlin", to: "Job Applications"),
            SankeyLink(39, from: "Barcelona", to: "Job Applications"),
            SankeyLink(35, from: "Madrid", to: "Job Applications"),
            SankeyLink(15, from: "Amsterdam", to: "Job Applications"),
            SankeyLink(14, from: "Paris", to: "Job Applications"),
            SankeyLink(6, from: "London", to: "Job Applications"),
            SankeyLink(5, from: "Munich", to: "Job Applications"),
            SankeyLink(4, from: "Brussels", to: "Job Applications"),
            SankeyLink(3, from: "Dubai", to: "Job Applications"),
            SankeyLink(3, from: "Dublin", to: "Job Applications"),
            SankeyLink(12, from: "Other Cities", to: "Job Applications"),
            SankeyLink(189, from: "Job Applications", to: "No Response"),
            SankeyLink(49, from: "Job Applications", to: "Responded", color: .orange),
            SankeyLink(38, from: "Responded", to: "Rejected"),
            SankeyLink(11, from: "Responded", to: "Interviewed", color: .orange),
            SankeyLink(8, from: "Interviewed", to: "No Offer"),
            SankeyLink(2, from: "Interviewed", to: "Declined Offer"),
            SankeyLink(1, from: "Interviewed", to: "Accepted Offer", color: .orange)
        ]
    )

    var body: some View {
        SankeyDiagram(data)
            .nodePadding(4)
            .nodeDefaultColor(Color(hex: "#999999"))
            .nodeOpacity(0.9)
            .linkDefaultColor(Color(hex: "#BBBBBB"))
            .linkOpacity(0.8)
            .labelFontSize(10)
            .padding(10)
            .frame(height: 600)
    }
}

#Preview {
    D3FlowOMaticView()
}
