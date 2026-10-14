# Rendering Paths

How a glass surface is drawn on each OS, and how to choose the path yourself.

## Overview

Every surface resolves its ``GlassRenderingMode`` against
``GlassRenderingMode/isNativeGlassAvailable`` when it is drawn.

| Path     | When                                     | How it draws                                                        |
| -------- | ---------------------------------------- | ------------------------------------------------------------------- |
| Native   | iOS, macOS, tvOS, watchOS 26 or later    | `glassEffect(_:in:)` with a `Glass` value derived from the material |
| Fallback | Earlier OS versions, visionOS, or forced | `Material` blur, tint overlay, gradient edge stroke and shadow      |

### Material mapping

| ``GlassMaterial``            | Native `Glass`         | Fallback `Material`                   |
| -------------------------- | ---------------------- | ------------------------------------- |
| ``GlassMaterial/clear``      | `.clear`               | `.ultraThinMaterial`                  |
| ``GlassMaterial/frosted``    | `.regular`             | `.thinMaterial`                       |
| ``GlassMaterial/tinted(_:)`` | `.regular.tint(color)` | `.regularMaterial` + color overlay    |
| ``GlassMaterial/dark``       | `.regular.tint(black)` | `.ultraThickMaterial` + black overlay |

The `interactive` flag of ``SwiftUICore/View/glassSurface(_:in:interactive:)`` maps to
`Glass.interactive(_:)` and only affects the native path. ``LiquidGlassButtonStyle``
animates its own pressed state, so buttons respond to touches on both paths.

The fallback reads ``GlassTheme/shadowRadius``, ``GlassTheme/shadowOpacity`` and
``GlassTheme/strokeOpacity``; native glass draws its own highlights and shadow.

## Forcing a path

Set the mode for a subtree through the environment:

```swift
ContentView()
    .glassRenderingMode(.fallback)
```

Use ``GlassRenderingMode/fallback`` to keep the same look on every OS version, or to
compare both paths side by side as the demo app's _Compare_ screen does. Requesting
``GlassRenderingMode/native`` on an OS without native glass falls back automatically.

## Grouping

Native glass shapes that sit close together can blend into each other. Wrap them in a
``GlassGroup`` to use SwiftUI's `GlassEffectContainer` on the native path; on the fallback
path the group has no effect, so the same code works everywhere.

## Accessibility

When _Reduce Transparency_ is on, the fallback path replaces the blur with an opaque
secondary background. The native path follows the system's own handling of the setting.
