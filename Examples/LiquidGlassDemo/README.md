# LiquidGlassDemo

An iOS app that shows every LiquidGlassKit component over a colorful background. It uses the
package from this repository (`../..`), so it always runs the code you are looking at.

| Screen  | What it shows                                                                |
| ------- | ---------------------------------------------------------------------------- |
| Gallery | Navigation bar, search bar, card, text field, buttons and all four materials |
| Tabs    | Tab bars with different materials, with and without labels                   |
| Sheet   | The glass bottom sheet; drag it down or tap outside to close it              |
| Compare | The same views on the native path and on the fallback path, side by side     |

## Run it

1. Open `LiquidGlassDemo.xcodeproj` in Xcode 26 or later.
2. Choose the **LiquidGlassDemo** scheme and an iPhone simulator in the toolbar.
3. Press **Run** (⌘R).

On iOS 26 and later the app uses native glass; on an iOS 17 or 18 simulator it shows the
`Material` fallback.

From the command line:

```bash
xcodebuild build \
  -project Examples/LiquidGlassDemo/LiquidGlassDemo.xcodeproj \
  -scheme LiquidGlassDemo \
  -destination 'generic/platform=iOS Simulator'
```

CI builds the app the same way for every pull request and every push to main
(`.github/workflows/ios.yml`).

## Launch arguments

| Argument                                | Effect                          |
| --------------------------------------- | ------------------------------- |
| `-screen gallery\|tabs\|sheet\|compare` | Opens a specific screen         |
| `-renderingMode automatic\|fallback`    | Forces a rendering path         |
| `-presentSheet`                         | Opens the glass sheet on launch |

`scripts/screenshots.sh` uses `-screen` and `-presentSheet` to capture the README screenshots in
the iOS Simulator.

## Project file

The Xcode project is generated from `project.yml` with
[XcodeGen](https://github.com/yonaskolb/XcodeGen). After changing `project.yml`, run
`xcodegen generate --spec project.yml` in this folder.
