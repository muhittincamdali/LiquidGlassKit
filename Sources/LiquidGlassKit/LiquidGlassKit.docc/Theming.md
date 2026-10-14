# Theming

Set default materials, shapes and shadows for a whole view hierarchy.

## Overview

Every component accepts an optional `material` (and ``GlassCard`` and
``SwiftUICore/View/glassSurface(_:in:interactive:)`` an optional `shape`). When you pass
`nil`, the value comes from the ``GlassTheme`` in the environment.

```swift
ContentView()
    .glassTheme(.subtle)
```

The basic presets are:

- ``GlassTheme/standard``: frosted glass, 20 pt corners, soft shadow (the default).
- ``GlassTheme/subtle``: clear glass, 14 pt corners, small shadow and faint edge.
- ``GlassTheme/dark``: dark glass with a deeper shadow.

``GlassPreset/all`` lists these and eleven more, such as ``GlassTheme/aqua``,
``GlassTheme/forest`` and ``GlassTheme/midnight``, each with a display name for pickers. See
<doc:TuningAndExportingALook>.

## Custom themes

```swift
extension GlassTheme {
    static let brand = GlassTheme(
        material: .tinted(.indigo),
        shape: .roundedRectangle(cornerRadius: 12),
        shadowRadius: 6
    )
}

ContentView()
    .glassTheme(.brand)
```

Out-of-range values are clamped, both in the initializer and when you assign a property
later: shadow radii stay between 0 and ``GlassTheme/maximumShadowRadius`` (100 pt),
opacities are limited to `0...1`, and NaN becomes zero. Shapes with negative corner radii are drawn with square corners.

Controls with a fixed outline keep it regardless of the theme shape: buttons, the search
bar, the tab bar and the navigation bar are capsules, and text fields use their own corner
radius.
