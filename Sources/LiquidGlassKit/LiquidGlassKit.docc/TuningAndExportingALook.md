# Tuning and Exporting a Look

Start from a built-in preset, adjust it while the app runs, and turn the result into Swift
code you can paste into your project.

## Overview

``GlassPreset`` names fourteen ready-made ``GlassTheme`` values, from the default frosted
look to tinted themes such as ``GlassTheme/aqua`` and ``GlassTheme/midnight``.
``GlassCodeExporter`` writes any theme, material, shape or color back out as source that uses
this package. Together they let you build a tuning screen in a debug build and keep the
values you like.

## Apply a preset

Every preset is also a static ``GlassTheme`` member, so you can apply one directly:

```swift
ContentView()
    .glassTheme(.aqua)
```

To let people choose, list ``GlassPreset/all`` in a picker and look the selection up with
``GlassPreset/named(_:)``, which ignores case and surrounding spaces:

```swift
struct AppearancePicker: View {
    @AppStorage("glassStyle") private var styleName = "Standard"

    var body: some View {
        VStack {
            Picker("Style", selection: $styleName) {
                ForEach(GlassPreset.all) { preset in
                    Text(preset.name).tag(preset.name)
                }
            }
            GlassCard { Text("Preview") }
        }
        .glassTheme(GlassPreset.named(styleName)?.theme ?? .standard)
    }
}
```

Storing the name rather than the theme keeps the saved value readable and lets a future
version of the preset change without a migration.

## Adjust a theme at run time

``GlassTheme`` is a value type with mutable properties. Start from a preset and change what
you need; out-of-range values are clamped as you assign them, so sliders can write directly
into a theme.

```swift
struct ThemeTuner: View {
    @State private var theme = GlassTheme.ocean

    var body: some View {
        VStack(spacing: 16) {
            GlassCard { Text("Preview") }
            GlassSlider("Shadow", value: $theme.shadowRadius.asDouble, in: 0...30, step: 1)
            GlassSlider("Edge", value: $theme.strokeOpacity, format: .percent)
        }
        .glassTheme(theme)
    }
}

extension CGFloat {
    /// Lets a `CGFloat` property drive a `Double` slider.
    var asDouble: Double {
        get { Double(self) }
        set { self = CGFloat(newValue) }
    }
}
```

## Export the result as code

Ask a ``GlassCodeExporter`` for the source of any value. Built-in themes are written by name,
and initializer arguments equal to their defaults are left out:

```swift
let exporter = GlassCodeExporter()
exporter.themeArgument(for: .aqua)                        // ".aqua"
exporter.code(for: GlassTheme(material: .tinted(.teal)))  // "GlassTheme(material: .tinted(.teal))"
exporter.code(for: GlassShape.topRounded(24))             // ".topRounded(24)"
```

``GlassCodeExporter/viewCode(named:theme:renderingMode:highlight:)`` writes a complete view that
compiles as is, with a ``GlassHighlight`` when you pass one. Names that are not valid Swift identifiers are cleaned up, and the indentation width is
limited to ``GlassCodeExporter/maximumIndentWidth``.

```swift
let exporter = GlassCodeExporter(indentWidth: 2)
let source = exporter.viewCode(named: "Promo Card", theme: theme, renderingMode: .fallback)
```

Standard SwiftUI colors such as `.teal` are written by name. Other colors are resolved in a
light environment and written as sRGB components, so a dynamic color exports its light
appearance.

## Try it in the demo app

The **Playground** tab of the demo app in `Examples/LiquidGlassDemo` combines these pieces: a
preset picker, sliders for corner radius, shadow and edge, a switch for the fallback path, a
highlight picker and the generated code with a copy button.
