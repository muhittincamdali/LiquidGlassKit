# Getting Started

Add the package and put your first glass surfaces on screen.

## Add the package

In an Xcode project:

1. Choose **File › Add Package Dependencies…**.
2. Paste `https://github.com/muhittincamdali/LiquidGlassKit.git` into the search field in the
   top-right corner of the dialog.
3. Leave **Dependency Rule** at **Up to Next Major Version** and check that it starts at
   `2.0.0`, then click **Add Package**.
4. In the next dialog, choose your app target in the **Add to Target** column for the
   `LiquidGlassKit` product, and click **Add Package** again.

In a Swift package, add it to `Package.swift` instead:

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

## Next steps

- <doc:BuildingAFloatingTabBarScreen> puts these pieces together into a full screen.
- <doc:RenderingPaths> explains what users on each OS see.
- `Examples/LiquidGlassDemo` contains an iOS app that shows every component and a side-by-side
  comparison of the native and fallback rendering paths.
