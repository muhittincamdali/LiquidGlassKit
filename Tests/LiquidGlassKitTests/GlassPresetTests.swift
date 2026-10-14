import SwiftUI
import Testing
@testable import LiquidGlassKit

@Suite("GlassPreset")
struct GlassPresetTests {
    @Test func namesAreUniqueIgnoringCase() {
        let names = GlassPreset.all.map { $0.name.lowercased() }
        #expect(Set(names).count == names.count)
        #expect(GlassPreset.all.allSatisfy { !$0.summary.isEmpty })
    }

    @Test func everyPresetHasItsOwnTheme() {
        #expect(Set(GlassPreset.all.map(\.theme)).count == GlassPreset.all.count)
    }

    @Test func theDefaultLookComesFirst() {
        #expect(GlassPreset.all.first?.theme == .standard)
        #expect(GlassPreset.all.contains { $0.theme == .subtle })
        #expect(GlassPreset.all.contains { $0.theme == .dark })
    }

    @Test(arguments: ["Aqua", "aqua", "  AQUA\n"])
    func lookupIgnoresCaseAndSurroundingSpace(name: String) {
        #expect(GlassPreset.named(name)?.theme == .aqua)
    }

    @Test(arguments: ["", "Aquamarine", "Aq ua"])
    func unknownNamesFindNothing(name: String) {
        #expect(GlassPreset.named(name) == nil)
    }
}

@MainActor
@Suite("GlassPreset rendering")
struct GlassPresetRenderingTests {
    private static let size = CGSize(width: 120, height: 60)

    private func render(_ theme: GlassTheme) throws -> Bitmap {
        let surface = Color.clear
            .frame(width: 80, height: 30)
            .glassSurface()
            .glassTheme(theme)
        return try #require(Bitmap.render(surface, size: Self.size))
    }

    /// Presets that render identically would be one look under two names.
    @Test func everyPresetRendersDifferently() throws {
        let renders = try GlassPreset.all.map { ($0.name, try render($0.theme)) }
        for (index, (name, bitmap)) in renders.enumerated() {
            for (otherName, other) in renders[(index + 1)...] {
                #expect(bitmap.countDifferences(from: other) > 50, "\(name) and \(otherName) look the same")
            }
        }
    }

    @Test func tintedPresetsDrawTheirHue() throws {
        #expect(try render(.aqua).count(where: Bitmap.isBlue) > 1000)
        #expect(try render(.forest).count(where: Bitmap.isGreen) > 1000)
        #expect(try render(.sunset).count(where: Bitmap.isRed) > 1000)
    }
}
