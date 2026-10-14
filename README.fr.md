<!-- i18n-source: README.md@3ac8fd6d907a24d0353968251b18deffaeaeb2a8 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-fr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-fr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-fr-light.svg" alt="LiquidGlassKit: Surfaces et contrôles Liquid Glass pour SwiftUI : verre natif sur OS 26, repli sur Material jusqu'à iOS 17."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml/badge.svg" alt="État de la CI"></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-light.svg" alt="Dernière version: v2.1.0"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-light.svg" alt="Plateformes prises en charge: iOS 17+ · macOS 14+ · tvOS 17+ · watchOS 10+ · visionOS 1+"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-light.svg" alt="Version du langage: Swift 6.0+"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-light.svg" alt="Licence: MIT"></picture></a>
</p>

<p align="center">
<a href="#démarrage-rapide"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-fr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-fr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-fr-light.svg" alt="Commencer"></picture></a>
<a href="https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-fr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-fr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-fr-light.svg" alt="Documentation"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/tree/main/Examples/LiquidGlassDemo"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-fr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-fr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-fr-light.svg" alt="Exemples"></picture></a>
</p>

> Ceci est une traduction du README anglais. En cas de différence, la version anglaise fait foi.

<!-- brand:end -->

LiquidGlassKit est un package SwiftUI destiné aux apps qui veulent des surfaces et des
contrôles Liquid Glass tout en prenant en charge les systèmes qui n'en disposent pas. Sur iOS,
macOS, tvOS et watchOS 26, il dessine avec le `glassEffect` natif de SwiftUI ; sur les versions
antérieures (jusqu'à iOS 17, macOS 14, tvOS 17 et watchOS 10) et sur visionOS, il dessine un
flou `Material` avec une teinte, un reflet sur les bords et une ombre. Vous écrivez le même code
pour tous les systèmes.

| Galerie (clair) | Galerie (sombre) | Verre natif et repli |
| --- | --- | --- |
| ![Galerie, clair](docs/images/gallery-light.png) | ![Galerie, sombre](docs/images/gallery-dark.png) | ![Verre natif et repli](docs/images/compare-light.png) |

## Points forts

- **Un modificateur, deux chemins** — `glassSurface` choisit à l'exécution le verre natif ou
  le repli `Material`, et `glassRenderingMode(.fallback)` impose le repli si vous voulez le même
  rendu partout.
- **Des contrôles prêts à l'emploi** — boutons, cartes, champs de texte, barre de recherche,
  barre d'onglets flottante, barre de navigation et feuille en bas d'écran (bottom sheet), tous
  dessinés avec `glassSurface`.
- **Thèmes** — `GlassTheme` définit le matériau, la forme, l'ombre et le reflet des bords pour
  toute une hiérarchie de vues ; chaque composant peut tout de même recevoir son propre matériau.
- **Accessibilité** — quand « Réduire la transparence » (Reduce Transparency) est activé, le
  repli dessine un fond opaque ; les icônes décoratives sont masquées pour VoiceOver, la barre
  d'onglets annonce l'onglet sélectionné et la feuille se ferme avec le geste d'échappement.
- **Aucun conflit de noms** — l'API évite les noms propres à SwiftUI (`glassEffect`,
  `GlassEffectContainer`, `GlassButtonStyle`), ce qui permet d'importer les deux modules dans un
  même fichier.
- **Rendu testé** — les suites Swift Testing tournent en CI sur macOS et sur des simulateurs
  iOS ; des rendus hors écran vérifient, sur le chemin de repli, que chaque composant dessine son
  verre avec le bon matériau.

## Démarrage rapide

**1. Ajouter le paquet**

Dans Xcode, choisissez **File › Add Package Dependencies…** et saisissez l’URL du dépôt :

```text
https://github.com/muhittincamdali/LiquidGlassKit.git
```

Laissez la règle de dépendance sur **Up to Next Major Version** à partir de 2.0.0 et cliquez
sur **Add Package**. Dans la fenêtre suivante, choisissez la cible de votre app pour
`LiquidGlassKit`, puis cliquez de nouveau sur **Add Package**.

**2. Importer le module**

```swift
import LiquidGlassKit
```

**3. L’utiliser**

Remplacez le contenu de `ContentView.swift` par cette vue et lancez l'app (⌘R). Une carte et
un bouton en verre apparaissent sur un dégradé.

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

Dans Xcode, choisissez **File › Add Package Dependencies…** et saisissez l’URL du dépôt :

```text
https://github.com/muhittincamdali/LiquidGlassKit.git
```

Ou ajoutez-le aux `dependencies` de votre `Package.swift` :

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

## Utilisation

Le verre a besoin de quelque chose derrière lui : placez donc ces vues sur une image, un
dégradé ou un contenu qui défile. Les vues de ce README sont compilées et rendues par la suite de
tests ([`ReadmeExamplesTests.swift`](Tests/LiquidGlassKitTests/ReadmeExamplesTests.swift)).

### Placer n'importe quelle vue sur du verre

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

Matériaux : `.clear`, `.frosted`, `.tinted(Color)` et `.dark`. Formes : rectangle arrondi,
capsule, cercle et rayons différents pour chaque coin.

### Construire un formulaire avec les contrôles

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

### Faire flotter une barre d'onglets et ouvrir une feuille

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

`GlassTabBar` fonctionne avec n'importe quelle sélection `Hashable`, et son builder prend en
charge `if` et `for`. La feuille se ferme quand on la fait glisser vers le bas, quand on touche
le fond assombri ou avec le geste d'échappement de l'accessibilité. Elle n'existe pas sur tvOS.

### Appliquer un thème à toutes les vues et choisir le chemin de rendu

```swift
struct ThemedApp: View {
    var body: some View {
        RootView()
            .glassTheme(GlassTheme(material: .tinted(.indigo), shape: .roundedRectangle(cornerRadius: 12)))
            .glassRenderingMode(.automatic) // or .fallback to use the Material look everywhere
    }
}
```

### Vue d'ensemble de l'API

| API | Rôle |
| --- | --- |
| `glassSurface(_:in:interactive:)` | Place du verre derrière n'importe quelle vue. `glassEffect` natif sur OS 26, repli `Material` ailleurs. |
| `GlassGroup` | Enveloppe `GlassEffectContainer` sur OS 26 pour que les formes de verre proches se fondent ; ailleurs, transmet le contenu tel quel. |
| `GlassButton`, `.buttonStyle(.liquidGlass)` | Boutons en verre en forme de capsule, en trois tailles, avec les états appuyé, désactivé et destructif. |
| `GlassCard` | Conteneur avec marge intérieure, posé sur du verre. |
| `GlassTextField` | Champ de texte avec SF Symbol facultatif et anneau de focus. |
| `GlassSearchBar` | Champ de recherche en capsule avec boutons d'effacement et Cancel. |
| `GlassTabBar` | Barre d'onglets flottante, générique sur toute sélection `Hashable` ; le builder prend en charge `if` et `for`. |
| `GlassNavigationBar` | Barre de titre flottante avec éléments à gauche et à droite. |
| `glassSheet(isPresented:material:content:)` | Feuille flottante en bas d'écran ; se ferme par glissement, par une touche à l'extérieur ou avec le geste d'échappement. Absente sur tvOS. |
| `GlassTheme`, `GlassRenderingMode` | Valeurs d'environnement pour le matériau, la forme et l'ombre par défaut, et pour imposer le repli. |

## Démo

[`Examples/LiquidGlassDemo`](Examples/LiquidGlassDemo) est une app iOS avec une galerie de
composants, des barres d'onglets, une feuille et une comparaison entre verre natif et repli.
Ouvrez `LiquidGlassDemo.xcodeproj`, choisissez un simulateur d'iPhone et lancez l'app ; le
[README de la démo](Examples/LiquidGlassDemo/README.md) décrit ses écrans et ses arguments de
lancement. La CI la compile pour chaque pull request et chaque push sur main.

| Feuille (clair) | Barres d'onglets (sombre) | Verre natif et repli (sombre) |
| --- | --- | --- |
| ![Feuille en verre, clair](docs/images/sheet-light.png) | ![Barres d'onglets, sombre](docs/images/tabs-dark.png) | ![Verre natif et repli, sombre](docs/images/compare-dark.png) |

<sub>Captures d'écran de l'app de démo dans le simulateur iOS 27, réalisées avec
[`scripts/screenshots.sh`](scripts/screenshots.sh).</sub>

## Documentation

Référence de l’API et articles :

- [Référence de l'API](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/) sur GitHub Pages, produite à partir du catalogue DocC situé dans
  [`Sources/LiquidGlassKit/LiquidGlassKit.docc`](Sources/LiquidGlassKit/LiquidGlassKit.docc).
  Dans Xcode, **Product › Build Documentation** ouvre les mêmes pages hors ligne.
- Notes de version : [CHANGELOG.md](CHANGELOG.md).

## Guides

Les guides sont en anglais.

- [Getting Started](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/gettingstarted)
  — ajouter le package pas à pas et afficher les premières surfaces en verre.
- [Building a Screen with a Floating Tab Bar](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/buildingafloatingtabbarscreen)
  — barre de titre, champ de recherche, cartes, barre d'onglets et feuille sur un contenu qui défile, en cinq étapes.
- [Rendering Paths](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/renderingpaths)
  — ce que voient les utilisateurs selon le système, et comment imposer le repli.
- [Theming](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/theming)
  — thèmes prédéfinis, thèmes personnalisés et matériaux par composant.

## Prérequis

| Plateforme | Version minimale |
| --------- | --------------------- |
| iOS       | 17                    |
| macOS     | 14                    |
| tvOS      | 17                    |
| watchOS   | 10                    |
| visionOS  | 1                     |
| Chaîne d’outils | Swift 6.0 · Xcode 26+ |

Le package nécessite Xcode 26 ou une version ultérieure, même pour des cibles de déploiement
plus anciennes, car le chemin natif est compilé avec le SDK d'OS 26.

## Architecture

- `Sources/LiquidGlassKit/Core` contient les types valeur : `GlassMaterial`, `GlassShape`,
  `GlassTheme` et `GlassRenderingMode`.
- `Sources/LiquidGlassKit/Surface` contient `glassSurface` et `GlassGroup`, les seuls endroits qui
  appellent l'API de verre de SwiftUI.
- `Sources/LiquidGlassKit/Components` construit chaque contrôle sur `glassSurface`, si bien que le
  thème et le mode de rendu s'appliquent à tous.

`glassSurface` résout le `GlassRenderingMode` de l'environnement par rapport à
`GlassRenderingMode.isNativeGlassAvailable`, une vérification
`#available(iOS 26, macOS 26, tvOS 26, watchOS 26, *)` qui vaut toujours `false` sur visionOS,
où SwiftUI marque `glassEffect` comme indisponible. Chaque matériau a un équivalent sur les deux
chemins :

| `GlassMaterial` | Chemin natif | Chemin de repli |
| --- | --- | --- |
| `.clear` | `Glass.clear` | `.ultraThinMaterial` |
| `.frosted` | `Glass.regular` | `.thinMaterial` |
| `.tinted(c)` | `Glass.regular.tint(c)` | `.regularMaterial` + calque de couleur |
| `.dark` | `Glass.regular.tint(black)` | `.ultraThickMaterial` + calque noir |

### Tests

```bash
swift test                                                   # macOS
xcodebuild test -scheme LiquidGlassKit \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'   # iOS Simulator
```

Les suites Swift Testing couvrent la logique des matériaux et des formes, la limitation des
valeurs du thème, la résolution du mode de rendu, le builder d'onglets et les seuils de
fermeture de la feuille. Des rendus hors écran sur le chemin de repli vérifient que chaque
composant dessine son verre avec le matériau du thème, qu'un matériau explicite l'emporte sur le
thème, que les libellés sur verre sombre sont blancs et les libellés destructifs rouges, que la
feuille n'assombrit le fond que lorsqu'elle est affichée et que « Réduire la transparence »
dessine un fond opaque. La CI exécute la suite sur macOS, sur un simulateur iOS 26 et sur un
simulateur iOS 18.6, où seul le repli existe, et compile la bibliothèque pour chaque plateforme
de `Package.swift`.

`ImageRenderer` ne capture pas le flou et ne capture le verre natif qu'en partie : les tests
vérifient donc la teinte et la couverture du repli, ainsi que le fait que chaque composant est
rendu différemment sur le chemin natif et sur le chemin de repli ; ils ne vérifient pas l'aspect
final du verre.

## Feuille de route

Aucune version après 2.0.0 n'est encore prévue. Les rapports de bug et les demandes de
fonctionnalités sont suivis dans les [issues](https://github.com/muhittincamdali/LiquidGlassKit/issues).

## Contribuer

Les contributions sont les bienvenues. Lisez le [guide de contribution](https://github.com/muhittincamdali/LiquidGlassKit/blob/main/CONTRIBUTING.md) et le [code de conduite](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md) avant d’ouvrir une pull request. Signalez les problèmes de sécurité en privé, comme indiqué dans la [politique de sécurité](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md).

## Licence

Publié sous licence MIT. Voir [LICENSE](LICENSE).
