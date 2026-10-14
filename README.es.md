<!-- i18n-source: README.md@3ac8fd6d907a24d0353968251b18deffaeaeb2a8 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-es-light.svg" alt="LiquidGlassKit: Superficies y controles Liquid Glass para SwiftUI: vidrio nativo en OS 26 y una alternativa con Material hasta iOS 17."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml/badge.svg" alt="Estado de CI"></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-light.svg" alt="Última versión: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-light.svg" alt="Plataformas compatibles: iOS 17+ · macOS 14+ · tvOS 17+ · watchOS 10+ · visionOS 1+"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-light.svg" alt="Versión del lenguaje: Swift 6.0+"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-light.svg" alt="Licencia: MIT"></picture></a>
</p>

<p align="center">
<a href="#inicio-rápido"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-es-light.svg" alt="Empezar"></picture></a>
<a href="https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-es-light.svg" alt="Documentación"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/tree/main/Examples/LiquidGlassDemo"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-es-light.svg" alt="Ejemplos"></picture></a>
</p>

> Esta es una traducción del README en inglés. Si hay diferencias, la versión en inglés es la vigente.

<!-- brand:end -->

LiquidGlassKit es un paquete de SwiftUI para apps que quieren superficies y controles Liquid
Glass pero siguen dando soporte a sistemas que no los tienen. En iOS, macOS, tvOS y watchOS 26
dibuja con el `glassEffect` nativo de SwiftUI; en versiones anteriores (hasta iOS 17, macOS 14,
tvOS 17 y watchOS 10) y en visionOS dibuja un desenfoque `Material` con un tinte, un brillo en
los bordes y una sombra. Escribes el mismo código para todos los sistemas.

| Galería (claro) | Galería (oscuro) | Vidrio nativo y alternativa |
| --- | --- | --- |
| ![Galería, claro](docs/images/gallery-light.png) | ![Galería, oscuro](docs/images/gallery-dark.png) | ![Vidrio nativo y alternativa](docs/images/compare-light.png) |

## Lo más destacado

- **Un modificador, dos caminos** — `glassSurface` elige en tiempo de ejecución el vidrio
  nativo o la alternativa con `Material` (fallback), y `glassRenderingMode(.fallback)` fuerza la
  alternativa cuando quieres el mismo aspecto en todas partes.
- **Controles listos para usar** — botones, tarjetas, campos de texto, una barra de búsqueda,
  una barra de pestañas flotante, una barra de navegación y una hoja inferior (bottom sheet),
  todos dibujados con `glassSurface`.
- **Temas** — `GlassTheme` define el material, la forma, la sombra y el brillo de los bordes
  para toda una jerarquía de vistas; cada componente puede seguir usando su propio material.
- **Accesibilidad** — con «Reducir transparencia» (Reduce Transparency) activado, la
  alternativa dibuja un fondo opaco; los iconos decorativos se ocultan a VoiceOver, la barra de
  pestañas anuncia la pestaña seleccionada y la hoja se cierra con el gesto de escape.
- **Sin choques de nombres** — la API evita los nombres propios de SwiftUI (`glassEffect`,
  `GlassEffectContainer`, `GlassButtonStyle`), así que puedes importar ambos módulos en el mismo
  archivo.
- **Renderizado con pruebas** — las suites de Swift Testing se ejecutan en CI en macOS y en
  simuladores de iOS; los renderizados fuera de pantalla comprueban, en el camino alternativo, que
  cada componente dibuja su vidrio con el material correcto.

## Inicio rápido

**1. Añade el paquete**

En Xcode, elige **File › Add Package Dependencies…** e introduce la URL del repositorio:

```text
https://github.com/muhittincamdali/LiquidGlassKit.git
```

Deja la regla de dependencia en **Up to Next Major Version** a partir de 2.0.0 y haz clic en
**Add Package**. En el siguiente diálogo, elige el target de tu app para `LiquidGlassKit` y haz
clic de nuevo en **Add Package**.

**2. Importa el módulo**

```swift
import LiquidGlassKit
```

**3. Úsalo**

Reemplaza el contenido de `ContentView.swift` por esta vista y ejecuta la app (⌘R). Sobre un
degradado aparecen una tarjeta y un botón de vidrio.

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

## Instalación

### Swift Package Manager

En Xcode, elige **File › Add Package Dependencies…** e introduce la URL del repositorio:

```text
https://github.com/muhittincamdali/LiquidGlassKit.git
```

O añádelo a las `dependencies` de tu `Package.swift`:

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

## Uso

El vidrio necesita algo detrás, así que coloca estas vistas sobre una imagen, un degradado o
contenido que se desplaza. Las vistas de este README se compilan y renderizan en la suite de
pruebas ([`ReadmeExamplesTests.swift`](Tests/LiquidGlassKitTests/ReadmeExamplesTests.swift)).

### Pon cualquier vista sobre vidrio

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

Materiales: `.clear`, `.frosted`, `.tinted(Color)` y `.dark`. Formas: rectángulo
redondeado, cápsula, círculo y radios distintos para cada esquina.

### Crea un formulario con los controles

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

### Haz flotar una barra de pestañas y abre una hoja

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

`GlassTabBar` funciona con cualquier selección `Hashable`, y su builder admite `if` y `for`.
La hoja se cierra al arrastrarla hacia abajo, al tocar el fondo oscurecido o con el gesto de
escape de accesibilidad. No está disponible en tvOS.

### Aplica un tema a todas las vistas y elige el camino de renderizado

```swift
struct ThemedApp: View {
    var body: some View {
        RootView()
            .glassTheme(GlassTheme(material: .tinted(.indigo), shape: .roundedRectangle(cornerRadius: 12)))
            .glassRenderingMode(.automatic) // or .fallback to use the Material look everywhere
    }
}
```

### Resumen de la API

| API | Qué hace |
| --- | --- |
| `glassSurface(_:in:interactive:)` | Pone vidrio detrás de cualquier vista. `glassEffect` nativo en OS 26 y alternativa con `Material` en el resto. |
| `GlassGroup` | En OS 26 envuelve `GlassEffectContainer` para que las formas de vidrio cercanas se fundan; en el resto, deja pasar el contenido sin cambios. |
| `GlassButton`, `.buttonStyle(.liquidGlass)` | Botones de vidrio en forma de cápsula en tres tamaños, con estados pulsado, desactivado y destructivo. |
| `GlassCard` | Contenedor con margen interior sobre vidrio. |
| `GlassTextField` | Campo de texto con SF Symbol opcional y anillo de foco. |
| `GlassSearchBar` | Campo de búsqueda en cápsula con botones para borrar y Cancel. |
| `GlassTabBar` | Barra de pestañas flotante, genérica sobre cualquier selección `Hashable`; el builder admite `if` y `for`. |
| `GlassNavigationBar` | Barra de título flotante con elementos a la izquierda y a la derecha. |
| `glassSheet(isPresented:material:content:)` | Hoja inferior flotante; se cierra arrastrando, tocando fuera o con el gesto de escape de accesibilidad. No disponible en tvOS. |
| `GlassTheme`, `GlassRenderingMode` | Valores de entorno para el material, la forma y la sombra predeterminados, y para forzar la alternativa. |

## Demo

[`Examples/LiquidGlassDemo`](Examples/LiquidGlassDemo) es una app de iOS con una galería de
componentes, barras de pestañas, una hoja y una comparación entre vidrio nativo y alternativa.
Abre `LiquidGlassDemo.xcodeproj`, elige un simulador de iPhone y ejecútala; el
[README de la demo](Examples/LiquidGlassDemo/README.md) describe sus pantallas y argumentos de
arranque. La CI la compila en cada pull request y en cada push a main.

| Hoja (claro) | Barras de pestañas (oscuro) | Vidrio nativo y alternativa (oscuro) |
| --- | --- | --- |
| ![Hoja de vidrio, claro](docs/images/sheet-light.png) | ![Barras de pestañas, oscuro](docs/images/tabs-dark.png) | ![Vidrio nativo y alternativa, oscuro](docs/images/compare-dark.png) |

<sub>Capturas de la app de demo en el simulador de iOS 27, tomadas con
[`scripts/screenshots.sh`](scripts/screenshots.sh).</sub>

## Documentación

Referencia de la API y artículos:

- [Referencia de la API](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/) en GitHub Pages, creada a partir del catálogo DocC de
  [`Sources/LiquidGlassKit/LiquidGlassKit.docc`](Sources/LiquidGlassKit/LiquidGlassKit.docc).
  En Xcode, **Product › Build Documentation** abre las mismas páginas sin conexión.
- Notas de la versión: [CHANGELOG.md](CHANGELOG.md).

## Guías

Las guías están en inglés.

- [Getting Started](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/gettingstarted)
  — añade el paquete paso a paso y muestra las primeras superficies de vidrio.
- [Building a Screen with a Floating Tab Bar](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/buildingafloatingtabbarscreen)
  — barra de título, campo de búsqueda, tarjetas, barra de pestañas y hoja sobre contenido que se desplaza, en cinco pasos.
- [Rendering Paths](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/renderingpaths)
  — qué ven los usuarios en cada sistema y cómo forzar la alternativa.
- [Theming](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/theming)
  — temas predefinidos, temas propios y materiales por componente.

## Requisitos

| Plataforma | Versión mínima |
| --------- | --------------------- |
| iOS       | 17                    |
| macOS     | 14                    |
| tvOS      | 17                    |
| watchOS   | 10                    |
| visionOS  | 1                     |
| Herramientas | Swift 6.0 · Xcode 26+ |

El paquete necesita Xcode 26 o posterior incluso para deployment targets más antiguos, porque
el camino nativo se compila con el SDK de OS 26.

## Arquitectura

- `Sources/LiquidGlassKit/Core` contiene los tipos de valor: `GlassMaterial`, `GlassShape`,
  `GlassTheme` y `GlassRenderingMode`.
- `Sources/LiquidGlassKit/Surface` contiene `glassSurface` y `GlassGroup`, los únicos lugares
  que llaman a la API de vidrio de SwiftUI.
- `Sources/LiquidGlassKit/Components` construye cada control sobre `glassSurface`, de modo que el
  tema y el modo de renderizado se aplican a todos.

`glassSurface` resuelve el `GlassRenderingMode` del entorno frente a
`GlassRenderingMode.isNativeGlassAvailable`, una comprobación
`#available(iOS 26, macOS 26, tvOS 26, watchOS 26, *)` que siempre es `false` en visionOS, donde
SwiftUI marca `glassEffect` como no disponible. Cada material tiene su equivalente en ambos
caminos:

| `GlassMaterial` | Camino nativo | Camino alternativo |
| --- | --- | --- |
| `.clear` | `Glass.clear` | `.ultraThinMaterial` |
| `.frosted` | `Glass.regular` | `.thinMaterial` |
| `.tinted(c)` | `Glass.regular.tint(c)` | `.regularMaterial` + capa de color |
| `.dark` | `Glass.regular.tint(black)` | `.ultraThickMaterial` + capa negra |

### Pruebas

```bash
swift test                                                   # macOS
xcodebuild test -scheme LiquidGlassKit \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'   # iOS Simulator
```

Las suites de Swift Testing cubren la lógica de materiales y formas, la limitación de los
valores del tema, la resolución del modo de renderizado, el builder de pestañas y los umbrales
de cierre de la hoja. Los renderizados fuera de pantalla en el camino alternativo comprueban que
cada componente dibuja su vidrio con el material del tema, que un material explícito tiene
prioridad sobre el tema, que las etiquetas sobre vidrio oscuro son blancas y las destructivas,
rojas, que la hoja oscurece el fondo solo mientras se muestra y que «Reducir transparencia»
dibuja un fondo opaco. La CI ejecuta la suite en macOS, en un simulador de iOS 26 y en un
simulador de iOS 18.6, donde solo existe la alternativa, y compila la biblioteca para cada
plataforma de `Package.swift`.

`ImageRenderer` no captura el desenfoque y el vidrio nativo solo en parte, así que las pruebas
comprueban el tinte y la cobertura de la alternativa y que cada componente se renderiza de forma
distinta en el camino nativo que en el alternativo; no comprueban el aspecto final del vidrio.

## Hoja de ruta

Todavía no hay ninguna versión planificada después de 2.0.0. Los informes de errores y las
solicitudes de funciones se gestionan en los [issues](https://github.com/muhittincamdali/LiquidGlassKit/issues).

## Contribuir

Las contribuciones son bienvenidas. Lee la [guía de contribución](https://github.com/muhittincamdali/LiquidGlassKit/blob/main/CONTRIBUTING.md) y el [código de conducta](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md) antes de abrir una pull request. Informa de los problemas de seguridad de forma privada, como se describe en la [política de seguridad](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md).

## Licencia

Publicado bajo la licencia MIT. Consulta [LICENSE](LICENSE).
