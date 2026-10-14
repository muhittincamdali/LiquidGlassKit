# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

This release rebuilds the package. In June 2026 most of the source was replaced by
placeholders (unrelated "enterprise" helpers, a shader stub without a shader, sample screens),
and the test suites referenced types that did not exist, so tests never compiled; CI hid this
with `continue-on-error`. The components below were restored from the February 2026 history,
reviewed, and reworked so that they build with Swift 6 and do what their documentation says.

### Added

- `glassSurface(_:in:interactive:)`: uses SwiftUI's `glassEffect(_:in:)` on iOS, macOS, tvOS
  and watchOS 26, and a `Material` blur with tint, edge highlight and shadow elsewhere,
  including visionOS. The fallback honours Reduce Transparency.
- `GlassRenderingMode` (`automatic`, `native`, `fallback`) to force a rendering path through
  the environment, and `GlassGroup`, which wraps `GlassEffectContainer` on the native path.
- `GlassShape` value type (rounded rectangle, capsule, circle, per-corner radii).
- `LiquidGlassButtonStyle` (`.buttonStyle(.liquidGlass)`) and `GlassButtonSize`.
- `GlassSheetDismissal`, the extracted drag-to-dismiss rule.
- Swift Testing suites (32 tests): material equality and mapping, shape geometry, theme
  clamping, rendering-mode resolution, tab builder, sheet dismissal, offscreen rendering of
  every component, and compiled README/DocC examples.
- DocC catalog with Getting Started, Rendering Paths and Theming articles.
- iOS demo app (`Examples/LiquidGlassDemo`) and `scripts/screenshots.sh`, which captures the
  README screenshots in the iOS Simulator.

### Changed

- Restored and reworked `GlassMaterial`, `GlassTheme`, `GlassButton`, `GlassCard`,
  `GlassTextField`, `GlassSearchBar`, `GlassTabBar`, `GlassNavigationBar` and `GlassSheet`.
  Components take an optional material and fall back to the theme, which they previously
  ignored.
- `GlassTabBar` is generic over any `Hashable` selection; its builder supports `if`, `if`/`else`
  and `for`, and duplicate values are dropped.
- `GlassSheet` floats above the bottom safe area and adds the modal trait and escape action.
- Minimum platforms raised to iOS 17, macOS 14, tvOS 17, watchOS 10 (visionOS 1 unchanged);
  manifest moved to swift-tools-version 6.0. Building requires Xcode 26 or later.
- CI: one workflow that tests on macOS and the iOS Simulator, builds the demo app and builds
  for tvOS, watchOS and visionOS, with pinned actions and no `continue-on-error`.

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

Initial tag. It does not build with Swift 6.4: `GlassSheet` declares a generic parameter named
`Content`, which shadows `ViewModifier.Content`.

[Unreleased]: https://github.com/muhittincamdali/LiquidGlassKit/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/muhittincamdali/LiquidGlassKit/releases/tag/v1.0.0
