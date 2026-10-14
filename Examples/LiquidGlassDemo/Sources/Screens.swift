import LiquidGlassKit
import SwiftUI

struct GalleryScreen: View {
    @State private var email = ""
    @State private var query = ""
    @State private var notifications = true
    @State private var volume = 0.6

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                GlassNavigationBar(title: "LiquidGlassKit", subtitle: "Component gallery") {
                    Button("Back", systemImage: "chevron.left") {}
                } trailing: {
                    Button("Add", systemImage: "plus") {}
                }

                GlassSearchBar(text: $query, prompt: "Search components")

                GlassCard {
                    VStack(alignment: .leading, spacing: 6) {
                        Label("Storage", systemImage: "internaldrive")
                            .font(.headline)
                        Text("42 GB of 128 GB used")
                            .foregroundStyle(.secondary)
                        ProgressView(value: 42, total: 128)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                GlassTextField("Email", text: $email, systemImage: "envelope")

                GlassCard {
                    VStack(spacing: 14) {
                        Toggle("Notifications", isOn: $notifications)
                            .toggleStyle(.liquidGlass)
                        GlassSlider("Volume", value: $volume, format: .percent.precision(.fractionLength(0)))
                    }
                }

                GlassGroup(spacing: 12) {
                    HStack(spacing: 12) {
                        GlassButton("Play", systemImage: "play.fill") {}
                        GlassButton("Share", systemImage: "square.and.arrow.up", material: .tinted(.blue)) {}
                    }
                }

                HStack(spacing: 12) {
                    Button("Compact") {}.buttonStyle(.liquidGlass(size: .compact))
                    Button("Delete", role: .destructive) {}.buttonStyle(.liquidGlass(.tinted(.red), size: .compact))
                    Button("Dark") {}.buttonStyle(.liquidGlass(.dark, size: .compact))
                }

                MaterialRow()

                Label("Gradient glass", systemImage: "sparkles")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 64)
                    .glassGradient([.cyan, .blue, .purple], in: .roundedRectangle(cornerRadius: 20))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
        }
    }
}

struct MaterialRow: View {
    private let materials: [GlassMaterial] = [.clear, .frosted, .tinted(.mint), .dark]

    var body: some View {
        HStack(spacing: 10) {
            ForEach(materials, id: \.self) { material in
                Text(material.displayName)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(material == .dark ? .white : .primary)
                    .frame(maxWidth: .infinity, minHeight: 64)
                    .glassSurface(material, in: .roundedRectangle(cornerRadius: 16))
            }
        }
    }
}

struct TabsScreen: View {
    enum Section: Hashable { case home, search, inbox, profile }
    @State private var section = Section.home
    @State private var showsLabels = true

    var body: some View {
        VStack(spacing: 24) {
            GlassNavigationBar(title: "Tab bar", subtitle: "Generic selection")
            GlassCard {
                Toggle("Show labels", isOn: $showsLabels)
            }
            GlassTabBar(selection: $section, material: .tinted(.purple), showsLabels: showsLabels) {
                GlassTab("Home", systemImage: "house", value: Section.home)
                GlassTab("Search", systemImage: "magnifyingglass", value: Section.search)
                GlassTab("Inbox", systemImage: "tray", value: Section.inbox)
                GlassTab("Profile", systemImage: "person", value: Section.profile)
            }
            GlassTabBar(selection: $section, material: .dark, showsLabels: false) {
                GlassTab("Home", systemImage: "house", value: Section.home)
                GlassTab("Search", systemImage: "magnifyingglass", value: Section.search)
                GlassTab("Profile", systemImage: "person", value: Section.profile)
            }
            GlassTabBar(
                selection: $section,
                showsLabels: showsLabels,
                action: GlassTabBarAction("New Post", systemImage: "plus") {}
            ) {
                GlassTab("Home", systemImage: "house", value: Section.home)
                GlassTab("Inbox", systemImage: "tray", value: Section.inbox)
                GlassTab("Profile", systemImage: "person", value: Section.profile)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct SheetScreen: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack(spacing: 24) {
            GlassNavigationBar(title: "Sheet", subtitle: "Drag down or tap outside to close")
            GlassButton("Show sheet", systemImage: "rectangle.bottomhalf.inset.filled", size: .large) {
                isPresented = true
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct ShareSheetContent: View {
    @Binding var isPresented: Bool
    @State private var caption = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Share photo").font(.title3.bold())
            GlassTextField("Add a caption", text: $caption, systemImage: "text.bubble")
            HStack {
                GlassButton("Cancel") { isPresented = false }
                Spacer()
                GlassButton("Post", systemImage: "paperplane.fill", material: .tinted(.blue)) { isPresented = false }
            }
        }
        .padding(.horizontal, 24)
    }
}

struct CompareScreen: View {
    var body: some View {
        VStack(spacing: 16) {
            GlassNavigationBar(title: "Rendering paths", subtitle: nativeSubtitle)
            HStack(alignment: .top, spacing: 12) {
                column(title: "Native", mode: .automatic)
                column(title: "Fallback", mode: .fallback)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }

    private var nativeSubtitle: String {
        GlassRenderingMode.isNativeGlassAvailable ? "Native glass available" : "Native glass unavailable on this OS"
    }

    private func column(title: String, mode: GlassRenderingMode) -> some View {
        VStack(spacing: 12) {
            Text(title).font(.headline).foregroundStyle(.white)
            GlassCard { Text("Card").frame(maxWidth: .infinity) }
            GlassButton("Button", systemImage: "star.fill") {}
            Text("Tinted")
                .frame(maxWidth: .infinity, minHeight: 56)
                .glassSurface(.tinted(.orange), in: .capsule)
            Text("Dark")
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 56)
                .glassSurface(.dark, in: .roundedRectangle(cornerRadius: 14))
        }
        .glassRenderingMode(mode)
    }
}
