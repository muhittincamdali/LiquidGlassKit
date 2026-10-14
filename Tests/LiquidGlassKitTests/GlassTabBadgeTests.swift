import SwiftUI
import Testing
@testable import LiquidGlassKit

@Suite("GlassTab badge")
struct GlassTabBadgeTests {
    private let tab = GlassTab("Inbox", systemImage: "tray", value: 1)

    @Test func tabsHaveNoBadgeByDefault() {
        #expect(tab.badge == nil)
    }

    @Test(arguments: [(3, "3"), (1, "1"), (0, nil), (-2, nil)] as [(Int, String?)])
    func countsAboveZeroAreShown(count: Int, expected: String?) {
        #expect(tab.badge(count).badge == expected)
    }

    @Test func labelsAreShownUnlessEmpty() {
        #expect(tab.badge("New").badge == "New")
        #expect(tab.badge("").badge == nil)
        #expect(tab.badge(nil).badge == nil)
        #expect(tab.badge(4).badge(nil).badge == nil, "a nil label removes an earlier badge")
    }

    @Test func aBadgeKeepsTheTabAndSurvivesDeduplication() {
        let badged = tab.badge(2)
        #expect(badged.title == tab.title && badged.systemImage == tab.systemImage && badged.value == tab.value)
        let tabs = GlassTabBar<Int>.uniqued([badged, GlassTab("Again", systemImage: "tray", value: 1)])
        #expect(tabs.map(\.badge) == ["2"])
    }
}

@MainActor
@Suite("GlassTabBar badge rendering")
struct GlassTabBadgeRenderingTests {
    private static let size = CGSize(width: 240, height: 80)

    private func tabBar(secondTabBadge: Int) -> some View {
        GlassTabBar(selection: .constant(1)) {
            GlassTab("One", systemImage: "1.circle", value: 1)
            GlassTab("Two", systemImage: "2.circle", value: 2).badge(secondTabBadge)
        }
    }

    @Test func aBadgeIsDrawnInRedOverItsOwnTab() throws {
        let bitmap = try #require(Bitmap.render(tabBar(secondTabBadge: 5), size: Self.size))
        let half = Int(Self.size.width) / 2
        #expect(bitmap.count(columns: half..<Int(Self.size.width), where: Bitmap.isRed) > 60)
        #expect(bitmap.count(columns: 0..<half, where: Bitmap.isRed) == 0, "the first tab has no badge")
    }

    @Test func aZeroCountDrawsTheBarWithoutABadge() throws {
        let zero = try #require(Bitmap.render(tabBar(secondTabBadge: 0), size: Self.size))
        let plain = try #require(Bitmap.render(
            GlassTabBar(selection: .constant(1)) {
                GlassTab("One", systemImage: "1.circle", value: 1)
                GlassTab("Two", systemImage: "2.circle", value: 2)
            },
            size: Self.size
        ))
        #expect(zero.count(where: Bitmap.isRed) == 0)
        #expect(zero.countDifferences(from: plain) == 0)
    }
}
