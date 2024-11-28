import Sankey
import SwiftUI

struct DefaultSankeyView: View {
    let data: SankeyData = .preview
    
    var body: some View {
        SankeyDiagram(data: data)
    }
}

#Preview {
    DefaultSankeyView()
        .padding(10)
        .frame(height: 250)
}
