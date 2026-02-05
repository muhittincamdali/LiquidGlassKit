import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - GlassFallback

/// Provides backward-compatible glass rendering for iOS 13–25.
/// Uses `UIVisualEffectView` blur, tint overlays, and shadow composition
/// to approximate the iOS 26 Liquid Glass appearance.
///
/// ## Platform Support
/// - **iOS 26+**: Native Liquid Glass API
/// - **iOS 15–25**: SwiftUI Materials + UIVisualEffectView
/// - **iOS 13–14**: UIVisualEffectView with blur styles
/// - **macOS 11+**: NSVisualEffectView
/// - **watchOS**: Solid color fallback
/// - **tvOS**: UIBlurEffect
///
/// ## Usage
/// ```swift
/// if GlassFallback.isNativeGlassAvailable {
///     // Use native iOS 26 API
/// } else {
///     // Use LiquidGlassKit fallback
/// }
/// ```
public struct GlassFallback {

    // MARK: - Availability Check

    /// Returns `true` if the native iOS 26 Liquid Glass API is available.
    public static var isNativeGlassAvailable: Bool {
        if #available(iOS 26, *) {
            return true
        }
        return false
    }

    /// Returns `true` if running on a fallback rendering path.
    public static var isFallbackMode: Bool {
        !isNativeGlassAvailable
    }
    
    /// Returns `true` if SwiftUI Materials are available (iOS 15+).
    public static var isMaterialsAvailable: Bool {
        if #available(iOS 15, macOS 12, *) {
            return true
        }
        return false
    }
    
    /// The minimum iOS version supported by this framework.
    public static let minimumIOSVersion = "13.0"
    
    /// The iOS version where native Liquid Glass was introduced.
    public static let nativeGlassIOSVersion = "26.0"

    // MARK: - Rendering Strategy

    /// The rendering strategy used on the current platform.
    public enum RenderingStrategy: String, Sendable, CaseIterable {
        /// Native iOS 26 Liquid Glass.
        case native
        /// SwiftUI Material-based (iOS 15+).
        case swiftUIMaterial
        /// UIVisualEffectView-based blur (iOS 13–14).
        case blurEffect
        /// Solid color with opacity (watchOS fallback).
        case solidColor
        
        /// Human-readable description of the strategy.
        public var description: String {
            switch self {
            case .native:
                return "Native Liquid Glass (iOS 26+)"
            case .swiftUIMaterial:
                return "SwiftUI Materials (iOS 15+)"
            case .blurEffect:
                return "UIBlurEffect (iOS 13–14)"
            case .solidColor:
                return "Solid Color Fallback"
            }
        }
    }

    /// Determines the best rendering strategy for the current platform.
    public static var currentStrategy: RenderingStrategy {
        if #available(iOS 26, *) {
            return .native
        }
        #if os(watchOS)
        return .solidColor
        #elseif canImport(UIKit)
        if #available(iOS 15, *) {
            return .swiftUIMaterial
        }
        return .blurEffect
        #else
        if #available(macOS 12, *) {
            return .swiftUIMaterial
        }
        return .solidColor
        #endif
    }
    
    // MARK: - Capability Detection
    
    /// Returns the recommended blur radius for the current platform.
    public static var recommendedBlurRadius: CGFloat {
        switch currentStrategy {
        case .native:
            return 25
        case .swiftUIMaterial:
            return 20
        case .blurEffect:
            return 15  // Lower for performance on older devices
        case .solidColor:
            return 0
        }
    }
    
    /// Returns whether specular highlights are supported.
    public static var supportsSpecularHighlights: Bool {
        if #available(iOS 26, *) {
            return true
        }
        return false
    }
    
    /// Returns whether morphing animations are natively supported.
    public static var supportsMorphingAnimations: Bool {
        if #available(iOS 26, *) {
            return true
        }
        // We provide fallback morphing using matchedGeometryEffect
        return true
    }
}

// MARK: - FallbackGlassView

/// A UIKit-backed glass view for iOS 15–25 that provides high-fidelity
/// blur rendering using `UIVisualEffectView`.
#if canImport(UIKit) && !os(watchOS)
public struct FallbackGlassView: UIViewRepresentable {

    let material: GlassMaterial
    let cornerRadius: CGFloat

    public init(material: GlassMaterial = .frosted, cornerRadius: CGFloat = 16) {
        self.material = material
        self.cornerRadius = cornerRadius
    }

    public func makeUIView(context: Context) -> UIVisualEffectView {
        let blurStyle: UIBlurEffect.Style = {
            switch material {
            case .clear:
                return .systemUltraThinMaterial
            case .frosted:
                return .systemThinMaterial
            case .tinted:
                return .systemMaterial
            case .dark:
                return .systemChromeMaterialDark
            case .custom:
                return .systemMaterial
            }
        }()

        let blurEffect = UIBlurEffect(style: blurStyle)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.layer.cornerRadius = cornerRadius
        effectView.layer.masksToBounds = true
        effectView.layer.cornerCurve = .continuous

        // Add tint overlay
        let tintView = UIView()
        tintView.translatesAutoresizingMaskIntoConstraints = false
        tintView.backgroundColor = uiColor(for: material)
        effectView.contentView.addSubview(tintView)

        NSLayoutConstraint.activate([
            tintView.topAnchor.constraint(equalTo: effectView.contentView.topAnchor),
            tintView.leadingAnchor.constraint(equalTo: effectView.contentView.leadingAnchor),
            tintView.trailingAnchor.constraint(equalTo: effectView.contentView.trailingAnchor),
            tintView.bottomAnchor.constraint(equalTo: effectView.contentView.bottomAnchor)
        ])

        // Add border
        effectView.layer.borderWidth = 0.5
        effectView.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor

        return effectView
    }

    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.layer.cornerRadius = cornerRadius
    }

    private func uiColor(for material: GlassMaterial) -> UIColor {
        switch material {
        case .clear:
            return UIColor.white.withAlphaComponent(0.05)
        case .frosted:
            return UIColor.white.withAlphaComponent(0.15)
        case .tinted:
            return UIColor.systemBlue.withAlphaComponent(0.1)
        case .dark:
            return UIColor.black.withAlphaComponent(0.2)
        case .custom(_, _, _, let opacity):
            return UIColor.white.withAlphaComponent(opacity * 0.2)
        }
    }
}
#endif

// MARK: - Fallback SwiftUI Glass

/// Pure SwiftUI fallback glass view for platforms without UIKit.
public struct FallbackSwiftUIGlass: View {

    let material: GlassMaterial
    let cornerRadius: CGFloat

    public init(material: GlassMaterial = .frosted, cornerRadius: CGFloat = 16) {
        self.material = material
        self.cornerRadius = cornerRadius
    }

    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(material.swiftUIMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(material.tintColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [.white.opacity(0.25), .white.opacity(0.08), .clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 0.5
                    )
            )
    }
}
