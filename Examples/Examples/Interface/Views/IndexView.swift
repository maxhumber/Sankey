import SwiftUI

struct IndexView: View {
    var body: some View {
        NavigationView {
            Form {
                NavigationLink("Simple Sankey") {
                    SimpleSankeyView()
                }
                NavigationLink("Multilevel Sankey") {
                    MultilevelSankey()
                }
                Section("Controlling Colors") {
                    NavigationLink("Gradient Links") {
                        GradientLinksView()
                    }
                    NavigationLink("Uniform Color") {
                        UniformColorView()
                    }
                    NavigationLink("Stroked Links") {
                        StrokedLinksView()
                    }
                }
                Section("Customizing Labels") {
                    NavigationLink("Label Style") {
                        LabelStyleView()
                    }
                    NavigationLink("Label Padding") {
                        LabelPaddingView()
                    }
                }
                Section("Adjusting Nodes") {
                    NavigationLink("Node Width") {
                        NodeWidthView()
                    }
                    NavigationLink("Node Padding") {
                        NodePaddingView()
                    }
                }
            }
            .navigationTitle("Examples")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}
