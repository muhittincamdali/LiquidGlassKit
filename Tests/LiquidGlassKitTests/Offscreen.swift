import LiquidGlassKit
import SwiftUI

extension Bitmap {
    /// Without the tint overlay the untinted blur renders almost neutral gray
    /// (red, green and blue within a few units), so a clear margin is required.
    static let tintMargin = 20

    /// Renders `view` offscreen at scale 1 in the light color scheme.
    ///
    /// The view is drawn on an opaque `canvas`, or on a transparent background
    /// when `canvas` is `nil`, so that its own opacity can be read.
    ///
    /// The first few renders of a view can differ from later ones: `Material`
    /// edges change after the first passes, and text and symbols are drawn
    /// slightly differently once their glyphs have been drawn about six times.
    /// Comparing a render made before that with one made after made
    /// pixel-equality tests fail depending on test order. The view is therefore
    /// drawn ``warmUpRenderPasses`` times first, then until two passes match.
    @MainActor
    static func render(
        _ view: some View,
        size: CGSize,
        mode: GlassRenderingMode = .fallback,
        canvas: Color? = .white
    ) -> Bitmap? {
        let content = view
            .glassRenderingMode(mode)
            .environment(\.colorScheme, .light)
            .frame(width: size.width, height: size.height)
            .background(canvas ?? .clear)
        // A renderer caches its image, so every pass needs a new one.
        func renderPass() -> Bitmap? {
            let renderer = ImageRenderer(content: content)
            renderer.scale = 1
            return renderer.cgImage.map(Bitmap.init)
        }
        guard var previous = renderPass() else { return nil }
        for pass in 1..<maximumRenderPasses {
            guard let current = renderPass() else { return nil }
            if pass >= warmUpRenderPasses, current.countDifferences(from: previous) == 0 { return current }
            previous = current
        }
        return previous
    }

    /// Passes drawn before results are compared; glyphs settle after about six.
    static let warmUpRenderPasses = 8

    /// Keeps a view that never settles, such as a running animation, from
    /// looping forever.
    static let maximumRenderPasses = 16

    /// Green glass on a white canvas renders about (192, 224, 192).
    static func isGreen(_ pixel: Pixel) -> Bool {
        Int(pixel.green) - Int(pixel.red) > tintMargin && Int(pixel.green) - Int(pixel.blue) > tintMargin
    }

    /// Blue glass on a white canvas renders about (176, 208, 224).
    static func isBlue(_ pixel: Pixel) -> Bool {
        Int(pixel.blue) - Int(pixel.red) > tintMargin
    }

    /// Red dominates both other channels.
    static func isRed(_ pixel: Pixel) -> Bool {
        Int(pixel.red) - Int(max(pixel.green, pixel.blue)) > tintMargin
    }

    /// Number of pixels in the columns `columns` that match `predicate`.
    func count(columns: Range<Int>, where predicate: (Pixel) -> Bool) -> Int {
        var matches = 0
        for y in 0..<height {
            for x in columns where predicate(pixel(x: x, y: y)) {
                matches += 1
            }
        }
        return matches
    }
}
