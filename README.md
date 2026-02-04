<p align="center">
  <img src="Assets/logo.png" alt="LiquidGlassKit" width="200"/>
</p>

<h1 align="center">LiquidGlassKit</h1>

<p align="center">
  <strong>🧊 Complete Liquid Glass component library for iOS 26</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Swift-6.0-orange.svg" alt="Swift"/>
  <img src="https://img.shields.io/badge/iOS-26.0+-blue.svg" alt="iOS 26"/>
</p>

---

## What is Liquid Glass?

Liquid Glass is iOS 26's revolutionary UI paradigm - fluid, translucent, adaptive surfaces that respond to content and context. **LiquidGlassKit** provides ready-to-use components.

## Components

```swift
import LiquidGlassKit

// Glass Card
LiquidGlassCard {
    Text("Beautiful glass effect")
}

// Glass Button
LiquidGlassButton("Tap Me") {
    // action
}

// Glass Navigation Bar
LiquidGlassNavigationBar(title: "Settings")

// Glass Tab Bar
LiquidGlassTabBar(selection: $tab) {
    Tab("Home", icon: .house)
    Tab("Search", icon: .magnifyingglass)
}
```

## Customization

```swift
LiquidGlassCard {
    content
}
.glassStyle(.frosted)
.glassOpacity(0.3)
.glassBlur(20)
.glassTint(.blue)
```

## Glass Styles

| Style | Description |
|-------|-------------|
| `.clear` | Transparent with blur |
| `.frosted` | Heavy frost effect |
| `.tinted` | Color-tinted glass |
| `.chromatic` | Rainbow refraction |

## Backward Compatibility

```swift
// Automatic fallback for older iOS
LiquidGlassCard {
    content
}
.fallbackStyle(.material(.ultraThin))
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT License

---

## 📈 Star History

<a href="https://star-history.com/#muhittincamdali/LiquidGlassKit&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=muhittincamdali/LiquidGlassKit&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=muhittincamdali/LiquidGlassKit&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=muhittincamdali/LiquidGlassKit&type=Date" />
 </picture>
</a>
