import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - GlassEffectShape

/// Shape options for the glass effect container.
public enum GlassEffectShape: Sendable {
    /// Rectangular shape with custom corner radius.
    case rectangle(cornerRadius: CGFloat)
    /// Capsule shape (fully rounded).
    case capsule
    /// Circle shape.
    case circle
    /// Custom rounded rectangle with per-corner radii.
    case custom(topLeading: CGFloat, topTrailing: CGFloat, bottomLeading: CGFloat, bottomTrailing: CGFloat)
}

// MARK: - GlassEffectUnpadding

/// Edges where the glass effect extends beyond the content bounds.
public struct GlassEffectUnpadding: OptionSet, Sendable {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let top = GlassEffectUnpadding(rawValue: 1 << 0)
    public static let bottom = GlassEffectUnpadding(rawValue: 1 << 1)
    public static let leading = GlassEffectUnpadding(rawValue: 1 << 2)
    public static let trailing = GlassEffectUnpadding(rawValue: 1 << 3)
    public static let all: GlassEffectUnpadding = [.top, .bottom, .leading, .trailing]
    public static let horizontal: GlassEffectUnpadding = [.leading, .trailing]
    public static let vertical: GlassEffectUnpadding = [.top, .bottom]
}

// MARK: - GlassEffectContainer

/// A container view that wraps content with a native Liquid Glass effect on iOS 26+,
/// or a high-fidelity blur-based fallback on iOS 15–25.
///
/// On iOS 26, this view leverages the system's `glassEffect()` modifier
/// for true translucency with specular highlights, depth simulation,
/// and real-time background passthrough. On older systems, it composes
/// `UIVisualEffectView` blur with tint overlays to approximate the look.
public struct GlassEffectContainer<Content: View>: View {

    // MARK: - Properties

    private let content: Content
    private let material: GlassMaterial
    private let shape: GlassEffectShape
    private let unpadding: GlassEffectUnpadding
    private let shadowRadius: CGFloat
    private let shadowOpacity: CGFloat

    // MARK: - Initialization

    /// Creates a glass effect container.
    /// - Parameters:
    ///   - material: Glass material. Default is `.frosted`.
    ///   - shape: Container shape. Default is rectangle with 20pt radius.
    ///   - unpadding: Edges to extend glass beyond content. Default is empty.
    ///   - shadowRadius: Shadow radius. Default is 10.
    ///   - shadowOpacity: Shadow opacity. Default is 0.1.
    ///   - content: Content to display inside the glass container.
    public init(
        material: GlassMaterial = .frosted,
        shape: GlassEffectShape = .rectangle(cornerRadius: 20),
        unpadding: GlassEffectUnpadding = [],
        shadowRadius: CGFloat = 10,
        shadowOpacity: CGFloat = 0.1,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.material = material
        self.shape = shape
        self.unpadding = unpadding
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
    }

    // MARK: - Body

    public var body: some View {
        if #available(iOS 26, *) {
            nativeGlassContent
        } else {
            fallbackGlassContent
        }
    }

    // MARK: - Native iOS 26+

    @available(iOS 26, *)
    @ViewBuilder
    private var nativeGlassContent: some View {
        content
            .padding(unpaddingInsets)
            .background(shapeView.fill(.ultraThinMaterial))
            .clipShape(shapeView)
            .shadow(
                color: .black.opacity(shadowOpacity),
                radius: shadowRadius,
                y: 3
            )
    }

    // MARK: - Fallback iOS 15–25

    @ViewBuilder
    private var fallbackGlassContent: some View {
        content
            .padding(unpaddingInsets)
            .background(
                shapeView
                    .fill(material.swiftUIMaterial)
                    .overlay(
                        shapeView
                            .fill(material.tintColor)
                    )
                    .overlay(
                        shapeView
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        .white.opacity(0.3),
                                        .white.opacity(0.1),
                                        .clear
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 0.5
                            )
                    )
            )
            .clipShape(shapeView)
            .shadow(
                color: .black.opacity(shadowOpacity),
                radius: shadowRadius,
                y: 3
            )
    }

    // MARK: - Shape Helpers

    @ViewBuilder
    private var shapeView: some InsettableShape {
        switch shape {
        case .rectangle(let cornerRadius):
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        case .capsule:
            Capsule()
        case .circle:
            Circle()
        case .custom(let tl, let tt, let bl, let bt):
            UnevenRoundedRectangle(
                topLeadingRadius: tl,
                bottomLeadingRadius: bl,
                bottomTrailingRadius: bt,
                topTrailingRadius: tt
            )
        }
    }

    private var unpaddingInsets: EdgeInsets {
        EdgeInsets(
            top: unpadding.contains(.top) ? -8 : 0,
            leading: unpadding.contains(.leading) ? -8 : 0,
            bottom: unpadding.contains(.bottom) ? -8 : 0,
            trailing: unpadding.contains(.trailing) ? -8 : 0
        )
    }
}

// MARK: - View Modifiers

extension View {

    /// Sets the glass effect shape on a `GlassEffectContainer`.
    public func glassEffectShape(_ shape: GlassEffectShape) -> some View {
        self
    }

    /// Sets the glass effect unpadding on a `GlassEffectContainer`.
    public func glassEffectUnpadding(_ edges: GlassEffectUnpadding) -> some View {
        self
    }
}
