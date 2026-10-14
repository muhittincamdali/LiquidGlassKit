# LiquidGlassKit

[![CI](https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml/badge.svg)](https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/github/license/muhittincamdali/LiquidGlassKit)](LICENSE)

Liquid Glass style surfaces and controls for SwiftUI. On iOS, macOS, tvOS and watchOS 26 they
use SwiftUI's native `glassEffect`; on earlier systems (back to iOS 17) and on visionOS they
fall back to a `Material` blur with a tint, an edge highlight and a shadow. Your code is the
same on every OS.

| Gallery (light)                                  | Gallery (dark)                                 | Native vs fallback                                    |
| ------------------------------------------------ | ---------------------------------------------- | ----------------------------------------------------- |
| ![Gallery, light](docs/images/gallery-light.png) | ![Gallery, dark](docs/images/gallery-dark.png) | ![Native and fallback](docs/images/compare-light.png) |

<sub>Screenshots from the demo app on the iOS 27 simulator, captured with
`scripts/screenshots.sh`. More: [sheet](docs/images/sheet-light.png),
[tab bars](docs/images/tabs-dark.png), [comparison in dark mode](docs/images/compare-dark.png).</sub>

## What is included

| API                                         | What it does                                                                                          |
| ------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `glassSurface(_:in:interactive:)`           | Puts glass behind any view. Native `glassEffect` on OS 26, `Material` fallback elsewhere.             |
| `GlassGroup`                                | Wraps `GlassEffectContainer` on OS 26 so nearby glass shapes blend; a pass-through elsewhere.         |
| `GlassButton`, `.buttonStyle(.liquidGlass)` | Capsule glass buttons in three sizes, with pressed, disabled and destructive states.                  |
| `GlassCard`                                 | Padded container on glass.                                                                            |
| `GlassTextField`                            | Text field with optional SF Symbol and a focus ring.                                                  |
| `GlassSearchBar`                            | Capsule search field with clear and Cancel buttons.                                                   |
| `GlassTabBar`                               | Floating tab bar, generic over any `Hashable` selection; builder supports `if` and `for`.             |
| `GlassNavigationBar`                        | Floating title bar with leading and trailing items.                                                   |
| `glassSheet(isPresented:content:)`          | Floating bottom sheet; dismiss by drag, tap outside or the accessibility escape gesture. Not on tvOS. |
| `GlassTheme`, `GlassRenderingMode`          | Environment values for default material/shape/shadow, and for forcing the native or fallback path.    |

Materials: `.clear`, `.frosted`, `.tinted(Color)`, `.dark`. Shapes: rounded rectangle,
capsule, circle, per-corner radii.

The fallback path draws an opaque background when _Reduce Transparency_ is on. Decorative
icons are hidden from VoiceOver, and the tab bar exposes the selected tab.

## Requirements

- Xcode 26 or later (Swift 6). The native path is compiled against the OS 26 SDK.
- Deployment targets: iOS 17, macOS 14, tvOS 17, watchOS 10, visionOS 1.

## Installation

Swift Package Manager, in Xcode via **File > Add Package Dependencies…** with
`https://github.com/muhittincamdali/LiquidGlassKit.git`, or in `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/LiquidGlassKit.git", from: "2.0.0")
],
targets: [
    .target(name: "MyApp", dependencies: ["LiquidGlassKit"])
]
```

## Usage

Glass needs something behind it, so place these views over an image, a gradient or
scrolling content.

### Any view on glass

```swift
import LiquidGlassKit
import SwiftUI

struct NowPlayingBadge: View {
    var body: some View {
        Label("Now Playing", systemImage: "music.note")
            .padding()
            .glassSurface(.tinted(.purple), in: .capsule)
    }
}
```

### Controls

```swift
struct SignInForm: View {
    @State private var email = ""
    @State private var query = ""

    var body: some View {
        VStack(spacing: 16) {
            GlassSearchBar(text: $query, prompt: "Search")
            GlassTextField("Email", text: $email, systemImage: "envelope")
            GlassCard {
                Text("We will send you a sign-in link.")
            }
            HStack {
                Button("Cancel", role: .cancel) {}
                    .buttonStyle(.liquidGlass(size: .compact))
                GlassButton("Continue", systemImage: "arrow.right", material: .tinted(.blue)) {}
            }
        }
        .padding()
    }
}
```

### Tab bar and sheet

```swift
enum Screen: Hashable { case home, search, profile }

struct RootView: View {
    @State private var screen = Screen.home
    @State private var showsSheet = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.indigo.ignoresSafeArea()
            GlassTabBar(selection: $screen) {
                GlassTab("Home", systemImage: "house", value: Screen.home)
                GlassTab("Search", systemImage: "magnifyingglass", value: Screen.search)
                GlassTab("Profile", systemImage: "person", value: Screen.profile)
            }
            .padding()
        }
        .glassSheet(isPresented: $showsSheet) {
            Text("Sheet content").padding()
        }
    }
}
```

### Theme and rendering path

```swift
struct ThemedApp: View {
    var body: some View {
        RootView()
            .glassTheme(GlassTheme(material: .tinted(.indigo), shape: .roundedRectangle(cornerRadius: 12)))
            .glassRenderingMode(.automatic) // or .fallback to use the Material look everywhere
    }
}
```

The Swift examples in this section are compiled as part of the test suite
(`Tests/LiquidGlassKitTests/ReadmeExamplesTests.swift`).

## How it works

`glassSurface` resolves a `GlassRenderingMode` against
`GlassRenderingMode.isNativeGlassAvailable` (an `#available(iOS 26, macOS 26, tvOS 26,
watchOS 26, *)` check; always `false` on visionOS, where SwiftUI marks `glassEffect`
unavailable).

| `GlassMaterial` | Native path                 | Fallback path                         |
| --------------- | --------------------------- | ------------------------------------- |
| `.clear`        | `Glass.clear`               | `.ultraThinMaterial`                  |
| `.frosted`      | `Glass.regular`             | `.thinMaterial`                       |
| `.tinted(c)`    | `Glass.regular.tint(c)`     | `.regularMaterial` + color overlay    |
| `.dark`         | `Glass.regular.tint(black)` | `.ultraThickMaterial` + black overlay |

Every component draws through `glassSurface`, so the theme and rendering mode apply to all of
them. API names avoid SwiftUI's own (`glassEffect`, `GlassEffectContainer`,
`GlassButtonStyle`), so both modules can be imported in the same file.

Full API documentation is in the DocC catalog (`Sources/LiquidGlassKit/LiquidGlassKit.docc`);
build it with **Product > Build Documentation** in Xcode.

## Testing

```bash
swift test                                                   # macOS
xcodebuild test -scheme LiquidGlassKit \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'   # iOS Simulator
```

The suite uses Swift Testing and covers material and shape logic, theme clamping, rendering
mode resolution, the tab builder, sheet dismissal thresholds, and an offscreen render of every
component on both paths. CI runs it on macOS and the iOS Simulator and builds the library for
tvOS, watchOS and visionOS.

Limitations: `ImageRenderer` cannot capture blur, so the render tests check layout and the
fallback tint, not the final glass look. CI runs on OS 26 or later; the fallback path is
exercised there by forcing `.fallback` (as in the comparison screenshot), not on an iOS 17–25
runtime.

## Demo app

`Examples/LiquidGlassDemo` is an iOS app with a component gallery, tab bars, a sheet and a
native-vs-fallback comparison. Open `LiquidGlassDemo.xcodeproj` and run. The project is
generated from `project.yml` with [XcodeGen](https://github.com/yonaskolb/XcodeGen).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Changes are listed in [CHANGELOG.md](CHANGELOG.md).

## License

MIT. See [LICENSE](LICENSE).
