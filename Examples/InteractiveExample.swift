// InteractiveExample.swift
// LiquidGlassKit
//
// Interactive glass components with touch feedback, gestures, and animations.

import SwiftUI

// MARK: - Interactive Glass Card

/// A glass card that responds to touch with scale and glow effects.
public struct InteractiveGlassCard<Content: View>: View {
    
    let content: Content
    let material: GlassMaterial
    let onTap: (() -> Void)?
    
    @State private var isPressed = false
    @State private var dragOffset: CGSize = .zero
    
    public init(
        material: GlassMaterial = .frosted,
        onTap: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.material = material
        self.onTap = onTap
    }
    
    public var body: some View {
        content
            .glassBackground(material: material, cornerRadius: 20)
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .rotation3DEffect(
                .degrees(Double(dragOffset.width) / 20),
                axis: (x: 0, y: 1, z: 0)
            )
            .rotation3DEffect(
                .degrees(Double(-dragOffset.height) / 20),
                axis: (x: 1, y: 0, z: 0)
            )
            .shadow(
                color: .black.opacity(isPressed ? 0.2 : 0.1),
                radius: isPressed ? 4 : 8,
                y: isPressed ? 2 : 4
            )
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.6)) {
                            isPressed = true
                            dragOffset = CGSize(
                                width: value.translation.width.clamped(to: -30...30),
                                height: value.translation.height.clamped(to: -30...30)
                            )
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            isPressed = false
                            dragOffset = .zero
                        }
                        onTap?()
                    }
            )
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPressed)
    }
}

// MARK: - Expandable Glass Panel

/// A glass panel that expands on tap to reveal more content.
public struct ExpandableGlassPanel: View {
    
    let title: String
    let icon: String
    let content: String
    
    @State private var isExpanded = false
    
    public init(title: String, icon: String, content: String) {
        self.title = title
        self.icon = icon
        self.content = content
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header (always visible)
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(width: 40)
                
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .font(.body.weight(.medium))
                    .foregroundStyle(.secondary)
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
            }
            .padding(20)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    isExpanded.toggle()
                }
            }
            
            // Expandable content
            if isExpanded {
                Divider()
                    .padding(.horizontal, 20)
                
                Text(content)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .padding(20)
                    .transition(.asymmetric(
                        insertion: .push(from: .top).combined(with: .opacity),
                        removal: .push(from: .bottom).combined(with: .opacity)
                    ))
            }
        }
        .glassBackground(material: .frosted, cornerRadius: 16)
    }
}

// MARK: - Swipeable Glass Card

/// A card that can be swiped left/right with glass action buttons revealed.
public struct SwipeableGlassCard: View {
    
    let title: String
    let subtitle: String
    let onDelete: () -> Void
    let onArchive: () -> Void
    
    @State private var offset: CGFloat = 0
    @State private var isShowingActions = false
    
    private let actionWidth: CGFloat = 80
    
    public init(
        title: String,
        subtitle: String,
        onDelete: @escaping () -> Void,
        onArchive: @escaping () -> Void
    ) {
        self.title = title
        self.subtitle = subtitle
        self.onDelete = onDelete
        self.onArchive = onArchive
    }
    
    public var body: some View {
        ZStack(alignment: .trailing) {
            // Background actions
            HStack(spacing: 0) {
                Spacer()
                
                // Archive button
                Button(action: {
                    withAnimation { offset = 0 }
                    onArchive()
                }) {
                    Image(systemName: "archivebox.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: actionWidth, height: 80)
                }
                .background(Color.blue)
                
                // Delete button
                Button(action: {
                    withAnimation { offset = 0 }
                    onDelete()
                }) {
                    Image(systemName: "trash.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: actionWidth, height: 80)
                }
                .background(Color.red)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            // Main card
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.tertiary)
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .glassBackground(material: .frosted, cornerRadius: 16)
            .offset(x: offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let translation = value.translation.width
                        if translation < 0 {
                            offset = max(translation, -actionWidth * 2)
                        } else if isShowingActions {
                            offset = min(0, -actionWidth * 2 + translation)
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            if offset < -actionWidth {
                                offset = -actionWidth * 2
                                isShowingActions = true
                            } else {
                                offset = 0
                                isShowingActions = false
                            }
                        }
                    }
            )
        }
    }
}

// MARK: - Interactive Toggle Card

/// A glass card with an integrated toggle switch.
public struct GlassToggleCard: View {
    
    let title: String
    let subtitle: String
    let icon: String
    @Binding var isOn: Bool
    
    public init(
        title: String,
        subtitle: String,
        icon: String,
        isOn: Binding<Bool>
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self._isOn = isOn
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            // Icon with glass background
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(isOn ? .blue : .gray)
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill((isOn ? Color.blue : Color.gray).opacity(0.15))
                )
            
            // Text content
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Custom glass toggle
            GlassToggle(isOn: $isOn)
        }
        .padding(16)
        .glassBackground(material: .frosted, cornerRadius: 16)
        .animation(.spring(response: 0.3), value: isOn)
    }
}

// MARK: - Glass Toggle

/// A custom toggle switch with glass styling.
public struct GlassToggle: View {
    
    @Binding var isOn: Bool
    
    public init(isOn: Binding<Bool>) {
        self._isOn = isOn
    }
    
    public var body: some View {
        ZStack(alignment: isOn ? .trailing : .leading) {
            // Track
            Capsule()
                .fill(isOn ? Color.blue.opacity(0.3) : Color.gray.opacity(0.2))
                .frame(width: 50, height: 30)
                .overlay(
                    Capsule()
                        .stroke(isOn ? Color.blue.opacity(0.5) : Color.gray.opacity(0.3), lineWidth: 1)
                )
            
            // Thumb
            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 26, height: 26)
                .overlay(
                    Circle()
                        .fill(isOn ? Color.blue : Color.white)
                        .frame(width: 20, height: 20)
                )
                .shadow(color: .black.opacity(0.15), radius: 2, y: 1)
                .padding(2)
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                isOn.toggle()
            }
        }
    }
}

// MARK: - Draggable Glass Element

/// A glass element that can be dragged around the screen.
public struct DraggableGlassElement: View {
    
    let icon: String
    let color: Color
    
    @State private var position: CGPoint = .zero
    @State private var isDragging = false
    
    public init(icon: String, color: Color, initialPosition: CGPoint = .zero) {
        self.icon = icon
        self.color = color
        self._position = State(initialValue: initialPosition)
    }
    
    public var body: some View {
        Image(systemName: icon)
            .font(.title)
            .foregroundColor(color)
            .padding(20)
            .background(
                Circle()
                    .fill(.ultraThinMaterial)
                    .overlay(
                        Circle()
                            .fill(color.opacity(0.1))
                    )
                    .overlay(
                        Circle()
                            .stroke(.white.opacity(0.3), lineWidth: 0.5)
                    )
            )
            .shadow(
                color: color.opacity(isDragging ? 0.4 : 0.2),
                radius: isDragging ? 20 : 8,
                y: isDragging ? 0 : 4
            )
            .scaleEffect(isDragging ? 1.1 : 1.0)
            .position(position)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.interactiveSpring(response: 0.15, dampingFraction: 0.8)) {
                            isDragging = true
                            position = value.location
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            isDragging = false
                        }
                    }
            )
    }
}

// MARK: - Interactive Demo View

/// A complete demo showcasing all interactive glass components.
public struct InteractiveGlassDemo: View {
    
    @State private var wifiEnabled = true
    @State private var bluetoothEnabled = false
    @State private var darkModeEnabled = true
    @State private var items = ["Meeting Notes", "Shopping List", "Project Ideas"]
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Animated gradient background
            AnimatedGradientBackground()
            
            ScrollView {
                VStack(spacing: 24) {
                    Text("Interactive Glass")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                        .padding(.top, 40)
                    
                    // Interactive card with 3D effect
                    InteractiveGlassCard(material: .frosted) {
                        VStack(spacing: 12) {
                            Image(systemName: "hand.tap.fill")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                            Text("Tap & Drag Me")
                                .font(.headline)
                            Text("3D tilt effect on interaction")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity)
                    }
                    
                    // Expandable panels
                    VStack(spacing: 12) {
                        ExpandableGlassPanel(
                            title: "What is Liquid Glass?",
                            icon: "drop.fill",
                            content: "Liquid Glass is Apple's new design language introduced in iOS 26. It features translucent, depth-aware materials that respond to light and content behind them."
                        )
                        
                        ExpandableGlassPanel(
                            title: "How to Use",
                            icon: "questionmark.circle.fill",
                            content: "Simply apply the .glassBackground() modifier to any view, or use GlassCard for structured content. The effect automatically adapts to the background content."
                        )
                    }
                    
                    // Toggle cards
                    VStack(spacing: 12) {
                        GlassToggleCard(
                            title: "Wi-Fi",
                            subtitle: "Connected to Home Network",
                            icon: "wifi",
                            isOn: $wifiEnabled
                        )
                        
                        GlassToggleCard(
                            title: "Bluetooth",
                            subtitle: "2 devices available",
                            icon: "wave.3.right",
                            isOn: $bluetoothEnabled
                        )
                        
                        GlassToggleCard(
                            title: "Dark Mode",
                            subtitle: "Optimized for low light",
                            icon: "moon.fill",
                            isOn: $darkModeEnabled
                        )
                    }
                    
                    // Swipeable cards
                    VStack(spacing: 12) {
                        Text("Swipe Left →")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.6))
                        
                        ForEach(items, id: \.self) { item in
                            SwipeableGlassCard(
                                title: item,
                                subtitle: "Tap to view details",
                                onDelete: {
                                    withAnimation {
                                        items.removeAll { $0 == item }
                                    }
                                },
                                onArchive: {
                                    print("Archived: \(item)")
                                }
                            )
                        }
                    }
                }
                .padding()
            }
        }
    }
}

// MARK: - Animated Gradient Background

private struct AnimatedGradientBackground: View {
    @State private var animateGradient = false
    
    var body: some View {
        LinearGradient(
            colors: animateGradient ? 
                [.purple, .blue, .cyan] : 
                [.blue, .purple, .pink],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}

// MARK: - CGFloat Extension

private extension CGFloat {
    func clamped(to range: ClosedRange<CGFloat>) -> CGFloat {
        return min(max(self, range.lowerBound), range.upperBound)
    }
}

// MARK: - Preview

#if DEBUG
struct InteractiveExample_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveGlassDemo()
    }
}
#endif
