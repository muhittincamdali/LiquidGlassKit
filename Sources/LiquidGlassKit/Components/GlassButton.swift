import SwiftUI

// MARK: - GlassButtonStyle

/// Style variants for glass buttons.
public enum GlassButtonStyle: Sendable {
    /// Standard glass button appearance.
    case standard
    /// Prominent button with stronger glass effect.
    case prominent
    /// Compact button with reduced padding.
    case compact
}

// MARK: - GlassButton

/// An interactive button with a Liquid Glass background.
/// Features press-down animation, optional icon, and configurable material.
public struct GlassButton: View {

    // MARK: - Properties

    private let title: String
    private let icon: String?
    private let material: GlassMaterial
    private let style: GlassButtonStyle
    private let action: () -> Void

    @State private var isPressed = false

    // MARK: - Initialization

    /// Creates a glass button.
    /// - Parameters:
    ///   - title: The button label text.
    ///   - icon: Optional SF Symbol name.
    ///   - material: Glass material. Default is `.frosted`.
    ///   - style: Button style variant. Default is `.standard`.
    ///   - action: Closure executed on tap.
    public init(
        _ title: String,
        icon: String? = nil,
        material: GlassMaterial = .frosted,
        style: GlassButtonStyle = .standard,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.material = material
        self.style = style
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon)
                        .font(.body.weight(.medium))
                }
                Text(title)
                    .font(.body.weight(.semibold))
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
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
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.1), radius: 6, y: 3)
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPressed)
        }
        .buttonStyle(.plain)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }

    // MARK: - Private

    private var horizontalPadding: CGFloat {
        switch style {
        case .standard: return 20
        case .prominent: return 28
        case .compact: return 14
        }
    }

    private var verticalPadding: CGFloat {
        switch style {
        case .standard: return 12
        case .prominent: return 16
        case .compact: return 8
        }
    }
}
