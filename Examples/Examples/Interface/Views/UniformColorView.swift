import Sankey
import SwiftUI

struct UniformColorView: View {
    var body: some View {
        SankeyDiagram(
            SankeyLink.countries,
            nodeColors: ["#a61d4c"],
            nodeLabelColor: "#871b47",
            nodeLabelFontSize: 24,
            linkColorFill: "#d799ae",
            linkColorFillOpacity: 0.8,
            tooltipTextFontSize: 24
        )
    }
}

struct UniformColorView_Previews: PreviewProvider {
    static var previews: some View {
        UniformColorView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
