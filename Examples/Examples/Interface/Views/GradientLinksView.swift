import Sankey
import SwiftUI

struct GradientLinksView: View {
    let data = SankeyLink.countries
    
    let colors = [
        "#a6cee3", "#b2df8a", "#fb9a99", "#fdbf6f",
        "#cab2d6", "#ffff99", "#1f78b4", "#33a02c"
    ]
    
    var body: some View {
        diagram
            .navigationTitle("Gradient Links")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private var diagram: some View {
        SankeyDiagram(
            data,
            nodeColors: colors,
            linkColors: colors,
            linkColorMode: .gradient
        )
    }
}

struct GradientLinksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GradientLinksView()
        }
        .previewInterfaceOrientation(.landscapeLeft)
    }
}

