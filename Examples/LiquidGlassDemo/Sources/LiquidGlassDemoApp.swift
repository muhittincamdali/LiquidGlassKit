import LiquidGlassKit
import SwiftUI

/// Demo app for LiquidGlassKit.
///
/// Launch arguments (used by `scripts/screenshots.sh`):
/// - `-screen gallery|tabs|sheet|compare` opens a specific screen.
/// - `-renderingMode automatic|native|fallback` forces a rendering path.
/// - `-presentSheet` opens the glass sheet on launch.
@main
struct LiquidGlassDemoApp: App {
    private let options = LaunchOptions(arguments: ProcessInfo.processInfo.arguments)

    var body: some Scene {
        WindowGroup {
            RootView(initialScreen: options.screen, presentsSheet: options.presentsSheet)
                .glassRenderingMode(options.renderingMode)
        }
    }
}

enum DemoScreen: String, CaseIterable, Hashable {
    case gallery, tabs, sheet, compare
}

struct LaunchOptions {
    var screen: DemoScreen = .gallery
    var renderingMode: GlassRenderingMode = .automatic
    var presentsSheet = false

    init(arguments: [String]) {
        presentsSheet = arguments.contains("-presentSheet")
        if let value = Self.value(after: "-screen", in: arguments), let screen = DemoScreen(rawValue: value) {
            self.screen = screen
        }
        if let value = Self.value(after: "-renderingMode", in: arguments),
           let mode = GlassRenderingMode(rawValue: value) {
            self.renderingMode = mode
        }
    }

    private static func value(after flag: String, in arguments: [String]) -> String? {
        guard let index = arguments.firstIndex(of: flag), arguments.indices.contains(index + 1) else { return nil }
        return arguments[index + 1]
    }
}

struct RootView: View {
    @State private var screen: DemoScreen
    @State private var isSheetPresented: Bool

    init(initialScreen: DemoScreen, presentsSheet: Bool = false) {
        _screen = State(initialValue: initialScreen)
        _isSheetPresented = State(initialValue: presentsSheet)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            DemoBackground()
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            GlassTabBar(selection: $screen) {
                GlassTab("Gallery", systemImage: "square.grid.2x2", value: DemoScreen.gallery)
                GlassTab("Tabs", systemImage: "menubar.rectangle", value: DemoScreen.tabs)
                GlassTab("Sheet", systemImage: "rectangle.bottomhalf.inset.filled", value: DemoScreen.sheet)
                GlassTab("Compare", systemImage: "square.split.2x1", value: DemoScreen.compare)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
        }
        .glassSheet(isPresented: $isSheetPresented) {
            ShareSheetContent(isPresented: $isSheetPresented)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch screen {
        case .gallery: GalleryScreen()
        case .tabs: TabsScreen()
        case .sheet: SheetScreen(isPresented: $isSheetPresented)
        case .compare: CompareScreen()
        }
    }
}

/// A colorful backdrop so translucency is visible.
struct DemoBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
            Circle().fill(.orange).frame(width: 260).blur(radius: 30).offset(x: -120, y: -220)
            Circle().fill(.cyan).frame(width: 220).blur(radius: 20).offset(x: 140, y: 120)
            Circle().fill(.yellow.opacity(0.8)).frame(width: 160).offset(x: -100, y: 260)
        }
        .ignoresSafeArea()
    }
}
