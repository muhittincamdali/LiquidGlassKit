import Foundation
import SwiftUI
import Testing
@testable import LiquidGlassKit

@Suite("GlassRenderingMode")
struct GlassRenderingModeTests {

    @Test(arguments: [
        (GlassRenderingMode.automatic, true, GlassRenderingMode.Path.native),
        (.automatic, false, .fallback),
        (.native, true, .native),
        (.native, false, .fallback),
        (.fallback, true, .fallback),
        (.fallback, false, .fallback)
    ])
    func resolution(mode: GlassRenderingMode, nativeAvailable: Bool, expected: GlassRenderingMode.Path) {
        #expect(mode.resolved(nativeAvailable: nativeAvailable) == expected)
    }

    @Test func nativeAvailabilityMatchesTheRunningOS() {
        #if os(visionOS)
        #expect(!GlassRenderingMode.isNativeGlassAvailable)
        #else
        let major = ProcessInfo.processInfo.operatingSystemVersion.majorVersion
        #expect(GlassRenderingMode.isNativeGlassAvailable == (major >= 26))
        #endif
    }

    @Test func environmentDefaultsToAutomatic() {
        #expect(EnvironmentValues().glassRenderingMode == .automatic)
    }
}

@Suite("GlassTheme")
struct GlassThemeTests {

    @Test func environmentDefaultsToStandard() {
        #expect(EnvironmentValues().glassTheme == .standard)
    }

    @Test func environmentStoresACustomTheme() {
        var environment = EnvironmentValues()
        environment.glassTheme = .dark
        #expect(environment.glassTheme == .dark)
    }

    @Test func outOfRangeValuesAreClamped() {
        let theme = GlassTheme(shadowRadius: -4, shadowOpacity: 3, strokeOpacity: -1)
        #expect(theme.shadowRadius == 0)
        #expect(theme.shadowOpacity == 1)
        #expect(theme.strokeOpacity == 0)
    }

    @Test func presetsDiffer() {
        #expect(Set([GlassTheme.standard, .subtle, .dark]).count == 3)
        #expect(GlassTheme.subtle.material == .clear)
        #expect(GlassTheme.dark.material == .dark)
    }
}

@Suite("GlassButtonSize")
struct GlassButtonSizeTests {

    @Test func paddingGrowsWithSize() {
        let sizes = GlassButtonSize.allCases
        #expect(sizes == [.compact, .regular, .large])
        #expect(sizes.map(\.horizontalPadding) == sizes.map(\.horizontalPadding).sorted())
        #expect(sizes.map(\.verticalPadding) == sizes.map(\.verticalPadding).sorted())
        #expect(Set(sizes.map(\.horizontalPadding)).count == sizes.count)
    }
}

@Suite("GlassSheetDismissal")
struct GlassSheetDismissalTests {

    @Test(arguments: [
        (CGFloat(0), CGFloat(0), false),
        (120, 120, false),      // exactly at the distance threshold
        (121, 121, true),
        (40, 200, false),       // exactly at the predicted threshold
        (40, 260, true),        // short but fast flick
        (-300, -500, false)     // dragging upwards never dismisses
    ])
    func dismissal(translation: CGFloat, predicted: CGFloat, expected: Bool) {
        let dismisses = GlassSheetDismissal.shouldDismiss(translation: translation, predictedEndTranslation: predicted)
        #expect(dismisses == expected)
    }
}
