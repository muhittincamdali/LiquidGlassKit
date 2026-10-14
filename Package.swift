// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "LiquidGlassKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "LiquidGlassKit", targets: ["LiquidGlassKit"])
    ],
    targets: [
        .target(name: "LiquidGlassKit"),
        .testTarget(
            name: "LiquidGlassKitTests",
            dependencies: ["LiquidGlassKit"]
        )
    ]
)
