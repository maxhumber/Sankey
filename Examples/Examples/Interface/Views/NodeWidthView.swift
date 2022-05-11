import Sankey
import SwiftUI

struct NodeWidthView: View {
    var body: some View {
        SankeyDiagram(
            SankeyLink.countries,
            nodeLabelFontSize: 24,
            nodeLabelPadding: 30
        )
    }
}

struct AdjustingNodeWidthView_Previews: PreviewProvider {
    static var previews: some View {
        NodeWidthView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
