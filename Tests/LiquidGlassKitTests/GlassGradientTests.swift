import SwiftUI
import Testing
@testable import LiquidGlassKit

@Suite("GlassGradient")
struct GlassGradientTests {
    @Test(arguments: [(-0.5, 0.0), (0.4, 0.4), (3.0, 1.0), (Double.nan, 0.0), (Double.infinity, 1.0), (-Double.infinity, 0.0)])
    func intensityIsClamped(input: Double, expected: Double) {
        #expect(GlassGradient([.red], intensity: input).intensity == expected)
        var assigned = GlassGradient([.red])
        assigned.intensity = input
        #expect(assigned.intensity == expected, "assignment must clamp like the initializer")
    }

    @Test func directionsRunBetweenOppositeEdges() {
        for direction in GlassGradientDirection.allCases {
            let start = direction.startPoint
            let end = direction.endPoint
            #expect(start.x + end.x == 1 && start.y + end.y == 1, "\(direction) is not symmetric about the center")
            #expect(start != end)
        }
        #expect(GlassGradientDirection.horizontal.startPoint == .leading)
        #expect(GlassGradientDirection.reverseDiagonal.endPoint == .bottomLeading)
    }

    @Test func gradientsWithDifferentColorsAreNotEqual() {
        #expect(GlassGradient([.red, .blue]) != GlassGradient([.blue, .red]))
        #expect(GlassGradient([.red, .blue]) == GlassGradient([.red, .blue]))
    }
}

@MainActor
@Suite("GlassGradient rendering")
struct GlassGradientRenderingTests {
    private static let size = CGSize(width: 200, height: 80)

    private func render(
        _ colors: [Color],
        direction: GlassGradientDirection,
        intensity: Double = 0.6
    ) throws -> Bitmap {
        let view = Color.clear
            .glassGradient(colors, direction: direction, intensity: intensity, material: .frosted,
                           in: .roundedRectangle(cornerRadius: 0))
        return try #require(Bitmap.render(view, size: Self.size))
    }

    @Test func horizontalGradientsRunFromLeadingToTrailing() throws {
        let bitmap = try render([.red, .blue], direction: .horizontal)
        let quarter = bitmap.width / 4
        let leading = 0..<quarter
        let trailing = (bitmap.width - quarter)..<bitmap.width
        #expect(bitmap.count(columns: leading, where: Bitmap.isRed) > 1000)
        #expect(bitmap.count(columns: leading, where: Bitmap.isBlue) == 0)
        #expect(bitmap.count(columns: trailing, where: Bitmap.isBlue) > 1000)
        #expect(bitmap.count(columns: trailing, where: Bitmap.isRed) == 0)
    }

    @Test func verticalGradientsRunFromTopToBottom() throws {
        let bitmap = try render([.red, .blue], direction: .vertical)
        let top = bitmap.pixel(x: bitmap.width / 2, y: 2)
        let bottom = bitmap.pixel(x: bitmap.width / 2, y: bitmap.height - 3)
        #expect(Bitmap.isRed(top), "top pixel \(top)")
        #expect(Bitmap.isBlue(bottom) && !Bitmap.isRed(bottom), "bottom pixel \(bottom)")
    }

    @Test(arguments: [0.0, 0.6])
    func intensityControlsTheTint(intensity: Double) throws {
        let bitmap = try render([.red], direction: .diagonal, intensity: intensity)
        let red = bitmap.count(where: Bitmap.isRed)
        if intensity == 0 {
            #expect(red == 0, "a zero intensity drew \(red) red pixels")
        } else {
            #expect(red > bitmap.width * bitmap.height / 2, "drew only \(red) red pixels")
        }
    }

    @Test func noColorsDrawsPlainGlass() throws {
        let gradient = try render([], direction: .diagonal)
        let plain = try #require(Bitmap.render(
            Color.clear.glassSurface(.frosted, in: .roundedRectangle(cornerRadius: 0)),
            size: Self.size
        ))
        #expect(gradient.countDifferences(from: plain) == 0)
    }
}
