import SwiftUI

/// Default appearance values for every glass surface in a view hierarchy.
///
/// Components use the theme whenever their own `material` or `shape`
/// argument is `nil`. Install a theme with ``SwiftUICore/View/glassTheme(_:)``:
///
/// ```swift
/// ContentView()
///     .glassTheme(.subtle)
/// ```
///
/// Numeric values are kept in range whether they are passed to the initializer
/// or assigned later: the shadow radius stays between 0 and ``maximumShadowRadius``,
/// opacities in `0...1`, and NaN becomes zero.
public struct GlassTheme: Sendable, Hashable {

    /// Material used when a component does not specify one.
    public var material: GlassMaterial

    /// Outline used by ``SwiftUICore/View/glassSurface(_:in:interactive:)`` and ``GlassCard``
    /// when they do not specify one.
    public var shape: GlassShape

    /// Shadow blur radius on the fallback rendering path.
    public var shadowRadius: CGFloat {
        didSet { shadowRadius = Self.sanitizedRadius(shadowRadius) }
    }

    /// Shadow opacity on the fallback rendering path.
    public var shadowOpacity: Double {
        didSet { shadowOpacity = Self.sanitizedOpacity(shadowOpacity) }
    }

    /// Opacity of the highlight stroke drawn along the edge on the fallback rendering path.
    public var strokeOpacity: Double {
        didSet { strokeOpacity = Self.sanitizedOpacity(strokeOpacity) }
    }

    /// The largest shadow radius a theme keeps, in points. A blur radius has no
    /// visible effect past this size but still costs rendering time.
    public static let maximumShadowRadius: CGFloat = 100

    public init(
        material: GlassMaterial = .frosted,
        shape: GlassShape = .roundedRectangle(cornerRadius: 20),
        shadowRadius: CGFloat = 10,
        shadowOpacity: Double = 0.12,
        strokeOpacity: Double = 0.35
    ) {
        self.material = material
        self.shape = shape
        self.shadowRadius = Self.sanitizedRadius(shadowRadius)
        self.shadowOpacity = Self.sanitizedOpacity(shadowOpacity)
        self.strokeOpacity = Self.sanitizedOpacity(strokeOpacity)
    }

    static func sanitizedRadius(_ radius: CGFloat) -> CGFloat {
        radius.clampedReplacingNaN(to: 0...maximumShadowRadius)
    }

    static func sanitizedOpacity(_ opacity: Double) -> Double {
        opacity.clampedReplacingNaN(to: 0...1)
    }

    /// Frosted glass, 20 pt corners, soft shadow.
    public static let standard = GlassTheme()

    /// Clear glass with a smaller shadow and fainter edge.
    public static let subtle = GlassTheme(
        material: .clear,
        shape: .roundedRectangle(cornerRadius: 14),
        shadowRadius: 4,
        shadowOpacity: 0.06,
        strokeOpacity: 0.2
    )

    /// Dark glass with a deeper shadow.
    public static let dark = GlassTheme(
        material: .dark,
        shadowRadius: 14,
        shadowOpacity: 0.25,
        strokeOpacity: 0.18
    )
}

extension EnvironmentValues {
    /// The glass theme for this view hierarchy. Defaults to ``GlassTheme/standard``.
    @Entry public var glassTheme: GlassTheme = .standard
}

extension View {
    /// Sets the default glass appearance for this view and its descendants.
    public func glassTheme(_ theme: GlassTheme) -> some View {
        environment(\.glassTheme, theme)
    }
}

extension Comparable {
    /// `self` limited to `range`. A floating-point NaN is returned unchanged,
    /// so callers that accept arbitrary input check `isNaN` first.
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}

extension FloatingPoint {
    /// `self` limited to `range`, with NaN replaced by the range's lower bound.
    func clampedReplacingNaN(to range: ClosedRange<Self>) -> Self {
        isNaN ? range.lowerBound : clamped(to: range)
    }
}
