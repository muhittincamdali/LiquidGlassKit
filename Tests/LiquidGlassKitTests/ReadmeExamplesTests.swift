// The usage examples from README.md and the DocC articles, copied verbatim so that
// API changes which break the documentation also break the build.
import LiquidGlassKit
import SwiftUI
import Testing

// MARK: - README: Any view on glass

private struct NowPlayingBadge: View {
    var body: some View {
        Label("Now Playing", systemImage: "music.note")
            .padding()
            .glassSurface(.tinted(.purple), in: .capsule)
    }
}

// MARK: - README: Controls

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

// MARK: - README: Tab bar and sheet

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

// MARK: - README: Theme and rendering path

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

// MARK: - Render each example once

@MainActor
@Suite("Documentation examples")
struct ReadmeExamplesTests {
    private var examples: [AnyView] {
        var views: [AnyView] = [
            AnyView(NowPlayingBadge()),
            AnyView(SignInForm()),
            AnyView(NowPlaying()),
            AnyView(GettingStartedSnippets()),
            AnyView(SettingsView()),
            AnyView(ThemingSnippets())
        ]
        #if !os(tvOS)
        views.append(AnyView(ThemedApp()))
        #endif
        return views
    }

    /// Every example builds on both paths and draws on the fallback path (on a
    /// white canvas; see ``RenderingTests`` for why).
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
