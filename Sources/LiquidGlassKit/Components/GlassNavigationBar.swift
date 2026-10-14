import SwiftUI

/// A floating title bar on glass with optional leading and trailing items.
///
/// Use it as a custom overlay when the system navigation bar does not fit,
/// for example over full-bleed media.
///
/// ```swift
/// GlassNavigationBar(title: "Library", subtitle: "128 items") {
///     Button("Back", systemImage: "chevron.left") { dismiss() }
/// } trailing: {
///     Button("Add", systemImage: "plus") { add() }
/// }
/// ```
public struct GlassNavigationBar<Leading: View, Trailing: View>: View {
    private let title: String
    private let subtitle: String?
    private let material: GlassMaterial?
    private let leading: Leading
    private let trailing: Trailing

    public init(
        title: String,
        subtitle: String? = nil,
        material: GlassMaterial? = nil,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.subtitle = subtitle
        self.material = material
        self.leading = leading()
        self.trailing = trailing()
    }

    public var body: some View {
        ZStack {
            VStack(spacing: 1) {
                Text(title)
                    .font(.headline)
                    .lineLimit(1)
                if let subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isHeader)

            HStack {
                leading
                Spacer(minLength: 0)
                trailing
            }
            .labelStyle(.iconOnly)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(minHeight: 44)
        .glassSurface(material, in: .capsule)
    }
}

extension GlassNavigationBar where Leading == EmptyView, Trailing == EmptyView {
    /// A bar with only a title and optional subtitle.
    public init(title: String, subtitle: String? = nil, material: GlassMaterial? = nil) {
        self.init(
            title: title,
            subtitle: subtitle,
            material: material,
            leading: { EmptyView() },
            trailing: { EmptyView() }
        )
    }
}

extension GlassNavigationBar where Trailing == EmptyView {
    /// A bar with a title and leading items.
    public init(
        title: String,
        subtitle: String? = nil,
        material: GlassMaterial? = nil,
        @ViewBuilder leading: () -> Leading
    ) {
        self.init(title: title, subtitle: subtitle, material: material, leading: leading, trailing: { EmptyView() })
    }
}
