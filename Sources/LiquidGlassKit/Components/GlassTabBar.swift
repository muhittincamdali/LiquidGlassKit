import SwiftUI

// MARK: - GlassTab

/// Represents a single tab item in a `GlassTabBar`.
public struct GlassTab: Identifiable {

    public let id: Int
    public let title: String
    public let icon: String
    public let tag: Int

    /// Creates a glass tab item.
    /// - Parameters:
    ///   - title: Display label for the tab.
    ///   - icon: SF Symbol name for the tab icon.
    ///   - tag: Integer tag identifying the tab.
    public init(_ title: String, icon: String, tag: Int) {
        self.id = tag
        self.title = title
        self.icon = icon
        self.tag = tag
    }
}

// MARK: - GlassTabBar

/// A tab bar component with Liquid Glass background.
/// Supports selection animation, badge indicators, and configurable material.
public struct GlassTabBar: View {

    // MARK: - Properties

    @Binding private var selection: Int
    private let tabs: [GlassTab]
    private let material: GlassMaterial
    private let showLabels: Bool

    // MARK: - Initialization

    /// Creates a glass tab bar.
    /// - Parameters:
    ///   - selection: Binding to the selected tab index.
    ///   - material: Glass material. Default is `.frosted`.
    ///   - showLabels: Whether to show text labels. Default is true.
    ///   - tabs: Builder closure returning tab items.
    public init(
        selection: Binding<Int>,
        material: GlassMaterial = .frosted,
        showLabels: Bool = true,
        @GlassTabBuilder tabs: () -> [GlassTab]
    ) {
        self._selection = selection
        self.material = material
        self.showLabels = showLabels
        self.tabs = tabs()
    }

    // MARK: - Body

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs) { tab in
                tabItem(tab)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(material.swiftUIMaterial)
                .overlay(
                    Capsule()
                        .fill(material.tintColor)
                )
                .overlay(
                    Capsule()
                        .stroke(.white.opacity(0.2), lineWidth: 0.5)
                )
        )
        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
        .padding(.horizontal, 24)
    }

    // MARK: - Private

    @ViewBuilder
    private func tabItem(_ tab: GlassTab) -> some View {
        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                selection = tab.tag
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.icon)
                    .font(.system(size: 20, weight: .medium))
                    .symbolVariant(selection == tab.tag ? .fill : .none)

                if showLabels {
                    Text(tab.title)
                        .font(.caption2)
                        .lineLimit(1)
                }
            }
            .foregroundStyle(selection == tab.tag ? .primary : .secondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
            .background(
                Group {
                    if selection == tab.tag {
                        Capsule()
                            .fill(.white.opacity(0.15))
                    }
                }
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - GlassTabBuilder

/// Result builder for constructing `GlassTab` arrays declaratively.
@resultBuilder
public struct GlassTabBuilder {

    public static func buildBlock(_ components: GlassTab...) -> [GlassTab] {
        components
    }

    public static func buildArray(_ components: [[GlassTab]]) -> [GlassTab] {
        components.flatMap { $0 }
    }
}

// MARK: - Preview

#if DEBUG
struct GlassTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(
                colors: [.indigo, .purple],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Spacer()
                GlassTabBar(selection: .constant(0)) {
                    GlassTab("Home", icon: "house", tag: 0)
                    GlassTab("Search", icon: "magnifyingglass", tag: 1)
                    GlassTab("Favorites", icon: "heart", tag: 2)
                    GlassTab("Profile", icon: "person", tag: 3)
                }
            }
            .padding(.bottom, 20)
        }
    }
}
#endif
