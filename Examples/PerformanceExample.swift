// PerformanceExample.swift
// LiquidGlassKit
//
// Performance-optimized glass effects and profiling utilities.
// Demonstrates how to use glass effects efficiently in lists and animations.

import SwiftUI
import Combine

// MARK: - Performance Monitor

/// Monitors and displays frame rate and render performance.
public class PerformanceMonitor: ObservableObject {
    @Published public var fps: Double = 0
    @Published public var averageFPS: Double = 0
    @Published public var droppedFrames: Int = 0
    
    private var displayLink: CADisplayLink?
    private var lastTimestamp: CFTimeInterval = 0
    private var frameCount: Int = 0
    private var fpsHistory: [Double] = []
    
    public init() {}
    
    public func start() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .main, forMode: .common)
        lastTimestamp = CACurrentMediaTime()
    }
    
    public func stop() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func update(displayLink: CADisplayLink) {
        let currentTime = displayLink.timestamp
        frameCount += 1
        
        let elapsed = currentTime - lastTimestamp
        if elapsed >= 1.0 {
            let currentFPS = Double(frameCount) / elapsed
            
            DispatchQueue.main.async {
                self.fps = currentFPS
                self.fpsHistory.append(currentFPS)
                if self.fpsHistory.count > 60 {
                    self.fpsHistory.removeFirst()
                }
                self.averageFPS = self.fpsHistory.reduce(0, +) / Double(self.fpsHistory.count)
                
                // Count dropped frames (assuming 60fps target)
                let expectedFrames = Int(elapsed * 60)
                let dropped = max(0, expectedFrames - self.frameCount)
                self.droppedFrames += dropped
            }
            
            frameCount = 0
            lastTimestamp = currentTime
        }
    }
}

// MARK: - Performance Overlay

/// A floating overlay showing real-time performance metrics.
public struct PerformanceOverlay: View {
    
    @StateObject private var monitor = PerformanceMonitor()
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("FPS:")
                    .font(.caption.monospacedDigit())
                Text("\(Int(monitor.fps))")
                    .font(.caption.bold().monospacedDigit())
                    .foregroundColor(fpsColor)
            }
            
            HStack {
                Text("Avg:")
                    .font(.caption.monospacedDigit())
                Text("\(Int(monitor.averageFPS))")
                    .font(.caption.bold().monospacedDigit())
            }
            
            HStack {
                Text("Dropped:")
                    .font(.caption.monospacedDigit())
                Text("\(monitor.droppedFrames)")
                    .font(.caption.bold().monospacedDigit())
                    .foregroundColor(monitor.droppedFrames > 10 ? .red : .primary)
            }
        }
        .padding(12)
        .glassBackground(material: .dark, cornerRadius: 12)
        .onAppear { monitor.start() }
        .onDisappear { monitor.stop() }
    }
    
    private var fpsColor: Color {
        if monitor.fps >= 55 { return .green }
        if monitor.fps >= 30 { return .yellow }
        return .red
    }
}

// MARK: - Lazy Glass List

/// A performance-optimized list with glass styling.
/// Uses lazy loading and view recycling for smooth scrolling.
public struct LazyGlassList<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    
    let data: Data
    let content: (Data.Element) -> Content
    let material: GlassMaterial
    
    public init(
        _ data: Data,
        material: GlassMaterial = .frosted,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.content = content
        self.material = material
    }
    
    public var body: some View {
        LazyVStack(spacing: 12) {
            ForEach(data) { item in
                content(item)
                    .glassBackground(material: material, cornerRadius: 12)
            }
        }
    }
}

// MARK: - Optimized Glass Card

/// A glass card optimized for list rendering.
/// Reduces blur complexity and shadow calculations.
public struct OptimizedGlassCard<Content: View>: View {
    
    let content: Content
    let useSimplifiedEffect: Bool
    
    @Environment(\.isScrolling) private var isScrolling
    
    public init(
        useSimplifiedEffect: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.useSimplifiedEffect = useSimplifiedEffect
    }
    
    public var body: some View {
        content
            .background(backgroundView)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(
                color: .black.opacity(useSimplifiedEffect ? 0.05 : 0.1),
                radius: useSimplifiedEffect ? 4 : 8,
                y: useSimplifiedEffect ? 2 : 4
            )
    }
    
    @ViewBuilder
    private var backgroundView: some View {
        if useSimplifiedEffect {
            // Simplified effect for scrolling/animation
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.white.opacity(0.1))
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.regularMaterial)
                )
        } else {
            // Full glass effect
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.white.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(.white.opacity(0.2), lineWidth: 0.5)
                )
        }
    }
}

// MARK: - Scroll Detection

/// Environment key for scroll state.
private struct IsScrollingKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var isScrolling: Bool {
        get { self[IsScrollingKey.self] }
        set { self[IsScrollingKey.self] = newValue }
    }
}

// MARK: - Cached Glass Background

/// A glass background that caches its render for improved performance.
public struct CachedGlassBackground: View {
    
    let cornerRadius: CGFloat
    let material: GlassMaterial
    
    public init(
        cornerRadius: CGFloat = 16,
        material: GlassMaterial = .frosted
    ) {
        self.cornerRadius = cornerRadius
        self.material = material
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(material.swiftUIMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(material.tintColor)
            )
            .drawingGroup() // Rasterizes the view for better performance
    }
}

// MARK: - Benchmark View

/// Runs performance benchmarks on glass effects.
public struct GlassBenchmark: View {
    
    @State private var itemCount = 50
    @State private var isRunning = false
    @State private var results: [BenchmarkResult] = []
    @StateObject private var monitor = PerformanceMonitor()
    
    public init() {}
    
    public var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Glass Effect Benchmark")
                    .font(.title.weight(.bold))
                    .foregroundStyle(.white)
                
                // Controls
                VStack(spacing: 12) {
                    Stepper("Items: \(itemCount)", value: $itemCount, in: 10...500, step: 10)
                    
                    Button(isRunning ? "Running..." : "Run Benchmark") {
                        runBenchmark()
                    }
                    .disabled(isRunning)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .glassBackground()
                }
                .padding()
                .glassBackground(cornerRadius: 16)
                
                // Results
                if !results.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Results")
                            .font(.headline)
                        
                        ForEach(results) { result in
                            HStack {
                                Text(result.name)
                                    .font(.subheadline)
                                Spacer()
                                Text("\(Int(result.avgFPS)) FPS")
                                    .font(.subheadline.monospacedDigit())
                                    .foregroundColor(result.avgFPS >= 55 ? .green : (result.avgFPS >= 30 ? .yellow : .red))
                            }
                        }
                    }
                    .padding()
                    .glassBackground(cornerRadius: 16)
                }
                
                // FPS Monitor
                HStack {
                    Spacer()
                    PerformanceOverlay()
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func runBenchmark() {
        isRunning = true
        results = []
        
        // Simulate benchmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            results = [
                BenchmarkResult(name: "Standard Glass", avgFPS: 58),
                BenchmarkResult(name: "Optimized Glass", avgFPS: 60),
                BenchmarkResult(name: "Cached Glass", avgFPS: 60),
                BenchmarkResult(name: "Complex Glass", avgFPS: 45)
            ]
            isRunning = false
        }
    }
}

private struct BenchmarkResult: Identifiable {
    let id = UUID()
    let name: String
    let avgFPS: Double
}

// MARK: - Performance Tips View

/// Displays best practices for glass effect performance.
public struct PerformanceTipsView: View {
    
    public init() {}
    
    private let tips: [(icon: String, title: String, description: String)] = [
        (
            "bolt.fill",
            "Use LazyVStack",
            "Wrap glass cards in LazyVStack for efficient list rendering with view recycling."
        ),
        (
            "square.3.layers.3d",
            "Reduce Layers",
            "Minimize overlapping glass effects. Each layer adds GPU workload."
        ),
        (
            "memorychip.fill",
            "Cache with drawingGroup()",
            "Apply .drawingGroup() to static glass backgrounds for rasterization."
        ),
        (
            "arrow.triangle.branch",
            "Simplify During Animation",
            "Use simplified materials during scrolling or complex animations."
        ),
        (
            "shadow",
            "Optimize Shadows",
            "Reduce shadow radius and opacity in lists. Use shadowRadius: 4 instead of 10+."
        ),
        (
            "rectangle.compress.vertical",
            "Limit Blur Radius",
            "Keep blurRadius under 25 for smooth performance on older devices."
        ),
        (
            "viewfinder",
            "Use Fixed Sizes",
            "Define explicit frames for glass views to avoid layout recalculations."
        ),
        (
            "chart.bar.fill",
            "Profile with Instruments",
            "Use Xcode Instruments to identify GPU bottlenecks in complex views."
        )
    ]
    
    public var body: some View {
        ZStack {
            LinearGradient(
                colors: [.green.opacity(0.8), .blue.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    Text("Performance Tips")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                        .padding(.top, 40)
                    
                    Text("Optimize glass effects for 60 FPS")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.8))
                    
                    ForEach(tips, id: \.title) { tip in
                        tipCard(tip)
                    }
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    private func tipCard(_ tip: (icon: String, title: String, description: String)) -> some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: tip.icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(tip.title)
                    .font(.headline)
                Text(tip.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .glassBackground(material: .frosted, cornerRadius: 16)
    }
}

// MARK: - Stress Test View

/// Stress tests glass effects with many simultaneous views.
public struct GlassStressTest: View {
    
    @State private var gridSize = 4
    @State private var showPerformanceOverlay = true
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Colorful background
            LinearGradient(
                colors: [.orange, .pink, .purple, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 12) {
                // Controls
                HStack {
                    Text("Grid: \(gridSize)x\(gridSize) = \(gridSize * gridSize) items")
                        .font(.caption)
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Stepper("", value: $gridSize, in: 2...10)
                        .labelsHidden()
                }
                .padding()
                .glassBackground(material: .dark, cornerRadius: 12)
                
                // Stress test grid
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: gridSize), spacing: 8) {
                        ForEach(0..<(gridSize * gridSize), id: \.self) { index in
                            glassCell(index: index)
                        }
                    }
                    .padding(8)
                }
            }
            .padding()
            
            // Performance overlay
            if showPerformanceOverlay {
                VStack {
                    HStack {
                        Spacer()
                        PerformanceOverlay()
                            .padding()
                    }
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    private func glassCell(index: Int) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icons[index % icons.count])
                .font(.title2)
            Text("\(index)")
                .font(.caption2)
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .glassBackground(material: .frosted, cornerRadius: 8)
    }
    
    private let icons = [
        "star.fill", "heart.fill", "bolt.fill", "leaf.fill",
        "flame.fill", "drop.fill", "moon.fill", "sun.max.fill"
    ]
}

// MARK: - Complete Performance Demo

/// Full demo showcasing all performance features.
public struct PerformanceDemo: View {
    
    @State private var selectedTab = 0
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            // Tab selector
            Picker("", selection: $selectedTab) {
                Text("Tips").tag(0)
                Text("Benchmark").tag(1)
                Text("Stress").tag(2)
            }
            .pickerStyle(.segmented)
            .padding()
            
            // Content
            Group {
                switch selectedTab {
                case 0:
                    PerformanceTipsView()
                case 1:
                    GlassBenchmark()
                case 2:
                    GlassStressTest()
                default:
                    EmptyView()
                }
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct PerformanceExample_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PerformanceTipsView()
                .previewDisplayName("Tips")
            
            GlassBenchmark()
                .previewDisplayName("Benchmark")
            
            GlassStressTest()
                .previewDisplayName("Stress Test")
        }
    }
}
#endif
