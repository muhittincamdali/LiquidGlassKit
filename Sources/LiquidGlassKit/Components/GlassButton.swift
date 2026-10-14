import SwiftUI

/// Size presets for glass buttons.
public enum GlassButtonSize: String, Sendable, Hashable, CaseIterable {
    case compact
    case regular
    case large

    /// Horizontal padding around the label, in points.
    public var horizontalPadding: CGFloat {
        switch self {
        case .compact: 12
        case .regular: 20
        case .large: 28
        }
    }

    /// Vertical padding around the label, in points.
    public var verticalPadding: CGFloat {
        switch self {
        case .compact: 6
        case .regular: 12
        case .large: 16
        }
    }

    /// Font applied to the label.
    public var font: Font {
        switch self {
        case .compact: .subheadline.weight(.semibold)
        case .regular: .body.weight(.semibold)
        case .large: .title3.weight(.semibold)
        }
    }
}

/// A button style that draws the label on a capsule of glass.
///
/// ```swift
/// Button("Continue") { }
///     .buttonStyle(.liquidGlass)
///
/// Button("Delete", role: .destructive) { }
///     .buttonStyle(.liquidGlass(.tinted(.red), size: .compact))
/// ```
///
/// The pressed state is read from the button configuration, so taps,
/// keyboard activation and accessibility actions behave like any other
/// SwiftUI button. On the native rendering path the glass is interactive.
public struct LiquidGlassButtonStyle: ButtonStyle {
    /// The glass material, or `nil` to use the theme's material.
    public var material: GlassMaterial?
    /// The size preset.
    public var size: GlassButtonSize

    public init(material: GlassMaterial? = nil, size: GlassButtonSize = .regular) {
        self.material = material
        self.size = size
    }

    public func makeBody(configuration: Configuration) -> some View {
        StyledLabel(configuration: configuration, material: material, size: size)
    }

    private struct StyledLabel: View {
        let configuration: Configuration
        let material: GlassMaterial?
        let size: GlassButtonSize

        @Environment(\.isEnabled) private var isEnabled
        @Environment(\.glassTheme) private var theme

        var body: some View {
            configuration.label
                .font(size.font)
                .padding(.horizontal, size.horizontalPadding)
                .padding(.vertical, size.verticalPadding)
                .foregroundStyle(labelStyle)
                .glassSurface(material, in: .capsule, interactive: true)
                .scaleEffect(configuration.isPressed ? Self.pressedScale : 1)
                .opacity(isEnabled ? 1 : Self.disabledOpacity)
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
        }

        /// Red for destructive buttons; white on dark glass, where the primary
        /// color is black in light mode and would be hard to read.
        private var labelStyle: AnyShapeStyle {
            if configuration.role == .destructive { return AnyShapeStyle(.red) }
            if (material ?? theme.material) == .dark { return AnyShapeStyle(.white) }
            return AnyShapeStyle(.primary)
        }

        static let pressedScale = 0.96
        static let disabledOpacity = 0.5
    }
}

extension ButtonStyle where Self == LiquidGlassButtonStyle {
    /// A glass capsule button using the theme's material at regular size.
    public static var liquidGlass: LiquidGlassButtonStyle { LiquidGlassButtonStyle() }

    /// A glass capsule button with an explicit material and size.
    public static func liquidGlass(
        _ material: GlassMaterial? = nil,
        size: GlassButtonSize = .regular
    ) -> LiquidGlassButtonStyle {
        LiquidGlassButtonStyle(material: material, size: size)
    }
}

/// A convenience button with a title, an optional SF Symbol and the ``LiquidGlassButtonStyle``.
///
/// ```swift
/// GlassButton("Share", systemImage: "square.and.arrow.up") {
///     share()
/// }
/// ```
public struct GlassButton: View {
    private let title: String
    private let systemImage: String?
    private let material: GlassMaterial?
    private let size: GlassButtonSize
    private let role: ButtonRole?
    private let action: () -> Void

    public init(
        _ title: String,
        systemImage: String? = nil,
        material: GlassMaterial? = nil,
        size: GlassButtonSize = .regular,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.material = material
        self.size = size
        self.role = role
        self.action = action
    }

    public var body: some View {
        Button(role: role, action: action) {
            if let systemImage {
                Label(title, systemImage: systemImage)
            } else {
                Text(title)
            }
        }
        .buttonStyle(.liquidGlass(material, size: size))
    }
}
