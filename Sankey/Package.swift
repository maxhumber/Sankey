// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Sankey",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Sankey", targets: ["Sankey"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Sankey", dependencies: []),
        .testTarget(name: "SankeyTests", dependencies: ["Sankey"]),
    ]
)
