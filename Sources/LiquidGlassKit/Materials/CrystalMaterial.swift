//
//  CrystalMaterial.swift
//  LiquidGlassKit
//
//  Created by Muhittin Camdali on 2025.
//  Copyright © 2025 Muhittin Camdali. All rights reserved.
//

import SwiftUI

// MARK: - Crystal Material Configuration

/// Configuration for crystal-style materials.
///
/// Crystal materials simulate the appearance of glass, gems, and other
/// transparent crystalline structures with facets and light refraction.
public struct CrystalMaterialConfiguration: Equatable, Sendable {
    /// The base tint color of the crystal
    public var tintColor: Color
    
    /// The secondary color for gradient effects
    public var secondaryColor: Color
    
    /// The number of facets visible
    public var facetCount: Int
    
    /// The intensity of light refraction (0.0 to 1.0)
    public var refractionIntensity: CGFloat
    
    /// The intensity of specular highlights
    public var specularIntensity: CGFloat
    
    /// The overall transparency (0.0 to 1.0)
    public var transparency: CGFloat
    
    /// The blur radius for frosted effect
    public var blurRadius: CGFloat
    
    /// Whether to animate light reflections
    public var animateReflections: Bool
    
    /// The speed of reflection animation
    public var animationSpeed: CGFloat
    
    /// The intensity of inner glow
    public var innerGlowIntensity: CGFloat
    
    /// The color of inner glow
    public var innerGlowColor: Color
    
    /// The border thickness
    public var borderWidth: CGFloat
    
    /// The border color
    public var borderColor: Color
    
    /// Creates a new crystal material configuration
    public init(
        tintColor: Color = .white,
        secondaryColor: Color = .blue.opacity(0.3),
        facetCount: Int = 6,
        refractionIntensity: CGFloat = 0.3,
        specularIntensity: CGFloat = 0.8,
        transparency: CGFloat = 0.7,
        blurRadius: CGFloat = 8,
        animateReflections: Bool = true,
        animationSpeed: CGFloat = 1.0,
        innerGlowIntensity: CGFloat = 0.3,
        innerGlowColor: Color = .white,
        borderWidth: CGFloat = 1,
        borderColor: Color = .white.opacity(0.3)
    ) {
        self.tintColor = tintColor
        self.secondaryColor = secondaryColor
        self.facetCount = facetCount
        self.refractionIntensity = refractionIntensity
        self.specularIntensity = specularIntensity
        self.transparency = transparency
        self.blurRadius = blurRadius
        self.animateReflections = animateReflections
        self.animationSpeed = animationSpeed
        self.innerGlowIntensity = innerGlowIntensity
        self.innerGlowColor = innerGlowColor
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }
    
    /// Clear diamond preset
    public static let diamond = CrystalMaterialConfiguration(
        tintColor: .white,
        secondaryColor: .cyan.opacity(0.2),
        facetCount: 8,
        refractionIntensity: 0.5,
        specularIntensity: 1.0,
        transparency: 0.85,
        innerGlowIntensity: 0.4
    )
    
    /// Sapphire preset
    public static let sapphire = CrystalMaterialConfiguration(
        tintColor: Color(red: 0.1, green: 0.2, blue: 0.8),
        secondaryColor: .blue.opacity(0.4),
        facetCount: 6,
        refractionIntensity: 0.4,
        specularIntensity: 0.9,
        transparency: 0.75,
        innerGlowColor: .blue
    )
    
    /// Ruby preset
    public static let ruby = CrystalMaterialConfiguration(
        tintColor: Color(red: 0.8, green: 0.1, blue: 0.2),
        secondaryColor: .red.opacity(0.4),
        facetCount: 6,
        refractionIntensity: 0.35,
        specularIntensity: 0.85,
        transparency: 0.7,
        innerGlowColor: .red
    )
    
    /// Emerald preset
    public static let emerald = CrystalMaterialConfiguration(
        tintColor: Color(red: 0.1, green: 0.7, blue: 0.3),
        secondaryColor: .green.opacity(0.4),
        facetCount: 6,
        refractionIntensity: 0.3,
        specularIntensity: 0.8,
        transparency: 0.65,
        innerGlowColor: .green
    )
    
    /// Amethyst preset
    public static let amethyst = CrystalMaterialConfiguration(
        tintColor: Color(red: 0.6, green: 0.3, blue: 0.8),
        secondaryColor: .purple.opacity(0.4),
        facetCount: 6,
        refractionIntensity: 0.35,
        specularIntensity: 0.85,
        transparency: 0.7,
        innerGlowColor: .purple
    )
    
    /// Frosted glass preset
    public static let frostedGlass = CrystalMaterialConfiguration(
        tintColor: .white.opacity(0.8),
        secondaryColor: .white.opacity(0.2),
        facetCount: 0,
        refractionIntensity: 0.1,
        specularIntensity: 0.3,
        transparency: 0.5,
        blurRadius: 20,
        animateReflections: false,
        innerGlowIntensity: 0.1
    )
    
    /// Ice crystal preset
    public static let ice = CrystalMaterialConfiguration(
        tintColor: Color(red: 0.9, green: 0.95, blue: 1.0),
        secondaryColor: .cyan.opacity(0.3),
        facetCount: 6,
        refractionIntensity: 0.25,
        specularIntensity: 0.7,
        transparency: 0.6,
        innerGlowColor: .cyan.opacity(0.5)
    )
}

// MARK: - Crystal Material View

/// A view that renders a crystal material effect.
public struct CrystalMaterialView: View {
    @State private var reflectionPhase: CGFloat = 0
    
    let configuration: CrystalMaterialConfiguration
    
    /// Creates a crystal material view
    public init(configuration: CrystalMaterialConfiguration = CrystalMaterialConfiguration()) {
        self.configuration = configuration
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Base blur layer
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .blur(radius: configuration.blurRadius)
                
                // Gradient base
                LinearGradient(
                    colors: [
                        configuration.tintColor.opacity(configuration.transparency * 0.3),
                        configuration.secondaryColor.opacity(configuration.transparency * 0.5),
                        configuration.tintColor.opacity(configuration.transparency * 0.3)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Facets layer
                if configuration.facetCount > 0 {
                    FacetsLayer(
                        facetCount: configuration.facetCount,
                        refractionIntensity: configuration.refractionIntensity,
                        phase: reflectionPhase
                    )
                }
                
                // Specular highlights
                SpecularHighlightsLayer(
                    intensity: configuration.specularIntensity,
                    phase: reflectionPhase
                )
                
                // Inner glow
                if configuration.innerGlowIntensity > 0 {
                    InnerGlowLayer(
                        color: configuration.innerGlowColor,
                        intensity: configuration.innerGlowIntensity
                    )
                }
            }
            .onAppear {
                if configuration.animateReflections {
                    startAnimation()
                }
            }
        }
    }
    
    private func startAnimation() {
        withAnimation(.linear(duration: 8.0 / configuration.animationSpeed).repeatForever(autoreverses: false)) {
            reflectionPhase = 1.0
        }
    }
}

// MARK: - Facets Layer

/// Renders the faceted appearance of crystal materials.
struct FacetsLayer: View {
    let facetCount: Int
    let refractionIntensity: CGFloat
    let phase: CGFloat
    
    var body: some View {
        Canvas { context, size in
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            let maxRadius = min(size.width, size.height) / 2
            
            for i in 0..<facetCount {
                let angle = (CGFloat(i) / CGFloat(facetCount)) * 2 * .pi + phase * .pi
                let nextAngle = (CGFloat(i + 1) / CGFloat(facetCount)) * 2 * .pi + phase * .pi
                
                var path = Path()
                path.move(to: center)
                path.addLine(to: CGPoint(
                    x: center.x + cos(angle) * maxRadius * 1.5,
                    y: center.y + sin(angle) * maxRadius * 1.5
                ))
                path.addLine(to: CGPoint(
                    x: center.x + cos(nextAngle) * maxRadius * 1.5,
                    y: center.y + sin(nextAngle) * maxRadius * 1.5
                ))
                path.closeSubpath()
                
                let brightness = (sin(phase * .pi * 2 + CGFloat(i)) + 1) / 2 * refractionIntensity
                context.fill(path, with: .color(.white.opacity(brightness * 0.2)))
            }
        }
        .blendMode(.overlay)
    }
}

// MARK: - Specular Highlights Layer

/// Renders specular highlights for crystal materials.
struct SpecularHighlightsLayer: View {
    let intensity: CGFloat
    let phase: CGFloat
    
    var body: some View {
        Canvas { context, size in
            // Main specular highlight
            let highlightSize = CGSize(width: size.width * 0.4, height: size.height * 0.2)
            let highlightPosition = CGPoint(
                x: size.width * 0.3 + sin(phase * .pi * 2) * size.width * 0.1,
                y: size.height * 0.25 + cos(phase * .pi * 2) * size.height * 0.05
            )
            
            let highlightRect = CGRect(origin: highlightPosition, size: highlightSize)
            let highlightPath = Path(ellipseIn: highlightRect)
            
            context.fill(highlightPath, with: .linearGradient(
                Gradient(colors: [
                    .white.opacity(intensity * 0.6),
                    .white.opacity(0)
                ]),
                startPoint: CGPoint(x: highlightRect.minX, y: highlightRect.minY),
                endPoint: CGPoint(x: highlightRect.maxX, y: highlightRect.maxY)
            ))
            
            // Secondary highlights
            for i in 0..<3 {
                let offset = CGFloat(i) * 0.3
                let x = size.width * (0.6 + offset * 0.2) + sin(phase * .pi * 2 + offset) * 10
                let y = size.height * (0.3 + offset * 0.2) + cos(phase * .pi * 2 + offset) * 5
                let dotSize = (3 - CGFloat(i)) * 4
                
                let dotRect = CGRect(x: x, y: y, width: dotSize, height: dotSize)
                let dotPath = Path(ellipseIn: dotRect)
                context.fill(dotPath, with: .color(.white.opacity(intensity * 0.4)))
            }
        }
        .blendMode(.screen)
    }
}

// MARK: - Inner Glow Layer

/// Renders the inner glow effect for crystal materials.
struct InnerGlowLayer: View {
    let color: Color
    let intensity: CGFloat
    
    var body: some View {
        RadialGradient(
            colors: [
                color.opacity(intensity * 0.5),
                color.opacity(intensity * 0.2),
                .clear
            ],
            center: .center,
            startRadius: 0,
            endRadius: 200
        )
        .blendMode(.screen)
    }
}

// MARK: - Crystal Shape

/// A shape that renders a crystal-like polygon.
public struct CrystalShape: Shape {
    let sides: Int
    let irregularity: CGFloat
    
    /// Creates a crystal shape
    public init(sides: Int = 6, irregularity: CGFloat = 0.1) {
        self.sides = max(3, sides)
        self.irregularity = irregularity
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        for i in 0..<sides {
            let angle = (CGFloat(i) / CGFloat(sides)) * 2 * .pi - .pi / 2
            let variation = 1 + CGFloat.random(in: -irregularity...irregularity)
            let point = CGPoint(
                x: center.x + cos(angle) * radius * variation,
                y: center.y + sin(angle) * radius * variation
            )
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        
        path.closeSubpath()
        return path
    }
}

// MARK: - Crystal Card

/// A card view with crystal material background.
public struct CrystalCard<Content: View>: View {
    let configuration: CrystalMaterialConfiguration
    let cornerRadius: CGFloat
    let content: Content
    
    /// Creates a crystal card
    public init(
        configuration: CrystalMaterialConfiguration = .diamond,
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
                CrystalMaterialView(configuration: configuration)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(
                                configuration.borderColor,
                                lineWidth: configuration.borderWidth
                            )
                    }
                    .shadow(color: configuration.tintColor.opacity(0.3), radius: 15, y: 8)
            }
    }
}

// MARK: - Crystal Button Style

/// A button style with crystal material appearance.
public struct CrystalButtonStyle: ButtonStyle {
    let configuration: CrystalMaterialConfiguration
    let cornerRadius: CGFloat
    
    /// Creates a crystal button style
    public init(
        configuration: CrystalMaterialConfiguration = .diamond,
        cornerRadius: CGFloat = 12
    ) {
        self.configuration = configuration
        self.cornerRadius = cornerRadius
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background {
                CrystalMaterialView(configuration: self.configuration)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(.white.opacity(0.4), lineWidth: 1)
                    }
            }
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .brightness(configuration.isPressed ? 0.1 : 0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Crystal Badge

/// A badge view with crystal material styling.
public struct CrystalBadge: View {
    let text: String
    let configuration: CrystalMaterialConfiguration
    
    /// Creates a crystal badge
    public init(text: String, configuration: CrystalMaterialConfiguration = .diamond) {
        self.text = text
        self.configuration = configuration
    }
    
    public var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background {
                CrystalMaterialView(configuration: configuration)
                    .clipShape(Capsule())
                    .overlay {
                        Capsule()
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    }
            }
            .shadow(color: configuration.tintColor.opacity(0.4), radius: 5, y: 2)
    }
}

// MARK: - Crystal Icon Container

/// A container for icons with crystal material background.
public struct CrystalIconContainer<Content: View>: View {
    let configuration: CrystalMaterialConfiguration
    let size: CGFloat
    let shape: CrystalIconShape
    let content: Content
    
    /// Creates a crystal icon container
    public init(
        configuration: CrystalMaterialConfiguration = .diamond,
        size: CGFloat = 50,
        shape: CrystalIconShape = .circle,
        @ViewBuilder content: () -> Content
    ) {
        self.configuration = configuration
        self.size = size
        self.shape = shape
        self.content = content()
    }
    
    public var body: some View {
        content
            .frame(width: size, height: size)
            .background {
                CrystalMaterialView(configuration: configuration)
                    .clipShape(shape.shape)
                    .overlay {
                        shape.shape
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    }
            }
            .shadow(color: configuration.tintColor.opacity(0.3), radius: 8, y: 4)
    }
    
    /// Shape options for icon containers
    public enum CrystalIconShape {
        case circle
        case roundedSquare(cornerRadius: CGFloat)
        case hexagon
        case diamond
        
        @ViewBuilder
        var shape: some Shape {
            switch self {
            case .circle:
                Circle()
            case .roundedSquare(let radius):
                RoundedRectangle(cornerRadius: radius)
            case .hexagon:
                CrystalShape(sides: 6)
            case .diamond:
                CrystalShape(sides: 4)
            }
        }
    }
}

// MARK: - Gem Selection View

/// A view for selecting different gem/crystal types.
public struct GemSelectionView: View {
    @Binding var selectedGem: CrystalMaterialConfiguration
    
    let gems: [(name: String, config: CrystalMaterialConfiguration)]
    
    /// Creates a gem selection view with default gems
    public init(selectedGem: Binding<CrystalMaterialConfiguration>) {
        self._selectedGem = selectedGem
        self.gems = [
            ("Diamond", .diamond),
            ("Sapphire", .sapphire),
            ("Ruby", .ruby),
            ("Emerald", .emerald),
            ("Amethyst", .amethyst),
            ("Ice", .ice)
        ]
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(gems, id: \.name) { gem in
                    GemButton(
                        name: gem.name,
                        configuration: gem.config,
                        isSelected: selectedGem == gem.config
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedGem = gem.config
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

/// A button representing a single gem option
struct GemButton: View {
    let name: String
    let configuration: CrystalMaterialConfiguration
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Circle()
                    .fill(.clear)
                    .frame(width: 50, height: 50)
                    .background {
                        CrystalMaterialView(configuration: configuration)
                            .clipShape(Circle())
                    }
                    .overlay {
                        Circle()
                            .stroke(isSelected ? .white : .clear, lineWidth: 2)
                    }
                
                Text(name)
                    .font(.caption)
                    .foregroundColor(isSelected ? .primary : .secondary)
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Crystal Progress Ring

/// A progress ring with crystal material appearance.
public struct CrystalProgressRing: View {
    @Binding var progress: CGFloat
    @State private var shimmerPhase: CGFloat = 0
    
    let configuration: CrystalMaterialConfiguration
    let lineWidth: CGFloat
    let size: CGFloat
    
    /// Creates a crystal progress ring
    public init(
        progress: Binding<CGFloat>,
        configuration: CrystalMaterialConfiguration = .diamond,
        lineWidth: CGFloat = 8,
        size: CGFloat = 100
    ) {
        self._progress = progress
        self.configuration = configuration
        self.lineWidth = lineWidth
        self.size = size
    }
    
    public var body: some View {
        ZStack {
            // Background ring
            Circle()
                .stroke(
                    configuration.tintColor.opacity(0.2),
                    lineWidth: lineWidth
                )
            
            // Progress ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        colors: [
                            configuration.tintColor,
                            configuration.secondaryColor,
                            configuration.tintColor
                        ],
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            
            // Shimmer effect
            Circle()
                .trim(from: max(0, progress - 0.1), to: progress)
                .stroke(
                    .white.opacity(0.5),
                    style: StrokeStyle(lineWidth: lineWidth / 2, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .blur(radius: 2)
            
            // Center percentage
            Text("\(Int(progress * 100))%")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(configuration.tintColor)
        }
        .frame(width: size, height: size)
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                shimmerPhase = 1.0
            }
        }
    }
}

// MARK: - View Extensions

public extension View {
    /// Applies a crystal material background to the view.
    func crystalMaterial(configuration: CrystalMaterialConfiguration = .diamond) -> some View {
        background {
            CrystalMaterialView(configuration: configuration)
        }
    }
    
    /// Wraps the view in a crystal card.
    func crystalCard(
        configuration: CrystalMaterialConfiguration = .diamond,
        cornerRadius: CGFloat = 16
    ) -> some View {
        CrystalCard(configuration: configuration, cornerRadius: cornerRadius) {
            self
        }
    }
}
