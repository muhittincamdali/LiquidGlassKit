import SwiftUI
import Testing
@testable import LiquidGlassKit

@Suite("GlassSliderTrack")
struct GlassSliderTrackTests {
    @Test func fractionMapsTheRangeOntoZeroToOne() {
        let track = GlassSliderTrack(range: 10...20, step: nil)
        #expect(track.fraction(of: 10) == 0)
        #expect(track.fraction(of: 15) == 0.5)
        #expect(track.fraction(of: 20) == 1)
    }

    @Test func valuesOutsideTheRangeAreClamped() {
        let track = GlassSliderTrack(range: 0...1, step: nil)
        #expect(track.fraction(of: -3) == 0)
        #expect(track.fraction(of: 7) == 1)
        #expect(track.value(atFraction: -0.5) == 0)
        #expect(track.value(atFraction: 1.5) == 1)
        #expect(track.snapped(.nan) == 0)
        #expect(track.value(atFraction: .infinity) == 0)
    }

    /// Regression test: the playground's slider rounded to multiples of the step
    /// from zero, so a 1...10 range with a step of 2 produced even values.
    @Test func stepsCountFromTheLowerBound() {
        let track = GlassSliderTrack(range: 1...10, step: 2)
        #expect(track.snapped(4.2) == 5)
        #expect(track.snapped(1.9) == 1)
        #expect(track.snapped(2.1) == 3)
        #expect(track.value(atFraction: 0.5) == 5)
    }

    /// 9 is the last step inside 1...10; rounding up to 11 must fall back to 9.
    @Test func snappingNeverLeavesTheRange() {
        let track = GlassSliderTrack(range: 1...10, step: 2)
        #expect(track.snapped(9.9) == 9)
        #expect(track.value(atFraction: 1) == 9)
    }

    @Test(arguments: [0.0, -1.0, .infinity, -.infinity, .nan])
    func stepsThatAreNotPositiveAndFiniteAreIgnored(step: Double) {
        let track = GlassSliderTrack(range: 0...1, step: step)
        #expect(track.snapped(0.37) == 0.37)
    }

    @Test func anEmptyRangeStaysAtItsValue() {
        let track = GlassSliderTrack(range: 5...5, step: 1)
        #expect(!track.isMovable)
        #expect(track.fraction(of: 5) == 0)
        #expect(track.value(atFraction: 0.8) == 5)
        #expect(track.value(adjusting: 5, up: true) == 5)
    }

    /// An infinite step used to make 0 * infinity, so every value snapped to NaN.
    @Test func anInfiniteStepNeverProducesNaN() {
        let track = GlassSliderTrack(range: 0...10, step: .infinity)
        #expect(track.snapped(3) == 3)
        #expect(track.value(adjusting: 3, up: true) == 4, "a tenth of the range, as without a step")
        #expect(track.value(atFraction: 0.5) == 5)
    }

    /// With a step far smaller than the range, the step count overflowed to
    /// infinity and snapping returned infinity, outside the range.
    @Test func aTinyStepOnAHugeRangeStaysInside() {
        let track = GlassSliderTrack(range: 0...1e300, step: 1e-300)
        #expect(track.snapped(5e299) == 5e299)
        #expect(track.value(atFraction: 1) == 1e300)
    }

    /// The width of these ranges is not finite, so fractions would be NaN and
    /// the thumb's offset invalid; the track treats them as unmovable.
    @Test(arguments: [0...Double.infinity, -Double.infinity...0, -Double.greatestFiniteMagnitude...Double.greatestFiniteMagnitude])
    func rangesWithoutAFiniteWidthDoNotMove(range: ClosedRange<Double>) {
        let track = GlassSliderTrack(range: range, step: 1)
        #expect(!track.isMovable)
        #expect(track.fraction(of: 0) == 0)
        #expect(!track.snapped(0).isNaN)
        #expect(!track.value(adjusting: 0, up: true).isNaN)
    }

    /// The thumb's center travels from `inset` to `width - inset`, so touches on
    /// the outer half-thumb map to the ends.
    @Test func locationsMapAcrossTheThumbTravel() {
        let track = GlassSliderTrack(range: 0...100, step: nil)
        #expect(track.value(atLocation: 13, width: 226, inset: 13) == 0)
        #expect(track.value(atLocation: 113, width: 226, inset: 13) == 50)
        #expect(track.value(atLocation: 213, width: 226, inset: 13) == 100)
        #expect(track.value(atLocation: 0, width: 226, inset: 13) == 0)
        #expect(track.value(atLocation: 226, width: 226, inset: 13) == 100)
        #expect(track.value(atLocation: 10, width: 20, inset: 13) == 0, "a track narrower than the thumb")
    }

    @Test func accessibilityAdjustmentsMoveByOneStepOrATenth() {
        let stepped = GlassSliderTrack(range: 0...40, step: 4)
        #expect(stepped.value(adjusting: 8, up: true) == 12)
        #expect(stepped.value(adjusting: 8, up: false) == 4)
        #expect(stepped.value(adjusting: 40, up: true) == 40)
        let continuous = GlassSliderTrack(range: 0...1, step: nil)
        #expect(abs(continuous.value(adjusting: 0.5, up: true) - 0.6) < 1e-9)
        #expect(continuous.value(adjusting: 0, up: false) == 0)
    }
}

#if !os(tvOS)
@MainActor
@Suite("GlassSlider rendering")
struct GlassSliderRenderingTests {
    private static let size = CGSize(width: 300, height: 60)

    /// The tinted fill runs from the leading edge to the thumb, so the share of
    /// green columns follows the value.
    @Test(arguments: [0.2, 0.8])
    func fillFollowsTheValue(value: Double) throws {
        let slider = GlassSlider("Level", value: .constant(value), showsValue: false)
            .tint(.green)
        let bitmap = try #require(Bitmap.render(slider, size: Self.size))
        let greenColumns = (0..<bitmap.width).filter { x in
            (0..<bitmap.height).contains { y in Bitmap.isGreen(bitmap.pixel(x: x, y: y)) }
        }
        let share = Double(greenColumns.count) / Double(bitmap.width)
        #expect(abs(share - value) < 0.12, "green fill covers \(share) of the width for value \(value)")
    }

    @Test func trackUsesTheThemeMaterial() throws {
        let slider = GlassSlider("Level", value: .constant(0), showsValue: false)
            .tint(.red)
            .glassTheme(GlassTheme(material: .tinted(.blue)))
        let bitmap = try #require(Bitmap.render(slider, size: Self.size))
        #expect(bitmap.count(where: Bitmap.isBlue) > 500)
    }
}
#endif
