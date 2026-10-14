import SwiftUI

/// The direction a ``GlassGradient`` runs in.
public enum GlassGradientDirection: String, Sendable, Hashable, CaseIterable {
    /// Top to bottom.
    case vertical
    /// Leading to trailing.
    case horizontal
    /// Top leading to bottom trailing.
    case diagonal
    /// Top trailing to bottom leading.
    case reverseDiagonal

    /// Where the first color is drawn.
    public var startPoint: UnitPoint {
        switch self {
        case .vertical: .top
        case .horizontal: .leading
        case .diagonal: .topLeading
        case .reverseDiagonal: .topTrailing
        }
    }

    /// Where the last color is drawn.
    public var endPoint: UnitPoint {
        switch self {
        case .vertical: .bottom
        case .horizontal: .trailing
        case .diagonal: .bottomTrailing
        case .reverseDiagonal: .bottomLeading
        }
    }
}

/// A multi-color tint laid over a glass surface.
///
/// Use it through ``SwiftUICore/View/glassGradient(_:direction:intensity:material:in:interactive:)``.
/// `intensity` is the opacity of the colors over the glass and is clamped to `0...1`.
public struct GlassGradient: Sendable, Hashable {
    /// The gradient's colors, from ``GlassGradientDirection/startPoint`` to ``GlassGradientDirection/endPoint``.
    public var colors: [Color]
    /// The direction the colors run in.
    public var direction: GlassGradientDirection
    /// The opacity of the colors over the glass, from 0 (glass only) to 1 (opaque colors).
    public var intensity: Double

    public init(_ colors: [Color], direction: GlassGradientDirection = .diagonal, intensity: Double = 0.35) {
        self.colors = colors
        self.direction = direction
        self.intensity = intensity.isFinite ? intensity.clamped(to: 0...1) : 0
    }

    /// The colors at ``intensity`` as a SwiftUI gradient. Empty when there are no colors.
    public var linearGradient: LinearGradient {
        LinearGradient(
            colors: colors.map { $0.opacity(intensity) },
            startPoint: direction.startPoint,
            endPoint: direction.endPoint
        )
    }
}

extension View {
    /// Places a glass surface with a gradient tint behind this view.
    ///
    /// ```swift
    /// Label("Sunset", systemImage: "sun.horizon")
    ///     .padding()
    ///     .glassGradient([.orange, .pink], direction: .horizontal)
    /// ```
    ///
    /// The gradient is drawn over the glass, inside the same shape, on both
    /// rendering paths. With *Reduce Transparency* on, the fallback path draws the
    /// gradient over an opaque background.
    ///
    /// - Parameters:
    ///   - colors: The gradient's colors. An empty array draws plain glass.
    ///   - direction: The direction the colors run in.
    ///   - intensity: The opacity of the colors over the glass, clamped to `0...1`.
    ///   - material: The glass material under the gradient, or `nil` to use the theme's material.
    ///   - shape: The outline, or `nil` to use the theme's shape.
    ///   - interactive: Makes native glass react to touches and pointer hover.
    public func glassGradient(
        _ colors: [Color],
        direction: GlassGradientDirection = .diagonal,
        intensity: Double = 0.35,
        material: GlassMaterial? = nil,
        in shape: GlassShape? = nil,
        interactive: Bool = false
    ) -> some View {
        modifier(
            GlassGradientModifier(
                gradient: GlassGradient(colors, direction: direction, intensity: intensity),
                material: material,
                shape: shape,
                isInteractive: interactive
            )
        )
    }
}

/// Draws a gradient inside the glass outline, under the content and over the glass.
struct GlassGradientModifier: ViewModifier {
    let gradient: GlassGradient
    let material: GlassMaterial?
    let shape: GlassShape?
    let isInteractive: Bool

    @Environment(\.glassTheme) private var theme

    func body(content: Content) -> some View {
        content
            .background {
                (shape ?? theme.shape).shape
                    .fill(gradient.linearGradient)
                    .allowsHitTesting(false)
            }
            .glassSurface(material, in: shape, interactive: isInteractive)
    }
}
