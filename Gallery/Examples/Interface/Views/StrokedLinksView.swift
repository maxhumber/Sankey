import Sankey
import SwiftUI

struct StrokedLinksView: View {
    var body: some View {
        SankeyDiagram(
            SankeyLink.countries,
            nodeColors: ["#a61d4c"],
            nodeLabelFontSize: 24,
            linkColorStroke: "black",
            linkColorStrokeWidth: 1
        )
        .navigationTitle("Stroked Links")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StrokedLinksView_Previews: PreviewProvider {
    static var previews: some View {
        StrokedLinksView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
