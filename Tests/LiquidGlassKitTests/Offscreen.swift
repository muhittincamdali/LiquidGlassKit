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
    @MainActor
    static func render(
        _ view: some View,
        size: CGSize,
        mode: GlassRenderingMode = .fallback,
        canvas: Color? = .white
    ) -> Bitmap? {
        let renderer = ImageRenderer(
            content: view
                .glassRenderingMode(mode)
                .environment(\.colorScheme, .light)
                .frame(width: size.width, height: size.height)
                .background(canvas ?? .clear)
        )
        renderer.scale = 1
        return renderer.cgImage.map(Bitmap.init)
    }

    /// Green glass on a white canvas renders about (192, 224, 192).
    static func isGreen(_ pixel: Pixel) -> Bool {
        Int(pixel.green) - Int(pixel.red) > tintMargin && Int(pixel.green) - Int(pixel.blue) > tintMargin
    }

    /// Blue glass on a white canvas renders about (176, 208, 224).
    static func isBlue(_ pixel: Pixel) -> Bool {
        Int(pixel.blue) - Int(pixel.red) > tintMargin
    }
}
