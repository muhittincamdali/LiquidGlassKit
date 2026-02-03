//
//  AquaMaterial.swift
//  LiquidGlassKit
//
//  Created by Muhittin Camdali on 2025.
//  Copyright © 2025 Muhittin Camdali. All rights reserved.
//

import SwiftUI

// MARK: - Aqua Material Configuration

/// Configuration for aqua-style liquid materials.
///
/// Aqua materials simulate the appearance of water and other clear liquids,
/// with support for caustics, refraction, and surface tension effects.
public struct AquaMaterialConfiguration: Equatable, Sendable {
    /// The base tint color of the aqua material
    public var tintColor: Color
    
    /// The intensity of the caustics effect (0.0 to 1.0)
    public var causticsIntensity: CGFloat
    
    /// The scale of caustic patterns
    public var causticsScale: CGFloat
    
    /// The speed of caustic animation
    public var causticsSpeed: CGFloat
    
    /// The amount of refraction distortion
    public var refractionStrength: CGFloat
    
    /// The opacity of the material (0.0 to 1.0)
    public var opacity: CGFloat
    
    /// The blur radius for the frosted effect
    public var blurRadius: CGFloat
    
    /// Whether to show surface bubbles
    public var showBubbles: Bool
    
    /// The density of surface bubbles
    public var bubbleDensity: CGFloat
    
    /// The surface tension effect intensity
    public var surfaceTension: CGFloat
    
    /// The depth effect intensity
    public var depthIntensity: CGFloat
    
    /// Creates a new aqua material configuration
    public init(
        tintColor: Color = .blue,
        causticsIntensity: CGFloat = 0.3,
        causticsScale: CGFloat = 1.0,
        causticsSpeed: CGFloat = 1.0,
        refractionStrength: CGFloat = 0.1,
        opacity: CGFloat = 0.6,
        blurRadius: CGFloat = 10,
        showBubbles: Bool = false,
        bubbleDensity: CGFloat = 0.5,
        surfaceTension: CGFloat = 0.5,
        depthIntensity: CGFloat = 0.3
    ) {
        self.tintColor = tintColor
        self.causticsIntensity = causticsIntensity
        self.causticsScale = causticsScale
        self.causticsSpeed = causticsSpeed
        self.refractionStrength = refractionStrength
        self.opacity = opacity
        self.blurRadius = blurRadius
        self.showBubbles = showBubbles
        self.bubbleDensity = bubbleDensity
        self.surfaceTension = surfaceTension
        self.depthIntensity = depthIntensity
    }
    
    /// Clear water preset
    public static let clearWater = AquaMaterialConfiguration(
        tintColor: .cyan.opacity(0.3),
        causticsIntensity: 0.4,
        refractionStrength: 0.15,
        opacity: 0.5,
        blurRadius: 8
    )
    
    /// Deep ocean preset
    public static let deepOcean = AquaMaterialConfiguration(
        tintColor: .blue,
        causticsIntensity: 0.2,
        causticsScale: 1.5,
        causticsSpeed: 0.5,
        refractionStrength: 0.05,
        opacity: 0.8,
        blurRadius: 15,
        depthIntensity: 0.6
    )
    
    /// Pool water preset
    public static let poolWater = AquaMaterialConfiguration(
        tintColor: .teal,
        causticsIntensity: 0.5,
        causticsScale: 0.8,
        causticsSpeed: 1.2,
        refractionStrength: 0.2,
        opacity: 0.55,
        blurRadius: 6,
        showBubbles: true,
        bubbleDensity: 0.3
    )
    
    /// Tropical lagoon preset
    public static let tropicalLagoon = AquaMaterialConfiguration(
        tintColor: Color(red: 0.2, green: 0.8, blue: 0.7),
        causticsIntensity: 0.35,
        causticsScale: 0.9,
        refractionStrength: 0.12,
        opacity: 0.45,
        blurRadius: 5
    )
    
    /// Ice water preset
    public static let iceWater = AquaMaterialConfiguration(
        tintColor: Color(red: 0.85, green: 0.95, blue: 1.0),
        causticsIntensity: 0.15,
        refractionStrength: 0.08,
        opacity: 0.4,
        blurRadius: 12,
        surfaceTension: 0.7
    )
}

// MARK: - Aqua Material View

/// A view that renders an aqua material effect.
public struct AquaMaterialView: View {
    @State private var causticsPhase: CGFloat = 0
    @State private var bubblePositions: [BubblePosition] = []
    
    let configuration: AquaMaterialConfiguration
    
    /// Creates an aqua material view
    public init(configuration: AquaMaterialConfiguration = AquaMaterialConfiguration()) {
        self.configuration = configuration
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Base blur layer
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .blur(radius: configuration.blurRadius)
                
                // Tint layer
                Rectangle()
                    .fill(configuration.tintColor.opacity(configuration.opacity))
                
                // Caustics layer
                if configuration.causticsIntensity > 0 {
                    CausticsLayer(
                        phase: causticsPhase,
                        intensity: configuration.causticsIntensity,
                        scale: configuration.causticsScale
                    )
                }
                
                // Depth gradient
                if configuration.depthIntensity > 0 {
                    DepthGradientLayer(intensity: configuration.depthIntensity, color: configuration.tintColor)
                }
                
                // Bubbles layer
                if configuration.showBubbles {
                    BubblesLayer(bubbles: bubblePositions)
                }
                
                // Surface tension highlight
                if configuration.surfaceTension > 0 {
                    SurfaceTensionLayer(intensity: configuration.surfaceTension)
                }
            }
            .onAppear {
                startAnimations()
                if configuration.showBubbles {
                    generateBubbles(in: geometry.size)
                }
            }
        }
    }
    
    private func startAnimations() {
        withAnimation(.linear(duration: 4.0 / configuration.causticsSpeed).repeatForever(autoreverses: false)) {
            causticsPhase = 1.0
        }
    }
    
    private func generateBubbles(in size: CGSize) {
        let count = Int(configuration.bubbleDensity * 20)
        bubblePositions = (0..<count).map { _ in
            BubblePosition(
                x: CGFloat.random(in: 0...size.width),
                y: CGFloat.random(in: 0...size.height),
                size: CGFloat.random(in: 2...8),
                speed: CGFloat.random(in: 0.5...2.0)
            )
        }
    }
}

// MARK: - Caustics Layer

/// Renders the caustics effect for aqua materials.
struct CausticsLayer: View {
    let phase: CGFloat
    let intensity: CGFloat
    let scale: CGFloat
    
    var body: some View {
        Canvas { context, size in
            let patternSize: CGFloat = 40 * scale
            
            for x in stride(from: 0, to: size.width + patternSize, by: patternSize) {
                for y in stride(from: 0, to: size.height + patternSize, by: patternSize) {
                    let offsetX = sin(phase * .pi * 2 + y / 50) * 5
                    let offsetY = cos(phase * .pi * 2 + x / 50) * 5
                    
                    let brightness = (sin(phase * .pi * 4 + x / 30 + y / 40) + 1) / 2 * intensity
                    
                    let rect = CGRect(
                        x: x + offsetX,
                        y: y + offsetY,
                        width: patternSize * 0.6,
                        height: patternSize * 0.6
                    )
                    
                    let path = Path(ellipseIn: rect)
                    context.fill(path, with: .color(.white.opacity(brightness * 0.3)))
                }
            }
        }
        .blendMode(.overlay)
    }
}

// MARK: - Depth Gradient Layer

/// Renders the depth gradient for aqua materials.
struct DepthGradientLayer: View {
    let intensity: CGFloat
    let color: Color
    
    var body: some View {
        LinearGradient(
            colors: [
                color.opacity(0),
                color.opacity(intensity * 0.5),
                color.opacity(intensity)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Bubbles Layer

/// Renders animated bubbles for aqua materials.
struct BubblesLayer: View {
    let bubbles: [BubblePosition]
    
    @State private var animationPhase: CGFloat = 0
    
    var body: some View {
        Canvas { context, size in
            for bubble in bubbles {
                let yOffset = animationPhase * bubble.speed * size.height
                let adjustedY = (bubble.y - yOffset).truncatingRemainder(dividingBy: size.height)
                let finalY = adjustedY < 0 ? adjustedY + size.height : adjustedY
                
                let wobbleX = sin(animationPhase * .pi * 4 + bubble.x) * 2
                
                let rect = CGRect(
                    x: bubble.x + wobbleX - bubble.size / 2,
                    y: finalY - bubble.size / 2,
                    width: bubble.size,
                    height: bubble.size
                )
                
                // Bubble body
                let path = Path(ellipseIn: rect)
                context.fill(path, with: .color(.white.opacity(0.3)))
                
                // Bubble highlight
                let highlightRect = CGRect(
                    x: rect.minX + rect.width * 0.2,
                    y: rect.minY + rect.height * 0.2,
                    width: rect.width * 0.3,
                    height: rect.height * 0.3
                )
                let highlightPath = Path(ellipseIn: highlightRect)
                context.fill(highlightPath, with: .color(.white.opacity(0.5)))
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                animationPhase = 1.0
            }
        }
    }
}

/// Position data for a single bubble
struct BubblePosition: Identifiable {
    let id = UUID()
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    let speed: CGFloat
}

// MARK: - Surface Tension Layer

/// Renders the surface tension highlight effect.
struct SurfaceTensionLayer: View {
    let intensity: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            LinearGradient(
                colors: [
                    .white.opacity(intensity * 0.4),
                    .white.opacity(intensity * 0.1),
                    .clear
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 30)
            
            Spacer()
        }
    }
}

// MARK: - Aqua Button Style

/// A button style with aqua material appearance.
public struct AquaButtonStyle: ButtonStyle {
    let configuration: AquaMaterialConfiguration
    
    /// Creates an aqua button style
    public init(configuration: AquaMaterialConfiguration = .clearWater) {
        self.configuration = configuration
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background {
                AquaMaterialView(configuration: self.configuration)
                    .clipShape(Capsule())
                    .overlay {
                        Capsule()
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    }
            }
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Aqua Card

/// A card view with aqua material background.
public struct AquaCard<Content: View>: View {
    let configuration: AquaMaterialConfiguration
    let cornerRadius: CGFloat
    let content: Content
    
    /// Creates an aqua card
    public init(
        configuration: AquaMaterialConfiguration = .clearWater,
        cornerRadius: CGFloat = 16,
        @ViewBuilder content: () -> Content
    ) {
        self.configuration = configuration
        self.cornerRadius = cornerRadius
        self.content = content()
    }
    
    public var body: some View {
        content
            .background {
                AquaMaterialView(configuration: configuration)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                    }
                    .shadow(color: configuration.tintColor.opacity(0.3), radius: 10, y: 5)
            }
    }
}

// MARK: - Aqua Container

/// A container view with aqua material styling.
public struct AquaContainer<Content: View>: View {
    let configuration: AquaMaterialConfiguration
    let padding: CGFloat
    let cornerRadius: CGFloat
    let content: Content
    
    /// Creates an aqua container
    public init(
        configuration: AquaMaterialConfiguration = .clearWater,
        padding: CGFloat = 16,
        cornerRadius: CGFloat = 20,
        @ViewBuilder content: () -> Content
    ) {
        self.configuration = configuration
        self.padding = padding
        self.cornerRadius = cornerRadius
        self.content = content()
    }
    
    public var body: some View {
        content
            .padding(padding)
            .background {
                AquaMaterialView(configuration: configuration)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            }
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(
                            colors: [.white.opacity(0.4), .white.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            }
    }
}

// MARK: - Water Level Indicator

/// An indicator showing a water level with aqua material.
public struct WaterLevelIndicator: View {
    @Binding var level: CGFloat
    @State private var wavePhase: CGFloat = 0
    
    let configuration: AquaMaterialConfiguration
    let showPercentage: Bool
    
    /// Creates a water level indicator
    public init(
        level: Binding<CGFloat>,
        configuration: AquaMaterialConfiguration = .poolWater,
        showPercentage: Bool = true
    ) {
        self._level = level
        self.configuration = configuration
        self.showPercentage = showPercentage
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // Container
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                    }
                
                // Water fill
                ZStack {
                    // Wave shape
                    WaveShape(
                        configuration: WaveConfiguration(
                            amplitude: 8,
                            frequency: 2,
                            color: configuration.tintColor
                        ),
                        animationPhase: wavePhase
                    )
                    .fill(configuration.tintColor.opacity(configuration.opacity))
                    
                    // Caustics overlay
                    AquaMaterialView(configuration: configuration)
                        .opacity(0.5)
                }
                .frame(height: geometry.size.height * level)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                // Percentage label
                if showPercentage {
                    Text("\(Int(level * 100))%")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                        .frame(maxHeight: .infinity)
                }
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                wavePhase = 1.0
            }
        }
    }
}

// MARK: - Aqua Toggle Style

/// A toggle style with aqua material appearance.
public struct AquaToggleStyle: ToggleStyle {
    let onColor: AquaMaterialConfiguration
    let offColor: Color
    
    /// Creates an aqua toggle style
    public init(
        onColor: AquaMaterialConfiguration = .poolWater,
        offColor: Color = .gray.opacity(0.3)
    ) {
        self.onColor = onColor
        self.offColor = offColor
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            Spacer()
            
            ZStack {
                Capsule()
                    .fill(configuration.isOn ? AnyShapeStyle(.clear) : AnyShapeStyle(offColor))
                    .frame(width: 51, height: 31)
                    .overlay {
                        if configuration.isOn {
                            AquaMaterialView(configuration: onColor)
                                .clipShape(Capsule())
                        }
                    }
                    .overlay {
                        Capsule()
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                    }
                
                Circle()
                    .fill(.white)
                    .shadow(radius: 2)
                    .frame(width: 27, height: 27)
                    .offset(x: configuration.isOn ? 10 : -10)
            }
            .onTapGesture {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    configuration.isOn.toggle()
                }
            }
        }
    }
}

// MARK: - View Extensions

public extension View {
    /// Applies an aqua material background to the view.
    func aquaMaterial(configuration: AquaMaterialConfiguration = .clearWater) -> some View {
        background {
            AquaMaterialView(configuration: configuration)
        }
    }
    
    /// Wraps the view in an aqua container.
    func aquaContainer(
        configuration: AquaMaterialConfiguration = .clearWater,
        padding: CGFloat = 16,
        cornerRadius: CGFloat = 20
    ) -> some View {
        AquaContainer(configuration: configuration, padding: padding, cornerRadius: cornerRadius) {
            self
        }
    }
}
