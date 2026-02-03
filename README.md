<div align="center">

# 🧊 LiquidGlassKit

**Complete Liquid Glass component library for iOS 26**

[![Swift](https://img.shields.io/badge/Swift-6.0+-F05138?style=for-the-badge&logo=swift&logoColor=white)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-26.0+-000000?style=for-the-badge&logo=apple&logoColor=white)](https://developer.apple.com/ios/)
[![SPM](https://img.shields.io/badge/SPM-Compatible-FA7343?style=for-the-badge&logo=swift&logoColor=white)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

</div>

---

## ✨ Features

- 🧊 **Liquid Glass** — iOS 26 native material
- 🌊 **Fluid Animations** — Physics-based motion
- 📱 **50+ Components** — Buttons, cards, sheets
- 🎨 **Adaptive Tinting** — Auto color matching
- ⚡ **Performance** — GPU accelerated

---

## 🚀 Quick Start

```swift
import LiquidGlassKit

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello")
                .liquidGlass()
            
            LiquidGlassCard {
                // Content
            }
            
            LiquidGlassButton("Tap Me") {
                // Action
            }
        }
    }
}
```

---

## 📄 License

MIT • [@muhittincamdali](https://github.com/muhittincamdali)
