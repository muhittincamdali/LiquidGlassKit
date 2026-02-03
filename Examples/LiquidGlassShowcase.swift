import SwiftUI
import LiquidGlassKit

// MARK: - Showcase Application

/// Main showcase application demonstrating all LiquidGlassKit components.
/// This comprehensive example shows how to integrate liquid glass effects
/// into a real-world iOS 26 application.
@main
struct LiquidGlassShowcaseApp: App {
    
    // MARK: - Properties
    
    @State private var selectedTheme: DayNightTheme.Configuration = .automatic
    @State private var isNightMode: Bool = false
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            MainShowcaseView()
                .environment(\.dayNightConfiguration, selectedTheme)
        }
    }
}

// MARK: - Main Showcase View

/// Central hub for navigating through all showcase sections.
struct MainShowcaseView: View {
    
    // MARK: - Properties
    
    @State private var selectedTab: ShowcaseTab = .components
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Dynamic background gradient
                backgroundGradient
                    .ignoresSafeArea()
                
                // Main content
                VStack(spacing: 0) {
                    // Glass navigation bar
                    GlassNavigationBar(
                        title: selectedTab.title,
                        style: .prominent
                    )
                    
                    // Tab content
                    TabView(selection: $selectedTab) {
                        ComponentsShowcaseView()
                            .tag(ShowcaseTab.components)
                        
                        EffectsShowcaseView()
                            .tag(ShowcaseTab.effects)
                        
                        MaterialsShowcaseView()
                            .tag(ShowcaseTab.materials)
                        
                        ThemesShowcaseView()
                            .tag(ShowcaseTab.themes)
                        
                        AnimationsShowcaseView()
                            .tag(ShowcaseTab.animations)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    // Glass tab bar
                    GlassTabBar(
                        items: ShowcaseTab.allCases.map { tab in
                            GlassTabBar.TabItem(
                                id: tab,
                                title: tab.title,
                                icon: tab.icon
                            )
                        },
                        selection: $selectedTab
                    )
                }
            }
        }
    }
    
    // MARK: - Background
    
    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color(red: 0.2, green: 0.3, blue: 0.5),
                Color(red: 0.3, green: 0.2, blue: 0.4),
                Color(red: 0.1, green: 0.2, blue: 0.3)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Showcase Tab

/// Available sections in the showcase application.
enum ShowcaseTab: String, CaseIterable, Identifiable {
    case components
    case effects
    case materials
    case themes
    case animations
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .components: return "Components"
        case .effects: return "Effects"
        case .materials: return "Materials"
        case .themes: return "Themes"
        case .animations: return "Animations"
        }
    }
    
    var icon: String {
        switch self {
        case .components: return "square.grid.2x2"
        case .effects: return "sparkles"
        case .materials: return "cube.transparent"
        case .themes: return "paintpalette"
        case .animations: return "waveform.path"
        }
    }
}

// MARK: - Components Showcase

/// Demonstrates all glass UI components available in the framework.
struct ComponentsShowcaseView: View {
    
    // MARK: - Properties
    
    @State private var buttonTapCount: Int = 0
    @State private var textFieldValue: String = ""
    @State private var isSheetPresented: Bool = false
    @State private var searchQuery: String = ""
    @State private var selectedItem: String?
    
    // MARK: - Sample Data
    
    private let sampleItems = [
        "Crystal Clear Glass",
        "Frosted Window Pane",
        "Dark Obsidian Surface",
        "Aqua Marine Depth",
        "Morning Dew Droplets",
        "Sunset Reflection Pool",
        "Midnight Aurora Glass",
        "Spring Blossom Filter"
    ]
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Section: Cards
                sectionHeader("Glass Cards")
                cardShowcase
                
                // Section: Buttons
                sectionHeader("Glass Buttons")
                buttonShowcase
                
                // Section: Text Fields
                sectionHeader("Glass Text Fields")
                textFieldShowcase
                
                // Section: Search
                sectionHeader("Liquid Search")
                searchShowcase
                
                // Section: List
                sectionHeader("Liquid List")
                listShowcase
                
                // Section: Sheet Trigger
                sectionHeader("Glass Sheet")
                sheetShowcase
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .sheet(isPresented: $isSheetPresented) {
            GlassSheet(style: .prominent) {
                VStack(spacing: 20) {
                    Text("Glass Sheet Content")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.white)
                    
                    Text("This sheet uses the native liquid glass effect from iOS 26.")
                        .font(.body)
                        .foregroundStyle(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                    
                    GlassButton("Dismiss", style: .secondary) {
                        isSheetPresented = false
                    }
                }
                .padding(24)
            }
        }
    }
    
    // MARK: - Section Header
    
    private func sectionHeader(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.9))
            Spacer()
        }
        .padding(.top, 8)
    }
    
    // MARK: - Card Showcase
    
    private var cardShowcase: some View {
        VStack(spacing: 16) {
            GlassCard(style: .standard) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "sparkles")
                            .font(.title2)
                        Text("Standard Glass Card")
                            .font(.headline)
                    }
                    Text("Beautiful frosted glass effect with subtle shadows and reflections.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(16)
            }
            
            HStack(spacing: 12) {
                GlassCard(style: .compact) {
                    VStack(spacing: 8) {
                        Image(systemName: "drop.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.blue)
                        Text("Compact")
                            .font(.caption.weight(.medium))
                    }
                    .padding(12)
                }
                
                GlassCard(style: .prominent) {
                    VStack(spacing: 8) {
                        Image(systemName: "cube.transparent.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.purple)
                        Text("Prominent")
                            .font(.caption.weight(.medium))
                    }
                    .padding(12)
                }
            }
        }
    }
    
    // MARK: - Button Showcase
    
    private var buttonShowcase: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                GlassButton("Primary", style: .primary) {
                    buttonTapCount += 1
                }
                
                GlassButton("Secondary", style: .secondary) {
                    buttonTapCount += 1
                }
            }
            
            HStack(spacing: 12) {
                GlassButton("Destructive", style: .destructive) {
                    buttonTapCount = 0
                }
                
                GlassButton(
                    "With Icon",
                    icon: "star.fill",
                    style: .primary
                ) {
                    buttonTapCount += 5
                }
            }
            
            Text("Tap count: \(buttonTapCount)")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))
        }
    }
    
    // MARK: - Text Field Showcase
    
    private var textFieldShowcase: some View {
        VStack(spacing: 12) {
            GlassTextField(
                "Enter your name",
                text: $textFieldValue,
                icon: "person.fill"
            )
            
            GlassTextField(
                "Email address",
                text: .constant(""),
                icon: "envelope.fill",
                style: .prominent
            )
            
            if !textFieldValue.isEmpty {
                Text("Hello, \(textFieldValue)!")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
                    .transition(.opacity.combined(with: .scale))
            }
        }
        .animation(.smooth, value: textFieldValue)
    }
    
    // MARK: - Search Showcase
    
    private var searchShowcase: some View {
        VStack(spacing: 16) {
            LiquidSearch(
                query: $searchQuery,
                placeholder: "Search glass effects...",
                configuration: .init(
                    style: .prominent,
                    showCancelButton: true,
                    animatesOnFocus: true
                )
            )
            
            if !searchQuery.isEmpty {
                let filtered = sampleItems.filter {
                    $0.localizedCaseInsensitiveContains(searchQuery)
                }
                
                if filtered.isEmpty {
                    Text("No results for \"\(searchQuery)\"")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.6))
                } else {
                    ForEach(filtered, id: \.self) { item in
                        GlassCard(style: .compact) {
                            HStack {
                                Text(item)
                                    .font(.subheadline)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(12)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - List Showcase
    
    private var listShowcase: some View {
        LiquidList(
            items: Array(sampleItems.prefix(5)),
            selection: $selectedItem,
            configuration: .init(
                style: .inset,
                showsSeparators: true,
                selectionStyle: .highlight
            )
        ) { item in
            HStack {
                Circle()
                    .fill(Color.blue.opacity(0.5))
                    .frame(width: 32, height: 32)
                    .overlay {
                        Text(String(item.prefix(1)))
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.white)
                    }
                
                Text(item)
                    .font(.subheadline)
                
                Spacer()
                
                if selectedItem == item {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
            }
            .padding(.vertical, 4)
        }
        .frame(height: 280)
    }
    
    // MARK: - Sheet Showcase
    
    private var sheetShowcase: some View {
        GlassButton("Present Glass Sheet", icon: "rectangle.portrait.and.arrow.forward", style: .primary) {
            isSheetPresented = true
        }
    }
}

// MARK: - Effects Showcase

/// Demonstrates liquid glass visual effects.
struct EffectsShowcaseView: View {
    
    // MARK: - Properties
    
    @State private var rippleLocation: CGPoint = .zero
    @State private var isRippleActive: Bool = false
    @State private var waveAmplitude: CGFloat = 10
    @State private var waveFrequency: CGFloat = 3
    @State private var animationSpeed: CGFloat = 1.0
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Ripple Effect Demo
                effectSection("Ripple Effect") {
                    rippleEffectDemo
                }
                
                // Wave Effect Demo
                effectSection("Wave Effect") {
                    waveEffectDemo
                }
                
                // Liquid Animation Demo
                effectSection("Liquid Animation") {
                    liquidAnimationDemo
                }
                
                // Combined Effects
                effectSection("Combined Effects") {
                    combinedEffectsDemo
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }
    
    // MARK: - Section Builder
    
    private func effectSection<Content: View>(
        _ title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.9))
            
            content()
        }
    }
    
    // MARK: - Ripple Effect Demo
    
    private var rippleEffectDemo: some View {
        GlassCard(style: .standard) {
            VStack(spacing: 16) {
                ZStack {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .modifier(
                            RippleEffect(
                                origin: rippleLocation,
                                isActive: isRippleActive,
                                configuration: .init(
                                    amplitude: 12,
                                    frequency: 8,
                                    decay: 4,
                                    duration: 1.2
                                )
                            )
                        )
                        .onTapGesture { location in
                            rippleLocation = location
                            isRippleActive = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                isRippleActive = false
                            }
                        }
                    
                    Text("Tap anywhere to create ripples")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.8))
                }
                
                Text("Touch interaction creates expanding wave patterns")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(16)
        }
    }
    
    // MARK: - Wave Effect Demo
    
    private var waveEffectDemo: some View {
        GlassCard(style: .standard) {
            VStack(spacing: 16) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.cyan.opacity(0.4), .teal.opacity(0.4)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .modifier(
                        WaveEffect(
                            configuration: .init(
                                amplitude: waveAmplitude,
                                frequency: waveFrequency,
                                phase: 0,
                                direction: .horizontal,
                                speed: animationSpeed
                            ),
                            isAnimating: true
                        )
                    )
                
                // Controls
                VStack(spacing: 12) {
                    controlSlider(
                        "Amplitude",
                        value: $waveAmplitude,
                        range: 1...30
                    )
                    
                    controlSlider(
                        "Frequency",
                        value: $waveFrequency,
                        range: 1...10
                    )
                    
                    controlSlider(
                        "Speed",
                        value: $animationSpeed,
                        range: 0.1...3.0
                    )
                }
            }
            .padding(16)
        }
    }
    
    // MARK: - Control Slider
    
    private func controlSlider(
        _ label: String,
        value: Binding<CGFloat>,
        range: ClosedRange<CGFloat>
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(label)
                    .font(.caption.weight(.medium))
                Spacer()
                Text(String(format: "%.1f", value.wrappedValue))
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
            
            Slider(value: value, in: range)
                .tint(.white.opacity(0.8))
        }
    }
    
    // MARK: - Liquid Animation Demo
    
    private var liquidAnimationDemo: some View {
        GlassCard(style: .standard) {
            VStack(spacing: 16) {
                HStack(spacing: 20) {
                    liquidBubble(color: .blue, delay: 0)
                    liquidBubble(color: .purple, delay: 0.2)
                    liquidBubble(color: .pink, delay: 0.4)
                    liquidBubble(color: .orange, delay: 0.6)
                }
                .frame(height: 120)
                
                Text("Organic liquid motion with physics-based animations")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(16)
        }
    }
    
    private func liquidBubble(color: Color, delay: Double) -> some View {
        Circle()
            .fill(color.opacity(0.6))
            .frame(width: 50, height: 50)
            .modifier(
                LiquidAnimation(
                    configuration: .init(
                        tension: 0.8,
                        friction: 0.3,
                        mass: 1.0,
                        velocity: 0.5
                    ),
                    trigger: true
                )
            )
            .animation(
                .spring(response: 0.8, dampingFraction: 0.6)
                    .delay(delay)
                    .repeatForever(autoreverses: true),
                value: delay
            )
    }
    
    // MARK: - Combined Effects Demo
    
    private var combinedEffectsDemo: some View {
        GlassCard(style: .prominent) {
            VStack(spacing: 16) {
                ZStack {
                    // Base layer with wave
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [
                                    .indigo.opacity(0.4),
                                    .purple.opacity(0.3),
                                    .blue.opacity(0.4)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 180)
                        .modifier(
                            WaveEffect(
                                configuration: .init(
                                    amplitude: 5,
                                    frequency: 2,
                                    direction: .horizontal,
                                    speed: 0.5
                                ),
                                isAnimating: true
                            )
                        )
                    
                    // Content overlay
                    VStack(spacing: 8) {
                        Image(systemName: "water.waves")
                            .font(.system(size: 40))
                            .foregroundStyle(.white)
                        
                        Text("Multiple Effects Combined")
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        Text("Wave + Ripple + Liquid Animation")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(16)
        }
    }
}

// MARK: - Materials Showcase

/// Demonstrates different glass material types.
struct MaterialsShowcaseView: View {
    
    // MARK: - Properties
    
    @State private var selectedMaterial: MaterialType = .aqua
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Material Selector
                materialSelector
                
                // Material Preview
                materialPreview
                
                // Material Properties
                materialProperties
                
                // All Materials Grid
                allMaterialsGrid
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }
    
    // MARK: - Material Types
    
    enum MaterialType: String, CaseIterable, Identifiable {
        case aqua
        case crystal
        case frosted
        case dark
        case clear
        
        var id: String { rawValue }
        
        var displayName: String {
            rawValue.capitalized
        }
        
        var icon: String {
            switch self {
            case .aqua: return "drop.fill"
            case .crystal: return "diamond.fill"
            case .frosted: return "snowflake"
            case .dark: return "moon.fill"
            case .clear: return "sparkle"
            }
        }
        
        var gradient: [Color] {
            switch self {
            case .aqua:
                return [.cyan, .blue, .teal]
            case .crystal:
                return [.purple, .pink, .indigo]
            case .frosted:
                return [.white.opacity(0.8), .gray.opacity(0.6)]
            case .dark:
                return [.black.opacity(0.8), .gray.opacity(0.4)]
            case .clear:
                return [.white.opacity(0.3), .white.opacity(0.1)]
            }
        }
    }
    
    // MARK: - Material Selector
    
    private var materialSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(MaterialType.allCases) { material in
                    GlassButton(
                        material.displayName,
                        icon: material.icon,
                        style: selectedMaterial == material ? .primary : .secondary
                    ) {
                        withAnimation(.smooth) {
                            selectedMaterial = material
                        }
                    }
                }
            }
            .padding(.horizontal, 4)
        }
    }
    
    // MARK: - Material Preview
    
    private var materialPreview: some View {
        GlassCard(style: .prominent) {
            VStack(spacing: 20) {
                // Preview area
                ZStack {
                    // Background pattern
                    Image(systemName: "circle.hexagongrid.fill")
                        .font(.system(size: 100))
                        .foregroundStyle(
                            LinearGradient(
                                colors: selectedMaterial.gradient,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    // Material overlay based on selection
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                        .frame(width: 200, height: 150)
                        .overlay {
                            VStack(spacing: 8) {
                                Image(systemName: selectedMaterial.icon)
                                    .font(.title)
                                Text(selectedMaterial.displayName)
                                    .font(.headline)
                            }
                            .foregroundStyle(.white)
                        }
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                Text("Live preview of \(selectedMaterial.displayName) material")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(16)
        }
    }
    
    // MARK: - Material Properties
    
    private var materialProperties: some View {
        GlassCard(style: .standard) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Material Properties")
                    .font(.headline)
                
                propertyRow("Blur Radius", value: "20pt")
                propertyRow("Saturation", value: "1.8x")
                propertyRow("Opacity", value: "85%")
                propertyRow("Tint Color", value: selectedMaterial.displayName)
                propertyRow("Reflection", value: "Enabled")
            }
            .padding(16)
        }
    }
    
    private func propertyRow(_ label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline.weight(.medium))
        }
    }
    
    // MARK: - All Materials Grid
    
    private var allMaterialsGrid: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("All Materials")
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.9))
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 12
            ) {
                ForEach(MaterialType.allCases) { material in
                    materialGridItem(material)
                }
            }
        }
    }
    
    private func materialGridItem(_ material: MaterialType) -> some View {
        GlassCard(style: .compact) {
            VStack(spacing: 12) {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: material.gradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 50, height: 50)
                    .overlay {
                        Image(systemName: material.icon)
                            .font(.title3)
                            .foregroundStyle(.white)
                    }
                
                Text(material.displayName)
                    .font(.caption.weight(.medium))
            }
            .padding(16)
            .frame(maxWidth: .infinity)
        }
        .onTapGesture {
            withAnimation(.smooth) {
                selectedMaterial = material
            }
        }
    }
}

// MARK: - Themes Showcase

/// Demonstrates the day/night theming system.
struct ThemesShowcaseView: View {
    
    // MARK: - Properties
    
    @State private var currentTime: Date = Date()
    @State private var manualTimeOverride: Bool = false
    @State private var simulatedHour: Double = 12
    @State private var selectedPreset: ThemePreset = .automatic
    
    // MARK: - Timer
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Current theme status
                themeStatusCard
                
                // Time simulation
                timeSimulationCard
                
                // Theme presets
                themePresetsCard
                
                // Theme comparison
                themeComparisonCard
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .onReceive(timer) { _ in
            if !manualTimeOverride {
                currentTime = Date()
            }
        }
    }
    
    // MARK: - Theme Preset
    
    enum ThemePreset: String, CaseIterable, Identifiable {
        case automatic
        case alwaysLight
        case alwaysDark
        case sunset
        case midnight
        
        var id: String { rawValue }
        
        var displayName: String {
            switch self {
            case .automatic: return "Automatic"
            case .alwaysLight: return "Always Light"
            case .alwaysDark: return "Always Dark"
            case .sunset: return "Sunset Mode"
            case .midnight: return "Midnight Mode"
            }
        }
        
        var icon: String {
            switch self {
            case .automatic: return "circle.lefthalf.filled"
            case .alwaysLight: return "sun.max.fill"
            case .alwaysDark: return "moon.fill"
            case .sunset: return "sunset.fill"
            case .midnight: return "moon.stars.fill"
            }
        }
    }
    
    // MARK: - Theme Status Card
    
    private var themeStatusCard: some View {
        GlassCard(style: .prominent) {
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: isNightTime ? "moon.fill" : "sun.max.fill")
                        .font(.largeTitle)
                        .foregroundStyle(isNightTime ? .indigo : .orange)
                        .symbolEffect(.pulse)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(isNightTime ? "Night Mode" : "Day Mode")
                            .font(.title2.weight(.semibold))
                        
                        Text(timeFormatter.string(from: effectiveTime))
                            .font(.subheadline.monospacedDigit())
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                
                // Day/Night progress bar
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "sunrise.fill")
                            .foregroundStyle(.orange)
                        Spacer()
                        Image(systemName: "sun.max.fill")
                            .foregroundStyle(.yellow)
                        Spacer()
                        Image(systemName: "sunset.fill")
                            .foregroundStyle(.orange)
                        Spacer()
                        Image(systemName: "moon.fill")
                            .foregroundStyle(.indigo)
                    }
                    .font(.caption)
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(.white.opacity(0.2))
                            
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [.orange, .yellow, .orange, .indigo],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: geometry.size.width * dayProgress)
                        }
                    }
                    .frame(height: 8)
                }
            }
            .padding(20)
        }
    }
    
    // MARK: - Time Simulation Card
    
    private var timeSimulationCard: some View {
        GlassCard(style: .standard) {
            VStack(spacing: 16) {
                HStack {
                    Text("Time Simulation")
                        .font(.headline)
                    Spacer()
                    Toggle("Manual", isOn: $manualTimeOverride)
                        .labelsHidden()
                }
                
                if manualTimeOverride {
                    VStack(spacing: 8) {
                        Text(simulatedTimeString)
                            .font(.title3.monospacedDigit().weight(.medium))
                        
                        Slider(value: $simulatedHour, in: 0...24, step: 0.5)
                            .tint(.white.opacity(0.8))
                        
                        HStack {
                            Text("00:00")
                            Spacer()
                            Text("12:00")
                            Spacer()
                            Text("24:00")
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                }
                
                Text("Simulate different times of day to preview theme transitions")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(16)
        }
    }
    
    // MARK: - Theme Presets Card
    
    private var themePresetsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Theme Presets")
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.9))
            
            ForEach(ThemePreset.allCases) { preset in
                GlassCard(style: selectedPreset == preset ? .prominent : .compact) {
                    HStack(spacing: 12) {
                        Image(systemName: preset.icon)
                            .font(.title2)
                            .foregroundStyle(presetColor(for: preset))
                            .frame(width: 40)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(preset.displayName)
                                .font(.subheadline.weight(.medium))
                            Text(presetDescription(for: preset))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        if selectedPreset == preset {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        }
                    }
                    .padding(12)
                }
                .onTapGesture {
                    withAnimation(.smooth) {
                        selectedPreset = preset
                    }
                }
            }
        }
    }
    
    // MARK: - Theme Comparison Card
    
    private var themeComparisonCard: some View {
        GlassCard(style: .standard) {
            VStack(spacing: 16) {
                Text("Theme Comparison")
                    .font(.headline)
                
                HStack(spacing: 16) {
                    // Day preview
                    VStack(spacing: 8) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    colors: [.cyan.opacity(0.3), .blue.opacity(0.2)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(height: 80)
                            .overlay {
                                Image(systemName: "sun.max.fill")
                                    .font(.title)
                                    .foregroundStyle(.orange)
                            }
                        
                        Text("Day")
                            .font(.caption.weight(.medium))
                    }
                    
                    // Night preview
                    VStack(spacing: 8) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    colors: [.indigo.opacity(0.5), .purple.opacity(0.3)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(height: 80)
                            .overlay {
                                Image(systemName: "moon.stars.fill")
                                    .font(.title)
                                    .foregroundStyle(.white)
                            }
                        
                        Text("Night")
                            .font(.caption.weight(.medium))
                    }
                }
            }
            .padding(16)
        }
    }
    
    // MARK: - Computed Properties
    
    private var effectiveTime: Date {
        if manualTimeOverride {
            var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            components.hour = Int(simulatedHour)
            components.minute = Int((simulatedHour.truncatingRemainder(dividingBy: 1)) * 60)
            return Calendar.current.date(from: components) ?? Date()
        }
        return currentTime
    }
    
    private var isNightTime: Bool {
        let hour = Calendar.current.component(.hour, from: effectiveTime)
        return hour < 6 || hour >= 20
    }
    
    private var dayProgress: CGFloat {
        let hour = manualTimeOverride ? simulatedHour : Double(Calendar.current.component(.hour, from: currentTime))
        return CGFloat(hour / 24.0)
    }
    
    private var simulatedTimeString: String {
        let hours = Int(simulatedHour)
        let minutes = Int((simulatedHour.truncatingRemainder(dividingBy: 1)) * 60)
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }
    
    // MARK: - Helper Methods
    
    private func presetColor(for preset: ThemePreset) -> Color {
        switch preset {
        case .automatic: return .blue
        case .alwaysLight: return .orange
        case .alwaysDark: return .indigo
        case .sunset: return .orange
        case .midnight: return .purple
        }
    }
    
    private func presetDescription(for preset: ThemePreset) -> String {
        switch preset {
        case .automatic: return "Follows system and time of day"
        case .alwaysLight: return "Bright theme regardless of time"
        case .alwaysDark: return "Dark theme regardless of time"
        case .sunset: return "Warm tones with golden hour feel"
        case .midnight: return "Deep blues with starlight accents"
        }
    }
}

// MARK: - Animations Showcase

/// Demonstrates animation capabilities and transitions.
struct AnimationsShowcaseView: View {
    
    // MARK: - Properties
    
    @State private var isAnimating: Bool = false
    @State private var selectedTransition: TransitionType = .slide
    @State private var showTransitionDemo: Bool = false
    @State private var morphProgress: CGFloat = 0
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Spring animations
                springAnimationsCard
                
                // Morph animations
                morphAnimationsCard
                
                // Transitions
                transitionsCard
                
                // Interactive demo
                interactiveDemoCard
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }
    
    // MARK: - Transition Types
    
    enum TransitionType: String, CaseIterable, Identifiable {
        case slide
        case scale
        case opacity
        case blur
        case morph
        
        var id: String { rawValue }
        
        var displayName: String {
            rawValue.capitalized
        }
    }
    
    // MARK: - Spring Animations Card
    
    private var springAnimationsCard: some View {
        GlassCard(style: .standard) {
            VStack(spacing: 16) {
                Text("Spring Animations")
                    .font(.headline)
                
                HStack(spacing: 20) {
                    springBall(response: 0.3, damping: 0.5)
                    springBall(response: 0.5, damping: 0.7)
                    springBall(response: 0.8, damping: 0.9)
                }
                .frame(height: 100)
                
                GlassButton(isAnimating ? "Stop" : "Animate", style: .primary) {
                    withAnimation {
                        isAnimating.toggle()
                    }
                }
                
                Text("Different spring responses and damping values")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(16)
        }
    }
    
    private func springBall(response: Double, damping: Double) -> some View {
        Circle()
            .fill(
                LinearGradient(
                    colors: [.cyan, .blue],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: 40, height: 40)
            .offset(y: isAnimating ? -30 : 30)
            .animation(
                .spring(response: response, dampingFraction: damping)
                    .repeatForever(autoreverses: true),
                value: isAnimating
            )
    }
    
    // MARK: - Morph Animations Card
    
    private var morphAnimationsCard: some View {
        GlassCard(style: .standard) {
            VStack(spacing: 16) {
                Text("Morph Animations")
                    .font(.headline)
                
                ZStack {
                    if morphProgress < 0.5 {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.blue.opacity(0.5))
                            .frame(width: 100, height: 100)
                    } else {
                        Circle()
                            .fill(.purple.opacity(0.5))
                            .frame(width: 100, height: 100)
                    }
                }
                .frame(height: 120)
                
                Slider(value: $morphProgress, in: 0...1)
                    .tint(.white.opacity(0.8))
                
                HStack {
                    Text("Square")
                    Spacer()
                    Text("Circle")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding(16)
        }
        .animation(.smooth, value: morphProgress)
    }
    
    // MARK: - Transitions Card
    
    private var transitionsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Glass Transitions")
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.9))
            
            GlassCard(style: .standard) {
                VStack(spacing: 16) {
                    // Transition selector
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(TransitionType.allCases) { type in
                                GlassButton(
                                    type.displayName,
                                    style: selectedTransition == type ? .primary : .secondary
                                ) {
                                    selectedTransition = type
                                }
                            }
                        }
                    }
                    
                    // Demo area
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white.opacity(0.1))
                            .frame(height: 150)
                        
                        if showTransitionDemo {
                            transitionContent
                                .transition(transitionFor(selectedTransition))
                        }
                    }
                    
                    GlassButton(
                        showTransitionDemo ? "Hide" : "Show",
                        style: .primary
                    ) {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                            showTransitionDemo.toggle()
                        }
                    }
                }
                .padding(16)
            }
        }
    }
    
    private var transitionContent: some View {
        VStack(spacing: 8) {
            Image(systemName: "sparkles")
                .font(.largeTitle)
            Text("Transition Content")
                .font(.headline)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue.opacity(0.3))
        )
    }
    
    private func transitionFor(_ type: TransitionType) -> AnyTransition {
        switch type {
        case .slide: return .slide
        case .scale: return .scale
        case .opacity: return .opacity
        case .blur: return .opacity.combined(with: .scale(scale: 0.9))
        case .morph: return .asymmetric(
            insertion: .scale.combined(with: .opacity),
            removal: .scale(scale: 1.1).combined(with: .opacity)
        )
        }
    }
    
    // MARK: - Interactive Demo Card
    
    private var interactiveDemoCard: some View {
        GlassCard(style: .prominent) {
            VStack(spacing: 16) {
                Text("Interactive Animation Lab")
                    .font(.headline)
                
                Text("Combine multiple animation techniques to create fluid liquid glass experiences.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                
                HStack(spacing: 12) {
                    animatedIcon("drop.fill", color: .cyan, delay: 0)
                    animatedIcon("sparkles", color: .purple, delay: 0.1)
                    animatedIcon("waveform", color: .pink, delay: 0.2)
                    animatedIcon("cube.transparent.fill", color: .orange, delay: 0.3)
                }
                .padding(.vertical, 8)
            }
            .padding(20)
        }
    }
    
    private func animatedIcon(_ name: String, color: Color, delay: Double) -> some View {
        Image(systemName: name)
            .font(.title)
            .foregroundStyle(color)
            .scaleEffect(isAnimating ? 1.2 : 1.0)
            .opacity(isAnimating ? 1.0 : 0.6)
            .animation(
                .spring(response: 0.6, dampingFraction: 0.5)
                    .delay(delay)
                    .repeatForever(autoreverses: true),
                value: isAnimating
            )
    }
}

// MARK: - Preview Provider

#Preview {
    MainShowcaseView()
        .preferredColorScheme(.dark)
}
