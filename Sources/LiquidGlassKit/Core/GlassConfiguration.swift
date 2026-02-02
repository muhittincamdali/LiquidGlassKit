import SwiftUI

// MARK: - GlassConfiguration

/// Configuration model for glass effect parameters.
/// Use this to customize the appearance of any glass component.
public struct GlassConfiguration: Sendable, Hashable {

    // MARK: - Properties

    /// The material type for the glass surface.
    public var material: GlassMaterial

    /// Corner radius of the glass container.
    public var cornerRadius: CGFloat

    /// Shadow blur radius behind the glass.
    public var shadowRadius: CGFloat

    /// Shadow opacity behind the glass.
    public var shadowOpacity: CGFloat

    /// Shadow offset from the glass surface.
    public var shadowOffset: CGSize

    /// Blur radius for background content.
    public var blurRadius: CGFloat

    /// Whether the glass responds to device tilt with parallax.
    public var parallaxEnabled: Bool

    /// Whether haptic feedback is triggered on interaction.
    public var hapticFeedback: Bool

    /// Animation duration for state transitions.
    public var animationDuration: TimeInterval

    // MARK: - Initialization

    /// Creates a new glass configuration.
    /// - Parameters:
    ///   - material: Glass material type. Default is `.frosted`.
    ///   - cornerRadius: Corner radius. Default is 16.
    ///   - shadowRadius: Shadow radius. Default is 8.
    ///   - shadowOpacity: Shadow opacity. Default is 0.1.
    ///   - shadowOffset: Shadow offset. Default is (0, 2).
    ///   - blurRadius: Blur radius. Default is 20.
    ///   - parallaxEnabled: Enable parallax. Default is false.
    ///   - hapticFeedback: Enable haptics. Default is true.
    ///   - animationDuration: Animation duration. Default is 0.3.
    public init(
        material: GlassMaterial = .frosted,
        cornerRadius: CGFloat = 16,
        shadowRadius: CGFloat = 8,
        shadowOpacity: CGFloat = 0.1,
        shadowOffset: CGSize = CGSize(width: 0, height: 2),
        blurRadius: CGFloat = 20,
        parallaxEnabled: Bool = false,
        hapticFeedback: Bool = true,
        animationDuration: TimeInterval = 0.3
    ) {
        self.material = material
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.shadowOffset = shadowOffset
        self.blurRadius = blurRadius
        self.parallaxEnabled = parallaxEnabled
        self.hapticFeedback = hapticFeedback
        self.animationDuration = animationDuration
    }

    // MARK: - Presets

    /// Default configuration matching standard iOS 26 glass appearance.
    public static let standard = GlassConfiguration()

    /// Compact configuration with smaller radius and lighter effect.
    public static let compact = GlassConfiguration(
        cornerRadius: 10,
        shadowRadius: 4,
        shadowOpacity: 0.08,
        blurRadius: 15
    )

    /// Prominent configuration with larger radius and stronger effect.
    public static let prominent = GlassConfiguration(
        cornerRadius: 24,
        shadowRadius: 16,
        shadowOpacity: 0.15,
        blurRadius: 30
    )

    // MARK: - Conversion

    /// Converts this configuration into a `GlassEffect` instance.
    public func toEffect() -> GlassEffect {
        GlassEffect(
            material: material,
            blurRadius: blurRadius,
            cornerRadius: cornerRadius,
            shadowRadius: shadowRadius,
            shadowOpacity: shadowOpacity,
            shadowOffset: shadowOffset
        )
    }
}
