// The usage examples from README.md and the DocC articles, copied verbatim so that
// API changes which break the documentation also break the build.
import LiquidGlassKit
import SwiftUI
import Testing

// MARK: - README: Quick start

private struct ContentView: View {
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

// MARK: - README: Put any view on glass

private struct NowPlayingBadge: View {
    var body: some View {
        Label("Now Playing", systemImage: "music.note")
            .padding()
            .glassSurface(.tinted(.purple), in: .capsule)
    }
}

// MARK: - README: Build a form from controls

private struct SignInForm: View {
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

// MARK: - README: Float a tab bar and open a sheet

private enum Screen: Hashable { case home, search, profile }

#if !os(tvOS)
private struct RootView: View {
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

// MARK: - README: Theme every view and choose the rendering path

private struct ThemedApp: View {
    var body: some View {
        RootView()
            .glassTheme(GlassTheme(material: .tinted(.indigo), shape: .roundedRectangle(cornerRadius: 12)))
            .glassRenderingMode(.automatic) // or .fallback to use the Material look everywhere
    }
}
#endif

// MARK: - DocC: LiquidGlassKit landing page

private struct NowPlaying: View {
    var body: some View {
        VStack(spacing: 16) {
            GlassCard {
                Label("Midnight City", systemImage: "music.note")
            }
            GlassButton("Play", systemImage: "play.fill") {}
        }
    }
}

// MARK: - DocC: Getting Started

private struct GettingStartedSnippets: View {
    var body: some View {
        VStack {
            Text("Hello")
                .padding()
                .glassSurface()

            Label("Now Playing", systemImage: "music.note")
                .padding()
                .glassSurface(.tinted(.purple), in: .capsule)
        }
    }
}

private struct SettingsView: View {
    @State private var name = ""
    @State private var query = ""

    var body: some View {
        VStack(spacing: 16) {
            GlassSearchBar(text: $query)
            GlassTextField("Name", text: $name, systemImage: "person")
            GlassCard {
                Toggle("Notifications", isOn: .constant(true))
            }
            Button("Save") {}
                .buttonStyle(.liquidGlass(.tinted(.blue)))
        }
        .padding()
    }
}

// MARK: - DocC: Theming and Rendering Paths

extension GlassTheme {
    fileprivate static let brand = GlassTheme(
        material: .tinted(.indigo),
        shape: .roundedRectangle(cornerRadius: 12),
        shadowRadius: 6
    )
}

private struct ThemingSnippets: View {
    var body: some View {
        VStack {
            SettingsView().glassTheme(.subtle)
            SettingsView().glassTheme(.brand)
            SettingsView().glassRenderingMode(.fallback)
        }
    }
}

// MARK: - DocC: Building a Screen with a Floating Tab Bar

#if !os(tvOS)
private enum LibrarySection: Hashable {
    case albums, artists, playlists
}

private struct LibraryScreen: View {
    @State private var section = LibrarySection.albums
    @State private var query = ""
    @State private var showsNowPlaying = false

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 16) {
                    GlassNavigationBar(title: "Library", subtitle: "128 albums") {
                        Button("Back", systemImage: "chevron.left") {}
                    } trailing: {
                        Button("Now Playing", systemImage: "music.note") {
                            showsNowPlaying = true
                        }
                    }
                    GlassSearchBar(text: $query, prompt: "Search the library")
                    ForEach(1...12, id: \.self) { index in
                        GlassCard {
                            Label("Album \(index)", systemImage: "square.stack")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            }
            .background {
                LinearGradient(colors: [.indigo, .purple, .pink], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            }

            GlassTabBar(selection: $section) {
                GlassTab("Albums", systemImage: "square.stack", value: LibrarySection.albums)
                GlassTab("Artists", systemImage: "music.mic", value: LibrarySection.artists)
                GlassTab("Playlists", systemImage: "music.note.list", value: LibrarySection.playlists)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
        }
        .glassSheet(isPresented: $showsNowPlaying) {
            VStack(spacing: 12) {
                Text("Midnight City").font(.headline)
                GlassGroup(spacing: 12) {
                    HStack(spacing: 12) {
                        GlassButton("Previous", systemImage: "backward.fill") {}
                        GlassButton("Play", systemImage: "play.fill", material: .tinted(.blue)) {}
                        GlassButton("Next", systemImage: "forward.fill") {}
                    }
                }
            }
            .padding()
        }
    }
}

private struct LibraryScreenSnippets: View {
    var body: some View {
        LibraryScreen()
            .glassRenderingMode(.fallback)
    }
}
#endif

// MARK: - DocC: Adding Controls and Effects

#if !os(tvOS)
private struct NotificationSettings: View {
    @State private var isEnabled = true
    @State private var showsPreviews = false

    var body: some View {
        GlassCard {
            VStack(spacing: 14) {
                Toggle("Notifications", isOn: $isEnabled)
                    .toggleStyle(.liquidGlass)
                Toggle("Show Previews", isOn: $showsPreviews)
                    .toggleStyle(.liquidGlass(tint: .green))
            }
        }
    }
}

private struct PlaybackSettings: View {
    @State private var volume = 0.6
    @State private var rate = 1.0

    var body: some View {
        GlassCard {
            VStack(spacing: 14) {
                GlassSlider("Volume", value: $volume, format: .percent)
                GlassSlider("Speed", value: $rate, in: 0.5...2, step: 0.25)
            }
        }
    }
}
#endif

private struct SunsetBadge: View {
    var body: some View {
        Label("Golden hour", systemImage: "sun.horizon")
            .padding()
            .glassGradient([.orange, .pink], direction: .horizontal, in: .capsule)
    }
}

private struct UpgradeButton: View {
    var body: some View {
        GlassButton("Upgrade", systemImage: "sparkles", material: .tinted(.purple)) {}
            .glassHighlight(.shimmer, in: .capsule)
    }
}

private struct InboxTabs: View {
    enum Section: Hashable { case inbox, archive }
    @State private var section = Section.inbox

    var body: some View {
        GlassTabBar(
            selection: $section,
            action: GlassTabBarAction("New Message", systemImage: "square.and.pencil") {}
        ) {
            GlassTab("Inbox", systemImage: "tray", value: Section.inbox)
            GlassTab("Archive", systemImage: "archivebox", value: Section.archive)
        }
    }
}

// MARK: - DocC: Tuning and Exporting a Look

private struct PresetSnippet: View {
    var body: some View {
        SettingsView()
            .glassTheme(.aqua)
    }
}

private struct AppearancePicker: View {
    @AppStorage("glassStyle") private var styleName = "Standard"

    var body: some View {
        VStack {
            Picker("Style", selection: $styleName) {
                ForEach(GlassPreset.all) { preset in
                    Text(preset.name).tag(preset.name)
                }
            }
            GlassCard { Text("Preview") }
        }
        .glassTheme(GlassPreset.named(styleName)?.theme ?? .standard)
    }
}

#if !os(tvOS)
private struct ThemeTuner: View {
    @State private var theme = GlassTheme.ocean

    var body: some View {
        VStack(spacing: 16) {
            GlassCard { Text("Preview") }
            GlassSlider("Shadow", value: $theme.shadowRadius.asDouble, in: 0...30, step: 1)
            GlassSlider("Edge", value: $theme.strokeOpacity, format: .percent)
        }
        .glassTheme(theme)
    }
}

extension CGFloat {
    /// Lets a `CGFloat` property drive a `Double` slider.
    fileprivate var asDouble: Double {
        get { Double(self) }
        set { self = CGFloat(newValue) }
    }
}
#endif

@Suite("Exporter documentation")
struct ExporterDocumentationTests {
    /// The values quoted in the article and in GlassCodeExporter's documentation.
    @Test func quotedOutputsMatch() {
        let exporter = GlassCodeExporter()
        exporter.themeArgument(for: .aqua)                        // ".aqua"
        exporter.code(for: GlassTheme(material: .tinted(.teal)))  // "GlassTheme(material: .tinted(.teal))"
        exporter.code(for: GlassShape.topRounded(24))             // ".topRounded(24)"
        #expect(exporter.themeArgument(for: .aqua) == ".aqua")
        #expect(exporter.code(for: GlassTheme(material: .tinted(.teal))) == "GlassTheme(material: .tinted(.teal))")
        #expect(exporter.code(for: GlassShape.topRounded(24)) == ".topRounded(24)")
        #expect(exporter.code(for: GlassMaterial.tinted(.blue)) == ".tinted(.blue)")
        #expect(exporter.code(for: GlassTheme(shadowRadius: 4)) == "GlassTheme(shadowRadius: 4)")
    }

    @Test func viewCodeSnippetNamesTheView() {
        let theme = GlassTheme.ocean
        let exporter = GlassCodeExporter(indentWidth: 2)
        let source = exporter.viewCode(named: "Promo Card", theme: theme, renderingMode: .fallback)
        #expect(source.contains("struct PromoCard: View {"))
        #expect(source.contains("\n  var body: some View {"))
        #expect(source.contains(".glassTheme(.ocean)"))
        #expect(source.contains(".glassRenderingMode(.fallback)"))
    }
}

// MARK: - Render each example once

@MainActor
@Suite("Documentation examples")
struct ReadmeExamplesTests {
    private var examples: [AnyView] {
        var views: [AnyView] = [
            AnyView(ContentView()),
            AnyView(NowPlayingBadge()),
            AnyView(SignInForm()),
            AnyView(NowPlaying()),
            AnyView(GettingStartedSnippets()),
            AnyView(SettingsView()),
            AnyView(ThemingSnippets()),
            AnyView(SunsetBadge()),
            AnyView(UpgradeButton()),
            AnyView(InboxTabs()),
            AnyView(PresetSnippet()),
            AnyView(AppearancePicker())
        ]
        #if !os(tvOS)
        views.append(AnyView(ThemedApp()))
        views.append(AnyView(LibraryScreen()))
        views.append(AnyView(LibraryScreenSnippets()))
        views.append(AnyView(NotificationSettings()))
        views.append(AnyView(PlaybackSettings()))
        views.append(AnyView(ThemeTuner()))
        #endif
        return views
    }

    /// Every example builds on both paths and draws on the fallback path (on a
    /// white canvas; see ``RenderingTests`` for why). Some examples set their own
    /// rendering mode, so the native path is not compared with the fallback here;
    /// ``RenderingTests`` does that for every component.
    @Test(arguments: [GlassRenderingMode.fallback, .automatic])
    func examplesRender(mode: GlassRenderingMode) throws {
        for (index, example) in examples.enumerated() {
            let renderer = ImageRenderer(
                content: example
                    .glassRenderingMode(mode)
                    .frame(width: 390, height: 600)
                    .background(.white)
            )
            let image = try #require(renderer.cgImage, "example \(index) did not render")
            if mode == .fallback {
                #expect(Bitmap(image).count(where: Bitmap.differsFromWhite) > 0, "example \(index) drew nothing")
            }
        }
    }
}
