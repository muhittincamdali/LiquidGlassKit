# Contributing to LiquidGlassKit

Thanks for your interest. Bug reports, fixes and focused improvements are welcome. This file adds
the steps specific to this package to the
[shared contributing guide](https://github.com/muhittincamdali/.github/blob/main/CONTRIBUTING.md);
by taking part you agree to the
[code of conduct](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md).
Report security problems privately, as the
[security policy](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md) describes.

## Reporting bugs

Open an issue with:

- the OS and version you ran on (for example iOS 18.4 simulator or macOS 26.1),
- the Xcode version,
- which rendering path was active (`GlassRenderingMode.isNativeGlassAvailable`, or the mode you forced),
- a minimal SwiftUI snippet that shows the problem, and a screenshot if it is visual.

For a new API or a behavior change, open an issue first so we can agree on the approach.

## Development setup

You need Xcode 26 or later: the native path is compiled against the OS 26 SDK.

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
2. Keep the change focused; add or update tests for behavior changes. The rendering tests check
   pixels on the fallback path, so a visual change usually needs a test there too.
3. Make sure `swift test` and the iOS simulator tests pass. CI runs them, builds the library for
   every platform in `Package.swift` and builds the demo app.
4. Document new public API with DocC comments. If you change a README or DocC example, update
   `Tests/LiquidGlassKitTests/ReadmeExamplesTests.swift` so it keeps compiling.
5. If a change is visual, regenerate the screenshots with `scripts/screenshots.sh`.
6. Add an entry under "Unreleased" in `CHANGELOG.md`.

`README.md` is the source for the translated `README.<lang>.md` files. You do not have to update
the translations; CI marks them as behind and they are updated in a follow-up. If you do edit
one, keep code blocks and links identical to the English file.

Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/)
(`feat:`, `fix:`, `docs:`, `test:`, `ci:`, `refactor:`, `chore:`).

## License

By contributing you agree that your contributions are licensed under the MIT License.
