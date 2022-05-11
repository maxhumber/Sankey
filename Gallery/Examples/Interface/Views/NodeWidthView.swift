import Sankey
import SwiftUI

struct NodeWidthView: View {
    var body: some View {
        SankeyDiagram(
            SankeyLink.countries,
            nodePadding: 40
        )
        .navigationTitle("Node Width")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AdjustingNodeWidthView_Previews: PreviewProvider {
    static var previews: some View {
        NodeWidthView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
