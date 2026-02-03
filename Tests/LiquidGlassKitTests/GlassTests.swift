import XCTest
@testable import LiquidGlassKit

final class GlassTests: XCTestCase {

    // MARK: - GlassMaterial Tests

    func testMaterialBlurRadius() {
        XCTAssertEqual(GlassMaterial.clear.blurRadius, 10)
        XCTAssertEqual(GlassMaterial.frosted.blurRadius, 20)
        XCTAssertEqual(GlassMaterial.dark.blurRadius, 25)
    }

    func testMaterialSaturation() {
        XCTAssertEqual(GlassMaterial.clear.saturation, 1.2)
        XCTAssertEqual(GlassMaterial.frosted.saturation, 1.8)
        XCTAssertEqual(GlassMaterial.dark.saturation, 1.4)
    }

    func testMaterialOpacity() {
        XCTAssertEqual(GlassMaterial.clear.opacity, 0.7)
        XCTAssertEqual(GlassMaterial.frosted.opacity, 0.85)
        XCTAssertEqual(GlassMaterial.dark.opacity, 0.9)
    }

    func testCustomMaterial() {
        let custom = GlassMaterial.custom(blurRadius: 30, tintColor: .red, saturation: 2.0, opacity: 0.9)
        XCTAssertEqual(custom.blurRadius, 30)
        XCTAssertEqual(custom.saturation, 2.0)
        XCTAssertEqual(custom.opacity, 0.9)
        XCTAssertEqual(custom.displayName, "Custom")
    }

    func testMaterialDisplayNames() {
        XCTAssertEqual(GlassMaterial.clear.displayName, "Clear")
        XCTAssertEqual(GlassMaterial.frosted.displayName, "Frosted")
        XCTAssertEqual(GlassMaterial.dark.displayName, "Dark")
    }

    // MARK: - GlassConfiguration Tests

    func testStandardConfiguration() {
        let config = GlassConfiguration.standard
        XCTAssertEqual(config.cornerRadius, 16)
        XCTAssertEqual(config.shadowRadius, 8)
        XCTAssertEqual(config.blurRadius, 20)
    }

    func testCompactConfiguration() {
        let config = GlassConfiguration.compact
        XCTAssertEqual(config.cornerRadius, 10)
        XCTAssertEqual(config.shadowRadius, 4)
    }

    func testProminentConfiguration() {
        let config = GlassConfiguration.prominent
        XCTAssertEqual(config.cornerRadius, 24)
        XCTAssertEqual(config.shadowRadius, 16)
    }

    func testConfigurationToEffect() {
        let config = GlassConfiguration(material: .dark, cornerRadius: 20)
        let effect = config.toEffect()
        XCTAssertEqual(effect.cornerRadius, 20)
    }

    // MARK: - GlassEffect Tests

    func testEffectPresets() {
        let standard = GlassEffect.standard
        XCTAssertEqual(standard.blurRadius, 20)

        let clear = GlassEffect.clear
        XCTAssertEqual(clear.blurRadius, 10)

        let dark = GlassEffect.dark
        XCTAssertEqual(dark.blurRadius, 25)
    }

    func testEffectBorderWidth() {
        let effect = GlassEffect()
        XCTAssertEqual(effect.borderWidth, 0.5)
    }

    // MARK: - GlassTheme Tests

    func testThemePresets() {
        let standard = GlassTheme.standard
        XCTAssertEqual(standard.cornerRadius, 16)

        let minimal = GlassTheme.minimal
        XCTAssertEqual(minimal.cornerRadius, 12)

        let vibrant = GlassTheme.vibrant
        XCTAssertEqual(vibrant.cornerRadius, 20)
    }

    // MARK: - GlassFallback Tests

    func testFallbackStrategy() {
        let strategy = GlassFallback.currentStrategy
        XCTAssertNotNil(strategy.rawValue)
    }

    func testFallbackModeConsistency() {
        XCTAssertNotEqual(
            GlassFallback.isNativeGlassAvailable,
            GlassFallback.isFallbackMode
        )
    }
}
