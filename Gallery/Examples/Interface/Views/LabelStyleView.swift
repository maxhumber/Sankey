import Sankey
import SwiftUI

struct LabelStyleView: View {
    var body: some View {
        SankeyDiagram(
            SankeyLink.countries,
            nodeLabelColor: "#871b47",
            nodeLabelFontSize: 24,
            nodeLabelFontName: "Times-Roman",
            nodeLabelBold: true,
            nodeLabelItalic: true
        )
        .navigationTitle("Label Style")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CustomizingLabelsView_Previews: PreviewProvider {
    static var previews: some View {
        LabelStyleView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

