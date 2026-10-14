<!-- i18n-source: README.md@1fdc5fa59b8a5bbcccee03211df035b12b5c5f6f status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-de-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-de-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-de-light.svg" alt="LiquidGlassKit: Liquid-Glass-Oberflächen und -Steuerelemente für SwiftUI: natives Glas ab OS 26, Material-Fallback bis iOS 17."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml/badge.svg" alt="CI-Status"></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-light.svg" alt="Aktuelle Version: v2.1.0"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-light.svg" alt="Unterstützte Plattformen: iOS 17+ · macOS 14+ · tvOS 17+ · watchOS 10+ · visionOS 1+"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-light.svg" alt="Sprachversion: Swift 6.0+"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-light.svg" alt="Lizenz: MIT"></picture></a>
</p>

<p align="center">
<a href="#schnellstart"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-de-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-de-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-de-light.svg" alt="Loslegen"></picture></a>
<a href="https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-de-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-de-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-de-light.svg" alt="Dokumentation"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/tree/main/Examples/LiquidGlassDemo"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-de-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-de-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-de-light.svg" alt="Beispiele"></picture></a>
</p>

> Dies ist eine Übersetzung der englischen README. Bei Abweichungen gilt die englische Fassung.

<!-- brand:end -->

LiquidGlassKit ist ein SwiftUI-Paket für Apps, die Liquid-Glass-Oberflächen und
-Steuerelemente nutzen, aber weiterhin Systeme ohne Liquid Glass unterstützen. Unter iOS, macOS,
tvOS und watchOS 26 zeichnet es mit SwiftUIs nativem `glassEffect`; auf älteren Versionen (bis
zurück zu iOS 17, macOS 14, tvOS 17 und watchOS 10) und unter visionOS zeichnet es einen
`Material`-Weichzeichner mit Tönung, Kantenlicht und Schatten. Du schreibst denselben Code für
jedes Betriebssystem.

| Galerie (hell) | Galerie (dunkel) | Natives Glas und Fallback |
| --- | --- | --- |
| ![Galerie, hell](docs/images/gallery-light.png) | ![Galerie, dunkel](docs/images/gallery-dark.png) | ![Natives Glas und Fallback](docs/images/compare-light.png) |

## Highlights

- **Ein Modifier, zwei Wege** — `glassSurface` wählt zur Laufzeit natives Glas oder den
  `Material`-Fallback; `glassRenderingMode(.fallback)` erzwingt den Fallback, wenn du überall
  denselben Look willst.
- **Fertige Steuerelemente** — Buttons, ein Schalter-Stil, ein Schieberegler, Karten, Textfelder,
  eine Suchleiste, eine schwebende Tab-Leiste mit optionalem Aktions-Button und Tab-Badges, eine
  Navigationsleiste und ein Bottom Sheet, alle über `glassSurface` gezeichnet.
- **Effekte** — Glas mit Farbverlauf und animierte Shimmer-, Pulse- und Breathe-Highlights, die
  auf beiden Wegen funktionieren.
- **Themes und Presets** — `GlassTheme` legt Material, Form, Schatten und Kantenlicht für eine
  ganze View-Hierarchie fest, `GlassPreset` benennt 14 fertige Themes, und `GlassCodeExporter`
  macht aus einem zur Laufzeit angepassten Theme wieder Swift-Code.
- **Bedienungshilfen** — ist „Transparenz reduzieren“ (Reduce Transparency) aktiv, zeichnet der
  Fallback einen deckenden Hintergrund, bei „Kontrast erhöhen“ (Increase Contrast) eine stärkere
  Kante; Highlights stoppen bei „Bewegung reduzieren“ (Reduce Motion), Schalter und Schieberegler
  behalten das VoiceOver-Verhalten von SwiftUI, die Tab-Leiste meldet den ausgewählten Tab, und
  das Sheet schließt sich mit der Escape-Geste.
- **Keine Namenskonflikte** — die API meidet SwiftUIs eigene Namen (`glassEffect`,
  `GlassEffectContainer`, `GlassButtonStyle`), sodass sich beide Module in einer Datei
  importieren lassen.
- **Getestetes Rendering** — die Swift-Testing-Suites laufen in der CI unter macOS und in
  iOS-Simulatoren; Offscreen-Renderings prüfen auf dem Fallback-Weg, dass jede Komponente ihr
  Glas im richtigen Material zeichnet.

## Schnellstart

**1. Paket hinzufügen**

Wähle in Xcode **File › Add Package Dependencies…** und gib die Repository-URL ein:

```text
https://github.com/muhittincamdali/LiquidGlassKit.git
```

Lass die Abhängigkeitsregel auf **Up to Next Major Version** ab 2.1.0 stehen und klicke auf
**Add Package**. Wähle im nächsten Dialog dein App-Target für `LiquidGlassKit` aus und klicke
noch einmal auf **Add Package**.

**2. Modul importieren**

```swift
import LiquidGlassKit
```

**3. Verwenden**

Ersetze den Inhalt von `ContentView.swift` durch diese View und starte die App (⌘R). Über
einem Farbverlauf erscheinen eine Glaskarte und ein Glas-Button.

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

## Installation

### Swift Package Manager

Wähle in Xcode **File › Add Package Dependencies…** und gib die Repository-URL ein:

```text
https://github.com/muhittincamdali/LiquidGlassKit.git
```

Oder füge es zu den `dependencies` in deiner `Package.swift` hinzu:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/LiquidGlassKit.git", from: "2.1.0")
],
targets: [
    .target(name: "YourApp", dependencies: [
        .product(name: "LiquidGlassKit", package: "LiquidGlassKit")
    ])
]
```

## Verwendung

Glas braucht etwas dahinter, also platziere diese Views über einem Bild, einem Farbverlauf
oder scrollendem Inhalt. Die Views in diesem README werden von der Test-Suite kompiliert und
gerendert ([`ReadmeExamplesTests.swift`](Tests/LiquidGlassKitTests/ReadmeExamplesTests.swift)).

### Eine beliebige View auf Glas setzen

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

Materialien: `.clear`, `.frosted`, `.tinted(Color)` und `.dark`. Formen: abgerundetes
Rechteck, Kapsel, Kreis und eigene Radien pro Ecke.

### Ein Formular aus Steuerelementen bauen

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

### Eine Tab-Leiste schweben lassen und ein Sheet öffnen

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

`GlassTabBar` funktioniert mit jeder `Hashable`-Auswahl, und sein Builder unterstützt `if`
und `for`. Ein Tab zeigt mit `.badge(_:)` eine Zahl oder ein kurzes Label über seinem Symbol,
zum Beispiel `GlassTab("Profile", systemImage: "person", value: Screen.profile).badge(2)`. Das
Sheet schließt sich, wenn man es nach unten zieht, auf den abgedunkelten Hintergrund tippt oder
die Escape-Geste der Bedienungshilfen nutzt. Unter tvOS gibt es das Sheet nicht.

### Einen Schalter, einen Schieberegler und Effekte hinzufügen

```swift
struct PlayerSettings: View {
    @State private var shuffle = false
    @State private var volume = 0.6

    var body: some View {
        VStack(spacing: 16) {
            GlassCard {
                VStack(spacing: 14) {
                    Toggle("Shuffle", isOn: $shuffle)
                        .toggleStyle(.liquidGlass)
                    GlassSlider("Volume", value: $volume, format: .percent)
                }
            }
            Label("Golden hour", systemImage: "sun.horizon")
                .padding()
                .glassGradient([.orange, .pink], direction: .horizontal, in: .capsule)
            GlassButton("Upgrade", systemImage: "sparkles", material: .tinted(.purple)) {}
                .glassHighlight(.shimmer, in: .capsule)
        }
        .padding()
    }
}
```

Der Schalter-Stil behält die Bedienungshilfen von `Toggle`, und VoiceOver-Nutzer verstellen den
Schieberegler Schritt für Schritt. Bei „Bewegung reduzieren“ werden keine Highlights gezeichnet.
`GlassSlider` gibt es unter tvOS nicht.

### Alle Views mit einem Theme versehen und den Rendering-Weg wählen

```swift
struct ThemedApp: View {
    var body: some View {
        RootView()
            .glassTheme(GlassTheme(material: .tinted(.indigo), shape: .roundedRectangle(cornerRadius: 12)))
            .glassRenderingMode(.automatic) // or .fallback to use the Material look everywhere
    }
}
```

Starte mit einem der 14 Presets aus `GlassPreset.all`, passe es an und mach daraus eine View,
die du in dein Projekt einfügen kannst:

```swift
var theme = GlassPreset.named("Ocean")?.theme ?? .standard
theme.shadowRadius = 4
let source = GlassCodeExporter().viewCode(named: "PromoCard", theme: theme)
```

### API-Überblick

| API | Was es tut |
| --- | --- |
| `glassSurface(_:in:interactive:)` | Legt Glas hinter eine beliebige View. Natives `glassEffect` unter OS 26, sonst der `Material`-Fallback. |
| `GlassGroup` | Umschließt unter OS 26 `GlassEffectContainer`, damit benachbarte Glasformen ineinanderfließen; sonst wird der Inhalt unverändert durchgereicht. |
| `GlassButton`, `.buttonStyle(.liquidGlass)` | Kapselförmige Glas-Buttons in drei Größen, mit gedrücktem, deaktiviertem und destruktivem Zustand. |
| `.toggleStyle(.liquidGlass)` | Schalter mit Glasspur, die sich im eingeschalteten Zustand mit der Tint-Farbe füllt; behält die Bedienungshilfen von `Toggle`. |
| `GlassSlider` | Schieberegler auf einer Glasspur mit Schritten ab der Untergrenze und beliebigem `FormatStyle`. Nicht unter tvOS. |
| `GlassCard` | Container mit Innenabstand auf Glas. |
| `GlassTextField` | Textfeld mit optionalem SF Symbol und Fokusring. |
| `GlassSearchBar` | Kapselförmiges Suchfeld mit Lösch- und Cancel-Button. |
| `GlassTabBar` | Schwebende Tab-Leiste, generisch über jede `Hashable`-Auswahl; der Builder unterstützt `if` und `for`. |
| `GlassTabBarAction` | Runder Button nach den Tabs für die Hauptaktion des Bildschirms. |
| `GlassTab.badge(_:)` | Zahl oder kurzes Label in einer roten Kapsel über dem Tab-Symbol; die Zahl 0 blendet es aus. |
| `GlassNavigationBar` | Schwebende Titelleiste mit Elementen links und rechts. |
| `glassSheet(isPresented:material:content:)` | Schwebendes Bottom Sheet; schließt durch Ziehen, Tippen daneben oder die Escape-Geste der Bedienungshilfen. Nicht unter tvOS. |
| `glassGradient(_:direction:intensity:material:in:interactive:)` | Glas mit Farbverlauf, auf beiden Rendering-Wegen. |
| `glassHighlight(_:color:in:)` | Animiertes Shimmer-, Pulse- oder Breathe-Licht über Glas; aus bei „Bewegung reduzieren“. |
| `GlassTheme`, `GlassRenderingMode` | Environment-Werte für Standard-Material, -Form und -Schatten sowie zum Erzwingen des Fallbacks. |
| `GlassPreset` | 14 benannte Themes mit Anzeigenamen, für Auswahllisten und Einstellungsbildschirme. |
| `GlassCodeExporter` | Schreibt Themes, Materialien, Formen und Farben als Swift-Code, der dieses Paket nutzt. |

## Demo

[`Examples/LiquidGlassDemo`](Examples/LiquidGlassDemo) ist eine iOS-App mit einer
Komponenten-Galerie, Tab-Leisten, einem Sheet, einem Vergleich von nativem Glas und Fallback und
einem Playground, der ein Theme anpasst und seinen Code zeigt. Öffne `LiquidGlassDemo.xcodeproj`,
wähle einen iPhone-Simulator und starte die App; das
[README der Demo](Examples/LiquidGlassDemo/README.md) beschreibt die Bildschirme und
Startargumente. Die CI baut die App für jeden Pull Request und jeden Push auf main.

| Sheet (hell) | Tab-Leisten (dunkel) | Playground (hell) | Natives Glas und Fallback (dunkel) |
| --- | --- | --- | --- |
| ![Glas-Sheet, hell](docs/images/sheet-light.png) | ![Tab-Leisten, dunkel](docs/images/tabs-dark.png) | ![Playground, hell](docs/images/playground-light.png) | ![Natives Glas und Fallback, dunkel](docs/images/compare-dark.png) |

<sub>Screenshots der Demo-App im iOS-27-Simulator, aufgenommen mit
[`scripts/screenshots.sh`](scripts/screenshots.sh).</sub>

## Dokumentation

API-Referenz und Artikel:

- [API-Referenz](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/) auf GitHub Pages, erstellt aus dem DocC-Katalog in
  [`Sources/LiquidGlassKit/LiquidGlassKit.docc`](Sources/LiquidGlassKit/LiquidGlassKit.docc).
  In Xcode öffnet **Product › Build Documentation** dieselben Seiten offline.
- Versionshinweise: [CHANGELOG.md](CHANGELOG.md).

## Anleitungen

Die Anleitungen sind auf Englisch.

- [Getting Started](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/gettingstarted)
  — das Paket Schritt für Schritt hinzufügen und die ersten Glasflächen anzeigen.
- [Building a Screen with a Floating Tab Bar](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/buildingafloatingtabbarscreen)
  — Titelleiste, Suchfeld, Karten, Tab-Leiste und Sheet über scrollendem Inhalt, in fünf Schritten.
- [Rendering Paths](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/renderingpaths)
  — was Nutzer auf welchem Betriebssystem sehen und wie du den Fallback erzwingst.
- [Theming](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/theming)
  — Vorlagen, eigene Themes und Materialien pro Komponente.
- [Adding Controls and Effects](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/addingcontrolsandeffects)
  — der Glas-Schalter und -Schieberegler, Glas mit Farbverlauf, Highlights und der Aktions-Button
  der Tab-Leiste.
- [Tuning and Exporting a Look](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/tuningandexportingalook)
  — ein Preset wählen, ein Theme zur Laufzeit anpassen und es als Swift-Code kopieren.

## Voraussetzungen

| Plattform | Mindestversion |
| --------- | --------------------- |
| iOS       | 17                    |
| macOS     | 14                    |
| tvOS      | 17                    |
| watchOS   | 10                    |
| visionOS  | 1                     |
| Toolchain | Swift 6.0 · Xcode 26+ |

Das Paket braucht auch für ältere Deployment-Targets Xcode 26 oder neuer, weil der native Weg
gegen das OS-26-SDK kompiliert wird.

## Architektur

- `Sources/LiquidGlassKit/Core` enthält die Werttypen `GlassMaterial`, `GlassShape`,
  `GlassTheme`, `GlassPreset` und `GlassRenderingMode` sowie `GlassCodeExporter`.
- `Sources/LiquidGlassKit/Surface` enthält `glassSurface` und `GlassGroup`, die einzigen Stellen,
  die SwiftUIs Glas-API aufrufen, und die auf `glassSurface` aufbauenden Modifier für
  Farbverläufe und Highlights.
- `Sources/LiquidGlassKit/Components` baut jedes Steuerelement auf `glassSurface` auf, daher
  gelten Theme und Rendering-Modus für alle.

`glassSurface` löst den `GlassRenderingMode` aus dem Environment gegen
`GlassRenderingMode.isNativeGlassAvailable` auf, eine
`#available(iOS 26, macOS 26, tvOS 26, watchOS 26, *)`-Prüfung, die unter visionOS immer `false`
ergibt, weil SwiftUI `glassEffect` dort als nicht verfügbar markiert. Jedes Material hat eine
Entsprechung auf beiden Wegen:

| `GlassMaterial` | Nativer Weg | Fallback-Weg |
| --- | --- | --- |
| `.clear` | `Glass.clear` | `.ultraThinMaterial` |
| `.frosted` | `Glass.regular` | `.thinMaterial` |
| `.tinted(c)` | `Glass.regular.tint(c)` | `.regularMaterial` + Farbschicht |
| `.dark` | `Glass.regular.tint(black)` | `.ultraThickMaterial` + schwarze Schicht |

### Tests

```bash
swift test                                                   # macOS
xcodebuild test -scheme LiquidGlassKit \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'   # iOS Simulator
```

Die Swift-Testing-Suites decken die Logik von Materialien und Formen ab, das Begrenzen der
Theme- und Verlaufswerte (auch bei NaN), die Auflösung des Rendering-Modus, den Tab-Builder, die
Schließschwellen des Sheets, das Einrasten des Schiebereglers bei ungewöhnlichen Schritten und
Bereichen, das Timing der Highlights, die Preset-Suche und die Ausgabe des Exporters, von der
drei Beispiele im Test-Target kompiliert werden. Offscreen-Renderings auf dem Fallback-Weg
prüfen, dass jede Komponente ihr Glas im Material des Themes zeichnet, dass ein explizit
angegebenes Material Vorrang vor dem Theme hat, dass Beschriftungen auf dunklem Glas weiß und
destruktive Beschriftungen rot sind, dass das Sheet den Hintergrund nur abdunkelt, solange es
angezeigt wird, und dass „Transparenz reduzieren“ einen deckenden Hintergrund zeichnet. Die CI
führt die Suite unter macOS, in einem iOS-26-Simulator und in einem iOS-18.6-Simulator aus, wo
es nur den Fallback gibt, und baut die Bibliothek für jede Plattform aus `Package.swift`.

`ImageRenderer` erfasst den Weichzeichner nicht und natives Glas nur teilweise. Die Tests prüfen
deshalb Tönung und Abdeckung des Fallbacks sowie, dass jede Komponente auf dem nativen Weg
anders gerendert wird als auf dem Fallback-Weg; das endgültige Aussehen des Glases prüfen sie
nicht.

## Roadmap

Eine Version nach 2.1.0 ist noch nicht geplant. Fehlerberichte und Feature-Wünsche werden in
den [Issues](https://github.com/muhittincamdali/LiquidGlassKit/issues) verfolgt.

## Mitwirken

Beiträge sind willkommen. Lies vor einem Pull Request den [Leitfaden für Beiträge](https://github.com/muhittincamdali/LiquidGlassKit/blob/main/CONTRIBUTING.md) und den [Verhaltenskodex](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md). Sicherheitsprobleme meldest du vertraulich, wie in der [Sicherheitsrichtlinie](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md) beschrieben.

## Lizenz

Veröffentlicht unter der MIT-Lizenz. Siehe [LICENSE](LICENSE).
