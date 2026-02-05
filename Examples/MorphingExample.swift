// MorphingExample.swift
// LiquidGlassKit
//
// Demonstrates glass morphing animations and transitions between elements.
// Simulates iOS 26's .glassEffectID() for connected glass elements.

import SwiftUI

// MARK: - Glass Morph Namespace

/// Namespace for coordinating glass morphing animations.
public struct GlassMorphNamespace {
    public static let shared = Namespace().wrappedValue
}

// MARK: - Morphing Tab Bar

/// A tab bar where the glass effect morphs between selected items.
public struct MorphingGlassTabBar: View {
    
    @Binding var selectedTab: Int
    let tabs: [(icon: String, label: String)]
    
    @Namespace private var morphNamespace
    
    public init(selectedTab: Binding<Int>, tabs: [(icon: String, label: String)]) {
        self._selectedTab = selectedTab
        self.tabs = tabs
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs.indices, id: \.self) { index in
                tabItem(index: index)
            }
        }
        .padding(8)
        .glassBackground(material: .frosted, cornerRadius: 28)
    }
    
    @ViewBuilder
    private func tabItem(index: Int) -> some View {
        let isSelected = selectedTab == index
        
        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                selectedTab = index
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tabs[index].icon)
                    .font(.title3)
                Text(tabs[index].label)
                    .font(.caption2)
            }
            .foregroundColor(isSelected ? .blue : .secondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background {
                if isSelected {
                    Capsule()
                        .fill(.blue.opacity(0.15))
                        .matchedGeometryEffect(id: "tab_indicator", in: morphNamespace)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Morphing Segmented Control

/// A segmented control with morphing glass selection indicator.
public struct MorphingSegmentedControl: View {
    
    @Binding var selection: Int
    let segments: [String]
    
    @Namespace private var namespace
    
    public init(selection: Binding<Int>, segments: [String]) {
        self._selection = selection
        self.segments = segments
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            ForEach(segments.indices, id: \.self) { index in
                segmentButton(index: index)
            }
        }
        .padding(4)
        .glassBackground(material: .frosted, cornerRadius: 12)
    }
    
    @ViewBuilder
    private func segmentButton(index: Int) -> some View {
        let isSelected = selection == index
        
        Text(segments[index])
            .font(.subheadline.weight(.medium))
            .foregroundColor(isSelected ? .primary : .secondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background {
                if isSelected {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.background)
                        .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
                        .matchedGeometryEffect(id: "segment_bg", in: namespace)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    selection = index
                }
            }
    }
}

// MARK: - Hero Card Transition

/// A card that expands into a full detail view with morphing animation.
public struct HeroGlassCard: View {
    
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    
    @State private var isExpanded = false
    @Namespace private var heroNamespace
    
    public init(title: String, subtitle: String, icon: String, color: Color) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.color = color
    }
    
    public var body: some View {
        ZStack {
            if isExpanded {
                expandedView
            } else {
                compactView
            }
        }
    }
    
    @ViewBuilder
    private var compactView: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .fill(color.opacity(0.15))
                )
                .matchedGeometryEffect(id: "icon_\(title)", in: heroNamespace)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .matchedGeometryEffect(id: "title_\(title)", in: heroNamespace)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .matchedGeometryEffect(id: "subtitle_\(title)", in: heroNamespace)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.tertiary)
        }
        .padding(20)
        .glassBackground(material: .frosted, cornerRadius: 16)
        .matchedGeometryEffect(id: "card_\(title)", in: heroNamespace)
        .onTapGesture {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                isExpanded = true
            }
        }
    }
    
    @ViewBuilder
    private var expandedView: some View {
        VStack(spacing: 0) {
            // Header
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 16) {
                    Image(systemName: icon)
                        .font(.system(size: 60))
                        .foregroundColor(color)
                        .frame(width: 100, height: 100)
                        .background(
                            Circle()
                                .fill(color.opacity(0.15))
                        )
                        .matchedGeometryEffect(id: "icon_\(title)", in: heroNamespace)
                    
                    Text(title)
                        .font(.title.weight(.bold))
                        .matchedGeometryEffect(id: "title_\(title)", in: heroNamespace)
                    
                    Text(subtitle)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .matchedGeometryEffect(id: "subtitle_\(title)", in: heroNamespace)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                
                // Close button
                Button {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                        isExpanded = false
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
                .padding(20)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 16) {
                Text("Details")
                    .font(.headline)
                
                Text("This is the expanded view with additional content. The glass effect morphs smoothly from the compact card to this full-screen view, creating a seamless transition that feels natural and engaging.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .glassBackground(material: .frosted, cornerRadius: 0)
        .matchedGeometryEffect(id: "card_\(title)", in: heroNamespace)
    }
}

// MARK: - Morphing Icon Button

/// A button where the icon morphs on state change.
public struct MorphingIconButton: View {
    
    @Binding var isActive: Bool
    let activeIcon: String
    let inactiveIcon: String
    let activeColor: Color
    
    @Namespace private var iconNamespace
    
    public init(
        isActive: Binding<Bool>,
        activeIcon: String,
        inactiveIcon: String,
        activeColor: Color = .blue
    ) {
        self._isActive = isActive
        self.activeIcon = activeIcon
        self.inactiveIcon = inactiveIcon
        self.activeColor = activeColor
    }
    
    public var body: some View {
        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.6)) {
                isActive.toggle()
            }
        } label: {
            ZStack {
                if isActive {
                    Image(systemName: activeIcon)
                        .font(.title)
                        .foregroundColor(activeColor)
                        .matchedGeometryEffect(id: "morph_icon", in: iconNamespace)
                } else {
                    Image(systemName: inactiveIcon)
                        .font(.title)
                        .foregroundColor(.secondary)
                        .matchedGeometryEffect(id: "morph_icon", in: iconNamespace)
                }
            }
            .frame(width: 56, height: 56)
            .background(
                Circle()
                    .fill(.ultraThinMaterial)
                    .overlay(
                        Circle()
                            .fill(isActive ? activeColor.opacity(0.15) : Color.clear)
                    )
            )
            .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Liquid Morph Transition

/// A container that morphs between two views with liquid glass effect.
public struct LiquidMorphContainer<ContentA: View, ContentB: View>: View {
    
    @Binding var showSecond: Bool
    let first: ContentA
    let second: ContentB
    
    @Namespace private var morphSpace
    
    public init(
        showSecond: Binding<Bool>,
        @ViewBuilder first: () -> ContentA,
        @ViewBuilder second: () -> ContentB
    ) {
        self._showSecond = showSecond
        self.first = first()
        self.second = second()
    }
    
    public var body: some View {
        ZStack {
            if showSecond {
                second
                    .matchedGeometryEffect(id: "morph_container", in: morphSpace)
            } else {
                first
                    .matchedGeometryEffect(id: "morph_container", in: morphSpace)
            }
        }
    }
}

// MARK: - Floating Action Button Morph

/// A FAB that morphs into an expanded menu.
public struct MorphingFAB: View {
    
    @State private var isExpanded = false
    @Namespace private var fabNamespace
    
    let actions: [(icon: String, label: String, action: () -> Void)]
    
    public init(actions: [(icon: String, label: String, action: () -> Void)]) {
        self.actions = actions
    }
    
    public var body: some View {
        VStack(alignment: .trailing, spacing: 12) {
            if isExpanded {
                ForEach(actions.indices.reversed(), id: \.self) { index in
                    actionButton(index: index)
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .opacity).animation(.spring(response: 0.3, dampingFraction: 0.7).delay(Double(actions.count - 1 - index) * 0.05)),
                            removal: .scale.combined(with: .opacity).animation(.spring(response: 0.2).delay(Double(index) * 0.03))
                        ))
                }
            }
            
            // Main FAB
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    isExpanded.toggle()
                }
            } label: {
                Image(systemName: isExpanded ? "xmark" : "plus")
                    .font(.title2.weight(.medium))
                    .foregroundColor(.white)
                    .frame(width: 56, height: 56)
                    .background(
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
                    .shadow(color: .blue.opacity(0.3), radius: 8, y: 4)
                    .rotationEffect(.degrees(isExpanded ? 45 : 0))
            }
            .buttonStyle(.plain)
            .matchedGeometryEffect(id: "fab_main", in: fabNamespace)
        }
    }
    
    @ViewBuilder
    private func actionButton(index: Int) -> some View {
        HStack(spacing: 12) {
            Text(actions[index].label)
                .font(.subheadline.weight(.medium))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .glassBackground(material: .frosted, cornerRadius: 8)
            
            Button(action: {
                withAnimation(.spring(response: 0.3)) {
                    isExpanded = false
                }
                actions[index].action()
            }) {
                Image(systemName: actions[index].icon)
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(
                        Circle()
                            .fill(.ultraThinMaterial)
                            .overlay(Circle().fill(Color.blue.opacity(0.8)))
                    )
                    .shadow(color: .black.opacity(0.15), radius: 4, y: 2)
            }
            .buttonStyle(.plain)
        }
    }
}

// MARK: - Morphing Demo View

/// Complete demo showcasing all morphing glass effects.
public struct MorphingGlassDemo: View {
    
    @State private var selectedTab = 0
    @State private var segmentSelection = 0
    @State private var isPlaying = false
    @State private var isLiked = false
    @State private var isSaved = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [.indigo, .purple, .pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 24) {
                        Text("Morphing Glass")
                            .font(.largeTitle.weight(.bold))
                            .foregroundStyle(.white)
                            .padding(.top, 20)
                        
                        // Segmented Control
                        MorphingSegmentedControl(
                            selection: $segmentSelection,
                            segments: ["All", "Active", "Completed"]
                        )
                        .padding(.horizontal)
                        
                        // Icon buttons row
                        HStack(spacing: 24) {
                            MorphingIconButton(
                                isActive: $isPlaying,
                                activeIcon: "pause.fill",
                                inactiveIcon: "play.fill",
                                activeColor: .green
                            )
                            
                            MorphingIconButton(
                                isActive: $isLiked,
                                activeIcon: "heart.fill",
                                inactiveIcon: "heart",
                                activeColor: .pink
                            )
                            
                            MorphingIconButton(
                                isActive: $isSaved,
                                activeIcon: "bookmark.fill",
                                inactiveIcon: "bookmark",
                                activeColor: .orange
                            )
                        }
                        .padding(.vertical, 8)
                        
                        // Hero cards
                        VStack(spacing: 12) {
                            HeroGlassCard(
                                title: "Music Player",
                                subtitle: "Now Playing",
                                icon: "music.note",
                                color: .pink
                            )
                            
                            HeroGlassCard(
                                title: "Weather",
                                subtitle: "Current conditions",
                                icon: "sun.max.fill",
                                color: .orange
                            )
                            
                            HeroGlassCard(
                                title: "Fitness",
                                subtitle: "Today's activity",
                                icon: "figure.run",
                                color: .green
                            )
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 120)
                }
                
                // Morphing Tab Bar
                MorphingGlassTabBar(
                    selectedTab: $selectedTab,
                    tabs: [
                        ("house.fill", "Home"),
                        ("magnifyingglass", "Search"),
                        ("heart.fill", "Favorites"),
                        ("person.fill", "Profile")
                    ]
                )
                .padding()
            }
            
            // Floating action button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    MorphingFAB(actions: [
                        ("camera.fill", "Camera", { print("Camera") }),
                        ("photo.fill", "Gallery", { print("Gallery") }),
                        ("doc.fill", "Document", { print("Document") })
                    ])
                    .padding(.trailing, 24)
                    .padding(.bottom, 100)
                }
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct MorphingExample_Previews: PreviewProvider {
    static var previews: some View {
        MorphingGlassDemo()
    }
}
#endif
