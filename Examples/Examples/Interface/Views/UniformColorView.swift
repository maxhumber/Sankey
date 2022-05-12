import Sankey
import SwiftUI

struct UniformColorView: View {
    let data = SankeyLink.countries
    
    var body: some View {
        diagram
            .navigationTitle("Uniform Color")
            .navigationBarTitleDisplayMode(.inline)
    }

    private var diagram: some View {
        SankeyDiagram(
            data,
            nodeColors: ["#a61d4c"],
            nodeLabelColor: "#871b47",
            linkColorFill: "#d799ae",
            linkColorFillOpacity: 0.8
        )
    }
}

struct UniformColorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UniformColorView()
        }
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
