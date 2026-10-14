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
public struct GlassTheme: Sendable, Hashable {

    /// Material used when a component does not specify one.
    public var material: GlassMaterial

    /// Outline used by ``SwiftUICore/View/glassSurface(_:in:interactive:)`` and ``GlassCard``
    /// when they do not specify one.
    public var shape: GlassShape

    /// Shadow blur radius on the fallback rendering path.
    public var shadowRadius: CGFloat

    /// Shadow opacity on the fallback rendering path.
    public var shadowOpacity: Double

    /// Opacity of the highlight stroke drawn along the edge on the fallback rendering path.
    public var strokeOpacity: Double

    public init(
        material: GlassMaterial = .frosted,
        shape: GlassShape = .roundedRectangle(cornerRadius: 20),
        shadowRadius: CGFloat = 10,
        shadowOpacity: Double = 0.12,
        strokeOpacity: Double = 0.35
    ) {
        self.material = material
        self.shape = shape
        self.shadowRadius = max(0, shadowRadius)
        self.shadowOpacity = shadowOpacity.clamped(to: 0...1)
        self.strokeOpacity = strokeOpacity.clamped(to: 0...1)
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
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
