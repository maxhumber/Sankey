import Sankey
import SwiftUI

struct GradientColorsView: View {
    let colors = [
        "#a6cee3", "#b2df8a", "#fb9a99", "#fdbf6f",
        "#cab2d6", "#ffff99", "#1f78b4", "#33a02c"
    ]
    
    var body: some View {
        SankeyDiagram(
            SankeyLink.countries,
            nodeColors: colors,
            nodeLabelFontSize: 24,
            linkColors: colors,
            linkColorMode: .gradient,
            tooltipTextFontSize: 24
        )
    }
}

struct ControllingColors_Previews: PreviewProvider {
    static var previews: some View {
        GradientColorsView()
            .previewInterfaceOrientation(.landscapeLeft)



    }
}

