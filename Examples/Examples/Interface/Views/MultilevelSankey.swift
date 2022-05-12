import Sankey
import SwiftUI

struct MultilevelSankey: View {
    let data = SankeyLink.countries
    
    var body: some View {
        diagram
            .navigationTitle("Multilevel Sankey")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private var diagram: some View {
        SankeyDiagram(data)
    }
}

struct MultilevelSankeyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MultilevelSankey()
        }
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
