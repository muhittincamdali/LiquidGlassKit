import SwiftUI
import Testing
@testable import LiquidGlassKit

@Suite("GlassShape")
struct GlassShapeTests {
    private let wide = CGRect(x: 0, y: 0, width: 200, height: 60)
    private let topLeftCorner = CGPoint(x: 1, y: 1)
    private let bottomLeftCorner = CGPoint(x: 1, y: 59)
    private let center = CGPoint(x: 100, y: 30)

    @Test func zeroRadiusRectangleFillsItsCorners() {
        let path = GlassShape.roundedRectangle(cornerRadius: 0).path(in: wide)
        #expect(path.contains(topLeftCorner))
        #expect(path.contains(center))
    }

    @Test func negativeRadiusIsTreatedAsZero() {
        let negative = GlassShape.roundedRectangle(cornerRadius: -12).path(in: wide)
        #expect(negative.contains(topLeftCorner))
        #expect(negative.boundingRect == wide)
    }

    @Test func roundedRectangleCutsItsCorners() {
        let path = GlassShape.roundedRectangle(cornerRadius: 20).path(in: wide)
        #expect(!path.contains(topLeftCorner))
        #expect(path.contains(center))
        #expect(path.boundingRect == wide)
    }

    @Test func capsuleIsFullyRoundedOnTheShortSide() {
        let path = GlassShape.capsule.path(in: wide)
        #expect(!path.contains(CGPoint(x: 5, y: 5)))
        #expect(path.contains(CGPoint(x: 30, y: 30)))
    }

    @Test func circleFitsTheShorterSide() {
        let bounds = GlassShape.circle.path(in: wide).boundingRect
        #expect(abs(bounds.width - 60) < 0.001)
        #expect(abs(bounds.height - 60) < 0.001)
        #expect(abs(bounds.midX - wide.midX) < 0.001)
    }

    @Test func topRoundedKeepsSquareBottomCorners() {
        let path = GlassShape.topRounded(24).path(in: wide)
        #expect(!path.contains(topLeftCorner))
        #expect(path.contains(bottomLeftCorner))
        #expect(GlassShape.topRounded(24) == .unevenRoundedRectangle(
            topLeading: 24, bottomLeading: 0, bottomTrailing: 0, topTrailing: 24
        ))
    }

    @Test func unevenRadiiClampNegativeValues() {
        let path = GlassShape.unevenRoundedRectangle(
            topLeading: -5, bottomLeading: -5, bottomTrailing: -5, topTrailing: -5
        ).path(in: wide)
        #expect(path.contains(topLeftCorner))
        #expect(path.contains(bottomLeftCorner))
    }
}
