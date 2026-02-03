import SwiftUI

// MARK: - GlassMorphAnimationModifier

/// View modifier that animates the transition between two glass materials.
/// Creates a smooth morphing effect as the glass appearance changes.
public struct GlassMorphAnimationModifier: ViewModifier {

    // MARK: - Properties

    let fromMaterial: GlassMaterial
    let toMaterial: GlassMaterial
    let trigger: Bool
    let duration: TimeInterval

    @State private var progress: CGFloat = 0

    // MARK: - Body

    public func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(currentMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(currentTint)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(.white.opacity(0.2), lineWidth: 0.5)
                    )
            )
            .onChange(of: trigger) { _, newValue in
                withAnimation(.easeInOut(duration: duration)) {
                    progress = newValue ? 1.0 : 0.0
                }
            }
    }

    // MARK: - Private

    private var currentMaterial: Material {
        progress < 0.5 ? fromMaterial.swiftUIMaterial : toMaterial.swiftUIMaterial
    }

    private var currentTint: Color {
        let fromColor = fromMaterial.tintColor
        let toColor = toMaterial.tintColor

        // Simple crossfade between tint colors
        return progress < 0.5
            ? fromColor.opacity(1.0 - Double(progress * 2))
            : toColor.opacity(Double((progress - 0.5) * 2))
    }
}

// MARK: - GlassPulseModifier

/// View modifier that creates a pulsing glass effect.
/// The glass material subtly breathes with opacity changes.
public struct GlassPulseModifier: ViewModifier {

    let intensity: CGFloat
    let speed: TimeInterval

    @State private var isPulsing = false

    public func body(content: Content) -> some View {
        content
            .opacity(isPulsing ? 1.0 : (1.0 - Double(intensity) * 0.15))
            .onAppear {
                withAnimation(
                    .easeInOut(duration: speed)
                    .repeatForever(autoreverses: true)
                ) {
                    isPulsing = true
                }
            }
    }
}

// MARK: - View Extensions

extension View {

    /// Applies a morph animation between two glass materials.
    /// - Parameters:
    ///   - from: Starting material.
    ///   - to: Ending material.
    ///   - trigger: Boolean that triggers the animation.
    ///   - duration: Animation duration. Default is 0.5.
    public func glassMorphAnimation(
        from: GlassMaterial,
        to: GlassMaterial,
        trigger: Bool,
        duration: TimeInterval = 0.5
    ) -> some View {
        modifier(GlassMorphAnimationModifier(
            fromMaterial: from,
            toMaterial: to,
            trigger: trigger,
            duration: duration
        ))
    }

    /// Applies a pulsing animation to the glass effect.
    /// - Parameters:
    ///   - intensity: Pulse intensity from 0 to 1. Default is 0.5.
    ///   - speed: Pulse cycle duration. Default is 2.0.
    public func glassPulse(
        intensity: CGFloat = 0.5,
        speed: TimeInterval = 2.0
    ) -> some View {
        modifier(GlassPulseModifier(intensity: intensity, speed: speed))
    }
}
