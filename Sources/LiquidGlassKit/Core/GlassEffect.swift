import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - GlassEffect

/// Central rendering engine for Liquid Glass effects.
/// Handles blur computation, tint overlay, specular highlights,
/// and composition of the final glass appearance.
public struct GlassEffect: Sendable, Hashable {

    // MARK: - Properties

    /// The material defining the glass appearance.
    public var material: GlassMaterial

    /// Blur intensity applied to the background content.
    public var blurRadius: CGFloat

    /// Corner radius of the glass shape.
    public var cornerRadius: CGFloat

    /// Saturation boost applied to the blurred content.
    public var saturation: CGFloat

    /// Overall opacity of the glass layer.
    public var opacity: CGFloat

    /// Shadow radius for depth simulation.
    public var shadowRadius: CGFloat

    /// Shadow opacity for depth control.
    public var shadowOpacity: CGFloat

    /// Shadow offset from the glass surface.
    public var shadowOffset: CGSize

    /// Whether specular highlights are enabled (iOS 26+).
    public var specularHighlights: Bool

    // MARK: - Initialization

    /// Creates a new glass effect with the specified parameters.
    /// - Parameters:
    ///   - material: The glass material type.
    ///   - blurRadius: Blur intensity. Default is 20.
    ///   - cornerRadius: Corner radius. Default is 16.
    ///   - saturation: Saturation multiplier. Default is 1.8.
    ///   - opacity: Overall opacity. Default is 1.0.
    ///   - shadowRadius: Shadow blur radius. Default is 8.
    ///   - shadowOpacity: Shadow opacity. Default is 0.1.
    ///   - shadowOffset: Shadow offset. Default is (0, 2).
    ///   - specularHighlights: Enable specular highlights. Default is true.
    public init(
        material: GlassMaterial = .frosted,
        blurRadius: CGFloat = 20,
        cornerRadius: CGFloat = 16,
        saturation: CGFloat = 1.8,
        opacity: CGFloat = 1.0,
        shadowRadius: CGFloat = 8,
        shadowOpacity: CGFloat = 0.1,
        shadowOffset: CGSize = CGSize(width: 0, height: 2),
        specularHighlights: Bool = true
    ) {
        self.material = material
        self.blurRadius = blurRadius
        self.cornerRadius = cornerRadius
        self.saturation = saturation
        self.opacity = opacity
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.shadowOffset = shadowOffset
        self.specularHighlights = specularHighlights
    }

    // MARK: - Presets

    /// Standard glass effect matching iOS 26 defaults.
    public static let standard = GlassEffect(material: .frosted)

    /// Clear glass with minimal blur.
    public static let clear = GlassEffect(material: .clear, blurRadius: 10, saturation: 1.2)

    /// Heavy frosted glass for prominent surfaces.
    public static let heavyFrost = GlassEffect(
        material: .frosted,
        blurRadius: 30,
        saturation: 2.0,
        shadowRadius: 12,
        shadowOpacity: 0.15
    )

    /// Dark glass for contrasting surfaces.
    public static let dark = GlassEffect(
        material: .dark,
        blurRadius: 25,
        saturation: 1.5,
        shadowRadius: 10,
        shadowOpacity: 0.2
    )

    // MARK: - Rendering

    /// Determines if the native iOS 26 rendering path should be used.
    public var usesNativeRendering: Bool {
        if #available(iOS 26, *) {
            return true
        }
        return false
    }

    /// Computes the effective blur style for the current material on older iOS.
    #if canImport(UIKit)
    public var effectiveBlurStyle: UIBlurEffect.Style {
        switch material {
        case .clear:
            return .systemUltraThinMaterial
        case .frosted:
            return .systemThinMaterial
        case .tinted:
            return .systemMaterial
        case .dark:
            return .systemChromeMaterialDark
        case .custom:
            return .systemMaterial
        }
    }
    #endif

    /// Returns the tint color for overlay composition.
    public var effectiveTintColor: Color {
        switch material {
        case .clear:
            return .white.opacity(0.05)
        case .frosted:
            return .white.opacity(0.15)
        case .tinted(let color):
            return color.opacity(0.1)
        case .dark:
            return .black.opacity(0.2)
        case .custom(_, let tintColor, _, _):
            return tintColor
        }
    }

    /// Returns the border color for the glass edge highlight.
    public var borderColor: Color {
        switch material {
        case .dark:
            return .white.opacity(0.1)
        default:
            return .white.opacity(0.25)
        }
    }

    /// Returns the border width for edge highlighting.
    public var borderWidth: CGFloat {
        return 0.5
    }
}

// MARK: - GlassEffect + ViewModifier

extension GlassEffect {

    /// Creates a SwiftUI view modifier applying this glass effect.
    public func makeModifier() -> GlassEffectModifier {
        GlassEffectModifier(effect: self)
    }
}

/// A SwiftUI view modifier that applies a `GlassEffect` to any view.
public struct GlassEffectModifier: ViewModifier {

    public let effect: GlassEffect

    public func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: effect.cornerRadius)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: effect.cornerRadius)
                            .fill(effect.effectiveTintColor)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: effect.cornerRadius)
                            .stroke(effect.borderColor, lineWidth: effect.borderWidth)
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: effect.cornerRadius))
            .shadow(
                color: .black.opacity(effect.shadowOpacity),
                radius: effect.shadowRadius,
                x: effect.shadowOffset.width,
                y: effect.shadowOffset.height
            )
            .opacity(effect.opacity)
    }
}
