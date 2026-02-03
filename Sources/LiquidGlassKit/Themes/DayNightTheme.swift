//
//  DayNightTheme.swift
//  LiquidGlassKit
//
//  Created by Muhittin Camdali on 2025.
//  Copyright © 2025 Muhittin Camdali. All rights reserved.
//

import SwiftUI

// MARK: - Day Night Theme Mode

/// Represents the current theme mode.
public enum DayNightMode: String, CaseIterable, Sendable {
    case day
    case night
    case sunrise
    case sunset
    case auto
    
    /// Returns the appropriate mode based on the current time
    public static var currentAutoMode: DayNightMode {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 5..<7:
            return .sunrise
        case 7..<18:
            return .day
        case 18..<20:
            return .sunset
        default:
            return .night
        }
    }
    
    /// The effective mode (resolves .auto to an actual mode)
    public var effectiveMode: DayNightMode {
        if self == .auto {
            return DayNightMode.currentAutoMode
        }
        return self
    }
}

// MARK: - Day Night Theme Configuration

/// Configuration for day/night themed appearances.
public struct DayNightThemeConfiguration: Equatable, Sendable {
    /// The current theme mode
    public var mode: DayNightMode
    
    /// Primary background color
    public var backgroundColor: Color
    
    /// Secondary background color for gradients
    public var secondaryBackgroundColor: Color
    
    /// Primary text color
    public var primaryTextColor: Color
    
    /// Secondary text color
    public var secondaryTextColor: Color
    
    /// Accent color for interactive elements
    public var accentColor: Color
    
    /// Glass material tint color
    public var glassTintColor: Color
    
    /// Glass material opacity
    public var glassOpacity: CGFloat
    
    /// Shadow color
    public var shadowColor: Color
    
    /// Shadow opacity
    public var shadowOpacity: CGFloat
    
    /// Whether to show ambient particles
    public var showAmbientParticles: Bool
    
    /// The type of ambient particles
    public var particleType: AmbientParticleType
    
    /// Animation intensity (0.0 to 1.0)
    public var animationIntensity: CGFloat
    
    /// Creates a new day/night theme configuration
    public init(
        mode: DayNightMode,
        backgroundColor: Color,
        secondaryBackgroundColor: Color,
        primaryTextColor: Color,
        secondaryTextColor: Color,
        accentColor: Color,
        glassTintColor: Color,
        glassOpacity: CGFloat,
        shadowColor: Color,
        shadowOpacity: CGFloat,
        showAmbientParticles: Bool = true,
        particleType: AmbientParticleType = .none,
        animationIntensity: CGFloat = 1.0
    ) {
        self.mode = mode
        self.backgroundColor = backgroundColor
        self.secondaryBackgroundColor = secondaryBackgroundColor
        self.primaryTextColor = primaryTextColor
        self.secondaryTextColor = secondaryTextColor
        self.accentColor = accentColor
        self.glassTintColor = glassTintColor
        self.glassOpacity = glassOpacity
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.showAmbientParticles = showAmbientParticles
        self.particleType = particleType
        self.animationIntensity = animationIntensity
    }
    
    /// Ambient particle type options
    public enum AmbientParticleType: String, CaseIterable, Sendable {
        case none
        case sunRays
        case stars
        case clouds
        case fireflies
        case snowflakes
        case raindrops
    }
    
    /// Day theme preset
    public static let day = DayNightThemeConfiguration(
        mode: .day,
        backgroundColor: Color(red: 0.95, green: 0.97, blue: 1.0),
        secondaryBackgroundColor: Color(red: 0.85, green: 0.92, blue: 1.0),
        primaryTextColor: Color(red: 0.1, green: 0.1, blue: 0.15),
        secondaryTextColor: Color(red: 0.4, green: 0.4, blue: 0.5),
        accentColor: Color(red: 0.2, green: 0.5, blue: 1.0),
        glassTintColor: .white,
        glassOpacity: 0.6,
        shadowColor: .black,
        shadowOpacity: 0.1,
        showAmbientParticles: true,
        particleType: .sunRays
    )
    
    /// Night theme preset
    public static let night = DayNightThemeConfiguration(
        mode: .night,
        backgroundColor: Color(red: 0.05, green: 0.05, blue: 0.15),
        secondaryBackgroundColor: Color(red: 0.1, green: 0.1, blue: 0.25),
        primaryTextColor: Color(red: 0.95, green: 0.95, blue: 1.0),
        secondaryTextColor: Color(red: 0.6, green: 0.6, blue: 0.7),
        accentColor: Color(red: 0.4, green: 0.6, blue: 1.0),
        glassTintColor: Color(red: 0.2, green: 0.2, blue: 0.4),
        glassOpacity: 0.4,
        shadowColor: .black,
        shadowOpacity: 0.3,
        showAmbientParticles: true,
        particleType: .stars
    )
    
    /// Sunrise theme preset
    public static let sunrise = DayNightThemeConfiguration(
        mode: .sunrise,
        backgroundColor: Color(red: 1.0, green: 0.85, blue: 0.75),
        secondaryBackgroundColor: Color(red: 1.0, green: 0.7, blue: 0.6),
        primaryTextColor: Color(red: 0.2, green: 0.15, blue: 0.1),
        secondaryTextColor: Color(red: 0.5, green: 0.4, blue: 0.35),
        accentColor: Color(red: 1.0, green: 0.5, blue: 0.3),
        glassTintColor: Color(red: 1.0, green: 0.9, blue: 0.8),
        glassOpacity: 0.5,
        shadowColor: Color(red: 0.3, green: 0.2, blue: 0.1),
        shadowOpacity: 0.15,
        showAmbientParticles: true,
        particleType: .clouds
    )
    
    /// Sunset theme preset
    public static let sunset = DayNightThemeConfiguration(
        mode: .sunset,
        backgroundColor: Color(red: 0.3, green: 0.2, blue: 0.4),
        secondaryBackgroundColor: Color(red: 0.6, green: 0.3, blue: 0.4),
        primaryTextColor: Color(red: 1.0, green: 0.95, blue: 0.9),
        secondaryTextColor: Color(red: 0.8, green: 0.7, blue: 0.6),
        accentColor: Color(red: 1.0, green: 0.6, blue: 0.4),
        glassTintColor: Color(red: 0.5, green: 0.3, blue: 0.4),
        glassOpacity: 0.45,
        shadowColor: Color(red: 0.2, green: 0.1, blue: 0.2),
        shadowOpacity: 0.25,
        showAmbientParticles: true,
        particleType: .fireflies
    )
    
    /// Returns the configuration for a given mode
    public static func configuration(for mode: DayNightMode) -> DayNightThemeConfiguration {
        switch mode.effectiveMode {
        case .day:
            return .day
        case .night:
            return .night
        case .sunrise:
            return .sunrise
        case .sunset:
            return .sunset
        case .auto:
            return configuration(for: .currentAutoMode)
        }
    }
}

// MARK: - Day Night Theme Manager

/// Manages the current day/night theme state.
@Observable
public final class DayNightThemeManager {
    /// Shared instance for app-wide theme management
    public static let shared = DayNightThemeManager()
    
    /// The current theme mode
    public var mode: DayNightMode = .auto {
        didSet {
            updateConfiguration()
        }
    }
    
    /// The current theme configuration
    public private(set) var configuration: DayNightThemeConfiguration
    
    /// Whether to animate theme transitions
    public var animateTransitions: Bool = true
    
    /// The duration of theme transition animations
    public var transitionDuration: TimeInterval = 0.5
    
    /// Timer for auto-updating based on time
    private var autoUpdateTimer: Timer?
    
    /// Creates a new theme manager
    public init(mode: DayNightMode = .auto) {
        self.mode = mode
        self.configuration = DayNightThemeConfiguration.configuration(for: mode)
        
        if mode == .auto {
            startAutoUpdate()
        }
    }
    
    /// Updates the configuration based on current mode
    private func updateConfiguration() {
        let newConfig = DayNightThemeConfiguration.configuration(for: mode)
        
        if animateTransitions {
            withAnimation(.easeInOut(duration: transitionDuration)) {
                configuration = newConfig
            }
        } else {
            configuration = newConfig
        }
        
        if mode == .auto {
            startAutoUpdate()
        } else {
            stopAutoUpdate()
        }
    }
    
    /// Starts automatic theme updates based on time
    private func startAutoUpdate() {
        stopAutoUpdate()
        
        autoUpdateTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.checkAutoUpdate()
        }
    }
    
    /// Stops automatic theme updates
    private func stopAutoUpdate() {
        autoUpdateTimer?.invalidate()
        autoUpdateTimer = nil
    }
    
    /// Checks if the auto theme should update
    private func checkAutoUpdate() {
        guard mode == .auto else { return }
        
        let newConfig = DayNightThemeConfiguration.configuration(for: .auto)
        if newConfig != configuration {
            if animateTransitions {
                withAnimation(.easeInOut(duration: transitionDuration)) {
                    configuration = newConfig
                }
            } else {
                configuration = newConfig
            }
        }
    }
    
    /// Cycles to the next theme mode
    public func cycleMode() {
        let modes: [DayNightMode] = [.day, .sunset, .night, .sunrise, .auto]
        if let currentIndex = modes.firstIndex(of: mode) {
            let nextIndex = (currentIndex + 1) % modes.count
            mode = modes[nextIndex]
        }
    }
}

// MARK: - Day Night Background View

/// A background view that changes based on the current theme.
public struct DayNightBackgroundView: View {
    let configuration: DayNightThemeConfiguration
    
    @State private var particlePhase: CGFloat = 0
    
    /// Creates a day/night background view
    public init(configuration: DayNightThemeConfiguration) {
        self.configuration = configuration
    }
    
    public var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                colors: [configuration.backgroundColor, configuration.secondaryBackgroundColor],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Ambient particles
            if configuration.showAmbientParticles {
                ambientParticlesView
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                particlePhase = 1.0
            }
        }
    }
    
    @ViewBuilder
    private var ambientParticlesView: some View {
        switch configuration.particleType {
        case .none:
            EmptyView()
        case .sunRays:
            SunRaysView(intensity: configuration.animationIntensity)
        case .stars:
            StarsView(phase: particlePhase)
        case .clouds:
            CloudsView(phase: particlePhase)
        case .fireflies:
            FirefliesView(phase: particlePhase)
        case .snowflakes:
            SnowflakesView(phase: particlePhase)
        case .raindrops:
            RaindropsView(phase: particlePhase)
        }
    }
}

// MARK: - Sun Rays View

/// Displays animated sun rays effect.
struct SunRaysView: View {
    let intensity: CGFloat
    
    @State private var rotation: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<12) { index in
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.yellow.opacity(0.3 * intensity), .clear],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 20, height: geometry.size.height)
                        .rotationEffect(.degrees(Double(index) * 30 + rotation))
                }
            }
            .position(x: geometry.size.width * 0.8, y: -50)
            .blur(radius: 30)
        }
        .onAppear {
            withAnimation(.linear(duration: 60).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

// MARK: - Stars View

/// Displays animated stars effect.
struct StarsView: View {
    let phase: CGFloat
    
    var body: some View {
        Canvas { context, size in
            let starCount = 100
            
            for i in 0..<starCount {
                let seed = Double(i * 7919) // Prime number for pseudo-randomness
                let x = CGFloat((sin(seed) + 1) / 2) * size.width
                let y = CGFloat((cos(seed * 1.3) + 1) / 2) * size.height
                let baseSize = CGFloat(1 + (sin(seed * 2.7) + 1) * 1.5)
                
                let twinkle = sin(phase * .pi * 4 + seed) * 0.5 + 0.5
                let starSize = baseSize * (0.5 + twinkle * 0.5)
                
                let rect = CGRect(x: x - starSize/2, y: y - starSize/2, width: starSize, height: starSize)
                let path = Path(ellipseIn: rect)
                
                context.fill(path, with: .color(.white.opacity(0.5 + twinkle * 0.5)))
            }
        }
    }
}

// MARK: - Clouds View

/// Displays animated clouds effect.
struct CloudsView: View {
    let phase: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<5) { index in
                CloudShape()
                    .fill(.white.opacity(0.3))
                    .frame(width: 150, height: 60)
                    .offset(
                        x: (phase * geometry.size.width * 2 + CGFloat(index * 200))
                            .truncatingRemainder(dividingBy: geometry.size.width + 200) - 100,
                        y: CGFloat(index * 80 + 50)
                    )
            }
        }
    }
}

/// A cloud-like shape
struct CloudShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        path.addEllipse(in: CGRect(x: 0, y: height * 0.3, width: width * 0.4, height: height * 0.7))
        path.addEllipse(in: CGRect(x: width * 0.2, y: 0, width: width * 0.5, height: height * 0.8))
        path.addEllipse(in: CGRect(x: width * 0.5, y: height * 0.2, width: width * 0.5, height: height * 0.8))
        
        return path
    }
}

// MARK: - Fireflies View

/// Displays animated fireflies effect.
struct FirefliesView: View {
    let phase: CGFloat
    
    var body: some View {
        Canvas { context, size in
            let fireflyCount = 30
            
            for i in 0..<fireflyCount {
                let seed = Double(i * 3571)
                let baseX = CGFloat((sin(seed) + 1) / 2) * size.width
                let baseY = CGFloat((cos(seed * 1.7) + 1) / 2) * size.height
                
                let wobbleX = sin(phase * .pi * 2 + seed) * 20
                let wobbleY = cos(phase * .pi * 2 + seed * 1.3) * 20
                
                let x = baseX + wobbleX
                let y = baseY + wobbleY
                
                let glow = (sin(phase * .pi * 4 + seed * 0.7) + 1) / 2
                let fireflySize: CGFloat = 3 + glow * 3
                
                // Glow
                let glowRect = CGRect(x: x - 10, y: y - 10, width: 20, height: 20)
                context.fill(
                    Path(ellipseIn: glowRect),
                    with: .color(Color.yellow.opacity(glow * 0.3))
                )
                
                // Core
                let coreRect = CGRect(x: x - fireflySize/2, y: y - fireflySize/2, width: fireflySize, height: fireflySize)
                context.fill(
                    Path(ellipseIn: coreRect),
                    with: .color(Color.yellow.opacity(0.5 + glow * 0.5))
                )
            }
        }
    }
}

// MARK: - Snowflakes View

/// Displays animated snowflakes effect.
struct SnowflakesView: View {
    let phase: CGFloat
    
    var body: some View {
        Canvas { context, size in
            let snowflakeCount = 50
            
            for i in 0..<snowflakeCount {
                let seed = Double(i * 4217)
                let x = CGFloat((sin(seed) + 1) / 2) * size.width + sin(phase * .pi * 2 + seed) * 30
                let fallProgress = (phase + CGFloat(seed.truncatingRemainder(dividingBy: 1))).truncatingRemainder(dividingBy: 1)
                let y = fallProgress * (size.height + 20) - 10
                
                let snowflakeSize = CGFloat(2 + (sin(seed * 2.3) + 1) * 2)
                let rect = CGRect(x: x - snowflakeSize/2, y: y - snowflakeSize/2, width: snowflakeSize, height: snowflakeSize)
                
                context.fill(Path(ellipseIn: rect), with: .color(.white.opacity(0.7)))
            }
        }
    }
}

// MARK: - Raindrops View

/// Displays animated raindrops effect.
struct RaindropsView: View {
    let phase: CGFloat
    
    var body: some View {
        Canvas { context, size in
            let raindropCount = 80
            
            for i in 0..<raindropCount {
                let seed = Double(i * 2953)
                let x = CGFloat((sin(seed) + 1) / 2) * size.width
                let fallProgress = (phase * 3 + CGFloat(seed.truncatingRemainder(dividingBy: 1))).truncatingRemainder(dividingBy: 1)
                let y = fallProgress * (size.height + 50) - 25
                
                let raindropLength: CGFloat = 15 + CGFloat(sin(seed * 1.7) + 1) * 10
                
                var path = Path()
                path.move(to: CGPoint(x: x, y: y))
                path.addLine(to: CGPoint(x: x - 2, y: y + raindropLength))
                
                context.stroke(path, with: .color(.white.opacity(0.3)), lineWidth: 1)
            }
        }
    }
}

// MARK: - Theme Toggle Button

/// A button for toggling between day/night themes.
public struct DayNightToggleButton: View {
    @Binding var mode: DayNightMode
    
    let showLabel: Bool
    
    /// Creates a day/night toggle button
    public init(mode: Binding<DayNightMode>, showLabel: Bool = true) {
        self._mode = mode
        self.showLabel = showLabel
    }
    
    public var body: some View {
        Button {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                cycleMode()
            }
        } label: {
            HStack(spacing: 8) {
                Image(systemName: iconName)
                    .font(.title2)
                    .symbolRenderingMode(.hierarchical)
                
                if showLabel {
                    Text(mode.rawValue.capitalized)
                        .font(.subheadline)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background {
                Capsule()
                    .fill(.ultraThinMaterial)
                    .overlay {
                        Capsule()
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                    }
            }
        }
        .buttonStyle(.plain)
    }
    
    private var iconName: String {
        switch mode.effectiveMode {
        case .day:
            return "sun.max.fill"
        case .night:
            return "moon.stars.fill"
        case .sunrise:
            return "sunrise.fill"
        case .sunset:
            return "sunset.fill"
        case .auto:
            return "clock.fill"
        }
    }
    
    private func cycleMode() {
        let modes: [DayNightMode] = [.day, .sunset, .night, .sunrise, .auto]
        if let currentIndex = modes.firstIndex(of: mode) {
            let nextIndex = (currentIndex + 1) % modes.count
            mode = modes[nextIndex]
        }
    }
}

// MARK: - Themed Glass Card

/// A glass card that adapts to the current theme.
public struct ThemedGlassCard<Content: View>: View {
    let configuration: DayNightThemeConfiguration
    let cornerRadius: CGFloat
    let content: Content
    
    /// Creates a themed glass card
    public init(
        configuration: DayNightThemeConfiguration,
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
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(configuration.glassTintColor.opacity(configuration.glassOpacity))
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                    }
                    .shadow(
                        color: configuration.shadowColor.opacity(configuration.shadowOpacity),
                        radius: 10,
                        y: 5
                    )
            }
    }
}

// MARK: - Environment Key

/// Environment key for accessing the current theme configuration
private struct DayNightThemeKey: EnvironmentKey {
    static let defaultValue = DayNightThemeConfiguration.day
}

public extension EnvironmentValues {
    /// The current day/night theme configuration
    var dayNightTheme: DayNightThemeConfiguration {
        get { self[DayNightThemeKey.self] }
        set { self[DayNightThemeKey.self] = newValue }
    }
}

// MARK: - View Extensions

public extension View {
    /// Applies a day/night themed background to the view.
    func dayNightBackground(configuration: DayNightThemeConfiguration) -> some View {
        background {
            DayNightBackgroundView(configuration: configuration)
        }
    }
    
    /// Applies the day/night theme to the environment.
    func dayNightTheme(_ configuration: DayNightThemeConfiguration) -> some View {
        environment(\.dayNightTheme, configuration)
    }
}
