import SwiftUI
import Testing
@testable import LiquidGlassKit

/// Renders every public component offscreen on both rendering paths.
///
/// `ImageRenderer` does not capture blur backdrops, so these tests check that
/// the view hierarchy builds and lays out at the expected size, and that the
/// fallback tint is actually drawn.
@MainActor
@Suite("Rendering")
struct RenderingTests {
    private static let size = CGSize(width: 320, height: 120)

    private func render(_ view: AnyView, mode: GlassRenderingMode) -> CGImage? {
        let renderer = ImageRenderer(
            content: view
                .glassRenderingMode(mode)
                .frame(width: Self.size.width, height: Self.size.height)
        )
        renderer.scale = 1
        return renderer.cgImage
    }

    private var components: [(String, AnyView)] {
        [
            ("card", AnyView(GlassCard { Text("Card") })),
            ("button", AnyView(GlassButton("Button", systemImage: "star") {})),
            ("styled button", AnyView(Button("Styled") {}.buttonStyle(.liquidGlass(.dark, size: .large)))),
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

    @Test(arguments: [GlassRenderingMode.fallback, .native])
    func everyComponentRenders(mode: GlassRenderingMode) throws {
        for (name, view) in components {
            let image = try #require(render(view, mode: mode), "\(name) did not render")
            #expect(image.width == Int(Self.size.width), "\(name)")
            #expect(image.height == Int(Self.size.height), "\(name)")
        }
    }

    #if !os(tvOS)
    @Test func presentedSheetRenders() throws {
        let view = Color.clear.glassSheet(isPresented: .constant(true)) { Text("Sheet") }
        let image = try #require(render(AnyView(view), mode: .fallback))
        #expect(image.width == Int(Self.size.width))
    }
    #endif

    /// Without the tint overlay the untinted blur renders almost neutral gray
    /// (red and blue within a few units), so a clear margin is required.
    private static let tintMargin = 20

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

    private func fallbackCenterPixel(_ material: GlassMaterial, reduceTransparency: Bool = false) throws -> Pixel {
        let surface = Color.clear
            .frame(width: Self.size.width, height: Self.size.height)
            .glassSurface(material, in: .roundedRectangle(cornerRadius: 0))
            .environment(\._accessibilityReduceTransparency, reduceTransparency)
        let image = try #require(render(AnyView(surface), mode: .fallback))
        return try #require(Self.centerPixel(of: image))
    }

    private struct Pixel: Equatable {
        let red: UInt8
        let blue: UInt8
        let alpha: UInt8
    }

    private static func centerPixel(of image: CGImage) -> Pixel? {
        var bytes = [UInt8](repeating: 0, count: 4)
        let drawn: Bool = bytes.withUnsafeMutableBytes { buffer in
            guard let context = CGContext(
                data: buffer.baseAddress, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4,
                space: CGColorSpaceCreateDeviceRGB(),
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            ) else { return false }
            let x = -CGFloat(image.width / 2)
            let y = -CGFloat(image.height / 2)
            context.draw(image, in: CGRect(x: x, y: y, width: CGFloat(image.width), height: CGFloat(image.height)))
            return true
        }
        return drawn ? Pixel(red: bytes[0], blue: bytes[2], alpha: bytes[3]) : nil
    }
}
