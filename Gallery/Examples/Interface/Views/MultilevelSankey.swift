import Sankey
import SwiftUI

struct MultilevelSankey: View {
    var body: some View {
        SankeyDiagram(SankeyLink.countries)
            .navigationTitle("Multilevel Sankey")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct MultilevelSankeyView_Previews: PreviewProvider {
    static var previews: some View {
        MultilevelSankey()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
