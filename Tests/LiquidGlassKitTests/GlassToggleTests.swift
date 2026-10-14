import SwiftUI
import Testing
@testable import LiquidGlassKit

@MainActor
@Suite("LiquidGlassToggleStyle")
struct GlassToggleTests {
    private typealias Metrics = LiquidGlassToggleStyle.Metrics
    private static let size = CGSize(width: 240, height: 48)

    @Test func thumbStaysInsideTheTrack() {
        for isOn in [false, true] {
            let center = Metrics.trackWidth / 2 + Metrics.thumbOffset(isOn: isOn)
            #expect(center - Metrics.thumbDiameter / 2 == (isOn ? Metrics.trackWidth - Metrics.thumbDiameter - Metrics.thumbInset : Metrics.thumbInset))
        }
        #expect(Metrics.thumbOffset(isOn: true) == -Metrics.thumbOffset(isOn: false))
        #expect(Metrics.thumbDiameter + 2 * Metrics.thumbInset == Metrics.trackHeight)
    }

    /// The track is the only colored part of the row: green fill when on, the
    /// theme's blue glass when off.
    @Test(arguments: [false, true])
    func trackShowsTheTintOnlyWhenOn(isOn: Bool) throws {
        let toggle = Toggle("Wi-Fi", isOn: .constant(isOn))
            .toggleStyle(.liquidGlass(tint: .green))
            .glassTheme(GlassTheme(material: .tinted(.blue)))
        let bitmap = try #require(Bitmap.render(toggle, size: Self.size))
        let green = bitmap.count(where: Bitmap.isGreen)
        let blueGlass = bitmap.count(where: { Bitmap.isBlue($0) && !Bitmap.isGreen($0) })
        if isOn {
            #expect(green > 500, "an on toggle drew \(green) green pixels")
        } else {
            #expect(green == 0, "an off toggle drew \(green) green pixels")
            #expect(blueGlass > 300, "an off toggle drew \(blueGlass) pixels of the theme's blue glass")
        }
    }

    /// The thumb is white, so it is found where the track has no green: on the
    /// trailing end when on.
    @Test func thumbMovesToTheTrailingEndWhenOn() throws {
        let toggle = Toggle(isOn: .constant(true)) { EmptyView() }
            .toggleStyle(.liquidGlass(tint: .green))
        let bitmap = try #require(Bitmap.render(toggle, size: Self.size))
        let trackStart = Int(Self.size.width - Metrics.trackWidth)
        let middle = trackStart + Int(Metrics.trackWidth / 2)
        let leading = (trackStart..<middle).reduce(0) { sum, x in sum + (Bitmap.isGreen(bitmap.pixel(x: x, y: 24)) ? 1 : 0) }
        let trailing = (middle..<Int(Self.size.width)).reduce(0) { sum, x in sum + (Bitmap.isGreen(bitmap.pixel(x: x, y: 24)) ? 1 : 0) }
        #expect(leading > trailing, "green (uncovered track) should be on the leading half: \(leading) vs \(trailing)")
    }

    @Test func anExplicitMaterialOverridesTheTheme() throws {
        let toggle = Toggle("Off", isOn: .constant(false))
            .toggleStyle(.liquidGlass(.tinted(.green)))
            .glassTheme(GlassTheme(material: .tinted(.blue)))
        let bitmap = try #require(Bitmap.render(toggle, size: Self.size))
        #expect(bitmap.count(where: Bitmap.isGreen) > 300)
    }
}
