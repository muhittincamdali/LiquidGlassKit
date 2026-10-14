import SwiftUI

/// Groups glass surfaces so native glass can blend and morph between them.
///
/// On the native rendering path this wraps SwiftUI's `GlassEffectContainer`,
/// which lets nearby glass shapes merge and animate into each other. On the
/// fallback path it simply returns its content, so the same code runs on
/// every supported OS.
///
/// ```swift
/// GlassGroup(spacing: 12) {
///     HStack(spacing: 12) {
///         GlassButton("Play", systemImage: "play.fill") {}
///         GlassButton("Next", systemImage: "forward.fill") {}
///     }
/// }
/// ```
public struct GlassGroup<Content: View>: View {
    private let spacing: CGFloat?
    private let content: Content

    @Environment(\.glassRenderingMode) private var renderingMode

    /// - Parameters:
    ///   - spacing: Distance at which native glass shapes start to merge. `nil` uses the system default.
    ///   - content: The views containing glass surfaces.
    public init(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        let path = renderingMode.resolved(nativeAvailable: GlassRenderingMode.isNativeGlassAvailable)
        #if os(visionOS)
        content
        #else
        if path == .native, #available(iOS 26, macOS 26, tvOS 26, watchOS 26, *) {
            GlassEffectContainer(spacing: spacing) { content }
        } else {
            content
        }
        #endif
    }
}
