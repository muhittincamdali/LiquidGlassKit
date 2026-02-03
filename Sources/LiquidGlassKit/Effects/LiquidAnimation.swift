//
//  LiquidAnimation.swift
//  LiquidGlassKit
//
//  Created by Muhittin Camdali on 2025.
//  Copyright © 2025 Muhittin Camdali. All rights reserved.
//

import SwiftUI
import Combine

// MARK: - Liquid Animation Protocol

/// Protocol defining the core requirements for liquid-based animations.
///
/// Conform to this protocol to create custom liquid animations that integrate
/// seamlessly with the LiquidGlassKit animation system.
public protocol LiquidAnimatable {
    /// The current animation progress from 0.0 to 1.0
    var progress: CGFloat { get set }
    
    /// The animation timing curve
    var timingCurve: LiquidTimingCurve { get }
    
    /// Whether the animation should auto-reverse
    var autoReverses: Bool { get }
    
    /// The number of times the animation should repeat
    var repeatCount: Int { get }
    
    /// Updates the animation state based on current progress
    func updateAnimation(progress: CGFloat)
    
    /// Resets the animation to its initial state
    func reset()
}

// MARK: - Liquid Timing Curve

/// Timing curves specifically designed for liquid-like motion.
///
/// These curves simulate the natural movement of liquids, with emphasis
/// on viscosity, surface tension, and momentum.
public enum LiquidTimingCurve: Hashable, Sendable {
    /// Standard liquid motion with moderate viscosity
    case standard
    
    /// Heavy, syrup-like motion with high viscosity
    case viscous
    
    /// Light, water-like motion with low viscosity
    case fluid
    
    /// Quick splash followed by settling
    case splash
    
    /// Gentle ripple propagation
    case ripple
    
    /// Bouncy, elastic liquid motion
    case bouncy
    
    /// Mercury-like heavy but quick motion
    case mercury
    
    /// Custom bezier curve for advanced control
    case custom(c1: CGPoint, c2: CGPoint)
    
    /// Returns the animation curve for SwiftUI
    public var animation: Animation {
        switch self {
        case .standard:
            return .timingCurve(0.4, 0.0, 0.2, 1.0, duration: 0.5)
        case .viscous:
            return .timingCurve(0.7, 0.0, 0.3, 1.0, duration: 0.8)
        case .fluid:
            return .timingCurve(0.2, 0.0, 0.1, 1.0, duration: 0.35)
        case .splash:
            return .timingCurve(0.1, 0.8, 0.3, 1.0, duration: 0.4)
        case .ripple:
            return .timingCurve(0.3, 0.0, 0.4, 1.0, duration: 0.6)
        case .bouncy:
            return .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.2)
        case .mercury:
            return .timingCurve(0.6, 0.0, 0.15, 1.0, duration: 0.45)
        case .custom(let c1, let c2):
            return .timingCurve(c1.x, c1.y, c2.x, c2.y, duration: 0.5)
        }
    }
    
    /// Returns the duration for this timing curve
    public var duration: TimeInterval {
        switch self {
        case .standard: return 0.5
        case .viscous: return 0.8
        case .fluid: return 0.35
        case .splash: return 0.4
        case .ripple: return 0.6
        case .bouncy: return 0.7
        case .mercury: return 0.45
        case .custom: return 0.5
        }
    }
}

// MARK: - Liquid Animation State

/// Represents the current state of a liquid animation.
@Observable
public final class LiquidAnimationState {
    /// Current animation progress (0.0 to 1.0)
    public var progress: CGFloat = 0
    
    /// Whether the animation is currently running
    public var isAnimating: Bool = false
    
    /// The current phase of the animation
    public var phase: AnimationPhase = .idle
    
    /// Current velocity of the animation
    public var velocity: CGFloat = 0
    
    /// The amplitude of the liquid effect
    public var amplitude: CGFloat = 1.0
    
    /// The frequency of oscillation
    public var frequency: CGFloat = 1.0
    
    /// Damping factor for settling animations
    public var damping: CGFloat = 0.5
    
    /// Creates a new animation state with default values
    public init() {}
    
    /// Creates an animation state with custom initial values
    public init(amplitude: CGFloat, frequency: CGFloat, damping: CGFloat) {
        self.amplitude = amplitude
        self.frequency = frequency
        self.damping = damping
    }
    
    /// Animation phases for liquid effects
    public enum AnimationPhase: String, CaseIterable, Sendable {
        case idle
        case starting
        case active
        case settling
        case completed
    }
}

// MARK: - Liquid Animation Controller

/// Controls and coordinates liquid animations across multiple views.
///
/// Use this controller to synchronize animations, create complex sequences,
/// and manage animation state across your application.
@Observable
public final class LiquidAnimationController {
    /// Shared instance for app-wide animation coordination
    public static let shared = LiquidAnimationController()
    
    /// All registered animation states
    private var registeredAnimations: [String: LiquidAnimationState] = [:]
    
    /// Animation sequences currently playing
    private var activeSequences: [String: AnimationSequence] = [:]
    
    /// Global animation speed multiplier
    public var globalSpeed: CGFloat = 1.0
    
    /// Whether animations are globally enabled
    public var animationsEnabled: Bool = true
    
    /// Reduce motion preference
    public var reducedMotion: Bool = false
    
    /// Creates a new animation controller
    public init() {
        setupReducedMotionObserver()
    }
    
    /// Registers an animation state with a unique identifier
    public func register(_ state: LiquidAnimationState, id: String) {
        registeredAnimations[id] = state
    }
    
    /// Unregisters an animation state
    public func unregister(id: String) {
        registeredAnimations.removeValue(forKey: id)
    }
    
    /// Retrieves a registered animation state
    public func state(for id: String) -> LiquidAnimationState? {
        registeredAnimations[id]
    }
    
    /// Triggers an animation by ID
    public func trigger(id: String, completion: (() -> Void)? = nil) {
        guard animationsEnabled, let state = registeredAnimations[id] else { return }
        
        state.phase = .starting
        state.isAnimating = true
        
        withAnimation(.easeInOut(duration: 0.5 / globalSpeed)) {
            state.progress = 1.0
            state.phase = .active
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 / globalSpeed) {
            state.phase = .settling
            
            withAnimation(.easeOut(duration: 0.3 / self.globalSpeed)) {
                state.phase = .completed
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 / self.globalSpeed) {
                state.isAnimating = false
                completion?()
            }
        }
    }
    
    /// Resets an animation by ID
    public func reset(id: String) {
        guard let state = registeredAnimations[id] else { return }
        
        state.progress = 0
        state.isAnimating = false
        state.phase = .idle
        state.velocity = 0
    }
    
    /// Resets all registered animations
    public func resetAll() {
        for id in registeredAnimations.keys {
            reset(id: id)
        }
    }
    
    /// Plays an animation sequence
    public func playSequence(_ sequence: AnimationSequence, id: String) {
        activeSequences[id] = sequence
        executeSequence(sequence, at: 0, id: id)
    }
    
    /// Stops a playing sequence
    public func stopSequence(id: String) {
        activeSequences.removeValue(forKey: id)
    }
    
    private func executeSequence(_ sequence: AnimationSequence, at index: Int, id: String) {
        guard index < sequence.steps.count, activeSequences[id] != nil else {
            activeSequences.removeValue(forKey: id)
            return
        }
        
        let step = sequence.steps[index]
        
        switch step {
        case .animate(let animationId, let duration):
            trigger(id: animationId) {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    self.executeSequence(sequence, at: index + 1, id: id)
                }
            }
        case .delay(let duration):
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.executeSequence(sequence, at: index + 1, id: id)
            }
        case .parallel(let animationIds):
            let group = DispatchGroup()
            for animId in animationIds {
                group.enter()
                trigger(id: animId) {
                    group.leave()
                }
            }
            group.notify(queue: .main) {
                self.executeSequence(sequence, at: index + 1, id: id)
            }
        case .reset(let animationId):
            reset(id: animationId)
            executeSequence(sequence, at: index + 1, id: id)
        }
    }
    
    private func setupReducedMotionObserver() {
        #if os(iOS)
        reducedMotion = UIAccessibility.isReduceMotionEnabled
        NotificationCenter.default.addObserver(
            forName: UIAccessibility.reduceMotionStatusDidChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.reducedMotion = UIAccessibility.isReduceMotionEnabled
        }
        #endif
    }
}

// MARK: - Animation Sequence

/// Defines a sequence of animation steps to be played in order.
public struct AnimationSequence: Sendable {
    /// The steps in this sequence
    public let steps: [SequenceStep]
    
    /// Creates a new animation sequence
    public init(steps: [SequenceStep]) {
        self.steps = steps
    }
    
    /// A single step in an animation sequence
    public enum SequenceStep: Sendable {
        /// Animate a specific animation ID with optional duration override
        case animate(id: String, duration: TimeInterval = 0)
        
        /// Delay before the next step
        case delay(TimeInterval)
        
        /// Run multiple animations in parallel
        case parallel([String])
        
        /// Reset an animation to its initial state
        case reset(id: String)
    }
}

// MARK: - Liquid Morph Animation

/// Provides morphing animations between different shapes with liquid-like transitions.
public struct LiquidMorphAnimation: ViewModifier {
    /// The current morph progress
    @State private var morphProgress: CGFloat = 0
    
    /// The source shape for morphing
    let sourceShape: MorphableShape
    
    /// The target shape for morphing
    let targetShape: MorphableShape
    
    /// Animation timing curve
    let timingCurve: LiquidTimingCurve
    
    /// Whether animation should auto-trigger
    let autoTrigger: Bool
    
    /// Creates a new liquid morph animation
    public init(
        from source: MorphableShape,
        to target: MorphableShape,
        timing: LiquidTimingCurve = .standard,
        autoTrigger: Bool = true
    ) {
        self.sourceShape = source
        self.targetShape = target
        self.timingCurve = timing
        self.autoTrigger = autoTrigger
    }
    
    public func body(content: Content) -> some View {
        content
            .clipShape(InterpolatedShape(
                source: sourceShape,
                target: targetShape,
                progress: morphProgress
            ))
            .onAppear {
                if autoTrigger {
                    withAnimation(timingCurve.animation) {
                        morphProgress = 1.0
                    }
                }
            }
    }
}

// MARK: - Morphable Shapes

/// Shapes that can be morphed between with liquid animations.
public enum MorphableShape: Hashable, Sendable {
    case circle
    case capsule
    case rectangle
    case roundedRectangle(cornerRadius: CGFloat)
    case blob(seed: Int)
    case custom(points: [CGPoint])
    
    /// Generates the path for this shape
    func path(in rect: CGRect) -> Path {
        switch self {
        case .circle:
            return Path(ellipseIn: rect)
        case .capsule:
            return Path(roundedRect: rect, cornerRadius: min(rect.width, rect.height) / 2)
        case .rectangle:
            return Path(rect)
        case .roundedRectangle(let radius):
            return Path(roundedRect: rect, cornerRadius: radius)
        case .blob(let seed):
            return blobPath(in: rect, seed: seed)
        case .custom(let points):
            return customPath(from: points, in: rect)
        }
    }
    
    private func blobPath(in rect: CGRect, seed: Int) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let pointCount = 8
        var points: [CGPoint] = []
        
        for i in 0..<pointCount {
            let angle = (CGFloat(i) / CGFloat(pointCount)) * 2 * .pi
            let variation = CGFloat((seed + i * 17) % 20) / 100.0
            let r = radius * (1.0 + variation - 0.1)
            let point = CGPoint(
                x: center.x + cos(angle) * r,
                y: center.y + sin(angle) * r
            )
            points.append(point)
        }
        
        path.move(to: points[0])
        for i in 0..<pointCount {
            let current = points[i]
            let next = points[(i + 1) % pointCount]
            let controlPoint1 = CGPoint(
                x: current.x + (next.x - current.x) * 0.5,
                y: current.y
            )
            let controlPoint2 = CGPoint(
                x: current.x + (next.x - current.x) * 0.5,
                y: next.y
            )
            path.addCurve(to: next, control1: controlPoint1, control2: controlPoint2)
        }
        path.closeSubpath()
        
        return path
    }
    
    private func customPath(from points: [CGPoint], in rect: CGRect) -> Path {
        guard !points.isEmpty else { return Path(rect) }
        
        var path = Path()
        let scaledPoints = points.map { point in
            CGPoint(x: point.x * rect.width, y: point.y * rect.height)
        }
        
        path.move(to: scaledPoints[0])
        for point in scaledPoints.dropFirst() {
            path.addLine(to: point)
        }
        path.closeSubpath()
        
        return path
    }
}

// MARK: - Interpolated Shape

/// A shape that interpolates between two morphable shapes.
public struct InterpolatedShape: Shape {
    let source: MorphableShape
    let target: MorphableShape
    var progress: CGFloat
    
    public var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    public func path(in rect: CGRect) -> Path {
        let sourcePath = source.path(in: rect)
        let targetPath = target.path(in: rect)
        
        return interpolatePaths(source: sourcePath, target: targetPath, progress: progress)
    }
    
    private func interpolatePaths(source: Path, target: Path, progress: CGFloat) -> Path {
        // Simplified path interpolation
        var result = Path()
        
        let sourceRect = source.boundingRect
        let targetRect = target.boundingRect
        
        let interpolatedRect = CGRect(
            x: sourceRect.origin.x + (targetRect.origin.x - sourceRect.origin.x) * progress,
            y: sourceRect.origin.y + (targetRect.origin.y - sourceRect.origin.y) * progress,
            width: sourceRect.width + (targetRect.width - sourceRect.width) * progress,
            height: sourceRect.height + (targetRect.height - sourceRect.height) * progress
        )
        
        let cornerRadius = (1 - progress) * 0 + progress * min(interpolatedRect.width, interpolatedRect.height) / 4
        result.addRoundedRect(in: interpolatedRect, cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
        
        return result
    }
}

// MARK: - Liquid Drop Animation

/// Creates a liquid drop animation effect.
public struct LiquidDropAnimation: ViewModifier {
    @State private var dropProgress: CGFloat = 0
    @State private var bouncePhase: Int = 0
    
    let dropHeight: CGFloat
    let bounceCount: Int
    let timing: LiquidTimingCurve
    
    /// Creates a liquid drop animation
    public init(dropHeight: CGFloat = 50, bounceCount: Int = 3, timing: LiquidTimingCurve = .bouncy) {
        self.dropHeight = dropHeight
        self.bounceCount = bounceCount
        self.timing = timing
    }
    
    public func body(content: Content) -> some View {
        content
            .offset(y: calculateOffset())
            .scaleEffect(calculateScale())
            .onAppear {
                animateDrop()
            }
    }
    
    private func calculateOffset() -> CGFloat {
        if bouncePhase == 0 {
            return -dropHeight * (1 - dropProgress)
        }
        
        let bounceDecay = pow(0.6, CGFloat(bouncePhase))
        let bounceOffset = dropHeight * 0.3 * bounceDecay
        
        return bouncePhase % 2 == 1 ? -bounceOffset * dropProgress : bounceOffset * (1 - dropProgress)
    }
    
    private func calculateScale() -> CGSize {
        let squash = 1.0 + (dropProgress - 0.5) * 0.2
        let stretch = 1.0 - (dropProgress - 0.5) * 0.1
        
        if bouncePhase == 0 && dropProgress > 0.8 {
            return CGSize(width: 1.1, height: 0.9)
        }
        
        return CGSize(width: squash, height: stretch)
    }
    
    private func animateDrop() {
        withAnimation(timing.animation) {
            dropProgress = 1.0
        }
        
        for i in 1...bounceCount {
            let delay = timing.duration + Double(i) * 0.15
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.easeInOut(duration: 0.15)) {
                    bouncePhase = i
                    dropProgress = i % 2 == 1 ? 1.0 : 0.0
                }
            }
        }
    }
}

// MARK: - Liquid Pulse Animation

/// Creates a pulsing liquid effect animation.
public struct LiquidPulseAnimation: ViewModifier {
    @State private var pulseScale: CGFloat = 1.0
    @State private var pulseOpacity: CGFloat = 1.0
    
    let minScale: CGFloat
    let maxScale: CGFloat
    let duration: TimeInterval
    let repeats: Bool
    
    /// Creates a liquid pulse animation
    public init(
        minScale: CGFloat = 0.95,
        maxScale: CGFloat = 1.05,
        duration: TimeInterval = 1.0,
        repeats: Bool = true
    ) {
        self.minScale = minScale
        self.maxScale = maxScale
        self.duration = duration
        self.repeats = repeats
    }
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(pulseScale)
            .opacity(pulseOpacity)
            .onAppear {
                startPulsing()
            }
    }
    
    private func startPulsing() {
        let animation = Animation
            .easeInOut(duration: duration)
            .repeatForever(autoreverses: true)
        
        withAnimation(repeats ? animation : .easeInOut(duration: duration)) {
            pulseScale = maxScale
        }
    }
}

// MARK: - Liquid Wave Animation

/// Creates a wave-like liquid animation effect.
public struct LiquidWaveAnimation: ViewModifier {
    @State private var wavePhase: CGFloat = 0
    
    let amplitude: CGFloat
    let frequency: CGFloat
    let speed: TimeInterval
    
    /// Creates a liquid wave animation
    public init(amplitude: CGFloat = 10, frequency: CGFloat = 2, speed: TimeInterval = 2) {
        self.amplitude = amplitude
        self.frequency = frequency
        self.speed = speed
    }
    
    public func body(content: Content) -> some View {
        content
            .offset(y: sin(wavePhase * frequency * .pi * 2) * amplitude)
            .onAppear {
                withAnimation(.linear(duration: speed).repeatForever(autoreverses: false)) {
                    wavePhase = 1.0
                }
            }
    }
}

// MARK: - View Extensions

public extension View {
    /// Applies a liquid morph animation between shapes.
    func liquidMorph(
        from source: MorphableShape,
        to target: MorphableShape,
        timing: LiquidTimingCurve = .standard
    ) -> some View {
        modifier(LiquidMorphAnimation(from: source, to: target, timing: timing))
    }
    
    /// Applies a liquid drop animation.
    func liquidDrop(
        height: CGFloat = 50,
        bounces: Int = 3,
        timing: LiquidTimingCurve = .bouncy
    ) -> some View {
        modifier(LiquidDropAnimation(dropHeight: height, bounceCount: bounces, timing: timing))
    }
    
    /// Applies a liquid pulse animation.
    func liquidPulse(
        minScale: CGFloat = 0.95,
        maxScale: CGFloat = 1.05,
        duration: TimeInterval = 1.0,
        repeats: Bool = true
    ) -> some View {
        modifier(LiquidPulseAnimation(minScale: minScale, maxScale: maxScale, duration: duration, repeats: repeats))
    }
    
    /// Applies a liquid wave animation.
    func liquidWave(
        amplitude: CGFloat = 10,
        frequency: CGFloat = 2,
        speed: TimeInterval = 2
    ) -> some View {
        modifier(LiquidWaveAnimation(amplitude: amplitude, frequency: frequency, speed: speed))
    }
}
