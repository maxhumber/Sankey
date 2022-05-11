import Sankey
import SwiftUI

struct UniformColorView: View {
    var body: some View {
        SankeyDiagram(
            SankeyLink.countries,
            nodeColors: ["#a61d4c"],
            nodeLabelColor: "#871b47",
            linkColorFill: "#d799ae",
            linkColorFillOpacity: 0.8
        )
        .navigationTitle("Uniform Color")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UniformColorView_Previews: PreviewProvider {
    static var previews: some View {
        UniformColorView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
