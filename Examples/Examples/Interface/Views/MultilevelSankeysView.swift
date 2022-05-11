import Sankey
import SwiftUI

struct MultilevelSankeysView: View {
    var body: some View {
        SankeyDiagram(
            SankeyLink.countries,
            nodeLabelFontSize: 24,
            tooltipTextFontSize: 24
        )
    }
}

struct MultilevelSankeysView_Previews: PreviewProvider {
    static var previews: some View {
        MultilevelSankeysView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
