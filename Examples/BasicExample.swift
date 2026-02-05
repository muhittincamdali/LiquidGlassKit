// BasicExample.swift
// LiquidGlassKit
//
// Comprehensive examples demonstrating basic glass effect usage.

import SwiftUI

// MARK: - Basic Glass View

/// The simplest way to apply a glass effect to any view.
/// Just add `.glassBackground()` and you're done!
public struct BasicGlassView: View {
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Vibrant gradient background to showcase glass effect
            LinearGradient(
                colors: [.blue, .purple, .pink, .orange],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Simple glass card
                Text("Hello, Liquid Glass!")
                    .font(.title2.weight(.semibold))
                    .padding(24)
                    .glassBackground()
                
                // Glass card with icon
                HStack(spacing: 12) {
                    Image(systemName: "sparkles")
                        .font(.title)
                    Text("Magical UI")
                        .font(.headline)
                }
                .padding(20)
                .glassBackground(material: .frosted, cornerRadius: 20)
            }
        }
    }
}

// MARK: - Glass Materials Showcase

/// Demonstrates all available glass materials.
public struct GlassMaterialsShowcase: View {
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Dynamic mesh-like background
            Image(systemName: "photo.artframe")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    LinearGradient(
                        colors: [.cyan.opacity(0.8), .blue.opacity(0.8), .purple.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    Text("Glass Materials")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                        .padding(.top, 40)
                    
                    // Clear Glass
                    materialCard(
                        title: "Clear",
                        description: "Maximum background visibility",
                        material: .clear
                    )
                    
                    // Frosted Glass (Default)
                    materialCard(
                        title: "Frosted",
                        description: "Standard iOS 26 appearance",
                        material: .frosted
                    )
                    
                    // Tinted Glass
                    materialCard(
                        title: "Tinted (Blue)",
                        description: "Custom color overlay",
                        material: .tinted(.blue)
                    )
                    
                    // Tinted Glass - Pink
                    materialCard(
                        title: "Tinted (Pink)",
                        description: "Vibrant accent color",
                        material: .tinted(.pink)
                    )
                    
                    // Dark Glass
                    materialCard(
                        title: "Dark",
                        description: "Night mode optimized",
                        material: .dark,
                        textColor: .white
                    )
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    private func materialCard(
        title: String,
        description: String,
        material: GlassMaterial,
        textColor: Color = .primary
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(textColor)
            Text(description)
                .font(.subheadline)
                .foregroundColor(textColor.opacity(0.7))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .glassBackground(material: material, cornerRadius: 16)
    }
}

// MARK: - Glass Card Examples

/// Various card layouts using GlassCard component.
public struct GlassCardExamples: View {
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Nature-inspired background
            LinearGradient(
                colors: [
                    Color(red: 0.2, green: 0.6, blue: 0.4),
                    Color(red: 0.1, green: 0.4, blue: 0.5),
                    Color(red: 0.2, green: 0.3, blue: 0.6)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Card
                    GlassCard(material: .frosted, cornerRadius: 24) {
                        HStack(spacing: 16) {
                            Circle()
                                .fill(.white.opacity(0.3))
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .font(.title)
                                        .foregroundColor(.white)
                                )
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("John Appleseed")
                                    .font(.headline)
                                Text("iOS Developer")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding(20)
                    }
                    
                    // Stats Card
                    GlassCard(material: .frosted) {
                        HStack(spacing: 0) {
                            statItem(value: "142", label: "Posts")
                            Divider()
                                .frame(height: 40)
                            statItem(value: "5.2K", label: "Followers")
                            Divider()
                                .frame(height: 40)
                            statItem(value: "890", label: "Following")
                        }
                        .padding(.vertical, 16)
                    }
                    
                    // Feature Card with Icon Grid
                    GlassCard(material: .tinted(.cyan.opacity(0.3)), cornerRadius: 20) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Quick Actions")
                                .font(.headline)
                            
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 16) {
                                actionIcon("camera.fill", label: "Camera")
                                actionIcon("photo.fill", label: "Photos")
                                actionIcon("location.fill", label: "Location")
                                actionIcon("star.fill", label: "Favorites")
                            }
                        }
                        .padding(20)
                    }
                    
                    // Notification Card
                    GlassCard(material: .dark) {
                        HStack(spacing: 12) {
                            Image(systemName: "bell.badge.fill")
                                .font(.title2)
                                .foregroundColor(.yellow)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("New Message")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("You have 3 unread messages")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            Text("2m")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(16)
                    }
                }
                .padding(20)
            }
        }
    }
    
    @ViewBuilder
    private func statItem(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2.weight(.bold))
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func actionIcon(_ systemName: String, label: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: systemName)
                .font(.title2)
            Text(label)
                .font(.caption2)
        }
        .foregroundColor(.primary)
    }
}

// MARK: - Glass Button Examples

/// Interactive button examples with glass styling.
public struct GlassButtonExamples: View {
    
    @State private var likeCount = 42
    @State private var isFollowing = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Warm sunset gradient
            LinearGradient(
                colors: [.orange, .pink, .purple],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 32) {
                Text("Glass Buttons")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                // Standard Buttons
                VStack(spacing: 16) {
                    GlassButton("Get Started", icon: "arrow.right") {
                        print("Button tapped!")
                    }
                    
                    GlassButton("Share", icon: "square.and.arrow.up", material: .frosted) {
                        print("Share tapped!")
                    }
                }
                
                // Interactive Like Button
                HStack(spacing: 20) {
                    GlassButton("♥ \(likeCount)", material: .tinted(.pink)) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            likeCount += 1
                        }
                    }
                    
                    GlassButton(isFollowing ? "Following" : "Follow", icon: isFollowing ? "checkmark" : "plus", material: isFollowing ? .dark : .frosted) {
                        withAnimation {
                            isFollowing.toggle()
                        }
                    }
                }
                
                // Button Styles
                VStack(spacing: 12) {
                    GlassButton("Prominent", style: .prominent) {
                        print("Prominent!")
                    }
                    
                    HStack(spacing: 12) {
                        GlassButton("Compact", style: .compact) {}
                        GlassButton("Compact", style: .compact) {}
                        GlassButton("Compact", style: .compact) {}
                    }
                }
                
                // Dark Mode Buttons
                GlassButton("Night Mode", icon: "moon.fill", material: .dark) {
                    print("Night mode!")
                }
            }
            .padding()
        }
    }
}

// MARK: - Glass Container Examples

/// Demonstrates GlassEffectContainer with various shapes.
public struct GlassContainerExamples: View {
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Colorful background
            MeshGradientBackground()
            
            ScrollView {
                VStack(spacing: 24) {
                    Text("Glass Containers")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                        .padding(.top, 40)
                    
                    // Rectangle (default)
                    GlassEffectContainer(
                        material: .frosted,
                        shape: .rectangle(cornerRadius: 20)
                    ) {
                        VStack(spacing: 8) {
                            Image(systemName: "rectangle.fill")
                                .font(.largeTitle)
                            Text("Rectangle")
                                .font(.headline)
                            Text("cornerRadius: 20")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(24)
                    }
                    
                    // Capsule
                    GlassEffectContainer(
                        material: .frosted,
                        shape: .capsule
                    ) {
                        HStack {
                            Image(systemName: "capsule.fill")
                                .font(.title2)
                            Text("Capsule Shape")
                                .font(.headline)
                        }
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                    }
                    
                    // Circle
                    GlassEffectContainer(
                        material: .tinted(.blue),
                        shape: .circle
                    ) {
                        VStack {
                            Image(systemName: "circle.fill")
                                .font(.largeTitle)
                            Text("Circle")
                                .font(.caption)
                        }
                        .frame(width: 100, height: 100)
                    }
                    
                    // Custom corners
                    GlassEffectContainer(
                        material: .frosted,
                        shape: .custom(topLeading: 30, topTrailing: 8, bottomLeading: 8, bottomTrailing: 30)
                    ) {
                        VStack(spacing: 8) {
                            Image(systemName: "square.on.square.squareshape.controlhandles")
                                .font(.title)
                            Text("Custom Corners")
                                .font(.headline)
                            Text("Asymmetric radius")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(24)
                    }
                }
                .padding()
            }
        }
    }
}

// MARK: - Helper Views

/// A colorful mesh-like gradient background.
private struct MeshGradientBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.indigo, .purple, .pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            Circle()
                .fill(.blue.opacity(0.4))
                .blur(radius: 80)
                .offset(x: -100, y: -200)
            
            Circle()
                .fill(.pink.opacity(0.4))
                .blur(radius: 100)
                .offset(x: 150, y: 200)
            
            Circle()
                .fill(.orange.opacity(0.3))
                .blur(radius: 60)
                .offset(x: -50, y: 300)
        }
        .ignoresSafeArea()
    }
}

// MARK: - Quick Start Example

/// Copy-paste ready example for getting started.
public struct QuickStartExample: View {
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Step 1: Add a colorful background
            LinearGradient(
                colors: [.blue, .purple, .pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Step 2: Use glassBackground() modifier
                Text("Quick & Easy")
                    .font(.title.weight(.bold))
                    .padding(24)
                    .glassBackground()
                
                // Step 3: Add GlassCard for structured content
                GlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Feature One", systemImage: "star.fill")
                        Label("Feature Two", systemImage: "heart.fill")
                        Label("Feature Three", systemImage: "bolt.fill")
                    }
                    .padding(20)
                }
                
                // Step 4: Use GlassButton for actions
                GlassButton("Continue", icon: "arrow.right") {
                    print("Let's go!")
                }
            }
            .padding()
        }
    }
}

// MARK: - Preview Provider

#if DEBUG
struct BasicExample_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BasicGlassView()
                .previewDisplayName("Basic Glass")
            
            GlassMaterialsShowcase()
                .previewDisplayName("Materials")
            
            GlassCardExamples()
                .previewDisplayName("Cards")
            
            GlassButtonExamples()
                .previewDisplayName("Buttons")
            
            GlassContainerExamples()
                .previewDisplayName("Containers")
            
            QuickStartExample()
                .previewDisplayName("Quick Start")
        }
    }
}
#endif
