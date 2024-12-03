// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Sankey",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "Sankey", targets: ["Sankey"]),
    ],
    targets: [
        .target(name: "Sankey", resources: [.process("Resources")]),
        .testTarget(name: "SankeyTests", dependencies: ["Sankey"]),
    ]
)
