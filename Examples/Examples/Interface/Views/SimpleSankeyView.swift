import Sankey
import SwiftUI

struct SimpleSankeyView: View {
    var body: some View {
        diagram
            .navigationTitle("Simple Sankey")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private var diagram: some View {
        SankeyDiagram([
            ["A", "X", "5"],
            ["A", "Y", "7"],
            ["A", "Z", "6"],
            ["B", "X", "2"],
            ["B", "Y", "9"],
            ["B", "Z", "4"]
        ])
    }
}

struct SimpleSankeyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SimpleSankeyView()
        }
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
