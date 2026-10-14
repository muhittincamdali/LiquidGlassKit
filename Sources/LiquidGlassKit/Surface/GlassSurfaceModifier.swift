import SwiftUI

extension View {
    /// Places a glass surface behind this view.
    ///
    /// ```swift
    /// Label("Now Playing", systemImage: "music.note")
    ///     .padding()
    ///     .glassSurface(.tinted(.purple), in: .capsule)
    /// ```
    ///
    /// On OS 26 this calls SwiftUI's `glassEffect(_:in:)`; elsewhere it draws a
    /// `Material` blur with a tint, an edge highlight and a shadow taken from the
    /// current ``GlassTheme``. When the user turns on *Reduce Transparency*, the
    /// fallback path draws an opaque background instead of a blur.
    ///
    /// - Parameters:
    ///   - material: The glass material, or `nil` to use the theme's material.
    ///   - shape: The outline, or `nil` to use the theme's shape.
    ///   - interactive: Makes native glass react to touches and pointer hover.
    ///     Has no effect on the fallback path.
    public func glassSurface(
        _ material: GlassMaterial? = nil,
        in shape: GlassShape? = nil,
        interactive: Bool = false
    ) -> some View {
        modifier(GlassSurfaceModifier(material: material, shape: shape, isInteractive: interactive))
    }
}

/// Draws a glass surface behind its content. Use ``SwiftUICore/View/glassSurface(_:in:interactive:)``.
struct GlassSurfaceModifier: ViewModifier {
    let material: GlassMaterial?
    let shape: GlassShape?
    let isInteractive: Bool

    @Environment(\.glassTheme) private var theme
    @Environment(\.glassRenderingMode) private var renderingMode
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    func body(content: Content) -> some View {
        let material = material ?? theme.material
        let outline = (shape ?? theme.shape).shape
        let path = renderingMode.resolved(nativeAvailable: GlassRenderingMode.isNativeGlassAvailable)

        if path == .native {
            NativeGlass(content: content, material: material, outline: outline, isInteractive: isInteractive) {
                fallback(content, material: material, outline: outline)
            }
        } else {
            fallback(content, material: material, outline: outline)
        }
    }

    private func fallback(_ content: Content, material: GlassMaterial, outline: AnyShape) -> some View {
        content
            .background {
                if reduceTransparency {
                    outline.fill(.background.secondary)
                } else {
                    outline
                        .fill(material.fallbackMaterial)
                        .overlay(outline.fill(material.tintOverlay))
                }
            }
            .overlay {
                outline
                    .stroke(
                        LinearGradient(
                            colors: [.white.opacity(theme.strokeOpacity), .white.opacity(theme.strokeOpacity * 0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
                    .allowsHitTesting(false)
            }
            .contentShape(outline)
            .shadow(color: .black.opacity(theme.shadowOpacity), radius: theme.shadowRadius, y: theme.shadowRadius / 3)
    }
}

/// Applies SwiftUI's native glass when the OS provides it, otherwise `fallback`.
private struct NativeGlass<Content: View, Fallback: View>: View {
    let content: Content
    let material: GlassMaterial
    let outline: AnyShape
    let isInteractive: Bool
    @ViewBuilder let fallback: () -> Fallback

    var body: some View {
        #if os(visionOS)
        fallback()
        #else
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, *) {
            content.glassEffect(nativeGlass, in: outline)
        } else {
            fallback()
        }
        #endif
    }

    #if !os(visionOS)
    @available(iOS 26, macOS 26, tvOS 26, watchOS 26, *)
    private var nativeGlass: Glass {
        let base: Glass = material.usesClearNativeGlass ? .clear : .regular
        return base.tint(material.nativeTint).interactive(isInteractive)
    }
    #endif
}
