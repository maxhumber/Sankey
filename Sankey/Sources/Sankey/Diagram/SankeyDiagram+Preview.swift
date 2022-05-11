import SwiftUI

struct SankeyDiagram_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var links: [SankeyLink] = [
            ["A", "X", "5"],
            ["A", "Y", "7"],
            ["A", "Z", "6"],
            ["B", "X", "2"],
            ["B", "Y", "9"],
            ["B", "Z", "4"]
        ]
        
        var body: some View {
            GeometryReader { geo in
                VStack {
                    Button {
                        links.append(SankeyLink(source: "C", target: "X", value: 5))
                    } label: {
                        Text("Add one")
                    }
                    SankeyDiagram($links, nodeLabelFontSize: 40, linkColorMode: .source, tooltipTextFontSize: 40)
                        .frame(height: geo.size.height * 0.5)
                    Text("Hey")
                }
            }
        }
    }
}
