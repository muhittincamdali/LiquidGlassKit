<!-- i18n-source: README.md@8ba8c05eac41803ed15d3f73d0e62ac899437b98 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-ja-light.svg" alt="LiquidGlassKit: SwiftUI 用 Liquid Glass サーフェスとコントロール。OS 26 はネイティブ、iOS 17 以降の旧 OS は Material で描画。"></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml/badge.svg" alt="CI ステータス"></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-light.svg" alt="最新バージョン: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-light.svg" alt="対応プラットフォーム: iOS 17+ · macOS 14+ · tvOS 17+ · watchOS 10+ · visionOS 1+"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-light.svg" alt="言語バージョン: Swift 6.0+"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-light.svg" alt="ライセンス: MIT"></picture></a>
</p>

<p align="center">
<a href="#クイックスタート"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-ja-light.svg" alt="はじめる"></picture></a>
<a href="https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-ja-light.svg" alt="ドキュメント"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/tree/main/Examples/LiquidGlassDemo"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-ja-light.svg" alt="サンプル"></picture></a>
</p>

> このドキュメントは英語版 README の翻訳です。内容が異なる場合は英語版が最新です。

<!-- brand:end -->

LiquidGlassKit は、Liquid Glass のサーフェスとコントロールを使いながら、Liquid Glass のないシステムもサポートし続けたいアプリのための SwiftUI パッケージです。iOS、macOS、tvOS、watchOS 26 では SwiftUI ネイティブの `glassEffect` で描画し、それより前のバージョン（iOS 17、macOS 14、tvOS 17、watchOS 10 まで）と visionOS では、色合い、縁のハイライト、影を加えた `Material` のぼかしで描画します。どの OS でも同じコードを書くだけです。

| ギャラリー（ライト） | ギャラリー（ダーク） | ネイティブとフォールバック |
| --- | --- | --- |
| ![ギャラリー、ライト](docs/images/gallery-light.png) | ![ギャラリー、ダーク](docs/images/gallery-dark.png) | ![ネイティブとフォールバック](docs/images/compare-light.png) |

## 主な特長

- **1 つのモディファイア、2 つの描画方法** — `glassSurface` は実行時にネイティブのガラスか `Material` によるフォールバックを選びます。どこでも同じ見た目にしたい場合は `glassRenderingMode(.fallback)` でフォールバックを強制できます。
- **すぐに使えるコントロール** — ボタン、カード、テキストフィールド、検索バー、フローティングタブバー、ナビゲーションバー、ボトムシート。すべて `glassSurface` で描画されます。
- **テーマ** — `GlassTheme` はビュー階層全体のマテリアル、形状、影、縁のハイライトを設定します。各コンポーネントには個別のマテリアルも指定できます。
- **アクセシビリティ** — 「透明度を下げる」（Reduce Transparency）がオンのとき、フォールバックは不透明な背景を描画します。装飾用アイコンは VoiceOver から隠され、タブバーは選択中のタブを伝え、シートはエスケープジェスチャで閉じます。
- **名前の衝突なし** — API は SwiftUI 自身の名前（`glassEffect`、`GlassEffectContainer`、`GlassButtonStyle`）を避けているため、両方のモジュールを同じファイルで import できます。
- **描画をテスト** — Swift Testing のテストスイートが CI 上の macOS と iOS シミュレータで実行され、オフスクリーン描画によって、フォールバックで各コンポーネントが正しいマテリアルでガラスを描くことを確認します。

## クイックスタート

**1. パッケージを追加する**

Xcode で **File › Add Package Dependencies…** を選び、リポジトリの URL を入力します。

```text
https://github.com/muhittincamdali/LiquidGlassKit.git
```

依存関係のルールは **Up to Next Major Version**（2.0.0 から）のままにして **Add Package** をクリックします。次のダイアログで `LiquidGlassKit` を追加するアプリのターゲットを選び、もう一度 **Add Package** をクリックします。

**2. モジュールをインポートする**

```swift
import LiquidGlassKit
```

**3. 使ってみる**

`ContentView.swift` の内容を次のビューに置き換えて、アプリを実行します（⌘R）。グラデーションの上にガラスのカードとガラスのボタンが表示されます。

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

## インストール

### Swift Package Manager

Xcode で **File › Add Package Dependencies…** を選び、リポジトリの URL を入力します。

```text
https://github.com/muhittincamdali/LiquidGlassKit.git
```

または `Package.swift` の `dependencies` に追加します。

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

## 使い方

ガラスの効果は背後に何かがあってこそ見えるので、これらのビューは画像、グラデーション、スクロールするコンテンツの上に置いてください。この README のビューはテストスイートでコンパイルと描画が行われます（[`ReadmeExamplesTests.swift`](Tests/LiquidGlassKitTests/ReadmeExamplesTests.swift)）。

### 任意のビューをガラスに載せる

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

マテリアル：`.clear`、`.frosted`、`.tinted(Color)`、`.dark`。形状：角丸長方形、カプセル、円、角ごとに異なる半径。

### コントロールでフォームを作る

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

### タブバーを浮かせてシートを開く

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

`GlassTabBar` は任意の `Hashable` な選択値で動作し、ビルダーは `if` と `for` に対応しています。シートは下にドラッグする、暗くなった背景をタップする、またはアクセシビリティのエスケープジェスチャで閉じます。tvOS では使用できません。

### すべてのビューにテーマを適用し、描画方法を選ぶ

```swift
struct ThemedApp: View {
    var body: some View {
        RootView()
            .glassTheme(GlassTheme(material: .tinted(.indigo), shape: .roundedRectangle(cornerRadius: 12)))
            .glassRenderingMode(.automatic) // or .fallback to use the Material look everywhere
    }
}
```

### API の概要

| API | 役割 |
| --- | --- |
| `glassSurface(_:in:interactive:)` | 任意のビューの背後にガラスを置きます。OS 26 ではネイティブの `glassEffect`、それ以外では `Material` によるフォールバック。 |
| `GlassGroup` | OS 26 では `GlassEffectContainer` で包み、近くのガラスの形状を融合させます。それ以外ではそのまま内容を表示します。 |
| `GlassButton`, `.buttonStyle(.liquidGlass)` | 3 つのサイズのカプセル型ガラスボタン。押下中、無効、破壊的操作の状態に対応。 |
| `GlassCard` | ガラス上の余白付きコンテナ。 |
| `GlassTextField` | 任意の SF Symbol とフォーカスリング付きのテキストフィールド。 |
| `GlassSearchBar` | クリアボタンと Cancel ボタン付きのカプセル型検索フィールド。 |
| `GlassTabBar` | 任意の `Hashable` な選択値に対応するジェネリックなフローティングタブバー。ビルダーは `if` と `for` に対応。 |
| `GlassNavigationBar` | 左右にアイテムを置けるフローティングのタイトルバー。 |
| `glassSheet(isPresented:material:content:)` | フローティングのボトムシート。ドラッグ、外側のタップ、アクセシビリティのエスケープジェスチャで閉じます。tvOS にはありません。 |
| `GlassTheme`, `GlassRenderingMode` | 既定のマテリアル・形状・影、およびフォールバックの強制に使う環境値。 |

## デモ

[`Examples/LiquidGlassDemo`](Examples/LiquidGlassDemo) は、コンポーネントギャラリー、タブバー、シート、ネイティブとフォールバックの比較を備えた iOS アプリです。`LiquidGlassDemo.xcodeproj` を開き、iPhone シミュレータを選んで実行してください。画面と起動引数は [デモの README](Examples/LiquidGlassDemo/README.md) に記載しています。CI は pull request ごと、および main への push ごとにこのアプリをビルドします。

| シート（ライト） | タブバー（ダーク） | ネイティブとフォールバック（ダーク） |
| --- | --- | --- |
| ![ガラスのシート、ライト](docs/images/sheet-light.png) | ![タブバー、ダーク](docs/images/tabs-dark.png) | ![ネイティブとフォールバック、ダーク](docs/images/compare-dark.png) |

<sub>スクリーンショットは iOS 27 シミュレータ上のデモアプリで、[`scripts/screenshots.sh`](scripts/screenshots.sh) を使って撮影しました。</sub>

## ドキュメント

API リファレンスと解説記事：

- GitHub Pages の [API リファレンス](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/)。[`Sources/LiquidGlassKit/LiquidGlassKit.docc`](Sources/LiquidGlassKit/LiquidGlassKit.docc) の DocC カタログから作成しています。Xcode では **Product › Build Documentation** で同じページをオフラインで開けます。
- リリースノート：[CHANGELOG.md](CHANGELOG.md)。

## ガイド

ガイドは英語です。

- [Getting Started](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/gettingstarted) — パッケージを手順どおりに追加し、最初のガラスのサーフェスを表示します。
- [Building a Screen with a Floating Tab Bar](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/buildingafloatingtabbarscreen) — スクロールするコンテンツの上にタイトルバー、検索フィールド、カード、タブバー、シートを 5 つの手順で配置します。
- [Rendering Paths](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/renderingpaths) — 各 OS のユーザーに何が表示されるか、フォールバックを強制する方法。
- [Theming](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/theming) — プリセット、独自のテーマ、コンポーネントごとのマテリアル。

## 動作要件

| プラットフォーム | 最小バージョン |
| --------- | --------------------- |
| iOS       | 17                    |
| macOS     | 14                    |
| tvOS      | 17                    |
| watchOS   | 10                    |
| visionOS  | 1                     |
| ツールチェーン | Swift 6.0 · Xcode 26+ |

古い配布ターゲット（deployment target）向けでも Xcode 26 以降が必要です。ネイティブの描画は OS 26 SDK に対してコンパイルされるためです。

## アーキテクチャ

- `Sources/LiquidGlassKit/Core` には値型 `GlassMaterial`、`GlassShape`、`GlassTheme`、`GlassRenderingMode` があります。
- `Sources/LiquidGlassKit/Surface` には `glassSurface` と `GlassGroup` があり、SwiftUI のガラス API を呼び出すのはここだけです。
- `Sources/LiquidGlassKit/Components` はすべてのコントロールを `glassSurface` の上に構築しているため、テーマと描画モードがすべてに適用されます。

`glassSurface` は環境の `GlassRenderingMode` を `GlassRenderingMode.isNativeGlassAvailable` と照らし合わせて解決します。これは `#available(iOS 26, macOS 26, tvOS 26, watchOS 26, *)` によるチェックで、SwiftUI が `glassEffect` を使用不可としている visionOS では常に `false` になります。各マテリアルには両方の描画方法での対応があります。

| `GlassMaterial` | ネイティブ | フォールバック |
| --- | --- | --- |
| `.clear` | `Glass.clear` | `.ultraThinMaterial` |
| `.frosted` | `Glass.regular` | `.thinMaterial` |
| `.tinted(c)` | `Glass.regular.tint(c)` | `.regularMaterial` + 色のオーバーレイ |
| `.dark` | `Glass.regular.tint(black)` | `.ultraThickMaterial` + 黒のオーバーレイ |

### テスト

```bash
swift test                                                   # macOS
xcodebuild test -scheme LiquidGlassKit \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'   # iOS Simulator
```

Swift Testing のテストスイートは、マテリアルと形状のロジック、テーマの値の制限、描画モードの解決、タブのビルダー、シートを閉じるしきい値をカバーしています。フォールバックでのオフスクリーン描画では、各コンポーネントがテーマのマテリアルでガラスを描くこと、明示したマテリアルがテーマより優先されること、ダークなガラス上のラベルが白いこと、シートが表示中だけ背景を暗くすること、「透明度を下げる」で不透明な背景になることを確認します。CI はテストを macOS、iOS 26 シミュレータ、フォールバックしかない iOS 18.6 シミュレータで実行し、`Package.swift` にあるすべてのプラットフォーム向けにライブラリをビルドします。

`ImageRenderer` はぼかしもネイティブのガラスもキャプチャしないため、テストではフォールバックの色合いと描画範囲、そしてネイティブ側のビューが構築できることを確認しています。ガラスの最終的な見た目は確認していません。

## ロードマップ

2.0.0 以降のリリースはまだ予定していません。バグ報告と機能の要望は [issues](https://github.com/muhittincamdali/LiquidGlassKit/issues) で管理しています。

## コントリビューション

コントリビューションを歓迎します。pull request を作成する前に[コントリビューションガイド](https://github.com/muhittincamdali/LiquidGlassKit/blob/main/CONTRIBUTING.md)と[行動規範](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md)をお読みください。セキュリティ上の問題は[セキュリティポリシー](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md)に従って非公開で報告してください。

## ライセンス

MIT ライセンスで公開しています。詳細は [LICENSE](LICENSE) を参照してください。
