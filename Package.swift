// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "Sankey",
    platforms: [.iOS(.v27), .macOS(.v27)],
    products: [.library(name: "Sankey", targets: ["Sankey"])],
    targets: [
        .target(name: "Sankey", swiftSettings: swiftSettings),
        .testTarget(
            name: "SankeyTests",
            dependencies: ["Sankey"],
            swiftSettings: swiftSettings
        )
    ],
    swiftLanguageModes: [.v6]
)

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("InternalImportsByDefault"),
    .enableUpcomingFeature("MemberImportVisibility"),
    .enableUpcomingFeature("InferIsolatedConformances"),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
    .enableUpcomingFeature("ImmutableWeakCaptures"),
]
