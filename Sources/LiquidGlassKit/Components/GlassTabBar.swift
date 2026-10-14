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

/// A round button shown after the tabs of a ``GlassTabBar`` for the screen's primary action.
public struct GlassTabBarAction {
    /// Read by VoiceOver; not shown on screen.
    public let title: String
    /// SF Symbol name.
    public let systemImage: String
    /// The button's glass material, or `nil` for glass tinted with the accent color.
    public let material: GlassMaterial?
    /// Runs when the button is tapped.
    public let action: () -> Void

    public init(
        _ title: String,
        systemImage: String,
        material: GlassMaterial? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.material = material
        self.action = action
    }
}

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
///
/// Pass an ``GlassTabBarAction`` to show a round glass button for the screen's
/// primary action, such as composing or adding, after the tabs:
///
/// ```swift
/// GlassTabBar(selection: $screen, action: GlassTabBarAction("New Post", systemImage: "plus") {
///     isComposing = true
/// }) {
///     GlassTab("Home", systemImage: "house", value: Screen.home)
///     GlassTab("Search", systemImage: "magnifyingglass", value: Screen.search)
/// }
/// ```
public struct GlassTabBar<Value: Hashable>: View {
    @Binding private var selection: Value
    private let tabs: [GlassTab<Value>]
    private let material: GlassMaterial?
    private let showsLabels: Bool
    private let action: GlassTabBarAction?

    @Namespace private var indicator

    /// Creates a tab bar without an action button.
    ///
    /// - Parameters:
    ///   - selection: The selected tab's value.
    ///   - material: The glass material, or `nil` to use the theme's material.
    ///   - showsLabels: Shows each tab's title under its icon.
    ///   - tabs: The tabs, in order.
    public init(
        selection: Binding<Value>,
        material: GlassMaterial? = nil,
        showsLabels: Bool = true,
        @GlassTabBuilder<Value> tabs: () -> [GlassTab<Value>]
    ) {
        self.init(selection: selection, material: material, showsLabels: showsLabels, action: nil, tabs: tabs)
    }

    /// Creates a tab bar with a round action button after the tabs.
    ///
    /// - Parameters:
    ///   - selection: The selected tab's value.
    ///   - material: The glass material, or `nil` to use the theme's material.
    ///   - showsLabels: Shows each tab's title under its icon.
    ///   - action: A round button after the tabs, or `nil` to hide it, for
    ///     example while a search field is focused.
    ///   - tabs: The tabs, in order.
    public init(
        selection: Binding<Value>,
        material: GlassMaterial? = nil,
        showsLabels: Bool = true,
        action: GlassTabBarAction?,
        @GlassTabBuilder<Value> tabs: () -> [GlassTab<Value>]
    ) {
        self._selection = selection
        self.material = material
        self.showsLabels = showsLabels
        self.action = action
        self.tabs = Self.uniqued(tabs())
    }

    public var body: some View {
        if let action {
            GlassGroup(spacing: Self.actionSpacing) {
                TabBarActionLayout(spacing: Self.actionSpacing) {
                    tabCapsule
                    actionButton(action)
                }
            }
        } else {
            tabCapsule
        }
    }

    private var tabCapsule: some View {
        HStack(spacing: 0) {
            ForEach(tabs) { tab in
                item(for: tab)
            }
        }
        .padding(6)
        .glassSurface(material, in: .capsule)
    }

    /// A circle as tall as the tab capsule, so both read as one bar.
    private func actionButton(_ action: GlassTabBarAction) -> some View {
        let material = action.material ?? .tinted(.accentColor)
        return Button(action: action.action) {
            Image(systemName: action.systemImage)
                .font(.system(size: 20, weight: .semibold))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(material == .dark ? AnyShapeStyle(.white) : AnyShapeStyle(.primary))
                .glassSurface(material, in: .circle, interactive: true)
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(action.title)
    }

    static var actionSpacing: CGFloat { 10 }

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

/// Lays out the tab capsule and, after it, a square as tall as the capsule.
///
/// An `HStack` cannot do this: the capsule's height depends on Dynamic Type,
/// and a flexible square in a stack takes its side from the width it is offered.
struct TabBarActionLayout: Layout {
    let spacing: CGFloat

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard let frames = frames(in: proposal, subviews: subviews) else { return .zero }
        return CGSize(width: frames.action.maxX, height: frames.bar.height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard let frames = frames(in: ProposedViewSize(bounds.size), subviews: subviews) else { return }
        for (subview, frame) in zip(subviews, [frames.bar, frames.action]) {
            subview.place(
                at: CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY),
                proposal: ProposedViewSize(frame.size)
            )
        }
    }

    /// The capsule from the leading edge, then the square after `spacing`.
    private func frames(in proposal: ProposedViewSize, subviews: Subviews) -> (bar: CGRect, action: CGRect)? {
        guard subviews.count == 2 else { return nil }
        let side = subviews[0].sizeThatFits(ProposedViewSize(width: proposal.width, height: nil)).height
        let barWidth: CGFloat
        if let width = proposal.width {
            barWidth = max(0, width - spacing - side)
        } else {
            barWidth = subviews[0].sizeThatFits(.unspecified).width
        }
        let bar = CGRect(x: 0, y: 0, width: barWidth, height: side)
        return (bar, CGRect(x: barWidth + spacing, y: 0, width: side, height: side))
    }
}
