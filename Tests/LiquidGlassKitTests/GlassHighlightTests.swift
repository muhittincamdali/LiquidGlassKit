import SwiftUI
import Testing
@testable import LiquidGlassKit

@Suite("GlassHighlight")
struct GlassHighlightTests {
    @Test func phaseWrapsEveryPeriod() {
        let pulse = GlassHighlight.pulse // 1.5 s
        #expect(pulse.phase(at: 0) == 0)
        #expect(pulse.phase(at: 0.75) == 0.5)
        #expect(pulse.phase(at: 1.5) == 0)
        #expect(pulse.phase(at: 3.375) == 0.25)
        #expect(pulse.phase(at: -0.375) == 0.75, "times before the reference date wrap forwards")
        #expect(pulse.phase(at: .nan) == 0)
    }

    @Test(arguments: GlassHighlight.allCases)
    func phaseStaysInTheUnitInterval(highlight: GlassHighlight) {
        for time in stride(from: -10.0, through: 10.0, by: 0.37) {
            let phase = highlight.phase(at: time)
            #expect(phase >= 0 && phase < 1, "\(highlight) phase \(phase) at \(time)")
        }
    }

    @Test func pulseRisesAndFallsWithinOneCycle() {
        let pulse = GlassHighlight.pulse
        #expect(pulse.opacity(at: 0) == 0)
        #expect(abs(pulse.opacity(at: 0.5) - GlassHighlight.pulsePeak) < 1e-12)
        #expect(pulse.opacity(at: 0.25) > pulse.opacity(at: 0.1))
        #expect(abs(pulse.opacity(at: 0.25) - pulse.opacity(at: 0.75)) < 1e-12)
    }

    @Test func breathingNeverFadesOut() {
        let samples = stride(from: 0.0, to: 1, by: 0.05).map(GlassHighlight.breathe.opacity(at:))
        #expect(abs(samples.min()! - GlassHighlight.breatheFloor) < 1e-12)
        #expect(samples.max()! <= GlassHighlight.breathePeak)
        #expect(samples.max()! > GlassHighlight.breathePeak - 0.01)
    }

    @Test func shimmerBandCrossesTheWholeSurface() {
        let half = GlassHighlight.shimmerHalfWidth
        #expect(GlassHighlight.shimmerCenter(at: 0) + half == 0, "the band starts just outside the leading edge")
        #expect(GlassHighlight.shimmerCenter(at: 1) - half == 1, "the band ends just outside the trailing edge")
        #expect(GlassHighlight.shimmerCenter(at: 0.25) < GlassHighlight.shimmerCenter(at: 0.75))
    }
}

@MainActor
@Suite("GlassHighlight rendering")
struct GlassHighlightRenderingTests {
    private static let size = CGSize(width: 200, height: 60)
    private static let outline = GlassShape.roundedRectangle(cornerRadius: 0).shape

    private func frame(_ highlight: GlassHighlight, phase: Double) throws -> Bitmap {
        let layer = GlassHighlightLayer(highlight: highlight, color: .green, outline: Self.outline, phase: phase)
        return try #require(Bitmap.render(layer, size: Self.size))
    }

    @Test func pulseIsInvisibleAtTheStartAndBrightestHalfway() throws {
        #expect(try frame(.pulse, phase: 0).count(where: Bitmap.differsFromWhite) == 0)
        let peak = try frame(.pulse, phase: 0.5)
        #expect(peak.count(where: Bitmap.isGreen) == peak.width * peak.height)
    }

    @Test func shimmerBandFollowsThePhase() throws {
        // Band centers at 0.3 and 0.7 of the width.
        let early = try frame(.shimmer, phase: 0.375)
        let late = try frame(.shimmer, phase: 0.625)
        let third = Int(Self.size.width) / 3
        let leading = 0..<third
        let trailing = (Int(Self.size.width) - third)..<Int(Self.size.width)
        #expect(early.count(columns: leading, where: Bitmap.isGreen) > early.count(columns: trailing, where: Bitmap.isGreen))
        #expect(late.count(columns: trailing, where: Bitmap.isGreen) > late.count(columns: leading, where: Bitmap.isGreen))
    }

    @Test(arguments: [false, true])
    func reduceMotionDrawsNothing(reduceMotion: Bool) throws {
        let base = Color.clear.glassSurface(.frosted, in: .roundedRectangle(cornerRadius: 0))
        let highlighted = base
            .glassHighlight(.breathe, color: .green, in: .roundedRectangle(cornerRadius: 0))
            .environment(\._accessibilityReduceMotion, reduceMotion)
        let plain = try #require(Bitmap.render(base, size: Self.size))
        let bitmap = try #require(Bitmap.render(highlighted, size: Self.size))
        if reduceMotion {
            #expect(bitmap.countDifferences(from: plain) == 0)
        } else {
            // Breathing never fades below its floor, so some frame is always visible.
            #expect(bitmap.countDifferences(from: plain) > 1000)
        }
    }

    @Test func aNilHighlightDrawsNothing() throws {
        let base = Color.clear.glassSurface(.frosted, in: .capsule)
        let plain = try #require(Bitmap.render(base, size: Self.size))
        let none = try #require(Bitmap.render(base.glassHighlight(nil), size: Self.size))
        #expect(none.countDifferences(from: plain) == 0)
    }
}
