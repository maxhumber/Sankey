import Sankey
import SwiftUI

struct NodePaddingView: View {
    var body: some View {
        SankeyDiagram(
            SankeyLink.countries,
            nodeWidth: 3
        )
        .navigationTitle("Node Padding")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NodePaddingView_Previews: PreviewProvider {
    static var previews: some View {
        NodePaddingView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
