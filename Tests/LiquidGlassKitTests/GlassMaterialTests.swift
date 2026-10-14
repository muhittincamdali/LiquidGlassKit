import SwiftUI
import Testing
@testable import LiquidGlassKit

@Suite("GlassMaterial")
struct GlassMaterialTests {

    @Test func tintedMaterialsWithDifferentColorsAreNotEqual() {
        // The previous implementation compared .tinted cases without their color.
        #expect(GlassMaterial.tinted(.red) != GlassMaterial.tinted(.blue))
        #expect(GlassMaterial.tinted(.red) == GlassMaterial.tinted(.red))
    }

    @Test func materialsAreUsableAsSetElements() {
        let materials: Set<GlassMaterial> = [.clear, .frosted, .dark, .tinted(.red), .tinted(.red), .tinted(.blue)]
        #expect(materials.count == 5)
    }

    @Test func onlyTintedAndDarkCarryANativeTint() {
        #expect(GlassMaterial.clear.nativeTint == nil)
        #expect(GlassMaterial.frosted.nativeTint == nil)
        #expect(GlassMaterial.dark.nativeTint != nil)
        #expect(GlassMaterial.tinted(.green).nativeTint == Color.green.opacity(GlassMaterial.nativeTintOpacity))
    }

    @Test func onlyClearMapsToClearNativeGlass() {
        #expect(GlassMaterial.clear.usesClearNativeGlass)
        #expect(!GlassMaterial.frosted.usesClearNativeGlass)
        #expect(!GlassMaterial.dark.usesClearNativeGlass)
        #expect(!GlassMaterial.tinted(.white).usesClearNativeGlass)
    }

    @Test func tintOverlayUsesTheTintColor() {
        #expect(GlassMaterial.tinted(.orange).tintOverlay == Color.orange.opacity(GlassMaterial.tintOverlayOpacity))
    }

    @Test(arguments: [
        (GlassMaterial.clear, "Clear", "Glass.clear"),
        (.frosted, "Frosted", "Glass.regular"),
        (.tinted(.pink), "Tinted", "Glass.regular.tint(color)"),
        (.dark, "Dark", "Glass.regular.tint(black)")
    ])
    func names(material: GlassMaterial, displayName: String, nativeDescription: String) {
        #expect(material.displayName == displayName)
        #expect(material.nativeDescription == nativeDescription)
    }
}
