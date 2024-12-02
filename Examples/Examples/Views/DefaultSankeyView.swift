import Sankey
import SwiftUI

struct DefaultSankeyView: View {
//    let data: SankeyData = SankeyData(
//        nodes: [SankeyNode("X")],
//        links: [SankeyLink(110, from: "Z", to: "D")]
//    )
    let data: SankeyData = .preview
    
    var body: some View {
        SankeyDiagram(data) {
            EmptyView()
        } failure: { error in
            Text(error.localizedDescription)
        }
    }
}

#Preview {
    DefaultSankeyView()
        .padding(10)
        .frame(height: 250)
}
