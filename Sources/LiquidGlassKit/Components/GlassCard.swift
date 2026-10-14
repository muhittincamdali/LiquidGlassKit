import SwiftUI

/// A padded container drawn on a glass surface.
///
/// ```swift
/// GlassCard {
///     VStack(alignment: .leading, spacing: 4) {
///         Text("Storage").font(.headline)
///         Text("42 GB of 128 GB used").foregroundStyle(.secondary)
///     }
/// }
/// ```
public struct GlassCard<Content: View>: View {
    private let material: GlassMaterial?
    private let shape: GlassShape?
    private let padding: CGFloat
    private let content: Content

    /// - Parameters:
    ///   - material: The glass material, or `nil` to use the theme's material.
    ///   - shape: The outline, or `nil` to use the theme's shape.
    ///   - padding: Inset between the content and the card edge. Default 16 pt.
    ///   - content: The card content.
    public init(
        material: GlassMaterial? = nil,
        shape: GlassShape? = nil,
        padding: CGFloat = 16,
        @ViewBuilder content: () -> Content
    ) {
        self.material = material
        self.shape = shape
        self.padding = max(0, padding)
        self.content = content()
    }

    public var body: some View {
        content
            .padding(padding)
            .glassSurface(material, in: shape)
    }
}
