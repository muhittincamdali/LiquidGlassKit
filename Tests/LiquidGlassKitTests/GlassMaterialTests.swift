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

    // `Material` is not Equatable; its description names the material, which is
    // enough to tell the five system materials apart.
    private static func name(of material: Material) -> String {
        String(describing: material)
    }

    @Test func systemMaterialDescriptionsAreDistinct() {
        let materials: [Material] = [
            .ultraThinMaterial, .thinMaterial, .regularMaterial, .thickMaterial, .ultraThickMaterial
        ]
        #expect(Set(materials.map(Self.name(of:))).count == materials.count)
    }

    @Test(arguments: [
        (GlassMaterial.clear, Material.ultraThinMaterial),
        (.frosted, .thinMaterial),
        (.tinted(.teal), .regularMaterial),
        (.dark, .ultraThickMaterial)
    ])
    func fallbackMaterial(material: GlassMaterial, expected: Material) {
        #expect(Self.name(of: material.fallbackMaterial) == Self.name(of: expected))
    }

    #if !os(visionOS)
    @Test(.enabled(if: GlassRenderingMode.isNativeGlassAvailable))
    func nativeGlassSelection() throws {
        guard #available(iOS 26, macOS 26, tvOS 26, watchOS 26, *) else { return }
        #expect(Glass.clear != Glass.regular)
        #expect(GlassMaterial.clear.nativeGlass(interactive: false) == Glass.clear)
        #expect(GlassMaterial.frosted.nativeGlass(interactive: false) == Glass.regular)
        #expect(GlassMaterial.frosted.nativeGlass(interactive: true) == Glass.regular.interactive())
        #expect(GlassMaterial.frosted.nativeGlass(interactive: true) != Glass.regular)
        let tinted = GlassMaterial.tinted(.red)
        #expect(tinted.nativeGlass(interactive: false) == Glass.regular.tint(tinted.nativeTint))
        #expect(tinted.nativeGlass(interactive: false) != Glass.regular)
        #expect(GlassMaterial.dark.nativeGlass(interactive: false) == Glass.regular.tint(GlassMaterial.dark.nativeTint))
    }
    #endif

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
