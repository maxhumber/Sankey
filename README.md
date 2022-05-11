<div align="center">
  <img src="https://raw.githubusercontent.com/maxhumber/gif/master/logo/gif.png" width="250px" alt="gif">
</div>

### About

Sankey diagrams in SwiftUI, powered by [Google Charts](https://developers.google.com/chart)



### Quickstart

Copy and paste this:

```swift
import Sankey
import SwiftUI

struct ReadMeView: View {
    // Create some data
    @State var data: [SankeyLink] = [
        // Option A: ExpressibleByArrayLiteral init
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
                // Native SwiftUI component
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
                        // Option B: Normal init
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



To make this:

  <img src="/Users/max/Repos/Sankey/Images/quickstart.png" width="250px" alt="gif">



### API

Optional styling for `SankeyDiagram(data, ...)`:

| Argument:              | Default                                         | Description                                                  |
| ---------------------- | ----------------------------------------------- | ------------------------------------------------------------ |
| `nodeColors`           | `[String]? = nil`                               | Custom color (hexcodes) palette to cycle through for sankey nodes |
| `nodeColorMode`        | `SankeyOptions.Sankey.Node.ColorMode = .unique` | Coloring mode for the sankey nodes                           |
| `nodeWidth`            | `Double? = nil`                                 | Thickness of the node                                        |
| `nodePadding`          | `Double? = nil`                                 | Vertical distance between nodes                              |
| `nodeLabelColor`       | `String = "black"`                              | Node label color (hexcode/html)                              |
| `nodeLabelFontSize`    | `Double = 40`                                   | Node label font size (pixels)                                |
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
| `tooltipTextFontSize`  | `Double = 40`                                   | Tooltip text font size (pixels)                              |
| `tooltipTextFontName`  | `String? = nil`                                 | Tooltip text font name                                       |
| `tooltipTextBold`      | `Bool = false`                                  | Bold tooltip label text                                      |
| `tooltipTextItalic`    | `Bool = false`                                  | Italicize tooltip label text                                 |
| `layoutIterations`     | `Int = 32`                                      | D3 layout engine layout search attempts to find the most optimal node positions (increasing this number may lead to more pleasing layouts of complex sankeys, at some cost) |

See the [Google Charts documentation](https://developers.google.com/chart/interactive/docs/gallery/sankey) for more info



### Swift Package Manager

Add Sankey to your project with:

```swift
dependencies: [
    .package(url: "https://github.com/maxhumber/Sankey.git", .upToNextMajor(from: "1.0"))
]
```
