import SwiftUI

struct IndexView: View {
    var body: some View {
        NavigationView {
            Form {
                NavigationLink("A Simple Example") {
                    ASimpleExampleView()
                }
                NavigationLink("Multilevel Sankeys") {
                    MultilevelSankeysView()
                }
                NavigationLink("Gradient Colors") {
                    GradientColorsView()
                }
                NavigationLink("Uniform Color") {
                    UniformColorView()
                }
                NavigationLink("Stroked Links") {
                    StrokedLinksView()
                }
            }
            .navigationTitle("Gallery")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}
