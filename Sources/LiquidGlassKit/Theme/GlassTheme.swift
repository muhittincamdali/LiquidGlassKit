import SwiftUI

// MARK: - GlassTheme

/// Centralized theme configuration for all glass components.
/// Apply a theme at the root of your view hierarchy to ensure
/// consistent glass appearance throughout the app.
public struct GlassTheme: Sendable {

    // MARK: - Properties

    /// Default material for glass components.
    public var defaultMaterial: GlassMaterial

    /// Default corner radius for glass surfaces.
    public var cornerRadius: CGFloat

    /// Default shadow blur radius.
    public var shadowRadius: CGFloat

    /// Default shadow opacity.
    public var shadowOpacity: CGFloat

    /// Default animation duration for transitions.
    public var animationDuration: TimeInterval

    /// Whether haptic feedback is enabled globally.
    public var hapticFeedback: Bool

    /// Border opacity for glass edges.
    public var borderOpacity: CGFloat

    // MARK: - Initialization

    /// Creates a custom glass theme.
    public init(
        defaultMaterial: GlassMaterial = .frosted,
        cornerRadius: CGFloat = 16,
        shadowRadius: CGFloat = 8,
        shadowOpacity: CGFloat = 0.1,
        animationDuration: TimeInterval = 0.3,
        hapticFeedback: Bool = true,
        borderOpacity: CGFloat = 0.2
    ) {
        self.defaultMaterial = defaultMaterial
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.animationDuration = animationDuration
        self.hapticFeedback = hapticFeedback
        self.borderOpacity = borderOpacity
    }

    // MARK: - Presets

    /// Standard theme matching iOS 26 defaults.
    public static let standard = GlassTheme()

    /// Minimal theme with subtle glass effects.
    public static let minimal = GlassTheme(
        defaultMaterial: .clear,
        cornerRadius: 12,
        shadowRadius: 4,
        shadowOpacity: 0.05,
        borderOpacity: 0.1
    )

    /// Vibrant theme with bold glass effects.
    public static let vibrant = GlassTheme(
        defaultMaterial: .frosted,
        cornerRadius: 20,
        shadowRadius: 16,
        shadowOpacity: 0.15,
        borderOpacity: 0.3
    )

    /// Dark-optimized theme.
    public static let dark = GlassTheme(
        defaultMaterial: .dark,
        cornerRadius: 16,
        shadowRadius: 10,
        shadowOpacity: 0.2,
        borderOpacity: 0.15
    )
}

// MARK: - Environment Key

private struct GlassThemeKey: EnvironmentKey {
    static let defaultValue = GlassTheme.standard
}

extension EnvironmentValues {
    /// The current glass theme in the environment.
    public var glassTheme: GlassTheme {
        get { self[GlassThemeKey.self] }
        set { self[GlassThemeKey.self] = newValue }
    }
}

// MARK: - View Extension

extension View {

    /// Applies a glass theme to the view hierarchy.
    /// - Parameter theme: The glass theme to apply.
    public func glassTheme(_ theme: GlassTheme) -> some View {
        environment(\.glassTheme, theme)
    }
}
