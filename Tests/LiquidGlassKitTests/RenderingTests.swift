import SwiftUI
import Testing
@testable import LiquidGlassKit

/// Renders every public component offscreen on both rendering paths.
///
/// `ImageRenderer` does not capture blur backdrops, and with native glass it
/// draws nothing for a view inside `glassEffect` (on macOS 27 a `GlassCard`
/// renders zero visible pixels). The pixel checks therefore run on the fallback
/// path, where each glass surface draws a translucent tint: with a green theme,
/// green pixels can only come from a component's glass, never from its text or
/// icons. On the native path the tests check that the hierarchies build.
///
/// Views are drawn on an opaque canvas. When a view draws nothing,
/// `ImageRenderer` can return a buffer that still holds an earlier render
/// (seen on macOS 27 when the suite runs in one process), so "draws nothing"
/// and "draws something" are measured against the canvas color instead of
/// transparency.
///
/// On iOS, rendering `GlassTextField` and `GlassSearchBar` this way logs
/// "Accessing FocusState's value outside of the body of a View": an offscreen
/// `ImageRenderer` has no focus system. The demo app does not log it.
@MainActor
@Suite("Rendering")
struct RenderingTests {
    private static let size = CGSize(width: 320, height: 120)

    /// Without the tint overlay the untinted blur renders almost neutral gray
    /// (red and blue within a few units), so a clear margin is required.
    private static let tintMargin = 20

    /// Smallest glass area, in pixels, that counts as "the component drew its
    /// glass". The smallest surface here, the unpadded "Grouped" capsule, tints
    /// about 500 pixels at scale 1.
    private static let minimumGlassArea = 250

    private func render(_ view: some View, mode: GlassRenderingMode, canvas: Color? = .white) -> Bitmap? {
        let renderer = ImageRenderer(
            content: view
                .glassRenderingMode(mode)
                .environment(\.colorScheme, .light)
                .frame(width: Self.size.width, height: Self.size.height)
                .background(canvas ?? .clear)
        )
        renderer.scale = 1
        return renderer.cgImage.map(Bitmap.init)
    }

    /// Components that take their material from the theme.
    private var themedComponents: [(String, AnyView)] {
        [
            ("card", AnyView(GlassCard { Text("Card") })),
            ("button", AnyView(GlassButton("Button", systemImage: "star") {})),
            ("styled button", AnyView(Button("Styled") {}.buttonStyle(.liquidGlass))),
            ("text field", AnyView(GlassTextField("Email", text: .constant("a@b.c"), systemImage: "envelope"))),
            ("search bar", AnyView(GlassSearchBar(text: .constant("query")))),
            ("tab bar", AnyView(GlassTabBar(selection: .constant(1)) {
                GlassTab("One", systemImage: "1.circle", value: 1)
                GlassTab("Two", systemImage: "2.circle", value: 2)
            })),
            ("navigation bar", AnyView(GlassNavigationBar(title: "Title", subtitle: "Subtitle"))),
            ("group", AnyView(GlassGroup(spacing: 8) { Text("Grouped").glassSurface(in: .capsule) }))
        ]
    }

    /// The same components with an explicit material, which must win over the theme.
    private func components(material: GlassMaterial) -> [(String, AnyView)] {
        [
            ("card", AnyView(GlassCard(material: material) { Text("Card") })),
            ("button", AnyView(GlassButton("Button", material: material) {})),
            ("styled button", AnyView(Button("Styled") {}.buttonStyle(.liquidGlass(material)))),
            ("text field", AnyView(GlassTextField("Email", text: .constant(""), material: material))),
            ("search bar", AnyView(GlassSearchBar(text: .constant(""), material: material))),
            ("tab bar", AnyView(GlassTabBar(selection: .constant(1), material: material) {
                GlassTab("One", systemImage: "1.circle", value: 1)
            })),
            ("navigation bar", AnyView(GlassNavigationBar(title: "Title", material: material))),
            ("group", AnyView(GlassGroup { Text("Grouped").glassSurface(material, in: .capsule) }))
        ]
    }

    @Test(arguments: [GlassRenderingMode.fallback, .automatic])
    func everyComponentBuildsAndRenders(mode: GlassRenderingMode) throws {
        for (name, view) in themedComponents {
            let bitmap = try #require(render(view, mode: mode), "\(name) did not render")
            if !Self.drawsNativeGlass(mode) {
                #expect(bitmap.count(where: Bitmap.differsFromWhite) > 0, "\(name) drew nothing")
            }
        }
    }

    @Test func everyComponentDrawsItsGlassWithTheThemeMaterial() throws {
        for (name, view) in themedComponents {
            let themed = view.glassTheme(GlassTheme(material: .tinted(.green)))
            let bitmap = try #require(render(themed, mode: .fallback))
            let green = bitmap.count(where: Self.isGreenGlass)
            #expect(green > Self.minimumGlassArea, "\(name) drew \(green) green glass pixels")
        }
    }

    @Test func anExplicitMaterialOverridesTheTheme() throws {
        for (name, view) in components(material: .tinted(.blue)) {
            let themed = view.glassTheme(GlassTheme(material: .tinted(.green)))
            let bitmap = try #require(render(themed, mode: .fallback))
            let blue = bitmap.count(where: Self.isBlueGlass)
            let green = bitmap.count(where: Self.isGreenGlass)
            #expect(blue > Self.minimumGlassArea, "\(name) drew \(blue) blue glass pixels")
            #expect(green == 0, "\(name) drew \(green) pixels in the theme's green")
        }
    }

    /// Regression test: dark glass buttons once drew their label in the primary
    /// color, which is black in light mode.
    @Test func buttonLabelsOnDarkGlassAreWhite() throws {
        let explicit = Button("Label") {}.buttonStyle(.liquidGlass(.dark, size: .large))
        let themed = Button("Label") {}.buttonStyle(.liquidGlass(size: .large)).glassTheme(.dark)
        let frosted = Button("Label") {}.buttonStyle(.liquidGlass(.frosted, size: .large))
        // A mid-gray canvas, so that neither white nor black label pixels match it.
        let canvas = Color(white: 0.5)

        let isWhite: (Bitmap.Pixel) -> Bool = { min($0.red, $0.green, $0.blue) > 230 }
        let isBlack: (Bitmap.Pixel) -> Bool = { max($0.red, $0.green, $0.blue) < 40 }

        for (name, view) in [("explicit .dark", AnyView(explicit)), ("theme .dark", AnyView(themed))] {
            let bitmap = try #require(render(view, mode: .fallback, canvas: canvas))
            #expect(bitmap.count(where: isWhite) > 20, "\(name): no white label pixels")
            #expect(bitmap.count(where: isBlack) == 0, "\(name): label drawn in black")
        }
        let control = try #require(render(frosted, mode: .fallback, canvas: canvas))
        #expect(control.count(where: isBlack) > 20, "frosted label should stay in the primary color")
    }

    #if !os(tvOS)
    @Test(arguments: [false, true])
    func sheetDrawsOnlyWhilePresented(isPresented: Bool) throws {
        let view = Color.clear
            .glassSheet(isPresented: .constant(isPresented)) { Text("Sheet") }
            .glassTheme(GlassTheme(material: .tinted(.green)))
        let bitmap = try #require(render(view, mode: .fallback))
        guard isPresented else {
            #expect(bitmap.count(where: Bitmap.differsFromWhite) == 0, "a dismissed sheet should draw nothing")
            return
        }
        let corner = bitmap.pixel(x: 1, y: 1)
        #expect(corner.red < 230, "the dimming layer should darken the top corner: \(corner)")
        let green = bitmap.count(where: Self.isGreenGlass)
        #expect(green > Self.minimumGlassArea, "sheet drew \(green) green glass pixels")
    }
    #endif

    @Test func fallbackDrawsTheTintBehindTheContent() throws {
        let red = try fallbackCenterPixel(.tinted(.red))
        let blue = try fallbackCenterPixel(.tinted(.blue))
        #expect(red.alpha > 0, "tint overlay should be visible")
        #expect(Int(red.red) - Int(red.blue) > Self.tintMargin, "red tint should dominate: \(red)")
        #expect(Int(blue.blue) - Int(blue.red) > Self.tintMargin, "blue tint should dominate: \(blue)")
    }

    @Test func reduceTransparencyDrawsAnOpaqueUntintedBackground() throws {
        let red = try fallbackCenterPixel(.tinted(.red), reduceTransparency: true)
        let blue = try fallbackCenterPixel(.tinted(.blue), reduceTransparency: true)
        #expect(red.alpha == 255, "background should be opaque: \(red)")
        #expect(red == blue, "tint should be ignored: \(red) vs \(blue)")
        #expect(red != (try fallbackCenterPixel(.tinted(.red))), "should differ from the tinted blur")
    }

    /// A surface that fills the whole frame, rendered without a canvas so that
    /// its own opacity can be read.
    private func fallbackCenterPixel(
        _ material: GlassMaterial,
        reduceTransparency: Bool = false
    ) throws -> Bitmap.Pixel {
        let surface = Color.clear
            .frame(width: Self.size.width, height: Self.size.height)
            .glassSurface(material, in: .roundedRectangle(cornerRadius: 0))
            .environment(\._accessibilityReduceTransparency, reduceTransparency)
        let bitmap = try #require(render(surface, mode: .fallback, canvas: nil))
        return bitmap.pixel(x: bitmap.width / 2, y: bitmap.height / 2)
    }

    // Green and blue tints, because on macOS `ImageRenderer` draws text fields as a
    // red and yellow placeholder. Measured on the white canvas: a green tint renders
    // about (192, 224, 192), a blue one about (176, 208, 224), untinted glass is gray.
    private static func isGreenGlass(_ pixel: Bitmap.Pixel) -> Bool {
        Int(pixel.green) - Int(pixel.red) > tintMargin && Int(pixel.green) - Int(pixel.blue) > tintMargin
    }

    private static func isBlueGlass(_ pixel: Bitmap.Pixel) -> Bool {
        Int(pixel.blue) - Int(pixel.red) > tintMargin
    }

    private static func drawsNativeGlass(_ mode: GlassRenderingMode) -> Bool {
        mode.resolved(nativeAvailable: GlassRenderingMode.isNativeGlassAvailable) == .native
    }
}
