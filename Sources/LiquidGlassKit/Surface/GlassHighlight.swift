import SwiftUI

/// An animated light effect drawn over a glass surface.
///
/// Apply it with ``SwiftUICore/View/glassHighlight(_:color:in:)``. Each highlight
/// repeats every ``period`` seconds. When the user turns on *Reduce Motion*, no
/// highlight is drawn.
public enum GlassHighlight: String, Sendable, Hashable, CaseIterable {
    /// A soft band of light that sweeps from the leading to the trailing edge.
    case shimmer
    /// The surface brightens and fades back, once per period.
    case pulse
    /// A slow, faint brightening and fading, for idle states.
    case breathe

    /// The length of one cycle, in seconds.
    public var period: Double {
        switch self {
        case .shimmer: 2.5
        case .pulse: 1.5
        case .breathe: 3
        }
    }

    /// The position in the cycle at `time` seconds, from 0 up to (not including) 1.
    func phase(at time: TimeInterval) -> Double {
        guard time.isFinite else { return 0 }
        let phase = time.truncatingRemainder(dividingBy: period) / period
        return phase < 0 ? phase + 1 : phase
    }

    /// The opacity of the highlight color at `phase`. For ``shimmer`` this is the
    /// band's peak, which stays constant while the band moves.
    func opacity(at phase: Double) -> Double {
        let wave = (1 - cos(2 * .pi * phase)) / 2 // 0 at the start and end of a cycle, 1 halfway
        switch self {
        case .shimmer: return Self.shimmerPeak
        case .pulse: return Self.pulsePeak * wave
        case .breathe: return Self.breatheFloor + (Self.breathePeak - Self.breatheFloor) * wave
        }
    }

    /// The horizontal center of the shimmer band at `phase`, in unit coordinates.
    /// The band starts fully outside the leading edge and ends outside the trailing edge.
    static func shimmerCenter(at phase: Double) -> Double {
        -shimmerHalfWidth + phase * (1 + 2 * shimmerHalfWidth)
    }

    static let shimmerHalfWidth = 0.3
    static let shimmerPeak = 0.35
    static let pulsePeak = 0.3
    static let breatheFloor = 0.05
    static let breathePeak = 0.18
}

extension View {
    /// Draws an animated highlight over this view, inside a glass outline.
    ///
    /// ```swift
    /// GlassButton("Upgrade", systemImage: "sparkles") {}
    ///     .glassHighlight(.shimmer, in: .capsule)
    /// ```
    ///
    /// The highlight is drawn over the view, ignores touches and is hidden from
    /// VoiceOver. With *Reduce Motion* on, or with a `nil` highlight, nothing is drawn.
    ///
    /// - Parameters:
    ///   - highlight: The effect, or `nil` for none.
    ///   - color: The color of the light. White suits most glass.
    ///   - shape: The outline to draw in, or `nil` to use the theme's shape. Match
    ///     the shape of the glass under it.
    public func glassHighlight(
        _ highlight: GlassHighlight?,
        color: Color = .white,
        in shape: GlassShape? = nil
    ) -> some View {
        modifier(GlassHighlightModifier(highlight: highlight, color: color, shape: shape))
    }
}

struct GlassHighlightModifier: ViewModifier {
    let highlight: GlassHighlight?
    let color: Color
    let shape: GlassShape?

    @Environment(\.glassTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content.overlay {
            if let highlight, !reduceMotion {
                TimelineView(.animation) { context in
                    GlassHighlightLayer(
                        highlight: highlight,
                        color: color,
                        outline: (shape ?? theme.shape).shape,
                        phase: highlight.phase(at: context.date.timeIntervalSinceReferenceDate)
                    )
                }
                .allowsHitTesting(false)
                .accessibilityHidden(true)
            }
        }
    }
}

/// One frame of a highlight.
struct GlassHighlightLayer: View {
    let highlight: GlassHighlight
    let color: Color
    let outline: AnyShape
    let phase: Double

    var body: some View {
        switch highlight {
        case .shimmer:
            let center = GlassHighlight.shimmerCenter(at: phase)
            let half = GlassHighlight.shimmerHalfWidth
            outline.fill(
                LinearGradient(
                    colors: [color.opacity(0), color.opacity(GlassHighlight.shimmerPeak), color.opacity(0)],
                    startPoint: UnitPoint(x: center - half, y: 0.5),
                    endPoint: UnitPoint(x: center + half, y: 0.5)
                )
            )
        case .pulse, .breathe:
            outline.fill(color.opacity(highlight.opacity(at: phase)))
        }
    }
}
