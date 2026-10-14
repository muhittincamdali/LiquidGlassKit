# Getting Started

Add the package and put your first glass surfaces on screen.

## Add the package

In Xcode choose **File > Add Package Dependencies…** and enter
`https://github.com/muhittincamdali/LiquidGlassKit.git`, or add it to `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/LiquidGlassKit.git", from: "2.0.0")
]
```

Then add `"LiquidGlassKit"` to your target's dependencies. Building requires Xcode 26 or
later, because the native path compiles against the OS 26 SDK.

## Put glass behind any view

``SwiftUICore/View/glassSurface(_:in:interactive:)`` is the building block every component
uses. Give it a ``GlassMaterial`` and a ``GlassShape``, or leave either out to use the
current ``GlassTheme``:

```swift
Text("Hello")
    .padding()
    .glassSurface()

Label("Now Playing", systemImage: "music.note")
    .padding()
    .glassSurface(.tinted(.purple), in: .capsule)
```

Glass needs something behind it to look like glass, so place these views over an image,
a gradient or scrolling content.

## Use the components

```swift
struct SettingsView: View {
    @State private var name = ""
    @State private var query = ""

    var body: some View {
        VStack(spacing: 16) {
            GlassSearchBar(text: $query)
            GlassTextField("Name", text: $name, systemImage: "person")
            GlassCard {
                Toggle("Notifications", isOn: .constant(true))
            }
            Button("Save") {}
                .buttonStyle(.liquidGlass(.tinted(.blue)))
        }
        .padding()
    }
}
```

## Run the demo

`Examples/LiquidGlassDemo` contains an iOS app that shows every component and a side-by-side
comparison of the native and fallback rendering paths.
