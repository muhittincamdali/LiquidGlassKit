import SwiftUI

/// The primary visual signature for the portfolio.
/// 
/// This modifier applies a world-class glass effect using .ultraThinMaterial,
/// custom strokes, and calibrated shadows.
public struct LiquidGlassModifier: ViewModifier {
    public let cornerRadius: CGFloat
    public let shadowRadius: CGFloat
    
    public init(cornerRadius: CGFloat = 24, shadowRadius: CGFloat = 10) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
    }
    
    public func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(.white.opacity(0.3), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.1), radius: shadowRadius, x: 0, y: 5)
    }
}

public extension View {
    /// Applies the world-class Liquid Glass visual signature.
    func liquidGlass(cornerRadius: CGFloat = 24, shadowRadius: CGFloat = 10) -> some View {
        self.modifier(LiquidGlassModifier(cornerRadius: cornerRadius, shadowRadius: shadowRadius))
    }
}
