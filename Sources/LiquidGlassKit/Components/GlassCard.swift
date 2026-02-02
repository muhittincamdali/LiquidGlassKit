import SwiftUI

// MARK: - GlassCard

/// A translucent card container with Liquid Glass styling.
/// Renders content over a glass background with configurable material,
/// corner radius, shadow, and optional border highlight.
public struct GlassCard<Content: View>: View {

    // MARK: - Properties

    private let content: Content
    private let configuration: GlassConfiguration

    @Environment(\.glassTheme) private var theme

    // MARK: - Initialization

    /// Creates a glass card with a specific material and corner radius.
    /// - Parameters:
    ///   - material: The glass material. Default is `.frosted`.
    ///   - cornerRadius: Corner radius. Default is 16.
    ///   - content: The view content to display inside the card.
    public init(
        material: GlassMaterial = .frosted,
        cornerRadius: CGFloat = 16,
        @ViewBuilder content: () -> Content
    ) {
        self.configuration = GlassConfiguration(
            material: material,
            cornerRadius: cornerRadius
        )
        self.content = content()
    }

    /// Creates a glass card with a full configuration.
    /// - Parameters:
    ///   - configuration: The glass configuration.
    ///   - content: The view content to display inside the card.
    public init(
        configuration: GlassConfiguration,
        @ViewBuilder content: () -> Content
    ) {
        self.configuration = configuration
        self.content = content()
    }

    // MARK: - Body

    public var body: some View {
        content
            .background(glassBackground)
            .clipShape(RoundedRectangle(cornerRadius: effectiveCornerRadius))
            .shadow(
                color: .black.opacity(configuration.shadowOpacity),
                radius: configuration.shadowRadius,
                x: configuration.shadowOffset.width,
                y: configuration.shadowOffset.height
            )
    }

    // MARK: - Private

    private var effectiveCornerRadius: CGFloat {
        configuration.cornerRadius
    }

    @ViewBuilder
    private var glassBackground: some View {
        RoundedRectangle(cornerRadius: effectiveCornerRadius)
            .fill(configuration.material.swiftUIMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: effectiveCornerRadius)
                    .fill(configuration.material.tintColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: effectiveCornerRadius)
                    .stroke(
                        LinearGradient(
                            colors: [
                                .white.opacity(0.3),
                                .white.opacity(0.1),
                                .clear
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 0.5
                    )
            )
    }
}

// MARK: - Preview

#if DEBUG
struct GlassCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .purple, .pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                GlassCard(material: .frosted) {
                    Text("Frosted Glass Card")
                        .padding()
                }

                GlassCard(material: .tinted(.blue)) {
                    Text("Tinted Glass Card")
                        .padding()
                }

                GlassCard(material: .dark) {
                    Text("Dark Glass Card")
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .padding()
        }
    }
}
#endif
