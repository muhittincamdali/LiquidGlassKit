import SwiftUI
import Testing
@testable import LiquidGlassKit

@Suite("GlassCodeExporter")
struct GlassCodeExporterTests {
    private let exporter = GlassCodeExporter()

    @Test func standardColorsAreWrittenByName() {
        #expect(exporter.code(for: Color.blue) == ".blue")
        #expect(exporter.code(for: Color.accentColor) == ".accentColor")
        #expect(exporter.code(for: Color.white) == ".white")
    }

    @Test func otherColorsAreWrittenAsComponents() {
        #expect(exporter.code(for: Color(red: 0.2, green: 0.4, blue: 1)) == "Color(red: 0.2, green: 0.4, blue: 1)")
        #expect(exporter.code(for: Color(red: 0, green: 0.6, blue: 1)) == "Color(red: 0, green: 0.6, blue: 1)")
        #expect(
            exporter.code(for: Color(red: 1, green: 0, blue: 0).opacity(0.5))
                == "Color(red: 1, green: 0, blue: 0).opacity(0.5)"
        )
    }

    @Test func materials() {
        #expect(exporter.code(for: GlassMaterial.clear) == ".clear")
        #expect(exporter.code(for: GlassMaterial.frosted) == ".frosted")
        #expect(exporter.code(for: GlassMaterial.dark) == ".dark")
        #expect(exporter.code(for: GlassMaterial.tinted(.purple)) == ".tinted(.purple)")
    }

    @Test func shapes() {
        #expect(exporter.code(for: GlassShape.capsule) == ".capsule")
        #expect(exporter.code(for: GlassShape.circle) == ".circle")
        let rounded = { (radius: CGFloat) in exporter.code(for: GlassShape.roundedRectangle(cornerRadius: radius)) }
        #expect(rounded(12.5) == ".roundedRectangle(cornerRadius: 12.5)")
        #expect(rounded(-4) == ".roundedRectangle(cornerRadius: 0)")
        #expect(exporter.code(for: GlassShape.topRounded(28)) == ".topRounded(28)")
        let uneven = GlassShape.unevenRoundedRectangle(
            topLeading: 1, bottomLeading: 2, bottomTrailing: 3, topTrailing: 4
        )
        #expect(
            exporter.code(for: uneven)
                == ".unevenRoundedRectangle(topLeading: 1, bottomLeading: 2, bottomTrailing: 3, topTrailing: 4)"
        )
    }

    @Test func themesLeaveOutDefaultArguments() {
        #expect(exporter.code(for: GlassTheme()) == "GlassTheme()")
        #expect(exporter.code(for: GlassTheme(shadowRadius: 4)) == "GlassTheme(shadowRadius: 4)")
        #expect(
            exporter.code(for: .subtle)
                == "GlassTheme(material: .clear, shape: .roundedRectangle(cornerRadius: 14), "
                + "shadowRadius: 4, shadowOpacity: 0.06, strokeOpacity: 0.2)"
        )
    }

    @Test func themeArgumentsPreferBuiltInThemes() {
        #expect(exporter.themeArgument(for: .aqua) == ".aqua")
        #expect(exporter.themeArgument(for: GlassTheme()) == ".standard")
        let custom = GlassTheme(material: .dark, shadowRadius: 3)
        #expect(exporter.themeArgument(for: custom) == "GlassTheme(material: .dark, shadowRadius: 3)")
        for preset in GlassPreset.all {
            #expect(exporter.themeArgument(for: preset.theme).hasPrefix("."), "\(preset.name) is not written by name")
        }
    }

    @Test(arguments: [(1.0, "1"), (0.12, "0.12"), (0.1234, "0.123"), (-0.0001, "0"), (Double.nan, "0"), (-2.5, "-2.5")])
    func numbers(value: Double, expected: String) {
        #expect(GlassCodeExporter.number(value) == expected)
    }

    @Test(arguments: [
        ("Badge", "Badge"), ("My Card!", "MyCard"), ("3D", "Glass3D"), ("", "GlassPreview"), ("é_1", "é_1"),
        ("class", "GlassClass"), ("Self", "GlassSelf"), ("_", "GlassPreview"), ("__", "GlassPreview"),
        ("_private", "_private"), ("\u{301}Accent", "Glass\u{301}Accent"), ("٣Arabic", "Glass٣Arabic"),
        ("a-b c", "abc"), ("🙂Smile", "Smile")])
    func viewNamesBecomeIdentifiers(name: String, expected: String) {
        #expect(GlassCodeExporter.identifier(from: name) == expected)
    }

    /// A negative width used to reach String(repeating:count:) and trap; a huge
    /// one allocated a line per level of that size.
    @Test(arguments: [(-1, 0), (Int.min, 0), (3, 3), (Int.max, GlassCodeExporter.maximumIndentWidth)])
    func indentWidthIsClamped(width: Int, expected: Int) throws {
        var exporter = GlassCodeExporter(indentWidth: width)
        #expect(exporter.indentWidth == expected)
        exporter.indentWidth = 4
        exporter.indentWidth = width
        #expect(exporter.indentWidth == expected, "assignment must clamp like the initializer")
        let lines = exporter.viewCode(named: "Clamped", theme: .standard).split(separator: "\n")
        let body = try #require(lines.first { $0.hasSuffix("var body: some View {") })
        #expect(body.prefix(while: { $0 == " " }).count == expected)
    }

    /// The expected text is also compiled below as `ExportedBadge`,
    /// `ExportedCard` and `ExportedShimmer`, so the exporter's output is known to build.
    @Test func viewCodeMatchesTheCompiledSamples() {
        #expect(exporter.viewCode(named: "ExportedBadge", theme: .aqua, renderingMode: .fallback) == Self.badgeSource)
        let card = GlassTheme(material: .tinted(.blue), shape: .capsule, shadowRadius: 4)
        #expect(GlassCodeExporter(indentWidth: 2).viewCode(named: "ExportedCard", theme: card) == Self.cardSource)
        #expect(exporter.viewCode(named: "ExportedShimmer", theme: .ocean, highlight: .shimmer) == Self.shimmerSource)
    }

    /// The playground previews its highlight, so the copied code must contain it,
    /// between the surface and the theme it takes its outline from.
    @Test(arguments: GlassHighlight.allCases)
    func viewCodeAddsTheHighlight(highlight: GlassHighlight) throws {
        let lines = exporter.viewCode(named: "Lit", theme: .standard, highlight: highlight)
            .split(separator: "\n")
            .map { $0.trimmingCharacters(in: .whitespaces) }
        let surface = try #require(lines.firstIndex(of: ".glassSurface()"))
        let theme = try #require(lines.firstIndex { $0.hasPrefix(".glassTheme(") })
        #expect(lines[surface + 1] == ".glassHighlight(.\(highlight.rawValue))")
        #expect(surface + 1 < theme)
        #expect(!exporter.viewCode(named: "Lit", theme: .standard).contains("glassHighlight"))
    }

    /// Guards the samples against drifting apart from the compiled copies in this file.
    @Test func compiledSamplesMatchTheExpectedText() throws {
        let file = try String(contentsOfFile: #filePath, encoding: .utf8)
        for source in [Self.badgeSource, Self.cardSource, Self.shimmerSource] {
            let body = source.components(separatedBy: "import SwiftUI\n\n")[1]
            #expect(file.contains("private " + body), "compiled copy differs from:\n\(body)")
        }
    }

    static let badgeSource = """
        import LiquidGlassKit
        import SwiftUI

        struct ExportedBadge: View {
            var body: some View {
                Text("Hello, glass")
                    .padding()
                    .glassSurface()
                    .glassTheme(.aqua)
                    .glassRenderingMode(.fallback)
            }
        }

        """

    static let cardSource = """
        import LiquidGlassKit
        import SwiftUI

        struct ExportedCard: View {
          var body: some View {
            Text("Hello, glass")
              .padding()
              .glassSurface()
              .glassTheme(GlassTheme(material: .tinted(.blue), shape: .capsule, shadowRadius: 4))
          }
        }

        """

    static let shimmerSource = """
        import LiquidGlassKit
        import SwiftUI

        struct ExportedShimmer: View {
            var body: some View {
                Text("Hello, glass")
                    .padding()
                    .glassSurface()
                    .glassHighlight(.shimmer)
                    .glassTheme(.ocean)
            }
        }

        """
}

// MARK: - Exporter output, compiled

private struct ExportedBadge: View {
    var body: some View {
        Text("Hello, glass")
            .padding()
            .glassSurface()
            .glassTheme(.aqua)
            .glassRenderingMode(.fallback)
    }
}

private struct ExportedCard: View {
  var body: some View {
    Text("Hello, glass")
      .padding()
      .glassSurface()
      .glassTheme(GlassTheme(material: .tinted(.blue), shape: .capsule, shadowRadius: 4))
  }
}

private struct ExportedShimmer: View {
    var body: some View {
        Text("Hello, glass")
            .padding()
            .glassSurface()
            .glassHighlight(.shimmer)
            .glassTheme(.ocean)
    }
}
