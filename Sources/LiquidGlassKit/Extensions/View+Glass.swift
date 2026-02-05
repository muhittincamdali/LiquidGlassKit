import SwiftUI

// MARK: - Glass Effect Variant

/// Defines the interaction style of the glass effect.
/// Mirrors the iOS 26 GlassEffectVariant API for backwards compatibility.
public enum GlassEffectVariant: Sendable, Hashable {
    /// Standard glass effect for static content.
    /// Best for cards, panels, and non-interactive elements.
    case regular
    
    /// Interactive glass effect with enhanced visual feedback.
    /// Automatically adjusts opacity and blur on press.
    case interactive
    
    /// Clear glass with minimal visual weight.
    /// Maximum content visibility with subtle blur.
    case clear
    
    /// Dark glass optimized for light content.
    /// Ideal for overlays on bright backgrounds.
    case dark
}

// MARK: - Glass Effect Content Shape

/// Defines the shape of the glass effect clipping.
/// Mirrors iOS 26's GlassEffectContentShape for compatibility.
public enum GlassEffectContentShape: Sendable, Hashable {
    /// Capsule shape (fully rounded pill).
    case capsule
    
    /// Rectangle with custom corner radius.
    case rectangle(cornerRadius: CGFloat)
    
    /// Circular shape.
    case circle
    
    /// Automatic shape based on content.
    case automatic
}

// MARK: - View + Glass Extensions

extension View {
    
    // MARK: - iOS 26 Compatible API
    
    /// Applies a glass effect with the specified variant.
    /// This is the primary API matching iOS 26's `.glassEffect()`.
    ///
    /// Example:
    /// ```swift
    /// Text("Hello")
    ///     .padding()
    ///     .glassEffect(.regular)
    /// ```
    ///
    /// - Parameter variant: The glass effect style. Default is `.regular`.
    /// - Returns: A view with the glass effect applied.
    public func glassEffect(_ variant: GlassEffectVariant = .regular) -> some View {
        modifier(GlassEffectVariantModifier(variant: variant))
    }
    
    /// Applies a glass effect with variant and shape.
    ///
    /// Example:
    /// ```swift
    /// Button("Tap Me") { }
    ///     .padding()
    ///     .glassEffect(.interactive, in: .capsule)
    /// ```
    ///
    /// - Parameters:
    ///   - variant: The glass effect style.
    ///   - shape: The content shape for clipping.
    /// - Returns: A view with shaped glass effect.
    public func glassEffect(
        _ variant: GlassEffectVariant = .regular,
        in shape: GlassEffectContentShape
    ) -> some View {
        modifier(GlassEffectVariantModifier(variant: variant, shape: shape))
    }
    
    /// Assigns a glass effect identity for morphing animations.
    /// Elements with the same ID in a container will morph between states.
    ///
    /// Example:
    /// ```swift
    /// GlassEffectContainer {
    ///     if isSelected {
    ///         expandedView
    ///             .glassEffectID("card")
    ///     } else {
    ///         compactView
    ///             .glassEffectID("card")
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - id: Unique identifier for morphing coordination.
    ///   - namespace: The namespace for the morphing group.
    /// - Returns: A view with glass effect identity.
    public func glassEffectID<ID: Hashable>(
        _ id: ID,
        in namespace: Namespace.ID
    ) -> some View {
        self.matchedGeometryEffect(id: id, in: namespace)
    }
    
    // MARK: - Standard API
    
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
    
    /// Disables the glass effect on this view.
    /// Useful for temporarily removing glass styling.
    public func glassEffectDisabled(_ disabled: Bool = true) -> some View {
        environment(\.glassEffectDisabled, disabled)
    }
}

// MARK: - Glass Effect Variant Modifier

/// A view modifier that applies a glass effect variant.
public struct GlassEffectVariantModifier: ViewModifier {
    
    let variant: GlassEffectVariant
    let shape: GlassEffectContentShape
    
    @State private var isPressed = false
    @Environment(\.glassEffectDisabled) private var isDisabled
    
    public init(
        variant: GlassEffectVariant,
        shape: GlassEffectContentShape = .automatic
    ) {
        self.variant = variant
        self.shape = shape
    }
    
    public func body(content: Content) -> some View {
        if isDisabled {
            content
        } else {
            effectiveContent(content)
        }
    }
    
    @ViewBuilder
    private func effectiveContent(_ content: Content) -> some View {
        switch variant {
        case .regular:
            content
                .background(glassBackground)
                .clipShape(effectiveShape)
                .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
            
        case .interactive:
            content
                .background(interactiveGlassBackground)
                .clipShape(effectiveShape)
                .shadow(
                    color: .black.opacity(isPressed ? 0.15 : 0.1),
                    radius: isPressed ? 4 : 8,
                    y: isPressed ? 2 : 4
                )
                .scaleEffect(isPressed ? 0.98 : 1.0)
                .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isPressed)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in isPressed = true }
                        .onEnded { _ in isPressed = false }
                )
            
        case .clear:
            content
                .background(clearGlassBackground)
                .clipShape(effectiveShape)
                .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
            
        case .dark:
            content
                .background(darkGlassBackground)
                .clipShape(effectiveShape)
                .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
        }
    }
    
    // MARK: - Background Views
    
    @ViewBuilder
    private var glassBackground: some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .overlay(Rectangle().fill(Color.white.opacity(0.1)))
            .overlay(Rectangle().stroke(.white.opacity(0.2), lineWidth: 0.5))
    }
    
    @ViewBuilder
    private var interactiveGlassBackground: some View {
        Rectangle()
            .fill(.thinMaterial)
            .overlay(Rectangle().fill(Color.white.opacity(isPressed ? 0.2 : 0.15)))
            .overlay(Rectangle().stroke(.white.opacity(isPressed ? 0.4 : 0.25), lineWidth: 0.5))
    }
    
    @ViewBuilder
    private var clearGlassBackground: some View {
        Rectangle()
            .fill(.ultraThinMaterial.opacity(0.7))
            .overlay(Rectangle().fill(Color.white.opacity(0.05)))
    }
    
    @ViewBuilder
    private var darkGlassBackground: some View {
        Rectangle()
            .fill(.ultraThickMaterial)
            .overlay(Rectangle().fill(Color.black.opacity(0.2)))
            .overlay(Rectangle().stroke(.white.opacity(0.1), lineWidth: 0.5))
    }
    
    // MARK: - Shape
    
    @ViewBuilder
    private var effectiveShape: some Shape {
        switch shape {
        case .capsule:
            Capsule()
        case .rectangle(let cornerRadius):
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        case .circle:
            Circle()
        case .automatic:
            RoundedRectangle(cornerRadius: 16, style: .continuous)
        }
    }
}

// MARK: - Environment Keys

private struct GlassEffectDisabledKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    /// Whether glass effects are disabled for this view hierarchy.
    public var glassEffectDisabled: Bool {
        get { self[GlassEffectDisabledKey.self] }
        set { self[GlassEffectDisabledKey.self] = newValue }
    }
}
