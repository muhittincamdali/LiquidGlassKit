import SwiftUI
import Testing
@testable import LiquidGlassKit

@MainActor
@Suite("GlassTabBar action")
struct GlassTabBarActionTests {
    private static let size = CGSize(width: 360, height: 100)

    private func tabBar(action: GlassTabBarAction?) -> some View {
        GlassTabBar(selection: .constant(1), action: action) {
            GlassTab("One", systemImage: "1.circle", value: 1)
            GlassTab("Two", systemImage: "2.circle", value: 2)
        }
        .glassTheme(GlassTheme(material: .tinted(.blue)))
    }

    /// Columns and rows that hold at least one pixel matching `predicate`.
    private func bounds(_ bitmap: Bitmap, where predicate: (Bitmap.Pixel) -> Bool) -> (x: ClosedRange<Int>, y: ClosedRange<Int>)? {
        var xs: [Int] = []
        var ys: [Int] = []
        for y in 0..<bitmap.height {
            for x in 0..<bitmap.width where predicate(bitmap.pixel(x: x, y: y)) {
                xs.append(x)
                ys.append(y)
            }
        }
        guard let minX = xs.min(), let maxX = xs.max(), let minY = ys.min(), let maxY = ys.max() else { return nil }
        return (minX...maxX, minY...maxY)
    }

    @Test func actionIsARoundButtonAfterTheTabsAsTallAsTheBar() throws {
        let action = GlassTabBarAction("Add", systemImage: "plus", material: .tinted(.green)) {}
        let bitmap = try #require(Bitmap.render(tabBar(action: action), size: Self.size))
        let bar = try #require(bounds(bitmap, where: { Bitmap.isBlue($0) && !Bitmap.isGreen($0) }), "no blue tab capsule")
        let button = try #require(bounds(bitmap, where: Bitmap.isGreen), "no green action button")

        #expect(button.x.lowerBound > bar.x.upperBound, "the button should follow the tabs")
        let barHeight = bar.y.count
        #expect(abs(button.y.count - barHeight) <= 3, "button height \(button.y.count) vs bar height \(barHeight)")
        #expect(abs(button.x.count - button.y.count) <= 2, "the button should be round: \(button.x.count)×\(button.y.count)")
    }

    @Test func withoutAnActionTheBarIsUnchanged() throws {
        let plain = GlassTabBar(selection: .constant(1)) {
            GlassTab("One", systemImage: "1.circle", value: 1)
            GlassTab("Two", systemImage: "2.circle", value: 2)
        }
        .glassTheme(GlassTheme(material: .tinted(.blue)))
        let withNil = try #require(Bitmap.render(tabBar(action: nil), size: Self.size))
        let original = try #require(Bitmap.render(plain, size: Self.size))
        #expect(withNil.countDifferences(from: original) == 0, "\(withNil.countDifferences(from: original)) differ")
        #expect(withNil.count(where: Bitmap.isGreen) == 0)
    }

    @Test func actionDefaultsToAccentTintedGlass() throws {
        let action = GlassTabBarAction("Add", systemImage: "plus") {}
        let view = tabBar(action: action).tint(.green).accentColor(.green)
        let bitmap = try #require(Bitmap.render(view, size: Self.size))
        #expect(bitmap.count(where: Bitmap.isGreen) > 300)
    }
}
