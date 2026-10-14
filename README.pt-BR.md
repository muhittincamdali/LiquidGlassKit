<!-- i18n-source: README.md@812a24dad3e35f6f6a2c1cf8a53f6fae5bfe6c1a status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-pt-BR-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-pt-BR-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-pt-BR-light.svg" alt="LiquidGlassKit: Superfícies e controles Liquid Glass para SwiftUI: vidro nativo no OS 26 e alternativa com Material até o iOS 17."></picture></p>

<p align="center">
<a href="https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml/badge.svg" alt="Status da CI"></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-light.svg" alt="Versão mais recente: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-light.svg" alt="Plataformas compatíveis: iOS 17+ · macOS 14+ · tvOS 17+ · watchOS 10+ · visionOS 1+"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-light.svg" alt="Versão da linguagem: Swift 6.0+"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-light.svg" alt="Licença: MIT"></picture></a>
</p>

<p align="center">
<a href="#início-rápido"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-pt-BR-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-pt-BR-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-pt-BR-light.svg" alt="Começar"></picture></a>
<a href="https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-pt-BR-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-pt-BR-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-pt-BR-light.svg" alt="Documentação"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/tree/main/Examples/LiquidGlassDemo"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-pt-BR-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-pt-BR-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-pt-BR-light.svg" alt="Exemplos"></picture></a>
</p>

> Esta é uma tradução do README em inglês. Se houver diferença, vale a versão em inglês.

<!-- brand:end -->

LiquidGlassKit é um pacote SwiftUI para apps que querem superfícies e controles Liquid Glass,
mas continuam dando suporte a sistemas que não os têm. No iOS, macOS, tvOS e watchOS 26, ele
desenha com o `glassEffect` nativo do SwiftUI; em versões anteriores (até o iOS 17, macOS 14,
tvOS 17 e watchOS 10) e no visionOS, desenha um desfoque `Material` com uma tonalidade, um brilho
nas bordas e uma sombra. Você escreve o mesmo código para todos os sistemas.

| Galeria (claro) | Galeria (escuro) | Vidro nativo e alternativa |
| --- | --- | --- |
| ![Galeria, claro](docs/images/gallery-light.png) | ![Galeria, escuro](docs/images/gallery-dark.png) | ![Vidro nativo e alternativa](docs/images/compare-light.png) |

## Destaques

- **Um modificador, dois caminhos** — `glassSurface` escolhe em tempo de execução o vidro
  nativo ou a alternativa com `Material` (fallback), e `glassRenderingMode(.fallback)` força a
  alternativa quando você quer a mesma aparência em todo lugar.
- **Controles prontos** — botões, cartões, campos de texto, uma barra de busca, uma barra de abas
  flutuante, uma barra de navegação e uma folha inferior (bottom sheet), todos desenhados com
  `glassSurface`.
- **Temas** — `GlassTheme` define o material, a forma, a sombra e o brilho das bordas de uma
  hierarquia de views inteira; cada componente ainda pode receber o próprio material.
- **Acessibilidade** — com "Reduzir Transparência" (Reduce Transparency) ativado, a alternativa
  desenha um fundo opaco; ícones decorativos ficam ocultos para o VoiceOver, a barra de abas
  informa a aba selecionada e a folha fecha com o gesto de escape.
- **Sem conflito de nomes** — a API evita os nomes do próprio SwiftUI (`glassEffect`,
  `GlassEffectContainer`, `GlassButtonStyle`), então os dois módulos podem ser importados no
  mesmo arquivo.
- **Renderização testada** — as suítes do Swift Testing rodam na CI no macOS e em simuladores
  iOS; renderizações fora da tela verificam, no caminho alternativo, que cada componente desenha
  o vidro com o material correto.

## Início rápido

**1. Adicione o pacote**

No Xcode, escolha **File › Add Package Dependencies…** e informe a URL do repositório:

```text
https://github.com/muhittincamdali/LiquidGlassKit.git
```

Mantenha a regra de dependência em **Up to Next Major Version** a partir de 2.0.0 e clique em
**Add Package**. Na janela seguinte, escolha o target do seu app para `LiquidGlassKit` e clique
de novo em **Add Package**.

**2. Importe o módulo**

```swift
import LiquidGlassKit
```

**3. Use**

Substitua o conteúdo de `ContentView.swift` por esta view e rode o app (⌘R). Um cartão e um
botão de vidro aparecem sobre um degradê.

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

## Instalação

### Swift Package Manager

No Xcode, escolha **File › Add Package Dependencies…** e informe a URL do repositório:

```text
https://github.com/muhittincamdali/LiquidGlassKit.git
```

Ou adicione-o às `dependencies` do seu `Package.swift`:

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

O vidro precisa de algo atrás dele, então coloque estas views sobre uma imagem, um degradê ou
um conteúdo com rolagem. As views deste README são compiladas e renderizadas pela suíte de testes
([`ReadmeExamplesTests.swift`](Tests/LiquidGlassKitTests/ReadmeExamplesTests.swift)).

### Coloque qualquer view sobre vidro

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

Materiais: `.clear`, `.frosted`, `.tinted(Color)` e `.dark`. Formas: retângulo arredondado,
cápsula, círculo e raios diferentes para cada canto.

### Monte um formulário com os controles

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

### Faça uma barra de abas flutuar e abra uma folha

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

`GlassTabBar` funciona com qualquer seleção `Hashable`, e o builder aceita `if` e `for`. A
folha fecha quando é arrastada para baixo, quando o fundo escurecido é tocado ou com o gesto de
escape de acessibilidade. Ela não está disponível no tvOS.

### Aplique um tema a todas as views e escolha o caminho de renderização

```swift
struct ThemedApp: View {
    var body: some View {
        RootView()
            .glassTheme(GlassTheme(material: .tinted(.indigo), shape: .roundedRectangle(cornerRadius: 12)))
            .glassRenderingMode(.automatic) // or .fallback to use the Material look everywhere
    }
}
```

### Visão geral da API

| API | O que faz |
| --- | --- |
| `glassSurface(_:in:interactive:)` | Coloca vidro atrás de qualquer view. `glassEffect` nativo no OS 26, alternativa com `Material` nos demais. |
| `GlassGroup` | No OS 26 envolve `GlassEffectContainer` para que formas de vidro próximas se fundam; nos demais, repassa o conteúdo sem mudanças. |
| `GlassButton`, `.buttonStyle(.liquidGlass)` | Botões de vidro em formato de cápsula em três tamanhos, com estados pressionado, desativado e destrutivo. |
| `GlassCard` | Contêiner com margem interna sobre vidro. |
| `GlassTextField` | Campo de texto com SF Symbol opcional e anel de foco. |
| `GlassSearchBar` | Campo de busca em cápsula com botões de limpar e Cancel. |
| `GlassTabBar` | Barra de abas flutuante, genérica para qualquer seleção `Hashable`; o builder aceita `if` e `for`. |
| `GlassNavigationBar` | Barra de título flutuante com itens à esquerda e à direita. |
| `glassSheet(isPresented:material:content:)` | Folha inferior flutuante; fecha arrastando, tocando fora ou com o gesto de escape de acessibilidade. Não existe no tvOS. |
| `GlassTheme`, `GlassRenderingMode` | Valores de ambiente para material, forma e sombra padrão, e para forçar a alternativa. |

## Demonstração

[`Examples/LiquidGlassDemo`](Examples/LiquidGlassDemo) é um app iOS com uma galeria de
componentes, barras de abas, uma folha e uma comparação entre vidro nativo e alternativa. Abra
`LiquidGlassDemo.xcodeproj`, escolha um simulador de iPhone e rode o app; o
[README da demo](Examples/LiquidGlassDemo/README.md) descreve as telas e os argumentos de
inicialização. A CI compila o app a cada push.

| Folha (claro) | Barras de abas (escuro) | Vidro nativo e alternativa (escuro) |
| --- | --- | --- |
| ![Folha de vidro, claro](docs/images/sheet-light.png) | ![Barras de abas, escuro](docs/images/tabs-dark.png) | ![Vidro nativo e alternativa, escuro](docs/images/compare-dark.png) |

<sub>Capturas de tela do app de demonstração no simulador do iOS 27, feitas com
[`scripts/screenshots.sh`](scripts/screenshots.sh).</sub>

## Documentação

Referência da API e artigos:

- [Referência da API](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/) no GitHub Pages, criada a partir do catálogo DocC em
  [`Sources/LiquidGlassKit/LiquidGlassKit.docc`](Sources/LiquidGlassKit/LiquidGlassKit.docc).
  No Xcode, **Product › Build Documentation** abre as mesmas páginas offline.
- Notas de versão: [CHANGELOG.md](CHANGELOG.md).

## Guias

Os guias estão em inglês.

- [Getting Started](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/gettingstarted)
  — adicione o pacote passo a passo e coloque as primeiras superfícies de vidro na tela.
- [Building a Screen with a Floating Tab Bar](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/buildingafloatingtabbarscreen)
  — barra de título, campo de busca, cartões, barra de abas e folha sobre conteúdo com rolagem, em cinco passos.
- [Rendering Paths](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/renderingpaths)
  — o que os usuários veem em cada sistema e como forçar a alternativa.
- [Theming](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/theming)
  — temas prontos, temas próprios e materiais por componente.

## Requisitos

| Plataforma | Versão mínima |
| --------- | --------------------- |
| iOS       | 17                    |
| macOS     | 14                    |
| tvOS      | 17                    |
| watchOS   | 10                    |
| visionOS  | 1                     |
| Ferramentas | Swift 6.0 · Xcode 26+ |

O pacote precisa do Xcode 26 ou posterior mesmo para deployment targets mais antigos, porque o
caminho nativo é compilado com o SDK do OS 26.

## Arquitetura

- `Sources/LiquidGlassKit/Core` contém os tipos de valor: `GlassMaterial`, `GlassShape`,
  `GlassTheme` e `GlassRenderingMode`.
- `Sources/LiquidGlassKit/Surface` contém `glassSurface` e `GlassGroup`, os únicos lugares que
  chamam a API de vidro do SwiftUI.
- `Sources/LiquidGlassKit/Components` constrói cada controle sobre `glassSurface`, então o tema e
  o modo de renderização valem para todos.

`glassSurface` resolve o `GlassRenderingMode` do ambiente em relação a
`GlassRenderingMode.isNativeGlassAvailable`, uma verificação
`#available(iOS 26, macOS 26, tvOS 26, watchOS 26, *)` que é sempre `false` no visionOS, onde o
SwiftUI marca `glassEffect` como indisponível. Cada material tem um equivalente nos dois
caminhos:

| `GlassMaterial` | Caminho nativo | Caminho alternativo |
| --- | --- | --- |
| `.clear` | `Glass.clear` | `.ultraThinMaterial` |
| `.frosted` | `Glass.regular` | `.thinMaterial` |
| `.tinted(c)` | `Glass.regular.tint(c)` | `.regularMaterial` + camada de cor |
| `.dark` | `Glass.regular.tint(black)` | `.ultraThickMaterial` + camada preta |

### Testes

```bash
swift test                                                   # macOS
xcodebuild test -scheme LiquidGlassKit \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'   # iOS Simulator
```

As suítes do Swift Testing cobrem a lógica de materiais e formas, a limitação dos valores do
tema, a resolução do modo de renderização, o builder de abas e os limites de fechamento da folha.
Renderizações fora da tela no caminho alternativo verificam que cada componente desenha o vidro
com o material do tema, que um material explícito tem prioridade sobre o tema, que os rótulos
sobre vidro escuro são brancos, que a folha escurece o fundo só enquanto está aberta e que
"Reduzir Transparência" desenha um fundo opaco. A CI roda a suíte no macOS, em um simulador do
iOS 26 e em um simulador do iOS 18.6, onde só existe a alternativa, e compila a biblioteca para
cada plataforma de `Package.swift`.

`ImageRenderer` não captura o desfoque nem o vidro nativo, então os testes verificam a
tonalidade e a cobertura da alternativa e se as views do caminho nativo são construídas; eles
não verificam a aparência final do vidro.

## Roteiro

Ainda não há versão planejada depois da 2.0.0. Relatos de bugs e pedidos de recursos são
acompanhados nas [issues](https://github.com/muhittincamdali/LiquidGlassKit/issues).

## Como contribuir

Contribuições são bem-vindas. Leia o [guia de contribuição](https://github.com/muhittincamdali/LiquidGlassKit/blob/main/CONTRIBUTING.md) e o [código de conduta](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md) antes de abrir um pull request. Relate problemas de segurança de forma privada, como descrito na [política de segurança](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md).

## Licença

Publicado sob a licença MIT. Veja [LICENSE](LICENSE).
