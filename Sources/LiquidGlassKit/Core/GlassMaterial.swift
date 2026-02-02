import SwiftUI

// MARK: - GlassMaterial

/// Defines the visual material applied to a glass surface.
/// Each material variant produces a distinct translucent appearance.
public enum GlassMaterial: Sendable, Hashable {

    /// Fully transparent glass with minimal blur.
    /// Best for subtle overlays where maximum background visibility is desired.
    case clear

    /// White frosted glass with moderate blur.
    /// The standard material for most glass components in iOS 26.
    case frosted

    /// Colored glass with a custom tint.
    /// The tint color is applied as a subtle overlay on the blurred background.
    /// - Parameter color: The tint color to apply.
    case tinted(Color)

    /// Dark translucent glass.
    /// Optimized for light text on dark surfaces and night mode interfaces.
    case dark

    /// Custom material with explicit parameters.
    /// - Parameters:
    ///   - blurRadius: Custom blur intensity.
    ///   - tintColor: Custom overlay tint color.
    ///   - saturation: Custom saturation multiplier.
    ///   - opacity: Custom material opacity.
    case custom(blurRadius: CGFloat, tintColor: Color, saturation: CGFloat, opacity: CGFloat)

    // MARK: - Computed Properties

    /// The blur radius associated with this material.
    public var blurRadius: CGFloat {
        switch self {
        case .clear:
            return 10
        case .frosted:
            return 20
        case .tinted:
            return 18
        case .dark:
            return 25
        case .custom(let blurRadius, _, _, _):
            return blurRadius
        }
    }

    /// The tint color overlay for this material.
    public var tintColor: Color {
        switch self {
        case .clear:
            return .white.opacity(0.05)
        case .frosted:
            return .white.opacity(0.15)
        case .tinted(let color):
            return color.opacity(0.1)
        case .dark:
            return .black.opacity(0.3)
        case .custom(_, let tintColor, _, _):
            return tintColor
        }
    }

    /// The saturation multiplier for the blurred background.
    public var saturation: CGFloat {
        switch self {
        case .clear:
            return 1.2
        case .frosted:
            return 1.8
        case .tinted:
            return 1.6
        case .dark:
            return 1.4
        case .custom(_, _, let saturation, _):
            return saturation
        }
    }

    /// The overall opacity of the material layer.
    public var opacity: CGFloat {
        switch self {
        case .clear:
            return 0.7
        case .frosted:
            return 0.85
        case .tinted:
            return 0.8
        case .dark:
            return 0.9
        case .custom(_, _, _, let opacity):
            return opacity
        }
    }

    /// The appropriate SwiftUI `Material` for fallback rendering.
    public var swiftUIMaterial: Material {
        switch self {
        case .clear:
            return .ultraThinMaterial
        case .frosted:
            return .thinMaterial
        case .tinted:
            return .regularMaterial
        case .dark:
            return .ultraThickMaterial
        case .custom:
            return .regularMaterial
        }
    }

    /// A human-readable name for this material.
    public var displayName: String {
        switch self {
        case .clear:
            return "Clear"
        case .frosted:
            return "Frosted"
        case .tinted:
            return "Tinted"
        case .dark:
            return "Dark"
        case .custom:
            return "Custom"
        }
    }

    // MARK: - Hashable

    public static func == (lhs: GlassMaterial, rhs: GlassMaterial) -> Bool {
        switch (lhs, rhs) {
        case (.clear, .clear), (.frosted, .frosted), (.dark, .dark):
            return true
        case (.tinted, .tinted):
            return true
        case (.custom(let lb, _, let ls, let lo), .custom(let rb, _, let rs, let ro)):
            return lb == rb && ls == rs && lo == ro
        default:
            return false
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(displayName)
        hasher.combine(blurRadius)
        hasher.combine(saturation)
        hasher.combine(opacity)
    }
}
