// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "Sankey",
    platforms: [.iOS(.v15), .macOS(.v10_15)],
    products: [
        .library(name: "Sankey", targets: ["Sankey"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Sankey", dependencies: []),
        .testTarget(name: "SankeyTests", dependencies: ["Sankey"]),
    ]
)
