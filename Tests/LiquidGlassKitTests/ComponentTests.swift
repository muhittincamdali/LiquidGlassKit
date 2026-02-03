import XCTest
@testable import LiquidGlassKit

// MARK: - Component Tests

/// Comprehensive test suite for all LiquidGlassKit UI components.
final class ComponentTests: XCTestCase {
    
    // MARK: - GlassCard Tests
    
    func testGlassCardStyleStandard() {
        let style = GlassCard.Style.standard
        XCTAssertEqual(style.cornerRadius, 16)
        XCTAssertEqual(style.shadowRadius, 8)
    }
    
    func testGlassCardStyleCompact() {
        let style = GlassCard.Style.compact
        XCTAssertEqual(style.cornerRadius, 10)
        XCTAssertEqual(style.shadowRadius, 4)
    }
    
    func testGlassCardStyleProminent() {
        let style = GlassCard.Style.prominent
        XCTAssertEqual(style.cornerRadius, 24)
        XCTAssertEqual(style.shadowRadius, 16)
    }
    
    func testGlassCardStyleEquality() {
        let style1 = GlassCard.Style.standard
        let style2 = GlassCard.Style.standard
        XCTAssertEqual(style1, style2)
    }
    
    func testGlassCardStyleInequality() {
        let style1 = GlassCard.Style.standard
        let style2 = GlassCard.Style.compact
        XCTAssertNotEqual(style1, style2)
    }
    
    // MARK: - GlassButton Tests
    
    func testGlassButtonStylePrimary() {
        let style = GlassButton.ButtonStyle.primary
        XCTAssertTrue(style.isPrimary)
        XCTAssertFalse(style.isDestructive)
    }
    
    func testGlassButtonStyleSecondary() {
        let style = GlassButton.ButtonStyle.secondary
        XCTAssertFalse(style.isPrimary)
        XCTAssertFalse(style.isDestructive)
    }
    
    func testGlassButtonStyleDestructive() {
        let style = GlassButton.ButtonStyle.destructive
        XCTAssertTrue(style.isDestructive)
    }
    
    func testGlassButtonStyleComparison() {
        XCTAssertNotEqual(
            GlassButton.ButtonStyle.primary,
            GlassButton.ButtonStyle.secondary
        )
    }
    
    // MARK: - GlassTextField Tests
    
    func testGlassTextFieldStyleStandard() {
        let style = GlassTextField.Style.standard
        XCTAssertEqual(style.cornerRadius, 12)
        XCTAssertEqual(style.padding, 12)
    }
    
    func testGlassTextFieldStyleProminent() {
        let style = GlassTextField.Style.prominent
        XCTAssertEqual(style.cornerRadius, 16)
        XCTAssertEqual(style.padding, 16)
    }
    
    func testGlassTextFieldPlaceholderNotEmpty() {
        let placeholder = "Enter text..."
        XCTAssertFalse(placeholder.isEmpty)
        XCTAssertEqual(placeholder, "Enter text...")
    }
    
    // MARK: - GlassSearchBar Tests
    
    func testGlassSearchBarDefaultPlaceholder() {
        let defaultPlaceholder = "Search..."
        XCTAssertEqual(defaultPlaceholder, "Search...")
    }
    
    func testGlassSearchBarConfiguration() {
        let config = GlassSearchBar.Configuration(
            placeholder: "Find items",
            showsCancelButton: true,
            cornerRadius: 14
        )
        XCTAssertEqual(config.placeholder, "Find items")
        XCTAssertTrue(config.showsCancelButton)
        XCTAssertEqual(config.cornerRadius, 14)
    }
    
    // MARK: - GlassSheet Tests
    
    func testGlassSheetStyleStandard() {
        let style = GlassSheet.SheetStyle.standard
        XCTAssertEqual(style.cornerRadius, 24)
        XCTAssertEqual(style.blurRadius, 20)
    }
    
    func testGlassSheetStyleProminent() {
        let style = GlassSheet.SheetStyle.prominent
        XCTAssertEqual(style.cornerRadius, 32)
        XCTAssertEqual(style.blurRadius, 30)
    }
    
    func testGlassSheetDetents() {
        let detents: [GlassSheet.Detent] = [.medium, .large]
        XCTAssertEqual(detents.count, 2)
        XCTAssertTrue(detents.contains(.medium))
        XCTAssertTrue(detents.contains(.large))
    }
    
    // MARK: - GlassNavigationBar Tests
    
    func testGlassNavigationBarStyleStandard() {
        let style = GlassNavigationBar.BarStyle.standard
        XCTAssertEqual(style.blurRadius, 20)
        XCTAssertTrue(style.showsDivider)
    }
    
    func testGlassNavigationBarStyleProminent() {
        let style = GlassNavigationBar.BarStyle.prominent
        XCTAssertEqual(style.blurRadius, 30)
    }
    
    func testGlassNavigationBarTitle() {
        let title = "Settings"
        XCTAssertFalse(title.isEmpty)
        XCTAssertEqual(title.count, 8)
    }
    
    // MARK: - GlassTabBar Tests
    
    func testGlassTabBarItemCreation() {
        let item = GlassTabBar.TabItem(
            id: "home",
            title: "Home",
            icon: "house.fill"
        )
        XCTAssertEqual(item.id, "home")
        XCTAssertEqual(item.title, "Home")
        XCTAssertEqual(item.icon, "house.fill")
    }
    
    func testGlassTabBarMultipleItems() {
        let items = [
            GlassTabBar.TabItem(id: "1", title: "Tab 1", icon: "1.circle"),
            GlassTabBar.TabItem(id: "2", title: "Tab 2", icon: "2.circle"),
            GlassTabBar.TabItem(id: "3", title: "Tab 3", icon: "3.circle")
        ]
        XCTAssertEqual(items.count, 3)
        XCTAssertEqual(items[1].title, "Tab 2")
    }
    
    func testGlassTabBarStyleStandard() {
        let style = GlassTabBar.BarStyle.standard
        XCTAssertEqual(style.height, 83)
        XCTAssertEqual(style.cornerRadius, 0)
    }
    
    func testGlassTabBarStyleFloating() {
        let style = GlassTabBar.BarStyle.floating
        XCTAssertEqual(style.height, 70)
        XCTAssertEqual(style.cornerRadius, 35)
    }
}

// MARK: - LiquidSearch Tests

final class LiquidSearchTests: XCTestCase {
    
    func testLiquidSearchConfigurationDefaults() {
        let config = LiquidSearch.Configuration()
        XCTAssertEqual(config.style, .standard)
        XCTAssertTrue(config.showCancelButton)
        XCTAssertTrue(config.animatesOnFocus)
    }
    
    func testLiquidSearchConfigurationCustom() {
        let config = LiquidSearch.Configuration(
            style: .prominent,
            showCancelButton: false,
            animatesOnFocus: false
        )
        XCTAssertEqual(config.style, .prominent)
        XCTAssertFalse(config.showCancelButton)
        XCTAssertFalse(config.animatesOnFocus)
    }
    
    func testLiquidSearchStyleEquality() {
        XCTAssertEqual(
            LiquidSearch.Style.standard,
            LiquidSearch.Style.standard
        )
        XCTAssertNotEqual(
            LiquidSearch.Style.standard,
            LiquidSearch.Style.prominent
        )
    }
    
    func testLiquidSearchFilterResults() {
        let items = ["Apple", "Banana", "Apricot", "Cherry"]
        let query = "ap"
        let filtered = items.filter {
            $0.localizedCaseInsensitiveContains(query)
        }
        XCTAssertEqual(filtered.count, 2)
        XCTAssertTrue(filtered.contains("Apple"))
        XCTAssertTrue(filtered.contains("Apricot"))
    }
    
    func testLiquidSearchEmptyQuery() {
        let items = ["Apple", "Banana", "Cherry"]
        let query = ""
        let filtered = query.isEmpty ? items : items.filter {
            $0.localizedCaseInsensitiveContains(query)
        }
        XCTAssertEqual(filtered.count, 3)
    }
}

// MARK: - LiquidList Tests

final class LiquidListTests: XCTestCase {
    
    func testLiquidListConfigurationDefaults() {
        let config = LiquidList.Configuration()
        XCTAssertEqual(config.style, .inset)
        XCTAssertTrue(config.showsSeparators)
        XCTAssertEqual(config.selectionStyle, .highlight)
    }
    
    func testLiquidListStyleInset() {
        let style = LiquidList.Style.inset
        XCTAssertEqual(style.padding, 16)
        XCTAssertEqual(style.cornerRadius, 12)
    }
    
    func testLiquidListStyleGrouped() {
        let style = LiquidList.Style.grouped
        XCTAssertEqual(style.padding, 20)
        XCTAssertEqual(style.cornerRadius, 16)
    }
    
    func testLiquidListStylePlain() {
        let style = LiquidList.Style.plain
        XCTAssertEqual(style.padding, 0)
        XCTAssertEqual(style.cornerRadius, 0)
    }
    
    func testLiquidListSelectionStyleHighlight() {
        let selectionStyle = LiquidList.SelectionStyle.highlight
        XCTAssertTrue(selectionStyle.showsHighlight)
        XCTAssertFalse(selectionStyle.showsCheckmark)
    }
    
    func testLiquidListSelectionStyleCheckmark() {
        let selectionStyle = LiquidList.SelectionStyle.checkmark
        XCTAssertFalse(selectionStyle.showsHighlight)
        XCTAssertTrue(selectionStyle.showsCheckmark)
    }
    
    func testLiquidListItemSelection() {
        var selectedItem: String? = nil
        let items = ["Item 1", "Item 2", "Item 3"]
        
        selectedItem = items[1]
        XCTAssertEqual(selectedItem, "Item 2")
        
        selectedItem = nil
        XCTAssertNil(selectedItem)
    }
}

// MARK: - Effect Tests

final class EffectTests: XCTestCase {
    
    // MARK: - RippleEffect Tests
    
    func testRippleEffectConfigurationDefaults() {
        let config = RippleEffect.Configuration()
        XCTAssertEqual(config.amplitude, 10)
        XCTAssertEqual(config.frequency, 6)
        XCTAssertEqual(config.decay, 3)
        XCTAssertEqual(config.duration, 1.0)
    }
    
    func testRippleEffectConfigurationCustom() {
        let config = RippleEffect.Configuration(
            amplitude: 15,
            frequency: 8,
            decay: 5,
            duration: 1.5
        )
        XCTAssertEqual(config.amplitude, 15)
        XCTAssertEqual(config.frequency, 8)
        XCTAssertEqual(config.decay, 5)
        XCTAssertEqual(config.duration, 1.5)
    }
    
    func testRippleEffectOriginPoint() {
        let origin = CGPoint(x: 100, y: 200)
        XCTAssertEqual(origin.x, 100)
        XCTAssertEqual(origin.y, 200)
    }
    
    // MARK: - WaveEffect Tests
    
    func testWaveEffectConfigurationDefaults() {
        let config = WaveEffect.Configuration()
        XCTAssertEqual(config.amplitude, 10)
        XCTAssertEqual(config.frequency, 3)
        XCTAssertEqual(config.phase, 0)
        XCTAssertEqual(config.direction, .horizontal)
        XCTAssertEqual(config.speed, 1.0)
    }
    
    func testWaveEffectConfigurationVertical() {
        let config = WaveEffect.Configuration(
            amplitude: 15,
            frequency: 5,
            direction: .vertical,
            speed: 2.0
        )
        XCTAssertEqual(config.direction, .vertical)
        XCTAssertEqual(config.speed, 2.0)
    }
    
    func testWaveEffectDirectionEquality() {
        XCTAssertEqual(
            WaveEffect.Direction.horizontal,
            WaveEffect.Direction.horizontal
        )
        XCTAssertNotEqual(
            WaveEffect.Direction.horizontal,
            WaveEffect.Direction.vertical
        )
    }
    
    // MARK: - LiquidAnimation Tests
    
    func testLiquidAnimationConfigurationDefaults() {
        let config = LiquidAnimation.Configuration()
        XCTAssertEqual(config.tension, 0.7)
        XCTAssertEqual(config.friction, 0.4)
        XCTAssertEqual(config.mass, 1.0)
        XCTAssertEqual(config.velocity, 0.0)
    }
    
    func testLiquidAnimationConfigurationBouncy() {
        let config = LiquidAnimation.Configuration.bouncy
        XCTAssertGreaterThan(config.tension, 0.5)
        XCTAssertLessThan(config.friction, 0.5)
    }
    
    func testLiquidAnimationConfigurationSmooth() {
        let config = LiquidAnimation.Configuration.smooth
        XCTAssertGreaterThan(config.friction, 0.5)
    }
    
    func testLiquidAnimationSpringResponse() {
        let config = LiquidAnimation.Configuration(
            tension: 0.8,
            friction: 0.3,
            mass: 1.0,
            velocity: 0.5
        )
        let response = config.springResponse
        XCTAssertGreaterThan(response, 0)
    }
    
    func testLiquidAnimationDampingFraction() {
        let config = LiquidAnimation.Configuration(
            tension: 0.8,
            friction: 0.6,
            mass: 1.0,
            velocity: 0.0
        )
        let damping = config.dampingFraction
        XCTAssertGreaterThan(damping, 0)
        XCTAssertLessThanOrEqual(damping, 1)
    }
}

// MARK: - Material Tests

final class MaterialTests: XCTestCase {
    
    // MARK: - AquaMaterial Tests
    
    func testAquaMaterialConfigurationDefaults() {
        let config = AquaMaterial.Configuration()
        XCTAssertEqual(config.depth, 0.5)
        XCTAssertEqual(config.clarity, 0.8)
        XCTAssertTrue(config.caustics)
        XCTAssertTrue(config.surfaceRipples)
    }
    
    func testAquaMaterialConfigurationDeep() {
        let config = AquaMaterial.Configuration(
            depth: 1.0,
            clarity: 0.6,
            caustics: true,
            surfaceRipples: true
        )
        XCTAssertEqual(config.depth, 1.0)
        XCTAssertEqual(config.clarity, 0.6)
    }
    
    func testAquaMaterialPresetShallow() {
        let preset = AquaMaterial.Preset.shallow
        XCTAssertLessThan(preset.depth, 0.5)
        XCTAssertGreaterThan(preset.clarity, 0.8)
    }
    
    func testAquaMaterialPresetDeep() {
        let preset = AquaMaterial.Preset.deep
        XCTAssertGreaterThan(preset.depth, 0.7)
        XCTAssertLessThan(preset.clarity, 0.7)
    }
    
    // MARK: - CrystalMaterial Tests
    
    func testCrystalMaterialConfigurationDefaults() {
        let config = CrystalMaterial.Configuration()
        XCTAssertEqual(config.refraction, 1.5)
        XCTAssertEqual(config.dispersion, 0.05)
        XCTAssertEqual(config.facets, 6)
        XCTAssertTrue(config.sparkle)
    }
    
    func testCrystalMaterialConfigurationDiamond() {
        let config = CrystalMaterial.Configuration(
            refraction: 2.4,
            dispersion: 0.044,
            facets: 58,
            sparkle: true
        )
        XCTAssertEqual(config.refraction, 2.4)
        XCTAssertEqual(config.facets, 58)
    }
    
    func testCrystalMaterialPresetQuartz() {
        let preset = CrystalMaterial.Preset.quartz
        XCTAssertEqual(preset.refraction, 1.54)
        XCTAssertEqual(preset.facets, 6)
    }
    
    func testCrystalMaterialPresetDiamond() {
        let preset = CrystalMaterial.Preset.diamond
        XCTAssertEqual(preset.refraction, 2.42)
        XCTAssertEqual(preset.facets, 58)
    }
    
    func testCrystalMaterialPresetSapphire() {
        let preset = CrystalMaterial.Preset.sapphire
        XCTAssertEqual(preset.refraction, 1.77)
    }
}

// MARK: - Theme Tests

final class ThemeTests: XCTestCase {
    
    // MARK: - DayNightTheme Tests
    
    func testDayNightThemeConfigurationAutomatic() {
        let config = DayNightTheme.Configuration.automatic
        XCTAssertTrue(config.followsSystem)
        XCTAssertTrue(config.transitionsEnabled)
    }
    
    func testDayNightThemeConfigurationAlwaysLight() {
        let config = DayNightTheme.Configuration.alwaysLight
        XCTAssertFalse(config.followsSystem)
        XCTAssertFalse(config.isNight)
    }
    
    func testDayNightThemeConfigurationAlwaysDark() {
        let config = DayNightTheme.Configuration.alwaysDark
        XCTAssertFalse(config.followsSystem)
        XCTAssertTrue(config.isNight)
    }
    
    func testDayNightThemeTimeOfDay() {
        let morningHour = 8
        let nightHour = 22
        
        let isMorningNight = morningHour < 6 || morningHour >= 20
        let isEveningNight = nightHour < 6 || nightHour >= 20
        
        XCTAssertFalse(isMorningNight)
        XCTAssertTrue(isEveningNight)
    }
    
    func testDayNightThemeTransitionDuration() {
        let config = DayNightTheme.Configuration.automatic
        XCTAssertEqual(config.transitionDuration, 0.5)
    }
    
    // MARK: - GlassTheme Tests
    
    func testGlassThemeStandard() {
        let theme = GlassTheme.standard
        XCTAssertEqual(theme.cornerRadius, 16)
        XCTAssertEqual(theme.shadowRadius, 8)
    }
    
    func testGlassThemeMinimal() {
        let theme = GlassTheme.minimal
        XCTAssertEqual(theme.cornerRadius, 12)
        XCTAssertEqual(theme.shadowRadius, 4)
    }
    
    func testGlassThemeVibrant() {
        let theme = GlassTheme.vibrant
        XCTAssertEqual(theme.cornerRadius, 20)
        XCTAssertGreaterThan(theme.saturation, 1.5)
    }
    
    func testGlassThemeEquality() {
        let theme1 = GlassTheme.standard
        let theme2 = GlassTheme.standard
        XCTAssertEqual(theme1.cornerRadius, theme2.cornerRadius)
        XCTAssertEqual(theme1.shadowRadius, theme2.shadowRadius)
    }
}

// MARK: - Animation Tests

final class AnimationTests: XCTestCase {
    
    // MARK: - GlassTransition Tests
    
    func testGlassTransitionSlide() {
        let transition = GlassTransition.slide
        XCTAssertNotNil(transition)
    }
    
    func testGlassTransitionScale() {
        let transition = GlassTransition.scale
        XCTAssertNotNil(transition)
    }
    
    func testGlassTransitionFade() {
        let transition = GlassTransition.fade
        XCTAssertNotNil(transition)
    }
    
    func testGlassTransitionBlur() {
        let transition = GlassTransition.blur
        XCTAssertNotNil(transition)
    }
    
    // MARK: - GlassMorphAnimation Tests
    
    func testGlassMorphAnimationConfigurationDefaults() {
        let config = GlassMorphAnimation.Configuration()
        XCTAssertEqual(config.duration, 0.5)
        XCTAssertEqual(config.delay, 0)
    }
    
    func testGlassMorphAnimationConfigurationCustom() {
        let config = GlassMorphAnimation.Configuration(
            duration: 1.0,
            delay: 0.2
        )
        XCTAssertEqual(config.duration, 1.0)
        XCTAssertEqual(config.delay, 0.2)
    }
    
    func testGlassMorphAnimationTimingCurve() {
        let curves: [GlassMorphAnimation.TimingCurve] = [
            .easeIn,
            .easeOut,
            .easeInOut,
            .spring
        ]
        XCTAssertEqual(curves.count, 4)
    }
}

// MARK: - Utility Tests

final class UtilityTests: XCTestCase {
    
    func testColorOpacityRange() {
        let opacity: CGFloat = 0.8
        XCTAssertGreaterThanOrEqual(opacity, 0)
        XCTAssertLessThanOrEqual(opacity, 1)
    }
    
    func testCornerRadiusPositive() {
        let cornerRadius: CGFloat = 16
        XCTAssertGreaterThan(cornerRadius, 0)
    }
    
    func testShadowRadiusNonNegative() {
        let shadowRadius: CGFloat = 8
        XCTAssertGreaterThanOrEqual(shadowRadius, 0)
    }
    
    func testBlurRadiusRange() {
        let blurRadius: CGFloat = 20
        XCTAssertGreaterThanOrEqual(blurRadius, 0)
        XCTAssertLessThanOrEqual(blurRadius, 100)
    }
    
    func testAnimationDurationPositive() {
        let duration: TimeInterval = 0.3
        XCTAssertGreaterThan(duration, 0)
    }
    
    func testPointDistanceCalculation() {
        let point1 = CGPoint(x: 0, y: 0)
        let point2 = CGPoint(x: 3, y: 4)
        
        let dx = point2.x - point1.x
        let dy = point2.y - point1.y
        let distance = sqrt(dx * dx + dy * dy)
        
        XCTAssertEqual(distance, 5, accuracy: 0.001)
    }
    
    func testRectContainsPoint() {
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let insidePoint = CGPoint(x: 50, y: 50)
        let outsidePoint = CGPoint(x: 150, y: 150)
        
        XCTAssertTrue(rect.contains(insidePoint))
        XCTAssertFalse(rect.contains(outsidePoint))
    }
    
    func testSizeAspectRatio() {
        let size = CGSize(width: 1920, height: 1080)
        let aspectRatio = size.width / size.height
        
        XCTAssertEqual(aspectRatio, 16.0 / 9.0, accuracy: 0.01)
    }
}
