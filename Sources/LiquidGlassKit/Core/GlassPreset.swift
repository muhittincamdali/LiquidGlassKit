import SwiftUI

/// A named ``GlassTheme`` for pickers, settings screens and quick experiments.
///
/// ```swift
/// ContentView()
///     .glassTheme(.aqua)
///
/// Picker("Style", selection: $presetName) {
///     ForEach(GlassPreset.all) { preset in
///         Text(preset.name).tag(preset.name)
///     }
/// }
/// ```
public struct GlassPreset: Identifiable, Sendable, Hashable {
    /// The display name, unique within ``all``.
    public let name: String
    /// A few words describing the look.
    public let summary: String
    /// The theme to install with ``SwiftUICore/View/glassTheme(_:)``.
    public let theme: GlassTheme

    public var id: String { name }

    public init(name: String, summary: String, theme: GlassTheme) {
        self.name = name
        self.summary = summary
        self.theme = theme
    }

    /// Every built-in preset, starting with the default look.
    public static let all: [GlassPreset] = [
        GlassPreset(name: "Standard", summary: "Frosted glass, the default", theme: .standard),
        GlassPreset(name: "Subtle", summary: "Clear glass with a faint edge", theme: .subtle),
        GlassPreset(name: "Dark", summary: "Dark glass for bright backgrounds", theme: .dark),
        GlassPreset(name: "Vapor", summary: "Almost invisible, large corners", theme: .vapor),
        GlassPreset(name: "Neon", summary: "Clear glass with a bright edge", theme: .neon),
        GlassPreset(name: "Aqua", summary: "Water-like blue", theme: .aqua),
        GlassPreset(name: "Ice", summary: "Pale, cold blue", theme: .ice),
        GlassPreset(name: "Ocean", summary: "Deep blue with depth", theme: .ocean),
        GlassPreset(name: "Forest", summary: "Green tint", theme: .forest),
        GlassPreset(name: "Amber", summary: "Warm golden tone", theme: .amber),
        GlassPreset(name: "Sunset", summary: "Orange tint", theme: .sunset),
        GlassPreset(name: "Rose", summary: "Soft pink tint", theme: .rose),
        GlassPreset(name: "Lavender", summary: "Soft purple haze", theme: .lavender),
        GlassPreset(name: "Midnight", summary: "Deep navy glass", theme: .midnight)
    ]

    /// The built-in preset with this name, ignoring case and surrounding spaces.
    public static func named(_ name: String) -> GlassPreset? {
        let key = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return all.first { $0.name.compare(key, options: .caseInsensitive) == .orderedSame }
    }
}

extension GlassTheme {
    /// Clear glass, 28 pt corners, almost no shadow or edge.
    public static let vapor = GlassTheme(
        material: .clear,
        shape: .roundedRectangle(cornerRadius: 28),
        shadowRadius: 2,
        shadowOpacity: 0.04,
        strokeOpacity: 0.15
    )

    /// Clear glass with a bright edge highlight.
    public static let neon = GlassTheme(material: .clear, shadowRadius: 8, shadowOpacity: 0.1, strokeOpacity: 0.9)

    /// Water-like blue glass, 24 pt corners.
    public static let aqua = GlassTheme(
        material: .tinted(Color(red: 0, green: 0.6, blue: 1)),
        shape: .roundedRectangle(cornerRadius: 24)
    )

    /// Pale, cold blue glass.
    public static let ice = GlassTheme(
        material: .tinted(Color(red: 0.7, green: 0.9, blue: 1)),
        shadowRadius: 6,
        shadowOpacity: 0.08,
        strokeOpacity: 0.5
    )

    /// Deep blue glass with a stronger shadow.
    public static let ocean = GlassTheme(
        material: .tinted(Color(red: 0, green: 0.3, blue: 0.7)),
        shadowRadius: 14,
        shadowOpacity: 0.2
    )

    /// Green glass.
    public static let forest = GlassTheme(material: .tinted(Color(red: 0.2, green: 0.7, blue: 0.3)))

    /// Warm golden glass.
    public static let amber = GlassTheme(material: .tinted(Color(red: 1, green: 0.8, blue: 0.3)))

    /// Orange glass.
    public static let sunset = GlassTheme(material: .tinted(Color(red: 1, green: 0.5, blue: 0.2)))

    /// Soft pink glass, 24 pt corners.
    public static let rose = GlassTheme(
        material: .tinted(Color(red: 1, green: 0.5, blue: 0.6)),
        shape: .roundedRectangle(cornerRadius: 24)
    )

    /// Soft purple glass.
    public static let lavender = GlassTheme(material: .tinted(Color(red: 0.6, green: 0.4, blue: 0.9)))

    /// Deep navy glass with a deep shadow.
    public static let midnight = GlassTheme(
        material: .tinted(Color(red: 0.05, green: 0.05, blue: 0.15)),
        shadowRadius: 16,
        shadowOpacity: 0.3,
        strokeOpacity: 0.2
    )
}
