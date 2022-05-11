import Sankey
import SwiftUI

struct GradientLinksView: View {
    let colors = [
        "#a6cee3", "#b2df8a", "#fb9a99", "#fdbf6f",
        "#cab2d6", "#ffff99", "#1f78b4", "#33a02c"
    ]
    
    var body: some View {
        SankeyDiagram(
            SankeyLink.countries,
            nodeColors: colors,
            linkColors: colors,
            linkColorMode: .gradient
        )
    }
}

struct ControllingColors_Previews: PreviewProvider {
    static var previews: some View {
        GradientLinksView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

