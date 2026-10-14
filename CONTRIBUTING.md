# Contributing to LiquidGlassKit

Thanks for your interest. Bug reports, fixes and focused improvements are welcome.

## Reporting bugs

Open an issue with:

- the OS and version you ran on (for example iOS 18.4 simulator or macOS 26.1),
- the Xcode version,
- which rendering path was active (`GlassRenderingMode.isNativeGlassAvailable`, or the mode you forced),
- a minimal SwiftUI snippet that shows the problem, and a screenshot if it is visual.

## Development setup

```bash
git clone https://github.com/muhittincamdali/LiquidGlassKit.git
cd LiquidGlassKit
swift test                                   # macOS
xcodebuild test -scheme LiquidGlassKit \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'
```

The demo app lives in `Examples/LiquidGlassDemo`. Open `LiquidGlassDemo.xcodeproj`, or regenerate it
with `xcodegen generate --spec project.yml` after changing `project.yml`.

## Pull requests

1. Branch from `main`.
2. Keep the change focused; add or update tests for behavior changes.
3. Make sure `swift test` and the iOS build pass. CI runs both.
4. Document new public API with DocC comments. If you change a README example, update
   `Tests/LiquidGlassKitTests/ReadmeExamplesTests.swift` so it keeps compiling.
5. If a change is visual, regenerate the screenshots with `scripts/screenshots.sh`.

Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/)
(`feat:`, `fix:`, `docs:`, `test:`, `ci:`, `refactor:`, `chore:`).

## License

By contributing you agree that your contributions are licensed under the MIT License.
