import Sankey
import SwiftUI

struct StrokedLinksView: View {
    let data = SankeyLink.countries
    
    var body: some View {
        diagram
            .navigationTitle("Stroked Links")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private var diagram: some View {
        SankeyDiagram(
            data,
            nodeColors: ["#a61d4c"],
            nodeLabelFontSize: 24,
            linkColorStroke: "black",
            linkColorStrokeWidth: 1
        )
    }
}

struct StrokedLinksView_Previews: PreviewProvider {
    static var previews: some View {
        StrokedLinksView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
