import SwiftUI

// MARK: - GlassNavigationBar

/// A navigation bar component with Liquid Glass background.
/// Supports leading and trailing action items, title, and subtitle.
/// Automatically adapts to safe area insets.
public struct GlassNavigationBar<Leading: View, Trailing: View>: View {

    // MARK: - Properties

    private let title: String
    private let subtitle: String?
    private let material: GlassMaterial
    private let leading: Leading
    private let trailing: Trailing
    private let showsDivider: Bool

    // MARK: - Initialization

    /// Creates a glass navigation bar.
    /// - Parameters:
    ///   - title: The navigation title.
    ///   - subtitle: Optional subtitle text.
    ///   - material: Glass material. Default is `.frosted`.
    ///   - showsDivider: Show bottom divider. Default is false.
    ///   - leading: Leading bar items builder.
    ///   - trailing: Trailing bar items builder.
    public init(
        title: String,
        subtitle: String? = nil,
        material: GlassMaterial = .frosted,
        showsDivider: Bool = false,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.subtitle = subtitle
        self.material = material
        self.showsDivider = showsDivider
        self.leading = leading()
        self.trailing = trailing()
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                // Leading items
                leading
                    .font(.body.weight(.medium))

                Spacer()

                // Title area
                VStack(spacing: 2) {
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

                Spacer()

                // Trailing items
                trailing
                    .font(.body.weight(.medium))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            if showsDivider {
                Divider()
                    .opacity(0.3)
            }
        }
        .background(
            Rectangle()
                .fill(material.swiftUIMaterial)
                .overlay(
                    Rectangle()
                        .fill(material.tintColor)
                )
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(.white.opacity(0.15))
                        .frame(height: 0.5)
                }
        )
        .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
    }
}

// MARK: - Convenience Initializers

extension GlassNavigationBar where Leading == EmptyView, Trailing == EmptyView {

    /// Creates a glass navigation bar with only a title.
    public init(title: String, material: GlassMaterial = .frosted) {
        self.init(
            title: title,
            material: material,
            leading: { EmptyView() },
            trailing: { EmptyView() }
        )
    }
}

extension GlassNavigationBar where Trailing == EmptyView {

    /// Creates a glass navigation bar with leading items only.
    public init(
        title: String,
        material: GlassMaterial = .frosted,
        @ViewBuilder leading: () -> Leading
    ) {
        self.init(
            title: title,
            material: material,
            leading: leading,
            trailing: { EmptyView() }
        )
    }
}

// MARK: - Preview

#if DEBUG
struct GlassNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(
                colors: [.orange, .pink],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                GlassNavigationBar(title: "Profile", subtitle: "Settings") {
                    Image(systemName: "chevron.left")
                } trailing: {
                    Image(systemName: "gearshape")
                }

                Spacer()
            }
        }
    }
}
#endif
