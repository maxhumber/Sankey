import Sankey
import SwiftUI

struct LabelPaddingView: View {
    let data = SankeyLink.countries
    
    var body: some View {
        diagram
            .navigationTitle("Label Padding")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private var diagram: some View {
        SankeyDiagram(
            data,
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
