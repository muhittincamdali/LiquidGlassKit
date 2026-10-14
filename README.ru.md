<!-- i18n-source: README.md@1fdc5fa59b8a5bbcccee03211df035b12b5c5f6f status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/banner-ru-light.svg" alt="LiquidGlassKit: Поверхности и элементы управления Liquid Glass для SwiftUI: нативное стекло на OS 26, Material до iOS 17."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/LiquidGlassKit/actions/workflows/ci.yml/badge.svg" alt="Статус CI"></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-version-light.svg" alt="Последняя версия: v2.1.0"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-platforms-light.svg" alt="Поддерживаемые платформы: iOS 17+ · macOS 14+ · tvOS 17+ · watchOS 10+ · visionOS 1+"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-language-light.svg" alt="Версия языка: Swift 6.0+"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/badge-license-light.svg" alt="Лицензия: MIT"></picture></a>
</p>

<p align="center">
<a href="#быстрый-старт"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-start-ru-light.svg" alt="Начать"></picture></a>
<a href="https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-docs-ru-light.svg" alt="Документация"></picture></a>
<a href="https://github.com/muhittincamdali/LiquidGlassKit/tree/main/Examples/LiquidGlassDemo"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/LiquidGlassKit/main/.github/brand/button-examples-ru-light.svg" alt="Примеры"></picture></a>
</p>

> Это перевод README на английском языке. Если они расходятся, актуальна английская версия.

<!-- brand:end -->

LiquidGlassKit — пакет SwiftUI для приложений, которым нужны поверхности и элементы
управления Liquid Glass, но которые по-прежнему поддерживают системы без них. В iOS, macOS, tvOS
и watchOS 26 он рисует нативным `glassEffect` из SwiftUI; в более ранних версиях (вплоть до
iOS 17, macOS 14, tvOS 17 и watchOS 10) и в visionOS — размытием `Material` с оттенком, бликом по
краю и тенью. Код один и тот же для всех систем.

| Галерея (светлая тема) | Галерея (тёмная тема) | Нативное стекло и запасной вариант |
| --- | --- | --- |
| ![Галерея, светлая тема](docs/images/gallery-light.png) | ![Галерея, тёмная тема](docs/images/gallery-dark.png) | ![Нативное стекло и запасной вариант](docs/images/compare-light.png) |

## Основные возможности

- **Один модификатор, два пути** — `glassSurface` во время выполнения выбирает нативное
  стекло или запасной вариант на `Material` (fallback), а `glassRenderingMode(.fallback)`
  включает запасной вариант принудительно, если вам нужен одинаковый вид везде.
- **Готовые элементы управления** — кнопки, стиль переключателя, слайдер, карточки, текстовые
  поля, строка поиска, плавающая панель вкладок с необязательной кнопкой действия и бейджами на
  вкладках, панель навигации и нижний лист (bottom sheet); все они рисуются через
  `glassSurface`.
- **Эффекты** — стекло с градиентным оттенком и анимированные блики shimmer, pulse и breathe,
  которые работают на обоих путях.
- **Темы и пресеты** — `GlassTheme` задаёт материал, форму, тень и блик по краю для целой
  иерархии представлений, `GlassPreset` даёт имена 14 готовым темам, а `GlassCodeExporter`
  превращает тему, настроенную во время выполнения, обратно в код на Swift.
- **Универсальный доступ** — при включённом «Понижении прозрачности» (Reduce Transparency)
  запасной вариант рисует непрозрачный фон, а при «Увеличении контраста» (Increase Contrast) —
  более заметный край; блики останавливаются при «Уменьшении движения» (Reduce Motion),
  переключатель и слайдер сохраняют поведение VoiceOver из SwiftUI, панель вкладок сообщает о
  выбранной вкладке, а лист закрывается жестом отмены (escape).
- **Без конфликтов имён** — API не использует имена самого SwiftUI (`glassEffect`,
  `GlassEffectContainer`, `GlassButtonStyle`), поэтому оба модуля можно импортировать в одном
  файле.
- **Проверенная отрисовка** — наборы тестов Swift Testing запускаются в CI на macOS и в
  симуляторах iOS; закадровая отрисовка на запасном пути проверяет, что каждый компонент рисует
  стекло нужным материалом.

## Быстрый старт

**1. Добавьте пакет**

В Xcode выберите **File › Add Package Dependencies…** и введите адрес репозитория:

```text
https://github.com/muhittincamdali/LiquidGlassKit.git
```

Оставьте правило зависимости **Up to Next Major Version** начиная с 2.1.0 и нажмите **Add
Package**. В следующем окне выберите для `LiquidGlassKit` таргет вашего приложения и снова
нажмите **Add Package**.

**2. Импортируйте модуль**

```swift
import LiquidGlassKit
```

**3. Используйте**

Замените содержимое `ContentView.swift` этим представлением и запустите приложение (⌘R).
Поверх градиента появятся стеклянная карточка и стеклянная кнопка.

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

## Установка

### Swift Package Manager

В Xcode выберите **File › Add Package Dependencies…** и введите адрес репозитория:

```text
https://github.com/muhittincamdali/LiquidGlassKit.git
```

Или добавьте его в `dependencies` вашего `Package.swift`:

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

## Использование

Стеклу нужно что-то позади, поэтому размещайте эти представления поверх изображения,
градиента или прокручиваемого содержимого. Представления из этого README компилируются и
отрисовываются набором тестов
([`ReadmeExamplesTests.swift`](Tests/LiquidGlassKitTests/ReadmeExamplesTests.swift)).

### Любое представление на стекле

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

Материалы: `.clear`, `.frosted`, `.tinted(Color)` и `.dark`. Формы: скруглённый
прямоугольник, капсула, круг и отдельный радиус для каждого угла.

### Форма из элементов управления

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

### Плавающая панель вкладок и нижний лист

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

`GlassTabBar` работает с любым выбором типа `Hashable`, а его builder поддерживает `if` и
`for`. Вкладка показывает число или короткую подпись над значком с помощью `.badge(_:)`,
например `GlassTab("Profile", systemImage: "person", value: Screen.profile).badge(2)`. Лист
закрывается, если потянуть его вниз, коснуться затемнённого фона или выполнить жест отмены
универсального доступа. В tvOS лист недоступен.

### Переключатель, слайдер и эффекты

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

Стиль переключателя сохраняет универсальный доступ `Toggle`, а пользователи VoiceOver
двигают слайдер по одному шагу. При «Уменьшении движения» блики не рисуются. `GlassSlider` в
tvOS недоступен.

### Тема для всех представлений и выбор пути отрисовки

```swift
struct ThemedApp: View {
    var body: some View {
        RootView()
            .glassTheme(GlassTheme(material: .tinted(.indigo), shape: .roundedRectangle(cornerRadius: 12)))
            .glassRenderingMode(.automatic) // or .fallback to use the Material look everywhere
    }
}
```

Начните с одного из 14 пресетов из `GlassPreset.all`, измените его и превратите результат в
представление, которое можно вставить в проект:

```swift
var theme = GlassPreset.named("Ocean")?.theme ?? .standard
theme.shadowRadius = 4
let source = GlassCodeExporter().viewCode(named: "PromoCard", theme: theme)
```

### Обзор API

| API | Что делает |
| --- | --- |
| `glassSurface(_:in:interactive:)` | Подкладывает стекло под любое представление. Нативный `glassEffect` в OS 26, запасной вариант на `Material` в остальных случаях. |
| `GlassGroup` | В OS 26 оборачивает содержимое в `GlassEffectContainer`, чтобы соседние стеклянные формы сливались; в остальных случаях пропускает содержимое без изменений. |
| `GlassButton`, `.buttonStyle(.liquidGlass)` | Стеклянные кнопки-капсулы трёх размеров с состояниями нажатия, отключения и деструктивного действия. |
| `.toggleStyle(.liquidGlass)` | Переключатель со стеклянной дорожкой, которая во включённом состоянии заполняется цветом акцента; сохраняет универсальный доступ `Toggle`. |
| `GlassSlider` | Слайдер на стеклянной дорожке с шагами от нижней границы и любым `FormatStyle`. Нет в tvOS. |
| `GlassCard` | Контейнер с внутренними отступами на стекле. |
| `GlassTextField` | Текстовое поле с необязательным SF Symbol и кольцом фокуса. |
| `GlassSearchBar` | Поле поиска в форме капсулы с кнопками очистки и Cancel. |
| `GlassTabBar` | Плавающая панель вкладок, обобщённая по любому выбору типа `Hashable`; builder поддерживает `if` и `for`. |
| `GlassTabBarAction` | Круглая кнопка после вкладок для главного действия экрана. |
| `GlassTab.badge(_:)` | Число или короткая подпись в красной капсуле над значком вкладки; ноль скрывает бейдж. |
| `GlassNavigationBar` | Плавающая панель заголовка с элементами слева и справа. |
| `glassSheet(isPresented:material:content:)` | Плавающий нижний лист; закрывается перетаскиванием, касанием снаружи или жестом отмены. Нет в tvOS. |
| `glassGradient(_:direction:intensity:material:in:interactive:)` | Стекло с градиентным оттенком на обоих путях отрисовки. |
| `glassHighlight(_:color:in:)` | Анимированный блик shimmer, pulse или breathe поверх стекла; выключается при «Уменьшении движения». |
| `GlassTheme`, `GlassRenderingMode` | Значения окружения для материала, формы и тени по умолчанию и для принудительного запасного варианта. |
| `GlassPreset` | 14 именованных тем с отображаемыми названиями для меню выбора и экранов настроек. |
| `GlassCodeExporter` | Записывает темы, материалы, формы и цвета в виде кода на Swift, использующего этот пакет. |

## Демо

[`Examples/LiquidGlassDemo`](Examples/LiquidGlassDemo) — приложение для iOS с галереей
компонентов, панелями вкладок, нижним листом, сравнением нативного стекла с запасным вариантом
и экраном Playground, где настраивается тема и показывается её код. Откройте
`LiquidGlassDemo.xcodeproj`, выберите симулятор iPhone и запустите приложение; экраны и
аргументы запуска описаны в [README демо](Examples/LiquidGlassDemo/README.md). CI собирает
приложение для каждого pull request и каждого push в main.

| Нижний лист (светлая тема) | Панели вкладок (тёмная тема) | Playground (светлая тема) | Нативное стекло и запасной вариант (тёмная тема) |
| --- | --- | --- | --- |
| ![Стеклянный лист, светлая тема](docs/images/sheet-light.png) | ![Панели вкладок, тёмная тема](docs/images/tabs-dark.png) | ![Playground, светлая тема](docs/images/playground-light.png) | ![Нативное стекло и запасной вариант, тёмная тема](docs/images/compare-dark.png) |

<sub>Снимки экрана демо-приложения в симуляторе iOS 27, сделанные с помощью
[`scripts/screenshots.sh`](scripts/screenshots.sh).</sub>

## Документация

Справочник API и статьи:

- [Справочник API](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/) на GitHub Pages, собранный из каталога DocC в
  [`Sources/LiquidGlassKit/LiquidGlassKit.docc`](Sources/LiquidGlassKit/LiquidGlassKit.docc).
  В Xcode команда **Product › Build Documentation** открывает те же страницы без сети.
- Заметки о выпусках: [CHANGELOG.md](CHANGELOG.md).

## Руководства

Руководства написаны на английском языке.

- [Getting Started](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/gettingstarted)
  — пошаговое добавление пакета и первые стеклянные поверхности на экране.
- [Building a Screen with a Floating Tab Bar](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/buildingafloatingtabbarscreen)
  — панель заголовка, поле поиска, карточки, панель вкладок и лист поверх прокручиваемого содержимого за пять шагов.
- [Rendering Paths](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/renderingpaths)
  — что видят пользователи каждой системы и как включить запасной вариант принудительно.
- [Theming](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/theming)
  — готовые темы, собственные темы и материалы для отдельных компонентов.
- [Adding Controls and Effects](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/addingcontrolsandeffects)
  — стеклянные переключатель и слайдер, градиентное стекло, блики и кнопка действия на панели
  вкладок.
- [Tuning and Exporting a Look](https://muhittincamdali.github.io/LiquidGlassKit/documentation/liquidglasskit/tuningandexportingalook)
  — выбор пресета, настройка темы во время выполнения и копирование её в виде кода на Swift.

## Требования

| Платформа | Минимальная версия |
| --------- | --------------------- |
| iOS       | 17                    |
| macOS     | 14                    |
| tvOS      | 17                    |
| watchOS   | 10                    |
| visionOS  | 1                     |
| Инструменты | Swift 6.0 · Xcode 26+ |

Пакету нужен Xcode 26 или новее даже для старых deployment target, потому что нативный путь
компилируется с SDK OS 26.

## Архитектура

- `Sources/LiquidGlassKit/Core` содержит типы-значения `GlassMaterial`, `GlassShape`,
  `GlassTheme`, `GlassPreset` и `GlassRenderingMode`, а также `GlassCodeExporter`.
- `Sources/LiquidGlassKit/Surface` содержит `glassSurface` и `GlassGroup` — единственные места,
  где вызывается стеклянный API SwiftUI, — и модификаторы градиента и бликов, построенные на
  `glassSurface`.
- `Sources/LiquidGlassKit/Components` строит каждый элемент управления на основе `glassSurface`,
  поэтому тема и режим отрисовки действуют на все компоненты.

`glassSurface` сопоставляет `GlassRenderingMode` из окружения с
`GlassRenderingMode.isNativeGlassAvailable` — проверкой
`#available(iOS 26, macOS 26, tvOS 26, watchOS 26, *)`, которая в visionOS всегда возвращает
`false`, потому что там SwiftUI помечает `glassEffect` как недоступный. Каждому материалу
соответствует вариант на обоих путях:

| `GlassMaterial` | Нативный путь | Запасной путь |
| --- | --- | --- |
| `.clear` | `Glass.clear` | `.ultraThinMaterial` |
| `.frosted` | `Glass.regular` | `.thinMaterial` |
| `.tinted(c)` | `Glass.regular.tint(c)` | `.regularMaterial` + цветной слой |
| `.dark` | `Glass.regular.tint(black)` | `.ultraThickMaterial` + чёрный слой |

### Тесты

```bash
swift test                                                   # macOS
xcodebuild test -scheme LiquidGlassKit \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'   # iOS Simulator
```

Наборы тестов Swift Testing покрывают логику материалов и форм, ограничение значений темы и
градиента (включая NaN), выбор режима отрисовки, builder вкладок, пороги закрытия листа,
привязку слайдера к шагу при необычных шагах и диапазонах, тайминг бликов, поиск пресетов и
вывод экспортёра, три примера которого компилируются в тестовом таргете. Закадровая отрисовка
на запасном пути проверяет, что каждый компонент рисует стекло материалом темы, что явно
заданный материал важнее темы, что подписи на тёмном стекле белые, а у деструктивных кнопок
красные, что лист затемняет фон только пока показан и что при «Понижении прозрачности»
рисуется непрозрачный фон. CI запускает тесты на macOS, в симуляторе iOS 26 и в симуляторе
iOS 18.6, где есть только запасной путь, и собирает библиотеку для каждой платформы из
`Package.swift`.

`ImageRenderer` не захватывает размытие, а нативное стекло захватывает лишь частично, поэтому
тесты проверяют оттенок и площадь запасного варианта и то, что на нативном пути каждый компонент
отрисовывается иначе, чем на запасном; итоговый вид стекла они не проверяют.

## План развития

Выпуск после 2.1.0 пока не запланирован. Сообщения об ошибках и пожелания отслеживаются в
[issues](https://github.com/muhittincamdali/LiquidGlassKit/issues).

## Участие в разработке

Мы рады вашему участию. Перед открытием pull request прочитайте [руководство для участников](https://github.com/muhittincamdali/LiquidGlassKit/blob/main/CONTRIBUTING.md) и [кодекс поведения](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md). О проблемах безопасности сообщайте конфиденциально, как описано в [политике безопасности](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md).

## Лицензия

Распространяется по лицензии MIT. Подробнее — в файле [LICENSE](LICENSE).
