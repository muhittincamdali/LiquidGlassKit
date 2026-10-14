<!-- i18n-source: README.md@812a24dad3e35f6f6a2c1cf8a53f6fae5bfe6c1a status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-zh-CN-light.svg" alt="LiquidGlassKit: 适用于 SwiftUI 的 Liquid Glass 表面与控件：OS 26 上使用原生玻璃效果，低至 iOS 17 的系统使用 Material 回退。"></picture></p>

<p align="center">
<a href="https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml/badge.svg" alt="CI 状态"></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-light.svg" alt="最新版本: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-light.svg" alt="支持的平台: iOS 17+ · macOS 14+ · tvOS 17+ · watchOS 10+ · visionOS 1+"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-light.svg" alt="语言版本: Swift 6.0+"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-light.svg" alt="许可证: MIT"></picture></a>
</p>

<p align="center">
<a href="#快速开始"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-zh-CN-light.svg" alt="开始使用"></picture></a>
<a href="https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-zh-CN-light.svg" alt="文档"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/tree/main/Examples/LiquidGlassDemo"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-zh-CN-light.svg" alt="示例"></picture></a>
</p>

> 本文是英文 README 的译文。如两者内容不一致，以英文版为准。

<!-- brand:end -->

LiquidGlassKit 是一个 SwiftUI 软件包，面向想使用 Liquid Glass 表面和控件、同时仍要支持没有 Liquid Glass 的系统的 App。在 iOS、macOS、tvOS 和 watchOS 26 上，它使用 SwiftUI 原生的 `glassEffect` 绘制；在更早的版本（最低到 iOS 17、macOS 14、tvOS 17 和 watchOS 10）以及 visionOS 上，它绘制带有色调、边缘高光和阴影的 `Material` 模糊效果。所有系统上的代码都一样。

| 组件库（浅色） | 组件库（深色） | 原生与回退 |
| --- | --- | --- |
| ![组件库，浅色](docs/images/gallery-light.png) | ![组件库，深色](docs/images/gallery-dark.png) | ![原生与回退](docs/images/compare-light.png) |

## 亮点

- **一个修饰符，两条渲染路径** — `glassSurface` 在运行时选择原生玻璃或基于 `Material` 的回退方案（fallback）；如果希望所有系统上外观一致，可以用 `glassRenderingMode(.fallback)` 强制使用回退方案。
- **现成的控件** — 按钮、卡片、文本框、搜索栏、悬浮标签栏、导航栏和底部面板（bottom sheet），全部通过 `glassSurface` 绘制。
- **主题** — `GlassTheme` 为整个视图层级设置材质、形状、阴影和边缘高光；每个组件仍可以使用自己的材质。
- **辅助功能** — 打开“降低透明度”（Reduce Transparency）时，回退方案绘制不透明背景；装饰性图标对 VoiceOver 隐藏，标签栏会报告当前选中的标签，底部面板可以用退出手势关闭。
- **没有命名冲突** — API 避开了 SwiftUI 自己的名称（`glassEffect`、`GlassEffectContainer`、`GlassButtonStyle`），因此两个模块可以在同一个文件中导入。
- **经过测试的渲染** — Swift Testing 测试套件在 CI 中的 macOS 和 iOS 模拟器上运行；离屏渲染会在回退路径上检查每个组件都用正确的材质绘制了玻璃。

## 快速开始

**1. 添加软件包**

在 Xcode 中选择 **File › Add Package Dependencies…**，然后输入仓库地址：

```text
https://github.com/muhittincamdali/LiquidGlassKit.git
```

将依赖规则保持为 **Up to Next Major Version**，起始版本 2.0.0，然后点击 **Add Package**。在下一个对话框中，为 `LiquidGlassKit` 选择你的 App target，再次点击 **Add Package**。

**2. 导入模块**

```swift
import LiquidGlassKit
```

**3. 开始使用**

把 `ContentView.swift` 的内容替换为下面的视图，然后运行 App（⌘R）。渐变背景上会出现一张玻璃卡片和一个玻璃按钮。

```swift
import LiquidGlassKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .pink], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 16) {
                GlassCard {
                    Label("Hello, glass", systemImage: "sparkles")
                }
                GlassButton("Tap me", systemImage: "hand.tap") {}
            }
        }
    }
}
```

## 安装

### Swift Package Manager

在 Xcode 中选择 **File › Add Package Dependencies…**，然后输入仓库地址：

```text
https://github.com/muhittincamdali/LiquidGlassKit.git
```

或者将其添加到 `Package.swift` 的 `dependencies` 中：

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/LiquidGlassKit.git", from: "2.0.0")
],
targets: [
    .target(name: "YourApp", dependencies: [
        .product(name: "LiquidGlassKit", package: "LiquidGlassKit")
    ])
]
```

## 使用方法

玻璃需要背后有内容才能显出效果，所以请把这些视图放在图片、渐变或滚动内容之上。本 README 中的视图都由测试套件编译并渲染（[`ReadmeExamplesTests.swift`](Tests/LiquidGlassKitTests/ReadmeExamplesTests.swift)）。

### 把任意视图放到玻璃上

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

材质：`.clear`、`.frosted`、`.tinted(Color)` 和 `.dark`。形状：圆角矩形、胶囊形、圆形，以及每个角单独设置的圆角半径。

### 用控件搭建表单

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

### 悬浮标签栏并打开底部面板

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

`GlassTabBar` 支持任意 `Hashable` 类型的选择值，它的 builder 支持 `if` 和 `for`。底部面板可以通过向下拖动、轻点变暗的背景或辅助功能的退出手势关闭。tvOS 上不提供底部面板。

### 为所有视图设置主题并选择渲染路径

```swift
struct ThemedApp: View {
    var body: some View {
        RootView()
            .glassTheme(GlassTheme(material: .tinted(.indigo), shape: .roundedRectangle(cornerRadius: 12)))
            .glassRenderingMode(.automatic) // or .fallback to use the Material look everywhere
    }
}
```

### API 概览

| API | 作用 |
| --- | --- |
| `glassSurface(_:in:interactive:)` | 在任意视图后面放置玻璃。OS 26 上使用原生 `glassEffect`，其他系统上使用 `Material` 回退。 |
| `GlassGroup` | 在 OS 26 上用 `GlassEffectContainer` 包裹内容，让相邻的玻璃形状融合；在其他系统上原样显示内容。 |
| `GlassButton`, `.buttonStyle(.liquidGlass)` | 三种尺寸的胶囊形玻璃按钮，支持按下、禁用和破坏性操作状态。 |
| `GlassCard` | 带内边距的玻璃容器。 |
| `GlassTextField` | 带可选 SF Symbol 和焦点环的文本框。 |
| `GlassSearchBar` | 带清除按钮和 Cancel 按钮的胶囊形搜索框。 |
| `GlassTabBar` | 悬浮标签栏，对任意 `Hashable` 选择值泛型化；builder 支持 `if` 和 `for`。 |
| `GlassNavigationBar` | 左右两侧可放置项目的悬浮标题栏。 |
| `glassSheet(isPresented:material:content:)` | 悬浮的底部面板；可通过拖动、轻点外部或辅助功能退出手势关闭。tvOS 上不可用。 |
| `GlassTheme`, `GlassRenderingMode` | 用于默认材质、形状、阴影以及强制回退的环境值。 |

## 演示

[`Examples/LiquidGlassDemo`](Examples/LiquidGlassDemo) 是一个 iOS App，包含组件库、标签栏、底部面板以及原生与回退的对比。打开 `LiquidGlassDemo.xcodeproj`，选择一个 iPhone 模拟器并运行；[演示 App 的 README](Examples/LiquidGlassDemo/README.md) 列出了各个页面和启动参数。CI 会在每次 push 时构建它。

| 底部面板（浅色） | 标签栏（深色） | 原生与回退（深色） |
| --- | --- | --- |
| ![玻璃底部面板，浅色](docs/images/sheet-light.png) | ![标签栏，深色](docs/images/tabs-dark.png) | ![原生与回退，深色](docs/images/compare-dark.png) |

<sub>截图来自 iOS 27 模拟器中的演示 App，使用 [`scripts/screenshots.sh`](scripts/screenshots.sh) 截取。</sub>

## 文档

API 参考文档与文章：

- GitHub Pages 上的 [API 参考](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/)，由 [`Sources/LiquidGlassKit/LiquidGlassKit.docc`](Sources/LiquidGlassKit/LiquidGlassKit.docc) 中的 DocC 目录构建。在 Xcode 中，**Product › Build Documentation** 可以离线打开相同的页面。
- 版本说明：[CHANGELOG.md](CHANGELOG.md)。

## 指南

以下指南为英文。

- [Getting Started](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/gettingstarted) — 一步步添加软件包，并在屏幕上显示第一个玻璃表面。
- [Building a Screen with a Floating Tab Bar](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/buildingafloatingtabbarscreen) — 分五步在滚动内容上放置标题栏、搜索框、卡片、标签栏和底部面板。
- [Rendering Paths](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/renderingpaths) — 各系统上的用户会看到什么，以及如何强制使用回退方案。
- [Theming](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/theming) — 预设主题、自定义主题和按组件设置的材质。

## 系统要求

| 平台 | 最低版本 |
| --------- | --------------------- |
| iOS       | 17                    |
| macOS     | 14                    |
| tvOS      | 17                    |
| watchOS   | 10                    |
| visionOS  | 1                     |
| 工具链 | Swift 6.0 · Xcode 26+ |

即使部署目标（deployment target）较旧，也需要 Xcode 26 或更高版本，因为原生路径要基于 OS 26 SDK 编译。

## 架构

- `Sources/LiquidGlassKit/Core` 包含值类型：`GlassMaterial`、`GlassShape`、`GlassTheme` 和 `GlassRenderingMode`。
- `Sources/LiquidGlassKit/Surface` 包含 `glassSurface` 和 `GlassGroup`，只有这里调用 SwiftUI 的玻璃 API。
- `Sources/LiquidGlassKit/Components` 中的每个控件都构建在 `glassSurface` 之上，因此主题和渲染模式对所有控件都生效。

`glassSurface` 会把环境中的 `GlassRenderingMode` 与 `GlassRenderingMode.isNativeGlassAvailable` 对照来决定渲染路径。后者是一个 `#available(iOS 26, macOS 26, tvOS 26, watchOS 26, *)` 检查，在 visionOS 上始终为 `false`，因为 SwiftUI 在 visionOS 上将 `glassEffect` 标记为不可用。每种材质在两条路径上都有对应：

| `GlassMaterial` | 原生路径 | 回退路径 |
| --- | --- | --- |
| `.clear` | `Glass.clear` | `.ultraThinMaterial` |
| `.frosted` | `Glass.regular` | `.thinMaterial` |
| `.tinted(c)` | `Glass.regular.tint(c)` | `.regularMaterial` + 颜色叠加层 |
| `.dark` | `Glass.regular.tint(black)` | `.ultraThickMaterial` + 黑色叠加层 |

### 测试

```bash
swift test                                                   # macOS
xcodebuild test -scheme LiquidGlassKit \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'   # iOS Simulator
```

Swift Testing 测试套件覆盖材质和形状逻辑、主题数值的限制、渲染模式的判定、标签 builder 以及底部面板的关闭阈值。回退路径上的离屏渲染会检查：每个组件都用主题的材质绘制玻璃，显式指定的材质优先于主题，深色玻璃上的标签为白色，底部面板只在显示时让背景变暗，以及“降低透明度”时绘制不透明背景。CI 在 macOS、iOS 26 模拟器和只有回退路径的 iOS 18.6 模拟器上运行测试，并为 `Package.swift` 中的每个平台构建该库。

`ImageRenderer` 既无法捕获模糊效果，也无法捕获原生玻璃，因此测试检查的是回退方案的色调和覆盖范围，以及原生路径的视图能够构建；不检查玻璃的最终外观。

## 路线图

2.0.0 之后的版本尚无计划。错误报告和功能请求在 [issues](https://github.com/muhittincamdali/LiquidGlassKit/issues) 中跟踪。

## 参与贡献

欢迎参与贡献。提交 pull request 之前，请先阅读[贡献指南](https://github.com/muhittincamdali/LiquidGlassKit/blob/main/CONTRIBUTING.md)和[行为准则](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md)。如发现安全问题，请按照[安全策略](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md)私下报告。

## 许可证

基于 MIT 许可证发布。详见 [LICENSE](LICENSE)。
