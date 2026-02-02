// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "LiquidGlassKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "LiquidGlassKit",
            targets: ["LiquidGlassKit"]
        )
    ],
    targets: [
        .target(
            name: "LiquidGlassKit",
            path: "Sources/LiquidGlassKit",
            swiftSettings: [
                .define("LIQUID_GLASS_KIT")
            ]
        ),
        .testTarget(
            name: "LiquidGlassKitTests",
            dependencies: ["LiquidGlassKit"],
            path: "Tests/LiquidGlassKitTests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
