<div align="center">
  <img src="https://raw.githubusercontent.com/maxhumber/gif/master/logo/gif.png" width="250px" alt="gif">
</div>

### About

Sankey diagrams in SwiftUI, powered by [Google Charts](https://developers.google.com/chart)<sup>‡</sup>



### Quickstart

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

<img src="https://raw.githubusercontent.com/maxhumber/Sankey/master/Images/simple_sankey.png" alt="simple_sankey" width="500px" align="left">



- Multilevel Sankey | [Code](https://github.com/maxhumber/Sankey/blob/master/Examples/Examples/Interface/Views/MultilevelSankey.swift) | [Inspiration](https://developers.google.com/chart/interactive/docs/gallery/sankey#multilevel-sankeys)

```swift
SankeyDiagram(data)
```

<img src="https://raw.githubusercontent.com/maxhumber/Sankey/master/Images/multilevel_sankey.png" alt="multilevel_sankey" width="500px" align="left">



- Gradient Links | [Code](https://github.com/maxhumber/Sankey/blob/master/Examples/Examples/Interface/Views/GradientLinksView.swift) | [Inspiration](https://developers.google.com/chart/interactive/docs/gallery/sankey#controlling-colors)

```swift
let colors = [
    "#a6cee3", "#b2df8a", "#fb9a99", "#fdbf6f",
    "#cab2d6", "#ffff99", "#1f78b4", "#33a02c"
]	

SankeyDiagram(
    data,
    nodeColors: colors,
    linkColors: colors,
    linkColorMode: .gradient
)
```

<img src="https://raw.githubusercontent.com/maxhumber/Sankey/master/Images/gradient_links.png" alt="gradient_links" width="500px" align="left">



- Uniform Color | [Code](https://github.com/maxhumber/Sankey/blob/master/Examples/Examples/Interface/Views/UniformColorView.swift) | [Inspiration](https://developers.google.com/chart/interactive/docs/gallery/sankey#controlling-colors)

```swift
SankeyDiagram(
    data,
    nodeColors: ["#a61d4c"],
    nodeLabelColor: "#871b47",
    linkColorFill: "#d799ae",
    linkColorFillOpacity: 0.8
)
```

<img src="https://raw.githubusercontent.com/maxhumber/Sankey/master/Images/uniform_color.png" alt="uniform_color" width="500px" align="left">



- Stroked Links | [Code](https://github.com/maxhumber/Sankey/blob/master/Examples/Examples/Interface/Views/StrokedLinksView.swift) | [Inspiration](https://developers.google.com/chart/interactive/docs/gallery/sankey#controlling-colors)

```swift
SankeyDiagram(
    data,
    nodeColors: ["#a61d4c"],
    linkColorStroke: "black",
    linkColorStrokeWidth: 1
)
```

<img src="https://raw.githubusercontent.com/maxhumber/Sankey/master/Images/stroked_links.png" alt="stroked_links" width="500px" align="left">



- Label Style | [Code](https://github.com/maxhumber/Sankey/blob/master/Examples/Examples/Interface/Views/LabelStyleView.swift) | [Inspiration](https://developers.google.com/chart/interactive/docs/gallery/sankey#customizing-labels)

```swift
SankeyDiagram(
    data,
    nodeLabelColor: "#871b47",
    nodeLabelFontSize: 32,
    nodeLabelFontName: "Times-Roman",
    nodeLabelBold: true,
    nodeLabelItalic: true
)
```

<img src="https://raw.githubusercontent.com/maxhumber/Sankey/master/Images/label_style.png" alt="label_style" width="500px" align="left">



- Label Padding | [Code](https://github.com/maxhumber/Sankey/blob/master/Examples/Examples/Interface/Views/LabelPaddingView.swift) | [Inspiration](https://developers.google.com/chart/interactive/docs/gallery/sankey#customizing-labels)

```swift
SankeyDiagram(
    data,
    nodeLabelPadding: 30
)
```

<img src="https://raw.githubusercontent.com/maxhumber/Sankey/master/Images/label_padding.png" alt="label_padding" width="500px" align="left">



- Node Width | [Code](https://github.com/maxhumber/Sankey/blob/master/Examples/Examples/Interface/Views/NodeWidthView.swift) | [Inspiration](https://developers.google.com/chart/interactive/docs/gallery/sankey#adjusting-nodes)

```swift
SankeyDiagram(
    data,
    nodeWidth: 24
)
```

<img src="https://raw.githubusercontent.com/maxhumber/Sankey/master/Images/node_width.png" alt="node_width" width="500px" align="left">



- Node Padding | [Code](https://github.com/maxhumber/Sankey/blob/master/Examples/Examples/Interface/Views/NodePaddingView.swift) | [Inspiration](https://developers.google.com/chart/interactive/docs/gallery/sankey#adjusting-nodes)

```swift
SankeyDiagram(
    data,
    nodePadding: 40
)
```

<img src="https://raw.githubusercontent.com/maxhumber/Sankey/master/Images/node_padding.png" alt="node_padding" width="500px" align="left">



- Data | [Code](https://github.com/maxhumber/Sankey/blob/master/Examples/Examples/Data/SankeyLink%2Bcountries.swift) | [Inspiration](https://developers.google.com/chart/interactive/docs/gallery/sankey#data-format)

```swift
let data: [SankeyLink] = [
    ["Brazil", "Portugal", "5"],
    ["Brazil", "France", "1"],
    ["Brazil", "Spain", "1"],
    ["Brazil", "England", "1"],
    ["Canada", "Portugal", "1"],
    ["Canada", "France", "5"],
    ["Canada", "England", "1"],
    ["Mexico", "Portugal", "1"],
    ["Mexico", "France", "1"],
    ["Mexico", "Spain", "5"],
    ["Mexico", "England", "1"],
    ["USA", "Portugal", "1"],
    ["USA", "France", "1"],
    ["USA", "Spain", "1"],
    ["USA", "England", "5"],
    ["Portugal", "Angola", "2"],
    ["Portugal", "Senegal", "1"],
    ["Portugal", "Morocco", "1"],
    ["Portugal", "South Africa", "3"],
    ["France", "Angola", "1"],
    ["France", "Senegal", "3"],
    ["France", "Mali", "3"],
    ["France", "Morocco", "3"],
    ["France", "South Africa", "1"],
    ["Spain", "Senegal", "1"],
    ["Spain", "Morocco", "3"],
    ["Spain", "South Africa", "1"],
    ["England", "Angola", "1"],
    ["England", "Senegal", "1"],
    ["England", "Morocco", "2"],
    ["England", "South Africa", "7"],
    ["South Africa", "China", "5"],
    ["South Africa", "India", "1"],
    ["South Africa", "Japan", "3"],
    ["Angola", "China", "5"],
    ["Angola", "India", "1"],
    ["Angola", "Japan", "3"],
    ["Senegal", "China", "5"],
    ["Senegal", "India", "1"],
    ["Senegal", "Japan", "3"],
    ["Mali", "China", "5"],
    ["Mali", "India", "1"],
    ["Mali", "Japan", "3"],
    ["Morocco", "China", "5"],
    ["Morocco", "India", "1"],
    ["Morocco", "Japan", "3"]
]
```



### API

Optional `SankeyDiagram(data, ...)` styling arguments :

| Argument:              | Default                                         | Description                                                  |
| ---------------------- | ----------------------------------------------- | ------------------------------------------------------------ |
| `nodeColors`           | `[String]? = nil`                               | Custom color (hexcodes) palette to cycle through for sankey nodes |
| `nodeColorMode`        | `SankeyOptions.Sankey.Node.ColorMode = .unique` | Coloring mode for the sankey nodes                           |
| `nodeWidth`            | `Double? = nil`                                 | Thickness of the node                                        |
| `nodePadding`          | `Double? = nil`                                 | Vertical distance between nodes                              |
| `nodeLabelColor`       | `String = "black"`                              | Node label color (hexcode/html)                              |
| `nodeLabelFontSize`    | `Double = 24`                                   | Node label font size (pixels)                                |
| `nodeLabelFontName`    | `String? = nil`                                 | Node label font name                                         |
| `nodeLabelBold`        | `Bool = false`                                  | Bold node label                                              |
| `nodeLabelItalic`      | `Bool = false`                                  | Italicize node label                                         |
| `nodeLabelPadding`     | `Double? = nil`                                 | Horizontal distance between the label and the node           |
| `nodeInteractivity`    | `Bool = false`                                  | Allow users to select node                                   |
| `linkColors`           | `[String]? = nil`                               | Custom color (hexcode) palette to cycle through for sankey links |
| `linkColorMode`        | `SankeyOptions.Sankey.Link.ColorMode? = nil`    | Coloring mode for the links between nodes (this option will override any linkColor+ argument) |
| `linkColorFill`        | `String? = nil`                                 | Color of the link                                            |
| `linkColorFillOpacity` | `Double? = nil`                                 | Transparency of the link                                     |
| `linkColorStroke`      | `String? = nil`                                 | Color of the link border                                     |
| `linkColorStrokeWidth` | `Double = 0`                                    | Thickness of the link border                                 |
| `tooltipValueLabel`    | `String = ""`                                   | Name of the link value to be displayed in the tooltip        |
| `tooltipTextColor`     | `String = "black"`                              | Tooltip text color (html/hexcode)                            |
| `tooltipTextFontSize`  | `Double = 24`                                   | Tooltip text font size (pixels)                              |
| `tooltipTextFontName`  | `String? = nil`                                 | Tooltip text font name                                       |
| `tooltipTextBold`      | `Bool = false`                                  | Bold tooltip label text                                      |
| `tooltipTextItalic`    | `Bool = false`                                  | Italicize tooltip label text                                 |
| `layoutIterations`     | `Int = 32`                                      | D3 layout engine layout search attempts to find the most optimal node positions (increasing this number may lead to more pleasing layouts of complex sankeys, at some cost) |

For more information see [configuration options](https://developers.google.com/chart/interactive/docs/gallery/sankey#configuration-options) 



### Swift Package Manager

Add to your project with:

```swift
dependencies: [
    .package(url: "https://github.com/maxhumber/Sankey.git", .upToNextMajor(from: "1.0"))
]
```



### Fine Print

<sup>‡ Active network connection required</sup>
