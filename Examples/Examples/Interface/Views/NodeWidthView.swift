import Sankey
import SwiftUI

struct NodeWidthView: View {
    let data = SankeyLink.countries
    
    var body: some View {
        diagram
            .navigationTitle("Node Width")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private var diagram: some View {
        SankeyDiagram(
            data,
            nodeWidth: 24
        )
    }
}

struct AdjustingNodeWidthView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NodeWidthView()
        }
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
