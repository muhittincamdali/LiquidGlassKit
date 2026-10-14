import SwiftUI

/// Turns glass values into Swift source that uses LiquidGlassKit.
///
/// Use it to copy a look tuned at run time, for example in a settings or debug
/// screen, into your code:
///
/// ```swift
/// let exporter = GlassCodeExporter()
/// exporter.code(for: GlassMaterial.tinted(.blue))     // ".tinted(.blue)"
/// exporter.code(for: GlassTheme(shadowRadius: 4))      // "GlassTheme(shadowRadius: 4)"
/// print(exporter.viewCode(named: "Badge", theme: .aqua))
/// ```
///
/// Standard SwiftUI colors such as `.blue` are written by name. Other colors are
/// resolved in a default (light) environment and written as sRGB components,
/// so a dynamic color exports its light appearance.
public struct GlassCodeExporter: Sendable {
    /// Spaces per indentation level in ``viewCode(named:theme:renderingMode:)``,
    /// kept between 0 and ``maximumIndentWidth``.
    public var indentWidth: Int {
        didSet { indentWidth = indentWidth.clamped(to: 0...Self.maximumIndentWidth) }
    }

    /// The widest indentation level the exporter writes.
    public static let maximumIndentWidth = 8

    public init(indentWidth: Int = 4) {
        self.indentWidth = indentWidth.clamped(to: 0...Self.maximumIndentWidth)
    }

    /// A Swift expression for `color`, such as `.blue` or `Color(red: 0.2, green: 0.4, blue: 1)`.
    public func code(for color: Color) -> String {
        if let name = Self.namedColors.first(where: { $0.color == color })?.name {
            return "." + name
        }
        let resolved = color.resolve(in: EnvironmentValues())
        let components = [("red", resolved.red), ("green", resolved.green), ("blue", resolved.blue)]
            .map { "\($0.0): \(Self.number(Double($0.1)))" }
            .joined(separator: ", ")
        let base = "Color(\(components))"
        return resolved.opacity < 1 ? "\(base).opacity(\(Self.number(Double(resolved.opacity))))" : base
    }

    /// A Swift expression for `material`, such as `.frosted` or `.tinted(.blue)`.
    public func code(for material: GlassMaterial) -> String {
        switch material {
        case .clear: ".clear"
        case .frosted: ".frosted"
        case .tinted(let color): ".tinted(\(code(for: color)))"
        case .dark: ".dark"
        }
    }

    /// A Swift expression for `shape`, such as `.capsule` or `.roundedRectangle(cornerRadius: 20)`.
    /// Negative radii are written as zero, which is how they are drawn.
    public func code(for shape: GlassShape) -> String {
        switch shape {
        case .roundedRectangle(let cornerRadius):
            return ".roundedRectangle(cornerRadius: \(Self.radius(cornerRadius)))"
        case .capsule:
            return ".capsule"
        case .circle:
            return ".circle"
        case .unevenRoundedRectangle(let topLeading, let bottomLeading, let bottomTrailing, let topTrailing):
            let radii = [topLeading, bottomLeading, bottomTrailing, topTrailing].map(Self.radius)
            if radii[0] == radii[3], radii[1] == "0", radii[2] == "0" {
                return ".topRounded(\(radii[0]))"
            }
            return ".unevenRoundedRectangle(topLeading: \(radii[0]), bottomLeading: \(radii[1]), "
                + "bottomTrailing: \(radii[2]), topTrailing: \(radii[3]))"
        }
    }

    /// A `GlassTheme(...)` initializer for `theme` that leaves out arguments equal to their defaults.
    public func code(for theme: GlassTheme) -> String {
        let defaults = GlassTheme()
        var arguments: [String] = []
        if theme.material != defaults.material { arguments.append("material: \(code(for: theme.material))") }
        if theme.shape != defaults.shape { arguments.append("shape: \(code(for: theme.shape))") }
        if theme.shadowRadius != defaults.shadowRadius {
            arguments.append("shadowRadius: \(Self.number(Double(theme.shadowRadius)))")
        }
        if theme.shadowOpacity != defaults.shadowOpacity {
            arguments.append("shadowOpacity: \(Self.number(theme.shadowOpacity))")
        }
        if theme.strokeOpacity != defaults.strokeOpacity {
            arguments.append("strokeOpacity: \(Self.number(theme.strokeOpacity))")
        }
        return "GlassTheme(\(arguments.joined(separator: ", ")))"
    }

    /// The argument for ``SwiftUICore/View/glassTheme(_:)``: a built-in theme such as
    /// `.aqua` when `theme` equals one of the ``GlassPreset/all`` themes, otherwise
    /// a `GlassTheme(...)` initializer.
    public func themeArgument(for theme: GlassTheme) -> String {
        if let preset = GlassPreset.all.first(where: { $0.theme == theme }) {
            return "." + preset.name.lowercased()
        }
        return code(for: theme)
    }

    /// A complete SwiftUI view that shows a label on glass in `theme`.
    ///
    /// - Parameters:
    ///   - name: The struct name. Characters that cannot appear in a Swift
    ///     identifier are dropped; an empty result becomes `GlassPreview`, and a
    ///     name that starts with a digit or is a Swift keyword gets a `Glass` prefix.
    ///   - theme: The theme the view installs.
    ///   - renderingMode: Adds `.glassRenderingMode(.fallback)` when it is ``GlassRenderingMode/fallback``.
    public func viewCode(
        named name: String,
        theme: GlassTheme,
        renderingMode: GlassRenderingMode = .automatic
    ) -> String {
        let indent = String(repeating: " ", count: indentWidth)
        var modifiers = [".padding()", ".glassSurface()", ".glassTheme(\(themeArgument(for: theme)))"]
        if renderingMode == .fallback { modifiers.append(".glassRenderingMode(.fallback)") }
        let lines = [
            "import LiquidGlassKit",
            "import SwiftUI",
            "",
            "struct \(Self.identifier(from: name)): View {",
            "\(indent)var body: some View {",
            "\(indent)\(indent)Text(\"Hello, glass\")"
        ] + modifiers.map { "\(indent)\(indent)\(indent)\($0)" } + [
            "\(indent)}",
            "}"
        ]
        return lines.joined(separator: "\n") + "\n"
    }

    // MARK: - Formatting

    static let namedColors: [(name: String, color: Color)] = [
        ("red", .red), ("orange", .orange), ("yellow", .yellow), ("green", .green), ("mint", .mint),
        ("teal", .teal), ("cyan", .cyan), ("blue", .blue), ("indigo", .indigo), ("purple", .purple),
        ("pink", .pink), ("brown", .brown), ("gray", .gray), ("black", .black), ("white", .white),
        ("primary", .primary), ("secondary", .secondary), ("accentColor", .accentColor)
    ]

    /// `value` with at most three decimals and no trailing zeros; non-finite values become 0.
    static func number(_ value: Double) -> String {
        guard value.isFinite else { return "0" }
        var text = String(format: "%.3f", value)
        while text.hasSuffix("0") { text.removeLast() }
        if text.hasSuffix(".") { text.removeLast() }
        return text == "-0" ? "0" : text
    }

    private static func radius(_ value: CGFloat) -> String {
        number(Double(max(0, value)))
    }

    /// A Swift type name made from `name`.
    ///
    /// Keeps the Unicode scalars that may continue an identifier (XID_Continue,
    /// which includes `_`), prefixes `Glass` when the first one may not start an
    /// identifier (a digit or a combining mark) or the result is a keyword, and
    /// falls back to `GlassPreview` when nothing usable is left.
    static func identifier(from name: String) -> String {
        let scalars = name.unicodeScalars.filter(\.properties.isXIDContinue)
        let identifier = String(String.UnicodeScalarView(scalars))
        guard let first = identifier.unicodeScalars.first, identifier.contains(where: { $0 != "_" }) else {
            return "GlassPreview"
        }
        if !(first.properties.isXIDStart || first == "_") || reservedWords.contains(identifier) {
            return "Glass" + identifier.prefix(1).uppercased() + identifier.dropFirst()
        }
        return identifier
    }

    /// Words that cannot name a struct without backticks.
    static let reservedWords: Set<String> = [
        "Any", "Protocol", "Self", "Type", "actor", "any", "as", "associatedtype", "async", "await",
        "break", "case", "catch", "class", "continue", "default", "defer", "deinit", "do", "else",
        "enum", "extension", "fallthrough", "false", "fileprivate", "for", "func", "guard", "if",
        "import", "in", "init", "inout", "internal", "is", "let", "nil", "open", "operator",
        "precedencegroup", "private", "protocol", "public", "repeat", "rethrows", "return", "self",
        "some", "static", "struct", "subscript", "super", "switch", "throw", "throws", "true", "try",
        "typealias", "var", "where", "while"
    ]
}
