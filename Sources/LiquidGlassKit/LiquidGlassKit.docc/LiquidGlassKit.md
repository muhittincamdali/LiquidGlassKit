# ``LiquidGlassKit``

Liquid Glass style surfaces and controls for SwiftUI that use native glass on OS 26 and a
`Material` based fallback on earlier systems.

## Overview

LiquidGlassKit gives you one API for glass surfaces across iOS 17 and later, macOS 14 and
later, tvOS 17 and later, watchOS 10 and later, and visionOS.

- On iOS, macOS, tvOS and watchOS 26 or later, surfaces are drawn with SwiftUI's
  `glassEffect(_:in:)`, and ``GlassGroup`` wraps `GlassEffectContainer`.
- On earlier systems, and on visionOS where SwiftUI's glass APIs are unavailable, surfaces are
  drawn with a `Material` blur, a tint overlay, an edge highlight and a shadow. The fallback
  draws an opaque background when _Reduce Transparency_ is on.

```swift
import LiquidGlassKit
import SwiftUI

struct NowPlaying: View {
    var body: some View {
        VStack(spacing: 16) {
            GlassCard {
                Label("Midnight City", systemImage: "music.note")
            }
            GlassButton("Play", systemImage: "play.fill") {}
        }
    }
}
```

## Topics

### Essentials

- <doc:GettingStarted>
- <doc:RenderingPaths>
- <doc:Theming>

### Surfaces

- ``SwiftUICore/View/glassSurface(_:in:interactive:)``
- ``GlassGroup``
- ``GlassMaterial``
- ``GlassShape``

### Controls

- ``GlassButton``
- ``LiquidGlassButtonStyle``
- ``GlassButtonSize``
- ``GlassTextField``
- ``GlassSearchBar``

### Containers and navigation

- ``GlassCard``
- ``GlassTabBar``
- ``GlassTab``
- ``GlassTabBuilder``
- ``GlassNavigationBar``
- ``GlassSheet``
- ``GlassSheetDismissal``

### Configuration

- ``GlassTheme``
- ``GlassRenderingMode``
