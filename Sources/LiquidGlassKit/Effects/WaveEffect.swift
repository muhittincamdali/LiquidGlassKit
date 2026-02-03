//
//  WaveEffect.swift
//  LiquidGlassKit
//
//  Created by Muhittin Camdali on 2025.
//  Copyright © 2025 Muhittin Camdali. All rights reserved.
//

import SwiftUI

// MARK: - Wave Configuration

/// Configuration options for wave effects.
public struct WaveConfiguration: Equatable, Sendable {
    /// The amplitude of the wave (height)
    public var amplitude: CGFloat
    
    /// The frequency of the wave (number of peaks)
    public var frequency: CGFloat
    
    /// The phase offset of the wave
    public var phase: CGFloat
    
    /// The speed of wave animation (cycles per second)
    public var speed: CGFloat
    
    /// The color of the wave
    public var color: Color
    
    /// Whether to fill the wave or just stroke
    public var filled: Bool
    
    /// The stroke width when not filled
    public var strokeWidth: CGFloat
    
    /// The wave shape type
    public var waveType: WaveType
    
    /// Creates a new wave configuration
    public init(
        amplitude: CGFloat = 20,
        frequency: CGFloat = 2,
        phase: CGFloat = 0,
        speed: CGFloat = 1,
        color: Color = .blue.opacity(0.5),
        filled: Bool = true,
        strokeWidth: CGFloat = 2,
        waveType: WaveType = .sine
    ) {
        self.amplitude = amplitude
        self.frequency = frequency
        self.phase = phase
        self.speed = speed
        self.color = color
        self.filled = filled
        self.strokeWidth = strokeWidth
        self.waveType = waveType
    }
    
    /// Preset for gentle ocean waves
    public static let ocean = WaveConfiguration(
        amplitude: 15,
        frequency: 1.5,
        speed: 0.5,
        color: .blue.opacity(0.4),
        waveType: .sine
    )
    
    /// Preset for rapid water ripples
    public static let ripple = WaveConfiguration(
        amplitude: 8,
        frequency: 4,
        speed: 2,
        color: .cyan.opacity(0.3),
        waveType: .sine
    )
    
    /// Preset for sharp audio visualizer waves
    public static let audio = WaveConfiguration(
        amplitude: 30,
        frequency: 6,
        speed: 3,
        color: .purple.opacity(0.6),
        filled: false,
        strokeWidth: 3,
        waveType: .triangle
    )
    
    /// Preset for calm pond waves
    public static let pond = WaveConfiguration(
        amplitude: 10,
        frequency: 2,
        speed: 0.3,
        color: .teal.opacity(0.35),
        waveType: .dampedSine
    )
}

// MARK: - Wave Type

/// The mathematical function used to generate the wave shape.
public enum WaveType: String, CaseIterable, Sendable {
    /// Standard sine wave
    case sine
    
    /// Cosine wave (shifted sine)
    case cosine
    
    /// Triangle wave
    case triangle
    
    /// Square wave
    case square
    
    /// Sawtooth wave
    case sawtooth
    
    /// Dampened sine wave
    case dampedSine
    
    /// Noise-based organic wave
    case organic
    
    /// Calculates the Y value for a given X position
    public func calculate(x: CGFloat, frequency: CGFloat, phase: CGFloat, amplitude: CGFloat) -> CGFloat {
        let normalizedX = x * frequency * 2 * .pi + phase
        
        switch self {
        case .sine:
            return sin(normalizedX) * amplitude
        case .cosine:
            return cos(normalizedX) * amplitude
        case .triangle:
            return (2 * abs(2 * ((normalizedX / (2 * .pi)).truncatingRemainder(dividingBy: 1)) - 1) - 1) * amplitude
        case .square:
            return (sin(normalizedX) >= 0 ? 1 : -1) * amplitude
        case .sawtooth:
            return (2 * ((normalizedX / (2 * .pi)).truncatingRemainder(dividingBy: 1)) - 1) * amplitude
        case .dampedSine:
            let damping = exp(-x * 2)
            return sin(normalizedX) * amplitude * damping
        case .organic:
            let noise1 = sin(normalizedX)
            let noise2 = sin(normalizedX * 2.3 + 0.5) * 0.5
            let noise3 = sin(normalizedX * 0.7 - 0.3) * 0.3
            return (noise1 + noise2 + noise3) / 1.8 * amplitude
        }
    }
}

// MARK: - Wave Shape

/// A shape that renders a wave path.
public struct WaveShape: Shape {
    /// The wave configuration
    var configuration: WaveConfiguration
    
    /// The current animation phase
    var animationPhase: CGFloat
    
    public var animatableData: CGFloat {
        get { animationPhase }
        set { animationPhase = newValue }
    }
    
    /// Creates a wave shape
    public init(configuration: WaveConfiguration, animationPhase: CGFloat = 0) {
        self.configuration = configuration
        self.animationPhase = animationPhase
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let midY = rect.height / 2
        let step: CGFloat = 2 // pixels per step
        
        path.move(to: CGPoint(x: 0, y: midY))
        
        for x in stride(from: 0, through: rect.width, by: step) {
            let normalizedX = x / rect.width
            let phase = configuration.phase + animationPhase * 2 * .pi
            let y = configuration.waveType.calculate(
                x: normalizedX,
                frequency: configuration.frequency,
                phase: phase,
                amplitude: configuration.amplitude
            )
            path.addLine(to: CGPoint(x: x, y: midY + y))
        }
        
        if configuration.filled {
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.closeSubpath()
        }
        
        return path
    }
}

// MARK: - Animated Wave View

/// A view that displays an animated wave.
public struct AnimatedWaveView: View {
    @State private var animationPhase: CGFloat = 0
    
    let configuration: WaveConfiguration
    let autoAnimate: Bool
    
    /// Creates an animated wave view
    public init(configuration: WaveConfiguration = WaveConfiguration(), autoAnimate: Bool = true) {
        self.configuration = configuration
        self.autoAnimate = autoAnimate
    }
    
    public var body: some View {
        WaveShape(configuration: configuration, animationPhase: animationPhase)
            .fill(configuration.filled ? configuration.color : .clear)
            .overlay {
                if !configuration.filled {
                    WaveShape(configuration: configuration, animationPhase: animationPhase)
                        .stroke(configuration.color, lineWidth: configuration.strokeWidth)
                }
            }
            .onAppear {
                if autoAnimate {
                    startAnimation()
                }
            }
    }
    
    private func startAnimation() {
        let duration = 1.0 / configuration.speed
        withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
            animationPhase = 1.0
        }
    }
}

// MARK: - Multi-Layer Wave View

/// A view that displays multiple layered waves for depth effect.
public struct MultiLayerWaveView: View {
    let layers: [WaveConfiguration]
    let autoAnimate: Bool
    
    @State private var phases: [CGFloat]
    
    /// Creates a multi-layer wave view
    public init(layers: [WaveConfiguration], autoAnimate: Bool = true) {
        self.layers = layers
        self.autoAnimate = autoAnimate
        self._phases = State(initialValue: Array(repeating: 0, count: layers.count))
    }
    
    /// Creates a default ocean wave with multiple layers
    public static func ocean(baseColor: Color = .blue) -> MultiLayerWaveView {
        MultiLayerWaveView(layers: [
            WaveConfiguration(amplitude: 20, frequency: 1.2, speed: 0.4, color: baseColor.opacity(0.3)),
            WaveConfiguration(amplitude: 15, frequency: 1.8, speed: 0.6, color: baseColor.opacity(0.5)),
            WaveConfiguration(amplitude: 10, frequency: 2.5, speed: 0.8, color: baseColor.opacity(0.7))
        ])
    }
    
    public var body: some View {
        ZStack {
            ForEach(0..<layers.count, id: \.self) { index in
                WaveShape(configuration: layers[index], animationPhase: phases[index])
                    .fill(layers[index].color)
            }
        }
        .onAppear {
            if autoAnimate {
                startAnimations()
            }
        }
    }
    
    private func startAnimations() {
        for (index, layer) in layers.enumerated() {
            let duration = 1.0 / layer.speed
            withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
                phases[index] = 1.0
            }
        }
    }
}

// MARK: - Wave Container

/// A container that displays content above animated waves.
public struct WaveContainer<Content: View>: View {
    let waveConfiguration: WaveConfiguration
    let wavePosition: WavePosition
    let content: Content
    
    /// Creates a wave container
    public init(
        configuration: WaveConfiguration = .ocean,
        position: WavePosition = .bottom,
        @ViewBuilder content: () -> Content
    ) {
        self.waveConfiguration = configuration
        self.wavePosition = position
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            content
            
            AnimatedWaveView(configuration: waveConfiguration)
                .frame(height: waveConfiguration.amplitude * 4)
                .frame(maxHeight: .infinity, alignment: wavePosition.alignment)
        }
    }
    
    /// Position options for the wave
    public enum WavePosition {
        case top
        case bottom
        
        var alignment: Alignment {
            switch self {
            case .top: return .top
            case .bottom: return .bottom
            }
        }
    }
}

// MARK: - Interactive Wave

/// A wave that responds to touch input.
public struct InteractiveWaveView: View {
    @State private var touchPoint: CGPoint?
    @State private var basePhase: CGFloat = 0
    @State private var disturbance: CGFloat = 0
    
    let configuration: WaveConfiguration
    
    /// Creates an interactive wave view
    public init(configuration: WaveConfiguration = WaveConfiguration()) {
        self.configuration = configuration
    }
    
    public var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                let path = createInteractivePath(in: size)
                
                if configuration.filled {
                    context.fill(path, with: .color(configuration.color))
                } else {
                    context.stroke(path, with: .color(configuration.color), lineWidth: configuration.strokeWidth)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        touchPoint = value.location
                        withAnimation(.easeOut(duration: 0.3)) {
                            disturbance = 1.0
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.easeOut(duration: 0.8)) {
                            disturbance = 0
                            touchPoint = nil
                        }
                    }
            )
            .onAppear {
                withAnimation(.linear(duration: 1.0 / configuration.speed).repeatForever(autoreverses: false)) {
                    basePhase = 1.0
                }
            }
        }
    }
    
    private func createInteractivePath(in size: CGSize) -> Path {
        var path = Path()
        let midY = size.height / 2
        let step: CGFloat = 2
        
        path.move(to: CGPoint(x: 0, y: midY))
        
        for x in stride(from: 0, through: size.width, by: step) {
            let normalizedX = x / size.width
            let phase = configuration.phase + basePhase * 2 * .pi
            
            var y = configuration.waveType.calculate(
                x: normalizedX,
                frequency: configuration.frequency,
                phase: phase,
                amplitude: configuration.amplitude
            )
            
            // Add touch disturbance
            if let touch = touchPoint {
                let distance = abs(x - touch.x)
                let influence = max(0, 1 - distance / 100) * disturbance
                let touchOffset = sin(distance / 20) * configuration.amplitude * influence
                y += touchOffset
            }
            
            path.addLine(to: CGPoint(x: x, y: midY + y))
        }
        
        if configuration.filled {
            path.addLine(to: CGPoint(x: size.width, y: size.height))
            path.addLine(to: CGPoint(x: 0, y: size.height))
            path.closeSubpath()
        }
        
        return path
    }
}

// MARK: - Wave Progress View

/// A progress indicator using wave animation.
public struct WaveProgressView: View {
    @Binding var progress: CGFloat
    @State private var animationPhase: CGFloat = 0
    
    let configuration: WaveConfiguration
    let backgroundColor: Color
    let showPercentage: Bool
    
    /// Creates a wave progress view
    public init(
        progress: Binding<CGFloat>,
        configuration: WaveConfiguration = .ocean,
        backgroundColor: Color = .gray.opacity(0.2),
        showPercentage: Bool = true
    ) {
        self._progress = progress
        self.configuration = configuration
        self.backgroundColor = backgroundColor
        self.showPercentage = showPercentage
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                RoundedRectangle(cornerRadius: 20)
                    .fill(backgroundColor)
                
                // Wave fill
                WaveShape(configuration: configuration, animationPhase: animationPhase)
                    .fill(configuration.color)
                    .mask {
                        Rectangle()
                            .frame(height: geometry.size.height * progress)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                // Percentage text
                if showPercentage {
                    Text("\(Int(progress * 100))%")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 1.0 / configuration.speed).repeatForever(autoreverses: false)) {
                animationPhase = 1.0
            }
        }
    }
}

// MARK: - Circular Wave View

/// A wave effect in a circular container.
public struct CircularWaveView: View {
    @State private var animationPhase: CGFloat = 0
    
    let configuration: WaveConfiguration
    let fillLevel: CGFloat
    
    /// Creates a circular wave view
    public init(configuration: WaveConfiguration = .ocean, fillLevel: CGFloat = 0.5) {
        self.configuration = configuration
        self.fillLevel = fillLevel
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            
            ZStack {
                // Outer circle
                Circle()
                    .stroke(configuration.color.opacity(0.3), lineWidth: 2)
                
                // Wave fill
                WaveShape(configuration: configuration, animationPhase: animationPhase)
                    .fill(configuration.color)
                    .offset(y: size * (1 - fillLevel) / 2)
                    .clipShape(Circle())
            }
            .frame(width: size, height: size)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .onAppear {
            withAnimation(.linear(duration: 1.0 / configuration.speed).repeatForever(autoreverses: false)) {
                animationPhase = 1.0
            }
        }
    }
}

// MARK: - Wave Divider

/// A divider line with a wave animation.
public struct WaveDivider: View {
    @State private var animationPhase: CGFloat = 0
    
    let color: Color
    let amplitude: CGFloat
    let frequency: CGFloat
    let speed: CGFloat
    let thickness: CGFloat
    
    /// Creates a wave divider
    public init(
        color: Color = .secondary.opacity(0.5),
        amplitude: CGFloat = 5,
        frequency: CGFloat = 3,
        speed: CGFloat = 1,
        thickness: CGFloat = 2
    ) {
        self.color = color
        self.amplitude = amplitude
        self.frequency = frequency
        self.speed = speed
        self.thickness = thickness
    }
    
    public var body: some View {
        WaveShape(
            configuration: WaveConfiguration(
                amplitude: amplitude,
                frequency: frequency,
                speed: speed,
                color: color,
                filled: false,
                strokeWidth: thickness
            ),
            animationPhase: animationPhase
        )
        .stroke(color, lineWidth: thickness)
        .frame(height: amplitude * 2 + thickness)
        .onAppear {
            withAnimation(.linear(duration: 1.0 / speed).repeatForever(autoreverses: false)) {
                animationPhase = 1.0
            }
        }
    }
}

// MARK: - Wave Modifier

/// A view modifier that adds a wave effect to any view.
public struct WaveEffectModifier: ViewModifier {
    let configuration: WaveConfiguration
    let position: WaveContainer<EmptyView>.WavePosition
    
    /// Creates a wave effect modifier
    public init(
        configuration: WaveConfiguration = .ocean,
        position: WaveContainer<EmptyView>.WavePosition = .bottom
    ) {
        self.configuration = configuration
        self.position = position
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            AnimatedWaveView(configuration: configuration)
                .frame(height: configuration.amplitude * 4)
                .frame(maxHeight: .infinity, alignment: position.alignment)
                .allowsHitTesting(false)
        }
    }
}

// MARK: - View Extensions

public extension View {
    /// Adds a wave effect to the view.
    func waveEffect(
        configuration: WaveConfiguration = .ocean,
        position: WaveContainer<EmptyView>.WavePosition = .bottom
    ) -> some View {
        modifier(WaveEffectModifier(configuration: configuration, position: position))
    }
    
    /// Adds an ocean wave effect to the view.
    func oceanWave(color: Color = .blue, position: WaveContainer<EmptyView>.WavePosition = .bottom) -> some View {
        waveEffect(
            configuration: WaveConfiguration(
                amplitude: 15,
                frequency: 1.5,
                speed: 0.5,
                color: color.opacity(0.4)
            ),
            position: position
        )
    }
}
