import SwiftUI

/// A toggle style that draws a switch with a glass track.
///
/// ```swift
/// Toggle("Wi-Fi", isOn: $isWiFiOn)
///     .toggleStyle(.liquidGlass)
///
/// Toggle("Low Power Mode", isOn: $lowPower)
///     .toggleStyle(.liquidGlass(tint: .yellow))
/// ```
///
/// When the toggle is off, the track is a capsule of glass in the given material
/// (or the theme's material). When it is on, the track fills with `tint`, or with
/// the view's tint color when `tint` is `nil`. VoiceOver reads it as a regular
/// switch, because the style keeps SwiftUI's own `Toggle` as its accessibility
/// representation.
public struct LiquidGlassToggleStyle: ToggleStyle {
    /// The glass material of the track while the toggle is off, or `nil` to use the theme's material.
    public var material: GlassMaterial?
    /// The fill of the track while the toggle is on, or `nil` to use the view's tint color.
    public var tint: Color?

    public init(material: GlassMaterial? = nil, tint: Color? = nil) {
        self.material = material
        self.tint = tint
    }

    public func makeBody(configuration: Configuration) -> some View {
        Switch(configuration: configuration, material: material, tint: tint)
    }

    /// Track and thumb measurements, in points.
    enum Metrics {
        static let trackWidth: CGFloat = 52
        static let trackHeight: CGFloat = 32
        static let thumbInset: CGFloat = 2
        static var thumbDiameter: CGFloat { trackHeight - 2 * thumbInset }

        /// Horizontal offset of the thumb's center from the center of the track.
        static func thumbOffset(isOn: Bool) -> CGFloat {
            let travel = (trackWidth - thumbDiameter) / 2 - thumbInset
            return isOn ? travel : -travel
        }
    }

    private struct Switch: View {
        let configuration: Configuration
        let material: GlassMaterial?
        let tint: Color?

        @Environment(\.isEnabled) private var isEnabled

        var body: some View {
            Button {
                configuration.isOn.toggle()
            } label: {
                HStack(spacing: 12) {
                    configuration.label
                    Spacer(minLength: 0)
                    track
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .opacity(isEnabled ? 1 : 0.5)
            .animation(.spring(response: 0.3, dampingFraction: 0.75), value: configuration.isOn)
            .selectionFeedback(trigger: configuration.isOn)
            .accessibilityRepresentation {
                Toggle(isOn: configuration.$isOn) { configuration.label }
            }
        }

        private var track: some View {
            ZStack {
                if configuration.isOn {
                    Capsule().fill(tint.map(AnyShapeStyle.init) ?? AnyShapeStyle(.tint))
                } else {
                    Capsule().fill(.clear).glassSurface(material, in: .capsule)
                }
                Circle()
                    .fill(.white)
                    .shadow(color: .black.opacity(0.2), radius: 2, y: 1)
                    .frame(width: Metrics.thumbDiameter, height: Metrics.thumbDiameter)
                    .offset(x: Metrics.thumbOffset(isOn: configuration.isOn))
            }
            .frame(width: Metrics.trackWidth, height: Metrics.trackHeight)
        }
    }
}

extension ToggleStyle where Self == LiquidGlassToggleStyle {
    /// A switch with a glass track in the theme's material, filled with the tint color when on.
    public static var liquidGlass: LiquidGlassToggleStyle { LiquidGlassToggleStyle() }

    /// A switch with a glass track in an explicit material and an explicit "on" fill.
    public static func liquidGlass(_ material: GlassMaterial? = nil, tint: Color? = nil) -> LiquidGlassToggleStyle {
        LiquidGlassToggleStyle(material: material, tint: tint)
    }
}
