# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2026-10-14

This release rebuilds the package. In June 2026 most of the source was replaced by
placeholders (unrelated "enterprise" helpers, a shader stub without a shader, sample screens),
and the test suites referenced types that did not exist, so tests never compiled; CI hid this
with `continue-on-error`. The components below were rewritten, using the February 2026
versions as a reference, so that they build with Swift 6 and do what their documentation says.

### Added

- `glassSurface(_:in:interactive:)`: uses SwiftUI's `glassEffect(_:in:)` on iOS, macOS, tvOS
  and watchOS 26, and a `Material` blur with tint, edge highlight and shadow elsewhere,
  including visionOS. The fallback honours Reduce Transparency.
- `GlassRenderingMode` (`automatic`, `fallback`) to force the fallback path through the
  environment, and `GlassGroup`, which wraps `GlassEffectContainer` on the native path.
- `GlassShape` value type (rounded rectangle, capsule, circle, per-corner radii).
- `LiquidGlassButtonStyle` (`.buttonStyle(.liquidGlass)`) and `GlassButtonSize`. Labels on
  `.dark` glass are white.
- `GlassSheetDismissal`, the extracted drag-to-dismiss rule.
- Swift Testing suites (39 tests in 9 suites): material equality, fallback `Material` and
  native `Glass` mapping, shape geometry, theme clamping, rendering-mode resolution, tab
  builder, sheet dismissal, and compiled README/DocC examples. Offscreen renders on the
  fallback path check the pixels: every component draws its glass in the theme's tint, an
  explicit material overrides the theme, labels on dark glass are white, the sheet dims the
  background only while presented, and Reduce Transparency draws an opaque background.
- DocC catalog with Getting Started, Building a Screen with a Floating Tab Bar, Rendering
  Paths and Theming articles.
- iOS demo app (`Examples/LiquidGlassDemo`) and `scripts/screenshots.sh`, which captures the
  README screenshots in the iOS Simulator.

### Changed

- Rewrote `GlassMaterial`, `GlassTheme`, `GlassButton`, `GlassCard`, `GlassTextField`,
  `GlassSearchBar`, `GlassTabBar`, `GlassNavigationBar` and `GlassSheet`.
  Components take an optional material and fall back to the theme, which they previously
  ignored.
- `GlassTabBar` is generic over any `Hashable` selection; its builder supports `if`, `if`/`else`
  and `for`, and duplicate values are dropped.
- `GlassSheet` floats above the bottom safe area and adds the modal trait and escape action.
- Renamed parameters: `GlassButton` and `GlassTextField` take `systemImage:` instead of
  `icon:`; `GlassTab` takes `systemImage:` and a `value:` of the selection type instead of
  `icon:` and an `Int` `tag:`; `GlassTabBar` takes `showsLabels:`; `GlassCard` takes `shape:`
  and `padding:`. The `GlassButtonStyle` enum is replaced by `GlassButtonSize`.
- Minimum platforms raised to iOS 17, macOS 14, tvOS 17, watchOS 10 (visionOS 1 unchanged);
  manifest moved to swift-tools-version 6.0. Building requires Xcode 26 or later.
- CI uses the shared workflows from `muhittincamdali/.github`: SwiftPM build and test on
  macOS and an `xcodebuild` build for iOS, macOS, tvOS, watchOS and visionOS (`ci.yml`), DocC
  published to GitHub Pages (`docs.yml`), and link, wording and README translation checks
  (`quality.yml`). `ios.yml` runs the tests on an iOS 26 simulator and on an iOS 18.6
  simulator, which has no native glass, and builds the demo app. Every action is pinned to a
  commit SHA and no step uses `continue-on-error`.

### Fixed

- `GlassMaterial` equality ignored the tint color of `.tinted` materials.
- `GlassSheet` did not compile: its generic parameter shadowed `ViewModifier.Content`.
- Several shape switches did not compile because `@ViewBuilder` cannot return `some Shape`.
- `GlassButton` tracked presses with `onLongPressGesture(minimumDuration: .infinity)`, which
  could swallow taps; the pressed state now comes from the button configuration.
- CONTRIBUTING, SECURITY, issue and pull request templates referred to another project.

### Removed

- Placeholder sources (`Enterprise/*`, `GlassShaders`, `LiquidGlassModifier`,
  `LiquidGlassButton`, `LiquidGlassCard`, sample login/dashboard screens).
- The February 2026 `glassEffect(_:)`, `GlassEffectContainer` and related types, whose names
  collide with SwiftUI's OS 26 API. Use `glassSurface` and `GlassGroup`.
- Unbuilt `Examples/*.swift` files, the one-line `Documentation/GettingStarted.md`, the
  CocoaPods podspec, and the release workflow that overwrote release notes.

## [1.0.0] - 2026-02-03

Initial tag. It does not build. The manifest points the test target at
`Tests/LiquidGlassKitTests`, a folder the tag does not contain, so package resolution fails
first. With that folder added, the sources still do not compile: `GlassCard` reads a
`glassTheme` environment value that is never declared, and `GlassSheet` declares a generic
parameter named `Content`, which shadows `ViewModifier.Content`.

[Unreleased]: https://github.com/muhittincamdali/LiquidGlassKit/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/muhittincamdali/LiquidGlassKit/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/muhittincamdali/LiquidGlassKit/releases/tag/v1.0.0
