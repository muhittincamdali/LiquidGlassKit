import SwiftUI

/// The visual material of a glass surface.
///
/// A material describes *what kind* of glass to draw. How it is drawn depends on
/// the rendering path (see ``GlassRenderingMode``):
///
/// - On iOS 26, macOS 26, tvOS 26 and watchOS 26 the material maps to SwiftUI's
///   native `Glass` value (see ``nativeDescription``).
/// - On earlier systems, and on visionOS, it is approximated with a SwiftUI
///   `Material` blur plus a translucent tint overlay.
public enum GlassMaterial: Sendable, Hashable {

    /// Highly transparent glass with a light blur.
    case clear

    /// Standard frosted glass. The default for every component.
    case frosted

    /// Frosted glass tinted with a color.
    case tinted(Color)

    /// Dark glass, suited to light content on bright backgrounds.
    case dark

    /// The SwiftUI blur material used on the fallback rendering path.
    public var fallbackMaterial: Material {
        switch self {
        case .clear: .ultraThinMaterial
        case .frosted: .thinMaterial
        case .tinted: .regularMaterial
        case .dark: .ultraThickMaterial
        }
    }

    /// The color drawn over the blur on the fallback rendering path.
    public var tintOverlay: Color {
        switch self {
        case .clear: .white.opacity(0.05)
        case .frosted: .white.opacity(0.15)
        case .tinted(let color): color.opacity(Self.tintOverlayOpacity)
        case .dark: .black.opacity(0.3)
        }
    }

    /// The color passed to `Glass.tint(_:)` on the native rendering path,
    /// or `nil` when the material is untinted.
    public var nativeTint: Color? {
        switch self {
        case .clear, .frosted: nil
        case .tinted(let color): color.opacity(Self.nativeTintOpacity)
        case .dark: .black.opacity(Self.nativeDarkTintOpacity)
        }
    }

    /// Whether the native path uses `Glass.clear` instead of `Glass.regular`.
    public var usesClearNativeGlass: Bool {
        self == .clear
    }

    /// A short description of the native `Glass` value this material maps to.
    public var nativeDescription: String {
        switch self {
        case .clear: "Glass.clear"
        case .frosted: "Glass.regular"
        case .tinted: "Glass.regular.tint(color)"
        case .dark: "Glass.regular.tint(black)"
        }
    }

    /// A human-readable name, useful for pickers and debugging.
    public var displayName: String {
        switch self {
        case .clear: "Clear"
        case .frosted: "Frosted"
        case .tinted: "Tinted"
        case .dark: "Dark"
        }
    }

    // Opacities chosen so text stays readable over the tint in both color schemes.
    static let tintOverlayOpacity = 0.22
    static let nativeTintOpacity = 0.35
    static let nativeDarkTintOpacity = 0.4
}
