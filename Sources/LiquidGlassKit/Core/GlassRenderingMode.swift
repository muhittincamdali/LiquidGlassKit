import SwiftUI

/// Chooses how glass surfaces are drawn.
///
/// The default, ``automatic``, uses SwiftUI's native Liquid Glass
/// (`glassEffect(_:in:)`) when the running OS provides it and falls back to a
/// `Material` blur otherwise. Force a path with
/// ``SwiftUICore/View/glassRenderingMode(_:)``, for example to compare both looks
/// side by side or to keep a consistent appearance across OS versions.
public enum GlassRenderingMode: String, Sendable, Hashable, CaseIterable {

    /// Native glass when available, otherwise the fallback.
    case automatic

    /// Always draw the `Material` based fallback.
    case fallback

    /// The concrete drawing path after taking OS support into account.
    public enum Path: Sendable, Hashable {
        case native
        case fallback
    }

    /// Resolves this mode to a drawing path.
    /// - Parameter nativeAvailable: Whether the OS provides native glass.
    public func resolved(nativeAvailable: Bool) -> Path {
        switch self {
        case .automatic:
            nativeAvailable ? .native : .fallback
        case .fallback:
            .fallback
        }
    }

    /// Whether SwiftUI's native glass APIs are available at run time.
    ///
    /// `true` on iOS, macOS, tvOS and watchOS 26 or later. Always `false` on
    /// visionOS, where SwiftUI marks `glassEffect` unavailable.
    public static var isNativeGlassAvailable: Bool {
        #if os(visionOS)
        return false
        #else
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, *) {
            return true
        }
        return false
        #endif
    }
}

extension EnvironmentValues {
    /// The glass rendering mode for this view hierarchy. Defaults to ``GlassRenderingMode/automatic``.
    @Entry public var glassRenderingMode: GlassRenderingMode = .automatic
}

extension View {
    /// Sets how glass surfaces in this view and its descendants are drawn.
    public func glassRenderingMode(_ mode: GlassRenderingMode) -> some View {
        environment(\.glassRenderingMode, mode)
    }
}
