import SwiftUI

// MARK: - View + Glass Extensions

extension View {

    /// Applies a glass effect to the view background.
    /// - Parameters:
    ///   - material: The glass material. Default is `.frosted`.
    ///   - cornerRadius: Corner radius. Default is 16.
    /// - Returns: A view with glass background applied.
    public func glassBackground(
        material: GlassMaterial = .frosted,
        cornerRadius: CGFloat = 16
    ) -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(material.swiftUIMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(material.tintColor)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .stroke(.white.opacity(0.2), lineWidth: 0.5)
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: .black.opacity(0.08), radius: 8, y: 3)
    }

    /// Applies a glass effect with full configuration.
    /// - Parameter effect: The glass effect configuration.
    /// - Returns: A view with the glass effect applied.
    public func glassEffect(_ effect: GlassEffect) -> some View {
        modifier(effect.makeModifier())
    }

    /// Wraps the view in a `GlassEffectContainer`.
    /// - Parameters:
    ///   - material: Glass material.
    ///   - shape: Container shape.
    /// - Returns: A view wrapped in a glass container.
    public func glassContainer(
        material: GlassMaterial = .frosted,
        shape: GlassEffectShape = .rectangle(cornerRadius: 20)
    ) -> some View {
        GlassEffectContainer(material: material, shape: shape) {
            self
        }
    }

    /// Applies a glass card style to the view.
    /// - Parameter material: Glass material. Default is `.frosted`.
    /// - Returns: A view styled as a glass card.
    public func asGlassCard(material: GlassMaterial = .frosted) -> some View {
        self
            .glassBackground(material: material, cornerRadius: 16)
    }

    /// Applies a glass pill style (capsule shape) to the view.
    /// - Parameter material: Glass material. Default is `.frosted`.
    /// - Returns: A view styled as a glass pill.
    public func asGlassPill(material: GlassMaterial = .frosted) -> some View {
        self
            .background(
                Capsule()
                    .fill(material.swiftUIMaterial)
                    .overlay(Capsule().fill(material.tintColor))
                    .overlay(Capsule().stroke(.white.opacity(0.2), lineWidth: 0.5))
            )
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.08), radius: 6, y: 2)
    }
}
