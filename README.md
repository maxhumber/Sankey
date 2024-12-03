<div align="center">
  <img src="Images/logo.png" width="150px" alt="logo">
</div>

#### About

Sankey diagrams in SwiftUI, powered by [D3](https://github.com/d3/d3-sankey).

#### Quickstart

Make interactive charts like this:

  <img src="https://raw.githubusercontent.com/maxhumber/Sankey/master/Images/quickstart.png" width="250px" alt="quickstart">



With code as simple as this:

```swift
import Sankey
import SwiftUI

struct ReadMeView: View {
    // Create some data
    @State var data: [SankeyLink] = [
        // Option A: ExpressibleByArrayLiteral
        ["A", "X", "5"],
        ["A", "Y", "7"],
        ["A", "Z", "6"],
        ["B", "X", "2"],
        ["B", "Y", "9"],
        ["B", "Z", "4"]
    ]

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20) {
                Text("Sankeys in SwiftUI!")
                    .font(.title3.bold())
                    .padding(.top, 20)
                // Native SwiftUI Component
                SankeyDiagram(
                    data,
                    nodeLabelFontSize: 50,
                    nodeInteractivity: true,
                    linkColorMode: .gradient,
                    tooltipTextFontSize: 50
                )
                // Will take up full View, unless you constrain it...
                .frame(height: geo.size.height * 0.5)
                Button {
                    data.append(
                        // Option B: Struct
                        SankeyLink(source: "C", target: "X", value: 3)
                    )
                } label: {
                    Text("Add a new link")
                }
                Text("Lorem Ipsum...")
            }
        }
    }
}
```



### Examples

Inspired by the examples in the Google Charts [Gallery](https://developers.google.com/chart/interactive/docs/gallery/sankey)



- Simple Sankey | [Code](https://github.com/maxhumber/Sankey/blob/master/Examples/Examples/Interface/Views/SimpleSankeyView.swift) | [Inspiration](https://developers.google.com/chart/interactive/docs/gallery/sankey#a-simple-example)

```swift
SankeyDiagram([
    ["A", "X", "5"],
    ["A", "Y", "7"],
    ["A", "Z", "6"],
    ["B", "X", "2"],
    ["B", "Y", "9"],
    ["B", "Z", "4"]
])
```

<img src="https://raw.githubusercontent.com/maxhumber/Sankey/master/Images/simple_sankey.png" alt="simple_sankey" width="500px">



### Swift Package Manager

Add to your project with:

```swift
dependencies: [
    .package(url: "https://github.com/maxhumber/Sankey.git", .upToNextMajor(from: "1.0"))
]
```
