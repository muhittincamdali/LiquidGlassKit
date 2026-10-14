import LiquidGlassKit
import SwiftUI
import UIKit

/// Tunes a ``GlassTheme`` at run time and shows the Swift code that recreates it.
///
/// Start from a built-in preset, adjust the corner radius, shadow and edge, switch
/// between the native and fallback paths, and copy the generated view.
struct PlaygroundScreen: View {
    @State private var preset = GlassPreset.all[0]
    @State private var cornerRadius = 20.0
    @State private var shadowRadius = 10.0
    @State private var strokeOpacity = 0.35
    @State private var usesFallback = false
    @State private var highlight: GlassHighlight?
    @State private var copied = false

    private let exporter = GlassCodeExporter()

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                GlassNavigationBar(title: "Playground", subtitle: "Tune a theme, copy the code")
                preview
                GlassCard { controls }
                GlassCard { codeView }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
        }
        .onChange(of: preset, initial: true) { _, preset in load(preset.theme) }
    }

    /// The theme built from the preset and the slider values.
    private var theme: GlassTheme {
        var theme = preset.theme
        theme.shape = .roundedRectangle(cornerRadius: cornerRadius)
        theme.shadowRadius = shadowRadius
        theme.strokeOpacity = strokeOpacity
        return theme
    }

    private var renderingMode: GlassRenderingMode { usesFallback ? .fallback : .automatic }

    private var code: String {
        exporter.viewCode(named: "MyGlassView", theme: theme, renderingMode: renderingMode)
    }

    private var preview: some View {
        Text("Hello, glass")
            .font(.title3.weight(.semibold))
            .foregroundStyle(theme.material == .dark ? .white : .primary)
            .padding(.horizontal, 28)
            .padding(.vertical, 22)
            .glassSurface()
            .glassHighlight(highlight)
            .glassTheme(theme)
            .glassRenderingMode(renderingMode)
            .frame(maxWidth: .infinity, minHeight: 140)
            .accessibilityElement(children: .combine)
    }

    private var controls: some View {
        VStack(alignment: .leading, spacing: 16) {
            Picker("Preset", selection: $preset) {
                ForEach(GlassPreset.all) { preset in
                    Text(preset.name).tag(preset)
                }
            }
            .pickerStyle(.menu)
            GlassSlider("Corner radius", value: $cornerRadius, in: 0...40, step: 2)
            GlassSlider("Shadow radius", value: $shadowRadius, in: 0...30, step: 1)
            GlassSlider("Edge", value: $strokeOpacity, in: 0...1, format: .percent.precision(.fractionLength(0)))
            Toggle("Fallback path", isOn: $usesFallback)
                .toggleStyle(.liquidGlass)
            Picker("Highlight", selection: $highlight) {
                Text("None").tag(GlassHighlight?.none)
                ForEach(GlassHighlight.allCases, id: \.self) { highlight in
                    Text(highlight.rawValue.capitalized).tag(Optional(highlight))
                }
            }
            .pickerStyle(.segmented)
        }
    }

    private var codeView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Swift").font(.headline)
                Spacer()
                Button(copied ? "Copied" : "Copy", systemImage: copied ? "checkmark" : "doc.on.doc") {
                    UIPasteboard.general.string = code
                    copied = true
                }
                .buttonStyle(.liquidGlass(size: .compact))
            }
            Text(code)
                .font(.caption.monospaced())
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onChange(of: code) { copied = false }
    }

    /// Moves the sliders to `theme`'s values. Presets other than rounded
    /// rectangles keep the current corner radius.
    private func load(_ theme: GlassTheme) {
        if case .roundedRectangle(let radius) = theme.shape { cornerRadius = Double(radius) }
        shadowRadius = Double(theme.shadowRadius)
        strokeOpacity = theme.strokeOpacity
    }
}
