import SwiftUI

/// The outline of a glass surface.
///
/// `GlassShape` is a value type so it can be stored in a ``GlassTheme``,
/// compared in tests and passed across concurrency domains. Use ``shape`` to
/// get a SwiftUI `Shape` for drawing.
///
/// Negative radii are treated as zero.
public enum GlassShape: Sendable, Hashable {

    /// A rectangle with continuous rounded corners.
    case roundedRectangle(cornerRadius: CGFloat)

    /// A capsule (fully rounded short sides).
    case capsule

    /// A circle that fits the shorter side of its frame.
    case circle

    /// A rectangle with an individual radius per corner.
    case unevenRoundedRectangle(
        topLeading: CGFloat,
        bottomLeading: CGFloat,
        bottomTrailing: CGFloat,
        topTrailing: CGFloat
    )

    /// A rounded rectangle with only the two top corners rounded, as used by sheets.
    public static func topRounded(_ radius: CGFloat) -> GlassShape {
        .unevenRoundedRectangle(topLeading: radius, bottomLeading: 0, bottomTrailing: 0, topTrailing: radius)
    }

    /// A type-erased SwiftUI shape for this outline.
    public var shape: AnyShape {
        switch self {
        case .roundedRectangle(let cornerRadius):
            AnyShape(RoundedRectangle(cornerRadius: max(0, cornerRadius), style: .continuous))
        case .capsule:
            AnyShape(Capsule(style: .continuous))
        case .circle:
            AnyShape(Circle())
        case .unevenRoundedRectangle(let topLeading, let bottomLeading, let bottomTrailing, let topTrailing):
            AnyShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: max(0, topLeading),
                    bottomLeadingRadius: max(0, bottomLeading),
                    bottomTrailingRadius: max(0, bottomTrailing),
                    topTrailingRadius: max(0, topTrailing),
                    style: .continuous
                )
            )
        }
    }

    /// The outline of this shape inside `rect`.
    public func path(in rect: CGRect) -> Path {
        shape.path(in: rect)
    }
}
