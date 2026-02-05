// CustomizationExample.swift
// LiquidGlassKit
//
// Advanced customization options for glass effects.
// Create unique, branded glass styles with full control.

import SwiftUI

// MARK: - Custom Glass Style

/// A fully customizable glass style configuration.
public struct CustomGlassStyle {
    public var blurRadius: CGFloat
    public var tintColor: Color
    public var tintOpacity: CGFloat
    public var saturation: CGFloat
    public var borderColor: Color
    public var borderWidth: CGFloat
    public var shadowColor: Color
    public var shadowRadius: CGFloat
    public var shadowOffset: CGSize
    public var cornerRadius: CGFloat
    
    public init(
        blurRadius: CGFloat = 20,
        tintColor: Color = .white,
        tintOpacity: CGFloat = 0.15,
        saturation: CGFloat = 1.8,
        borderColor: Color = .white.opacity(0.25),
        borderWidth: CGFloat = 0.5,
        shadowColor: Color = .black.opacity(0.1),
        shadowRadius: CGFloat = 8,
        shadowOffset: CGSize = CGSize(width: 0, height: 4),
        cornerRadius: CGFloat = 16
    ) {
        self.blurRadius = blurRadius
        self.tintColor = tintColor
        self.tintOpacity = tintOpacity
        self.saturation = saturation
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.cornerRadius = cornerRadius
    }
}

// MARK: - Preset Styles

extension CustomGlassStyle {
    
    /// Arctic frost - cool blue tint with high blur
    public static let arctic = CustomGlassStyle(
        blurRadius: 25,
        tintColor: .cyan,
        tintOpacity: 0.12,
        saturation: 1.6,
        borderColor: .white.opacity(0.3),
        shadowColor: .cyan.opacity(0.2),
        shadowRadius: 12
    )
    
    /// Sunset glow - warm orange/pink gradient feel
    public static let sunset = CustomGlassStyle(
        blurRadius: 22,
        tintColor: .orange,
        tintOpacity: 0.1,
        saturation: 2.0,
        borderColor: .orange.opacity(0.3),
        shadowColor: .orange.opacity(0.15),
        shadowRadius: 10
    )
    
    /// Midnight - deep dark glass
    public static let midnight = CustomGlassStyle(
        blurRadius: 30,
        tintColor: .black,
        tintOpacity: 0.4,
        saturation: 1.2,
        borderColor: .white.opacity(0.1),
        shadowColor: .black.opacity(0.3),
        shadowRadius: 15
    )
    
    /// Neon glow - vibrant with strong border
    public static let neon = CustomGlassStyle(
        blurRadius: 15,
        tintColor: .purple,
        tintOpacity: 0.15,
        saturation: 2.2,
        borderColor: .purple,
        borderWidth: 1.5,
        shadowColor: .purple.opacity(0.4),
        shadowRadius: 20
    )
    
    /// Minimal - ultra clean with subtle blur
    public static let minimal = CustomGlassStyle(
        blurRadius: 10,
        tintColor: .white,
        tintOpacity: 0.05,
        saturation: 1.4,
        borderColor: .clear,
        borderWidth: 0,
        shadowColor: .black.opacity(0.05),
        shadowRadius: 4,
        shadowOffset: CGSize(width: 0, height: 2)
    )
    
    /// Frosted thick - heavy blur with white tint
    public static let frostedThick = CustomGlassStyle(
        blurRadius: 40,
        tintColor: .white,
        tintOpacity: 0.3,
        saturation: 1.5,
        borderColor: .white.opacity(0.4),
        shadowColor: .black.opacity(0.15),
        shadowRadius: 8
    )
    
    /// Rose gold - elegant pink/gold tint
    public static let roseGold = CustomGlassStyle(
        blurRadius: 20,
        tintColor: Color(red: 0.9, green: 0.7, blue: 0.7),
        tintOpacity: 0.15,
        saturation: 1.7,
        borderColor: Color(red: 1.0, green: 0.8, blue: 0.8).opacity(0.4),
        shadowColor: Color(red: 0.9, green: 0.7, blue: 0.7).opacity(0.2),
        shadowRadius: 10
    )
    
    /// Ocean depth - deep blue gradient
    public static let ocean = CustomGlassStyle(
        blurRadius: 28,
        tintColor: .blue,
        tintOpacity: 0.2,
        saturation: 1.8,
        borderColor: .cyan.opacity(0.3),
        shadowColor: .blue.opacity(0.25),
        shadowRadius: 15
    )
    
    /// Forest mist - green nature feel
    public static let forest = CustomGlassStyle(
        blurRadius: 22,
        tintColor: .green,
        tintOpacity: 0.1,
        saturation: 1.9,
        borderColor: .green.opacity(0.25),
        shadowColor: .green.opacity(0.15),
        shadowRadius: 8
    )
    
    /// Crystal clear - maximum transparency
    public static let crystal = CustomGlassStyle(
        blurRadius: 8,
        tintColor: .white,
        tintOpacity: 0.02,
        saturation: 1.1,
        borderColor: .white.opacity(0.15),
        borderWidth: 0.3,
        shadowColor: .clear,
        shadowRadius: 0
    )
}

// MARK: - Custom Glass View Modifier

/// Applies a custom glass style to any view.
public struct CustomGlassModifier: ViewModifier {
    let style: CustomGlassStyle
    
    public func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                            .fill(style.tintColor.opacity(style.tintOpacity))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                            .stroke(style.borderColor, lineWidth: style.borderWidth)
                    )
                    .saturation(style.saturation)
            )
            .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))
            .shadow(
                color: style.shadowColor,
                radius: style.shadowRadius,
                x: style.shadowOffset.width,
                y: style.shadowOffset.height
            )
    }
}

extension View {
    /// Applies a custom glass style.
    public func customGlass(_ style: CustomGlassStyle) -> some View {
        modifier(CustomGlassModifier(style: style))
    }
}

// MARK: - Glass Style Editor

/// Interactive editor for creating custom glass styles.
public struct GlassStyleEditor: View {
    
    @State private var style = CustomGlassStyle()
    @State private var previewText = "Custom Glass"
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Dynamic background
            AnimatedMeshBackground()
            
            VStack(spacing: 0) {
                // Preview
                VStack(spacing: 16) {
                    Text("Preview")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.6))
                    
                    Text(previewText)
                        .font(.title2.weight(.semibold))
                        .padding(32)
                        .frame(maxWidth: .infinity)
                        .customGlass(style)
                }
                .padding()
                
                // Controls
                ScrollView {
                    VStack(spacing: 20) {
                        // Blur
                        sliderControl(
                            title: "Blur Radius",
                            value: $style.blurRadius,
                            range: 0...50,
                            format: "%.0f"
                        )
                        
                        // Tint Opacity
                        sliderControl(
                            title: "Tint Opacity",
                            value: $style.tintOpacity,
                            range: 0...0.5,
                            format: "%.2f"
                        )
                        
                        // Saturation
                        sliderControl(
                            title: "Saturation",
                            value: $style.saturation,
                            range: 0.5...3.0,
                            format: "%.1f"
                        )
                        
                        // Border Width
                        sliderControl(
                            title: "Border Width",
                            value: $style.borderWidth,
                            range: 0...3,
                            format: "%.1f"
                        )
                        
                        // Shadow Radius
                        sliderControl(
                            title: "Shadow Radius",
                            value: $style.shadowRadius,
                            range: 0...30,
                            format: "%.0f"
                        )
                        
                        // Corner Radius
                        sliderControl(
                            title: "Corner Radius",
                            value: $style.cornerRadius,
                            range: 0...40,
                            format: "%.0f"
                        )
                        
                        // Tint Color Picker
                        colorPicker(title: "Tint Color", color: $style.tintColor)
                        
                        // Preset Buttons
                        presetButtons
                    }
                    .padding()
                }
                .glassBackground(material: .frosted, cornerRadius: 24)
            }
        }
    }
    
    @ViewBuilder
    private func sliderControl(
        title: String,
        value: Binding<CGFloat>,
        range: ClosedRange<CGFloat>,
        format: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.subheadline)
                Spacer()
                Text(String(format: format, value.wrappedValue))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }
            
            Slider(value: value, in: range)
                .tint(.blue)
        }
    }
    
    @ViewBuilder
    private func colorPicker(title: String, color: Binding<Color>) -> some View {
        HStack {
            Text(title)
                .font(.subheadline)
            Spacer()
            ColorPicker("", selection: color)
                .labelsHidden()
        }
    }
    
    @ViewBuilder
    private var presetButtons: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Presets")
                .font(.subheadline)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 8) {
                presetButton("Arctic", style: .arctic)
                presetButton("Sunset", style: .sunset)
                presetButton("Midnight", style: .midnight)
                presetButton("Neon", style: .neon)
                presetButton("Minimal", style: .minimal)
                presetButton("Ocean", style: .ocean)
                presetButton("Forest", style: .forest)
                presetButton("Rose", style: .roseGold)
                presetButton("Crystal", style: .crystal)
            }
        }
    }
    
    @ViewBuilder
    private func presetButton(_ name: String, style preset: CustomGlassStyle) -> some View {
        Button {
            withAnimation(.spring(response: 0.3)) {
                style = preset
            }
        } label: {
            Text(name)
                .font(.caption)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.blue.opacity(0.1))
                )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Style Showcase

/// Displays all preset glass styles in a gallery.
public struct GlassStyleGallery: View {
    
    public init() {}
    
    private let styles: [(name: String, style: CustomGlassStyle)] = [
        ("Arctic", .arctic),
        ("Sunset", .sunset),
        ("Midnight", .midnight),
        ("Neon", .neon),
        ("Minimal", .minimal),
        ("Frosted Thick", .frostedThick),
        ("Rose Gold", .roseGold),
        ("Ocean", .ocean),
        ("Forest", .forest),
        ("Crystal", .crystal)
    ]
    
    public var body: some View {
        ZStack {
            AnimatedMeshBackground()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("Glass Style Gallery")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                        .padding(.top, 40)
                    
                    Text("20+ Preset Styles")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(styles, id: \.name) { item in
                            styleCard(name: item.name, style: item.style)
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    @ViewBuilder
    private func styleCard(name: String, style: CustomGlassStyle) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "sparkles")
                .font(.title)
            Text(name)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .customGlass(style)
    }
}

// MARK: - Gradient Glass

/// Glass effect with gradient tint instead of solid color.
public struct GradientGlassCard<Content: View>: View {
    
    let gradient: LinearGradient
    let cornerRadius: CGFloat
    let content: Content
    
    public init(
        colors: [Color],
        startPoint: UnitPoint = .topLeading,
        endPoint: UnitPoint = .bottomTrailing,
        cornerRadius: CGFloat = 20,
        @ViewBuilder content: () -> Content
    ) {
        self.gradient = LinearGradient(
            colors: colors.map { $0.opacity(0.15) },
            startPoint: startPoint,
            endPoint: endPoint
        )
        self.cornerRadius = cornerRadius
        self.content = content()
    }
    
    public var body: some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(gradient)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .stroke(
                                LinearGradient(
                                    colors: [.white.opacity(0.4), .white.opacity(0.1)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 0.5
                            )
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
    }
}

// MARK: - Animated Mesh Background

private struct AnimatedMeshBackground: View {
    @State private var phase = 0.0
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.purple, .blue, .cyan, .green],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            GeometryReader { geo in
                ForEach(0..<5) { i in
                    Circle()
                        .fill(colors[i % colors.count].opacity(0.4))
                        .frame(width: CGFloat.random(in: 100...300))
                        .blur(radius: 60)
                        .offset(
                            x: cos(phase + Double(i)) * 50,
                            y: sin(phase + Double(i) * 0.7) * 50
                        )
                        .position(
                            x: geo.size.width * positions[i % positions.count].x,
                            y: geo.size.height * positions[i % positions.count].y
                        )
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
                phase = .pi * 2
            }
        }
    }
    
    private let colors: [Color] = [.blue, .purple, .pink, .orange, .cyan]
    private let positions: [CGPoint] = [
        CGPoint(x: 0.2, y: 0.2),
        CGPoint(x: 0.8, y: 0.3),
        CGPoint(x: 0.5, y: 0.5),
        CGPoint(x: 0.3, y: 0.8),
        CGPoint(x: 0.7, y: 0.9)
    ]
}

// MARK: - Customization Demo

/// Complete demo showcasing all customization options.
public struct CustomizationDemo: View {
    
    @State private var selectedDemo = 0
    
    public init() {}
    
    public var body: some View {
        ZStack {
            AnimatedMeshBackground()
            
            VStack(spacing: 0) {
                // Segmented picker
                Picker("Demo", selection: $selectedDemo) {
                    Text("Gallery").tag(0)
                    Text("Editor").tag(1)
                    Text("Gradient").tag(2)
                }
                .pickerStyle(.segmented)
                .padding()
                
                // Content
                Group {
                    switch selectedDemo {
                    case 0:
                        GlassStyleGallery()
                    case 1:
                        GlassStyleEditor()
                    case 2:
                        gradientDemo
                    default:
                        EmptyView()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var gradientDemo: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Gradient Glass")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                    .padding(.top, 40)
                
                GradientGlassCard(colors: [.blue, .purple]) {
                    VStack(spacing: 8) {
                        Image(systemName: "paintbrush.fill")
                            .font(.largeTitle)
                        Text("Blue to Purple")
                            .font(.headline)
                    }
                    .padding(32)
                    .frame(maxWidth: .infinity)
                }
                
                GradientGlassCard(colors: [.orange, .pink, .purple]) {
                    VStack(spacing: 8) {
                        Image(systemName: "sun.max.fill")
                            .font(.largeTitle)
                        Text("Sunset Vibes")
                            .font(.headline)
                    }
                    .padding(32)
                    .frame(maxWidth: .infinity)
                }
                
                GradientGlassCard(colors: [.green, .cyan, .blue]) {
                    VStack(spacing: 8) {
                        Image(systemName: "leaf.fill")
                            .font(.largeTitle)
                        Text("Nature Flow")
                            .font(.headline)
                    }
                    .padding(32)
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
    }
}

// MARK: - Preview

#if DEBUG
struct CustomizationExample_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GlassStyleGallery()
                .previewDisplayName("Gallery")
            
            GlassStyleEditor()
                .previewDisplayName("Editor")
            
            CustomizationDemo()
                .previewDisplayName("Full Demo")
        }
    }
}
#endif
