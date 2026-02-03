import SwiftUI

// MARK: - GlassTransitionType

/// Types of glass-specific view transitions.
public enum GlassTransitionType: Sendable {
    /// Glass morphs in from transparent to the target material.
    case morphIn
    /// Glass morphs out from the current material to transparent.
    case morphOut
    /// Glass dissolves in with opacity animation.
    case dissolve(duration: TimeInterval = 0.4)
    /// Glass slides in from the specified edge with blur.
    case slide(edge: Edge, duration: TimeInterval = 0.35)
    /// Glass scales from a point with spring animation.
    case scale(anchor: UnitPoint = .center)
    /// Combined morph and scale for emphasis.
    case expand
}

// MARK: - GlassTransitionModifier

/// View modifier that applies glass-specific transition effects.
public struct GlassTransitionModifier: ViewModifier {

    let type: GlassTransitionType
    let isActive: Bool

    public func body(content: Content) -> some View {
        switch type {
        case .morphIn:
            content
                .opacity(isActive ? 1.0 : 0.0)
                .blur(radius: isActive ? 0 : 10)
                .animation(.easeOut(duration: 0.4), value: isActive)

        case .morphOut:
            content
                .opacity(isActive ? 0.0 : 1.0)
                .blur(radius: isActive ? 10 : 0)
                .animation(.easeIn(duration: 0.3), value: isActive)

        case .dissolve(let duration):
            content
                .opacity(isActive ? 1.0 : 0.0)
                .animation(.easeInOut(duration: duration), value: isActive)

        case .slide(let edge, let duration):
            content
                .offset(slideOffset(for: edge))
                .opacity(isActive ? 1.0 : 0.0)
                .animation(.easeOut(duration: duration), value: isActive)

        case .scale(let anchor):
            content
                .scaleEffect(isActive ? 1.0 : 0.8, anchor: anchor)
                .opacity(isActive ? 1.0 : 0.0)
                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isActive)

        case .expand:
            content
                .scaleEffect(isActive ? 1.0 : 0.85)
                .opacity(isActive ? 1.0 : 0.0)
                .blur(radius: isActive ? 0 : 5)
                .animation(.spring(response: 0.45, dampingFraction: 0.75), value: isActive)
        }
    }

    private func slideOffset(for edge: Edge) -> CGSize {
        guard !isActive else { return .zero }
        switch edge {
        case .top: return CGSize(width: 0, height: -50)
        case .bottom: return CGSize(width: 0, height: 50)
        case .leading: return CGSize(width: -50, height: 0)
        case .trailing: return CGSize(width: 50, height: 0)
        }
    }
}

// MARK: - View Extension

extension View {

    /// Applies a glass-specific transition to the view.
    /// - Parameters:
    ///   - type: The type of glass transition.
    ///   - isActive: Whether the transition target state is active.
    public func glassTransition(_ type: GlassTransitionType, isActive: Bool = true) -> some View {
        modifier(GlassTransitionModifier(type: type, isActive: isActive))
    }
}
