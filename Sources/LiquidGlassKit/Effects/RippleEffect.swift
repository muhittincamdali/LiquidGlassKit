//
//  RippleEffect.swift
//  LiquidGlassKit
//
//  Created by Muhittin Camdali on 2025.
//  Copyright © 2025 Muhittin Camdali. All rights reserved.
//

import SwiftUI

// MARK: - Ripple Configuration

/// Configuration options for ripple effects.
///
/// Use this struct to customize the appearance and behavior of ripple animations.
public struct RippleConfiguration: Equatable, Sendable {
    /// The color of the ripple
    public var color: Color
    
    /// The maximum radius the ripple will expand to
    public var maxRadius: CGFloat
    
    /// The duration of the ripple animation
    public var duration: TimeInterval
    
    /// The number of ripple rings to display
    public var ringCount: Int
    
    /// The delay between each ring
    public var ringDelay: TimeInterval
    
    /// The initial opacity of the ripple
    public var initialOpacity: CGFloat
    
    /// The final opacity of the ripple
    public var finalOpacity: CGFloat
    
    /// The stroke width of ripple rings
    public var strokeWidth: CGFloat
    
    /// Whether the ripple should fill instead of stroke
    public var filled: Bool
    
    /// The easing function for the animation
    public var easing: RippleEasing
    
    /// Creates a new ripple configuration with default values.
    public init(
        color: Color = .white.opacity(0.5),
        maxRadius: CGFloat = 100,
        duration: TimeInterval = 0.8,
        ringCount: Int = 1,
        ringDelay: TimeInterval = 0.15,
        initialOpacity: CGFloat = 0.8,
        finalOpacity: CGFloat = 0.0,
        strokeWidth: CGFloat = 2,
        filled: Bool = false,
        easing: RippleEasing = .easeOut
    ) {
        self.color = color
        self.maxRadius = maxRadius
        self.duration = duration
        self.ringCount = ringCount
        self.ringDelay = ringDelay
        self.initialOpacity = initialOpacity
        self.finalOpacity = finalOpacity
        self.strokeWidth = strokeWidth
        self.filled = filled
        self.easing = easing
    }
    
    /// Preset configuration for a subtle ripple effect
    public static let subtle = RippleConfiguration(
        color: .white.opacity(0.3),
        maxRadius: 60,
        duration: 0.6,
        ringCount: 1,
        initialOpacity: 0.5,
        strokeWidth: 1
    )
    
    /// Preset configuration for a pronounced ripple effect
    public static let pronounced = RippleConfiguration(
        color: .white.opacity(0.6),
        maxRadius: 150,
        duration: 1.0,
        ringCount: 3,
        ringDelay: 0.2,
        initialOpacity: 0.9,
        strokeWidth: 3
    )
    
    /// Preset configuration for a water drop ripple
    public static let waterDrop = RippleConfiguration(
        color: .blue.opacity(0.4),
        maxRadius: 120,
        duration: 1.2,
        ringCount: 4,
        ringDelay: 0.25,
        initialOpacity: 0.7,
        strokeWidth: 1.5,
        easing: .waterPhysics
    )
    
    /// Preset configuration for a filled pulse effect
    public static let pulse = RippleConfiguration(
        color: .white.opacity(0.4),
        maxRadius: 80,
        duration: 0.5,
        ringCount: 1,
        initialOpacity: 0.6,
        filled: true
    )
}

// MARK: - Ripple Easing

/// Easing functions for ripple animations.
public enum RippleEasing: String, CaseIterable, Sendable {
    /// Linear progression
    case linear
    
    /// Ease out - starts fast, ends slow
    case easeOut
    
    /// Ease in - starts slow, ends fast
    case easeIn
    
    /// Ease in and out
    case easeInOut
    
    /// Simulates water physics with deceleration
    case waterPhysics
    
    /// Spring-like motion
    case spring
    
    /// Returns the SwiftUI animation for this easing
    public var animation: Animation {
        switch self {
        case .linear:
            return .linear(duration: 1.0)
        case .easeOut:
            return .easeOut(duration: 1.0)
        case .easeIn:
            return .easeIn(duration: 1.0)
        case .easeInOut:
            return .easeInOut(duration: 1.0)
        case .waterPhysics:
            return .timingCurve(0.2, 0.8, 0.3, 1.0, duration: 1.0)
        case .spring:
            return .spring(response: 0.6, dampingFraction: 0.7)
        }
    }
    
    /// Applies the easing to a progress value
    public func apply(to progress: CGFloat) -> CGFloat {
        switch self {
        case .linear:
            return progress
        case .easeOut:
            return 1 - pow(1 - progress, 3)
        case .easeIn:
            return pow(progress, 3)
        case .easeInOut:
            return progress < 0.5
                ? 4 * pow(progress, 3)
                : 1 - pow(-2 * progress + 2, 3) / 2
        case .waterPhysics:
            return 1 - pow(1 - progress, 4)
        case .spring:
            let c4 = (2 * CGFloat.pi) / 3
            return progress == 0 ? 0 :
                   progress == 1 ? 1 :
                   pow(2, -10 * progress) * sin((progress * 10 - 0.75) * c4) + 1
        }
    }
}

// MARK: - Ripple State

/// Tracks the state of a single ripple animation.
@Observable
public final class RippleState: Identifiable {
    /// Unique identifier for the ripple
    public let id = UUID()
    
    /// The origin point of the ripple
    public var origin: CGPoint
    
    /// Current animation progress (0.0 to 1.0)
    public var progress: CGFloat = 0
    
    /// Whether the ripple animation is complete
    public var isComplete: Bool = false
    
    /// The configuration for this ripple
    public var configuration: RippleConfiguration
    
    /// Creates a new ripple state
    public init(origin: CGPoint, configuration: RippleConfiguration = RippleConfiguration()) {
        self.origin = origin
        self.configuration = configuration
    }
    
    /// Current radius based on progress
    public var currentRadius: CGFloat {
        configuration.easing.apply(to: progress) * configuration.maxRadius
    }
    
    /// Current opacity based on progress
    public var currentOpacity: CGFloat {
        let easedProgress = configuration.easing.apply(to: progress)
        return configuration.initialOpacity + (configuration.finalOpacity - configuration.initialOpacity) * easedProgress
    }
}

// MARK: - Ripple Manager

/// Manages multiple ripple animations within a view.
@Observable
public final class RippleManager {
    /// All active ripples
    public var ripples: [RippleState] = []
    
    /// The default configuration for new ripples
    public var defaultConfiguration: RippleConfiguration
    
    /// Maximum number of concurrent ripples
    public var maxConcurrentRipples: Int
    
    /// Creates a new ripple manager
    public init(
        defaultConfiguration: RippleConfiguration = RippleConfiguration(),
        maxConcurrentRipples: Int = 5
    ) {
        self.defaultConfiguration = defaultConfiguration
        self.maxConcurrentRipples = maxConcurrentRipples
    }
    
    /// Triggers a new ripple at the specified point
    public func trigger(at point: CGPoint, configuration: RippleConfiguration? = nil) {
        // Remove excess ripples if needed
        while ripples.count >= maxConcurrentRipples {
            if let oldest = ripples.first(where: { $0.isComplete }) {
                ripples.removeAll { $0.id == oldest.id }
            } else {
                ripples.removeFirst()
            }
        }
        
        let config = configuration ?? defaultConfiguration
        let ripple = RippleState(origin: point, configuration: config)
        ripples.append(ripple)
        
        // Animate the ripple
        animateRipple(ripple)
    }
    
    /// Removes all completed ripples
    public func cleanup() {
        ripples.removeAll { $0.isComplete }
    }
    
    /// Removes all ripples
    public func clear() {
        ripples.removeAll()
    }
    
    private func animateRipple(_ ripple: RippleState) {
        withAnimation(ripple.configuration.easing.animation.speed(1 / ripple.configuration.duration)) {
            ripple.progress = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + ripple.configuration.duration) {
            ripple.isComplete = true
            self.cleanup()
        }
    }
}

// MARK: - Ripple View

/// A view that displays ripple animations.
public struct RippleView: View {
    /// The ripple state to display
    let ripple: RippleState
    
    /// Creates a ripple view
    public init(ripple: RippleState) {
        self.ripple = ripple
    }
    
    public var body: some View {
        ZStack {
            ForEach(0..<ripple.configuration.ringCount, id: \.self) { index in
                RippleRing(
                    ripple: ripple,
                    ringIndex: index
                )
            }
        }
    }
}

// MARK: - Ripple Ring

/// A single ring within a ripple animation.
struct RippleRing: View {
    let ripple: RippleState
    let ringIndex: Int
    
    private var delayedProgress: CGFloat {
        let delay = CGFloat(ringIndex) * CGFloat(ripple.configuration.ringDelay / ripple.configuration.duration)
        let adjustedProgress = max(0, ripple.progress - delay) / (1 - delay)
        return min(1, max(0, adjustedProgress))
    }
    
    private var ringRadius: CGFloat {
        ripple.configuration.easing.apply(to: delayedProgress) * ripple.configuration.maxRadius
    }
    
    private var ringOpacity: CGFloat {
        let easedProgress = ripple.configuration.easing.apply(to: delayedProgress)
        return ripple.configuration.initialOpacity * (1 - easedProgress)
    }
    
    var body: some View {
        Circle()
            .stroke(
                ripple.configuration.color.opacity(ringOpacity),
                lineWidth: ripple.configuration.strokeWidth
            )
            .frame(width: ringRadius * 2, height: ringRadius * 2)
            .position(ripple.origin)
    }
}

// MARK: - Ripple Effect Modifier

/// A view modifier that adds ripple effects on tap.
public struct RippleEffectModifier: ViewModifier {
    /// The ripple manager
    @State private var manager: RippleManager
    
    /// The configuration for ripples
    let configuration: RippleConfiguration
    
    /// Whether ripples are enabled
    let enabled: Bool
    
    /// Creates a ripple effect modifier
    public init(configuration: RippleConfiguration = RippleConfiguration(), enabled: Bool = true) {
        self._manager = State(initialValue: RippleManager(defaultConfiguration: configuration))
        self.configuration = configuration
        self.enabled = enabled
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geometry in
                    ZStack {
                        ForEach(manager.ripples) { ripple in
                            RippleView(ripple: ripple)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture { location in
                        if enabled {
                            manager.trigger(at: location, configuration: configuration)
                        }
                    }
                }
            }
    }
}

// MARK: - Continuous Ripple Modifier

/// A view modifier that creates continuous ripple animations.
public struct ContinuousRippleModifier: ViewModifier {
    @State private var manager = RippleManager()
    @State private var timer: Timer?
    
    let configuration: RippleConfiguration
    let interval: TimeInterval
    let centerOrigin: Bool
    
    /// Creates a continuous ripple modifier
    public init(
        configuration: RippleConfiguration = RippleConfiguration(),
        interval: TimeInterval = 2.0,
        centerOrigin: Bool = true
    ) {
        self.configuration = configuration
        self.interval = interval
        self.centerOrigin = centerOrigin
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geometry in
                    ZStack {
                        ForEach(manager.ripples) { ripple in
                            RippleView(ripple: ripple)
                        }
                    }
                    .onAppear {
                        startContinuousRipples(in: geometry.size)
                    }
                    .onDisappear {
                        timer?.invalidate()
                    }
                }
            }
    }
    
    private func startContinuousRipples(in size: CGSize) {
        let origin = centerOrigin
            ? CGPoint(x: size.width / 2, y: size.height / 2)
            : CGPoint(
                x: CGFloat.random(in: 0...size.width),
                y: CGFloat.random(in: 0...size.height)
            )
        
        manager.trigger(at: origin, configuration: configuration)
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            let point = centerOrigin
                ? CGPoint(x: size.width / 2, y: size.height / 2)
                : CGPoint(
                    x: CGFloat.random(in: 0...size.width),
                    y: CGFloat.random(in: 0...size.height)
                )
            manager.trigger(at: point, configuration: configuration)
        }
    }
}

// MARK: - Interactive Ripple Modifier

/// A view modifier that creates ripples following touch movement.
public struct InteractiveRippleModifier: ViewModifier {
    @State private var manager = RippleManager(maxConcurrentRipples: 10)
    @State private var lastTriggerTime: Date = .distantPast
    
    let configuration: RippleConfiguration
    let triggerInterval: TimeInterval
    
    /// Creates an interactive ripple modifier
    public init(
        configuration: RippleConfiguration = .subtle,
        triggerInterval: TimeInterval = 0.1
    ) {
        self.configuration = configuration
        self.triggerInterval = triggerInterval
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geometry in
                    ZStack {
                        ForEach(manager.ripples) { ripple in
                            RippleView(ripple: ripple)
                        }
                    }
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let now = Date()
                                if now.timeIntervalSince(lastTriggerTime) >= triggerInterval {
                                    manager.trigger(at: value.location, configuration: configuration)
                                    lastTriggerTime = now
                                }
                            }
                    )
                }
            }
    }
}

// MARK: - Radial Ripple Effect

/// Creates a radial ripple effect emanating from a central point.
public struct RadialRippleEffect: View {
    @State private var animationProgress: CGFloat = 0
    
    let ringCount: Int
    let color: Color
    let maxRadius: CGFloat
    let duration: TimeInterval
    let autoStart: Bool
    
    /// Creates a radial ripple effect
    public init(
        ringCount: Int = 3,
        color: Color = .white.opacity(0.5),
        maxRadius: CGFloat = 100,
        duration: TimeInterval = 2.0,
        autoStart: Bool = true
    ) {
        self.ringCount = ringCount
        self.color = color
        self.maxRadius = maxRadius
        self.duration = duration
        self.autoStart = autoStart
    }
    
    public var body: some View {
        ZStack {
            ForEach(0..<ringCount, id: \.self) { index in
                Circle()
                    .stroke(color, lineWidth: 2)
                    .frame(width: ringRadius(for: index), height: ringRadius(for: index))
                    .opacity(ringOpacity(for: index))
            }
        }
        .onAppear {
            if autoStart {
                withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
                    animationProgress = 1.0
                }
            }
        }
    }
    
    private func ringRadius(for index: Int) -> CGFloat {
        let offset = CGFloat(index) / CGFloat(ringCount)
        let adjustedProgress = (animationProgress + offset).truncatingRemainder(dividingBy: 1.0)
        return adjustedProgress * maxRadius * 2
    }
    
    private func ringOpacity(for index: Int) -> CGFloat {
        let offset = CGFloat(index) / CGFloat(ringCount)
        let adjustedProgress = (animationProgress + offset).truncatingRemainder(dividingBy: 1.0)
        return 1.0 - adjustedProgress
    }
}

// MARK: - Ripple Button Style

/// A button style that displays ripple effects when pressed.
public struct RippleButtonStyle: ButtonStyle {
    let configuration: RippleConfiguration
    
    /// Creates a ripple button style
    public init(configuration: RippleConfiguration = RippleConfiguration()) {
        self.configuration = configuration
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        RippleButton(
            isPressed: configuration.isPressed,
            rippleConfiguration: self.configuration
        ) {
            configuration.label
        }
    }
}

/// Internal ripple button implementation
struct RippleButton<Label: View>: View {
    let isPressed: Bool
    let rippleConfiguration: RippleConfiguration
    let label: () -> Label
    
    @State private var manager = RippleManager()
    @State private var buttonSize: CGSize = .zero
    
    var body: some View {
        label()
            .background {
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            buttonSize = geometry.size
                        }
                        .onChange(of: geometry.size) { _, newSize in
                            buttonSize = newSize
                        }
                }
            }
            .overlay {
                ZStack {
                    ForEach(manager.ripples) { ripple in
                        RippleView(ripple: ripple)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .onChange(of: isPressed) { _, pressed in
                if pressed {
                    let center = CGPoint(x: buttonSize.width / 2, y: buttonSize.height / 2)
                    manager.trigger(at: center, configuration: rippleConfiguration)
                }
            }
    }
}

// MARK: - View Extensions

public extension View {
    /// Adds a ripple effect that triggers on tap.
    func rippleEffect(
        configuration: RippleConfiguration = RippleConfiguration(),
        enabled: Bool = true
    ) -> some View {
        modifier(RippleEffectModifier(configuration: configuration, enabled: enabled))
    }
    
    /// Adds continuous ripple animations.
    func continuousRipple(
        configuration: RippleConfiguration = RippleConfiguration(),
        interval: TimeInterval = 2.0,
        centerOrigin: Bool = true
    ) -> some View {
        modifier(ContinuousRippleModifier(
            configuration: configuration,
            interval: interval,
            centerOrigin: centerOrigin
        ))
    }
    
    /// Adds interactive ripples that follow touch movement.
    func interactiveRipple(
        configuration: RippleConfiguration = .subtle,
        triggerInterval: TimeInterval = 0.1
    ) -> some View {
        modifier(InteractiveRippleModifier(
            configuration: configuration,
            triggerInterval: triggerInterval
        ))
    }
}
