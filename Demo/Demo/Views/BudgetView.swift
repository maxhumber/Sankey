import Sankey
import SwiftUI

struct BudgetView: View {
    let data = SankeyData(
        nodes: [
            SankeyNode("salary", label: "Salary $5,000", color: .blue),
            SankeyNode("freelance", label: "Freelance $1,000", color: .blue),
            SankeyNode("income", label: "Income $6,000", color: .blue),
            SankeyNode("housing", label: "Housing $2,000", color: .orange),
            SankeyNode("food", label: "Food $800", color: .orange),
            SankeyNode("transport", label: "Transport $400", color: .orange),
            SankeyNode("fun", label: "Fun $600", color: .orange),
            SankeyNode("savings", label: "Savings $2,200", color: .green),
            SankeyNode("investing", label: "Investing $1,500", color: .green),
            SankeyNode("emergency", label: "Emergency $700", color: .green),
        ],
        links: [
            SankeyLink(5000, from: "salary", to: "income"),
            SankeyLink(1000, from: "freelance", to: "income"),
            SankeyLink(2000, from: "income", to: "housing"),
            SankeyLink(800, from: "income", to: "food"),
            SankeyLink(400, from: "income", to: "transport"),
            SankeyLink(600, from: "income", to: "fun"),
            SankeyLink(2200, from: "income", to: "savings"),
            SankeyLink(1500, from: "savings", to: "investing"),
            SankeyLink(700, from: "savings", to: "emergency"),
        ]
    )

    var body: some View {
        SankeyDiagram(data)
            .nodeWidth(10)
            .nodePadding(12)
            .linkColorMode(.gradient)
            .linkOpacity(0.35)
            .font(.caption.weight(.medium))
            .lineLimit(2)
            .padding(16)
    }
}

#Preview {
    BudgetView()
}
