import SwiftUI

/// One item in a ``GlassTabBar``.
public struct GlassTab<Value: Hashable>: Identifiable {
    public let title: String
    public let systemImage: String
    public let value: Value

    public var id: Value { value }

    /// - Parameters:
    ///   - title: Label shown under the icon and read by VoiceOver.
    ///   - systemImage: SF Symbol name. The filled variant is used when selected.
    ///   - value: The selection value this tab represents.
    public init(_ title: String, systemImage: String, value: Value) {
        self.title = title
        self.systemImage = systemImage
        self.value = value
    }
}

extension GlassTab: Sendable where Value: Sendable {}

/// Collects ``GlassTab`` values, with support for `if`, `if`/`else` and `for` loops.
@resultBuilder
public enum GlassTabBuilder<Value: Hashable> {
    public static func buildExpression(_ tab: GlassTab<Value>) -> [GlassTab<Value>] { [tab] }
    public static func buildBlock(_ components: [GlassTab<Value>]...) -> [GlassTab<Value>] { components.flatMap { $0 } }
    public static func buildOptional(_ component: [GlassTab<Value>]?) -> [GlassTab<Value>] { component ?? [] }
    public static func buildEither(first component: [GlassTab<Value>]) -> [GlassTab<Value>] { component }
    public static func buildEither(second component: [GlassTab<Value>]) -> [GlassTab<Value>] { component }
    public static func buildArray(_ components: [[GlassTab<Value>]]) -> [GlassTab<Value>] { components.flatMap { $0 } }
}

/// A floating capsule tab bar on glass.
///
/// ```swift
/// enum Screen: Hashable { case home, search, profile }
/// @State private var screen = Screen.home
///
/// GlassTabBar(selection: $screen) {
///     GlassTab("Home", systemImage: "house", value: Screen.home)
///     GlassTab("Search", systemImage: "magnifyingglass", value: Screen.search)
///     GlassTab("Profile", systemImage: "person", value: Screen.profile)
/// }
/// ```
///
/// Tabs with duplicate values are shown once (the first occurrence wins).
public struct GlassTabBar<Value: Hashable>: View {
    @Binding private var selection: Value
    private let tabs: [GlassTab<Value>]
    private let material: GlassMaterial?
    private let showsLabels: Bool

    @Namespace private var indicator

    public init(
        selection: Binding<Value>,
        material: GlassMaterial? = nil,
        showsLabels: Bool = true,
        @GlassTabBuilder<Value> tabs: () -> [GlassTab<Value>]
    ) {
        self._selection = selection
        self.material = material
        self.showsLabels = showsLabels
        self.tabs = Self.uniqued(tabs())
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs) { tab in
                item(for: tab)
            }
        }
        .padding(6)
        .glassSurface(material, in: .capsule)
    }

    private func item(for tab: GlassTab<Value>) -> some View {
        let isSelected = tab.value == selection
        return Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                selection = tab.value
            }
        } label: {
            VStack(spacing: 3) {
                Image(systemName: tab.systemImage)
                    .font(.system(size: 18, weight: .medium))
                    .symbolVariant(isSelected ? .fill : .none)
                if showsLabels {
                    Text(tab.title)
                        .font(.caption2.weight(.medium))
                        .lineLimit(1)
                }
            }
            .foregroundStyle(isSelected ? AnyShapeStyle(.tint) : AnyShapeStyle(.secondary))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
            .background {
                if isSelected {
                    Capsule()
                        .fill(.primary.opacity(0.08))
                        .matchedGeometryEffect(id: "selection", in: indicator)
                }
            }
            .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(tab.title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    nonisolated static func uniqued(_ tabs: [GlassTab<Value>]) -> [GlassTab<Value>] {
        var seen = Set<Value>()
        return tabs.filter { seen.insert($0.value).inserted }
    }
}
