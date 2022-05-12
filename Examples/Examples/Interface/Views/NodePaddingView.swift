import Sankey
import SwiftUI

struct NodePaddingView: View {
    let data = SankeyLink.countries
    
    var body: some View {
        diagram
            .navigationTitle("Node Padding")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private var diagram: some View {
        SankeyDiagram(
            data,
            nodePadding: 40
        )
    }
}

struct NodePaddingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NodePaddingView()
        }
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
