import Sankey
import SwiftUI

struct LabelPaddingView: View {
    var body: some View {
        SankeyDiagram(
            SankeyLink.countries,
            nodeLabelPadding: 30
        )
    }
}

struct CustomizingLabelPaddingView_Previews: PreviewProvider {
    static var previews: some View {
        LabelPaddingView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
