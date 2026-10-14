import SwiftUI

/// Maps between slider values, track fractions and touch locations.
///
/// Values are clamped to `range`. With a `step`, values snap to
/// `range.lowerBound + n * step`, so a range of `1...10` with a step of `2`
/// produces 1, 3, 5, 7 and 9, never a value outside the range.
struct GlassSliderTrack: Equatable {
    let range: ClosedRange<Double>
    let step: Double?

    /// Whether the range has room to move. A slider over `5...5` stays at 5, and
    /// one over a range whose width is not finite, such as `0...Double.infinity`,
    /// does not move either, because positions on it cannot be computed.
    var isMovable: Bool {
        let width = range.upperBound - range.lowerBound
        return width.isFinite && width > 0
    }

    /// The position of `value` along the track, from 0 (lower bound) to 1 (upper bound).
    func fraction(of value: Double) -> Double {
        guard isMovable else { return 0 }
        return ((snapped(value) - range.lowerBound) / (range.upperBound - range.lowerBound)).clamped(to: 0...1)
    }

    /// The value at a position along the track, from 0 to 1.
    func value(atFraction fraction: Double) -> Double {
        let fraction = fraction.isFinite ? fraction.clamped(to: 0...1) : 0
        return snapped(range.lowerBound + fraction * (range.upperBound - range.lowerBound))
    }

    /// The value under a touch at `location` points from the leading edge of a
    /// track `width` points wide, where the thumb's center travels from `inset`
    /// to `width - inset`.
    func value(atLocation location: CGFloat, width: CGFloat, inset: CGFloat) -> Double {
        let travel = width - 2 * inset
        guard travel > 0 else { return value(atFraction: 0) }
        return value(atFraction: Double((location - inset) / travel))
    }

    /// The value one accessibility increment or decrement away: one step, or a
    /// tenth of the range without a step.
    func value(adjusting value: Double, up: Bool) -> Double {
        let increment = step.flatMap { $0 > 0 && $0.isFinite ? $0 : nil } ?? (range.upperBound - range.lowerBound) / 10
        return snapped(value + (up ? increment : -increment))
    }

    /// `value` clamped to the range and, with a positive finite step, rounded to
    /// the nearest step from the lower bound that is still inside the range.
    func snapped(_ value: Double) -> Double {
        guard value.isFinite else { return range.lowerBound }
        let clamped = value.clamped(to: range)
        guard let step, step > 0, step.isFinite, isMovable else { return clamped }
        let steps = ((clamped - range.lowerBound) / step).rounded()
        let candidate = range.lowerBound + steps * step
        // A step far smaller than the range overflows the step count.
        guard candidate.isFinite else { return clamped }
        return (candidate > range.upperBound ? candidate - step : candidate).clamped(to: range)
    }
}

#if !os(tvOS)
/// A slider with a glass track, a tinted fill and a draggable thumb.
///
/// ```swift
/// @State private var volume = 0.6
///
/// GlassSlider("Volume", value: $volume)
///
/// GlassSlider("Corner radius", value: $radius, in: 0...40, step: 2)
/// ```
///
/// The title and the formatted value are shown above the track. VoiceOver reads
/// the slider as adjustable: swiping up or down moves it by one `step`, or by a
/// tenth of the range when there is no step. Not available on tvOS, which has no
/// drag gesture.
public struct GlassSlider: View {
    @Binding private var value: Double
    private let title: String
    private let track: GlassSliderTrack
    private let material: GlassMaterial?
    private let showsValue: Bool
    private let format: FloatingPointFormatStyle<Double>
    private let onEditingChanged: (Bool) -> Void

    @State private var isDragging = false
    @Environment(\.isEnabled) private var isEnabled

    /// - Parameters:
    ///   - title: Shown above the track and read by VoiceOver.
    ///   - value: The selected value.
    ///   - range: The values the slider can select.
    ///   - step: The distance between valid values, measured from the lower bound, or `nil` for any value.
    ///     A step that is not positive and finite is ignored.
    ///   - material: The track's glass material, or `nil` to use the theme's material.
    ///   - showsValue: Shows the formatted value next to the title.
    ///   - format: How the value is formatted on screen and for VoiceOver.
    ///   - onEditingChanged: Called with `true` when a drag starts and `false` when it ends.
    public init(
        _ title: String,
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...1,
        step: Double? = nil,
        material: GlassMaterial? = nil,
        showsValue: Bool = true,
        format: FloatingPointFormatStyle<Double> = .number.precision(.fractionLength(0...2)),
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) {
        self._value = value
        self.title = title
        self.track = GlassSliderTrack(range: range, step: step)
        self.material = material
        self.showsValue = showsValue
        self.format = format
        self.onEditingChanged = onEditingChanged
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer(minLength: 8)
                if showsValue {
                    Text(value.formatted(format))
                        .font(.subheadline.monospacedDigit())
                }
            }
            trackView
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(title)
        .accessibilityValue(value.formatted(format))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment: update(track.value(adjusting: value, up: true))
            case .decrement: update(track.value(adjusting: value, up: false))
            @unknown default: break
            }
        }
    }

    private var trackView: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let thumbCenter = Self.thumbRadius + (width - 2 * Self.thumbRadius) * track.fraction(of: value)
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.clear)
                    .glassSurface(material, in: .capsule)
                    .frame(height: Self.trackHeight)
                Capsule()
                    .fill(.tint)
                    .frame(width: max(Self.trackHeight, thumbCenter), height: Self.trackHeight)
                Circle()
                    .fill(.white)
                    .shadow(color: .black.opacity(0.2), radius: 3, y: 1)
                    .frame(width: 2 * Self.thumbRadius, height: 2 * Self.thumbRadius)
                    .scaleEffect(isDragging ? Self.draggingScale : 1)
                    .offset(x: thumbCenter - Self.thumbRadius)
            }
            .frame(maxHeight: .infinity)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        if !isDragging {
                            isDragging = true
                            onEditingChanged(true)
                        }
                        update(track.value(atLocation: gesture.location.x, width: width, inset: Self.thumbRadius))
                    }
                    .onEnded { _ in
                        isDragging = false
                        onEditingChanged(false)
                    }
            )
        }
        .frame(height: 2 * Self.thumbRadius)
        .opacity(track.isMovable && isEnabled ? 1 : 0.5)
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isDragging)
        .selectionFeedback(trigger: value) { _, _ in track.step != nil }
    }

    private func update(_ newValue: Double) {
        guard track.isMovable, newValue.isFinite, newValue != value else { return }
        value = newValue
    }

    static let trackHeight: CGFloat = 8
    static let thumbRadius: CGFloat = 13
    static let draggingScale = 1.15
}
#endif
