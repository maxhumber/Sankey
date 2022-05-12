import Sankey
import SwiftUI

struct LabelStyleView: View {
    let data = SankeyLink.countries
    
    var body: some View {
        diagram
            .navigationTitle("Label Style")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private var diagram: some View {
        SankeyDiagram(
            data,
            nodeLabelColor: "#871b47",
            nodeLabelFontSize: 32,
            nodeLabelFontName: "Times-Roman",
            nodeLabelBold: true,
            nodeLabelItalic: true
        )
    }
}

struct CustomizingLabelsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LabelStyleView()
        }
        .previewInterfaceOrientation(.landscapeLeft)
    }
}

