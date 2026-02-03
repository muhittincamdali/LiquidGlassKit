//
//  LiquidSearch.swift
//  LiquidGlassKit
//
//  Created by Muhittin Camdali on 2025.
//  Copyright © 2025 Muhittin Camdali. All rights reserved.
//

import SwiftUI
import Combine

// MARK: - Liquid Search Configuration

/// Configuration options for liquid search components.
public struct LiquidSearchConfiguration: Equatable, Sendable {
    /// The background style for the search bar
    public var backgroundStyle: BackgroundStyle
    
    /// The corner radius of the search bar
    public var cornerRadius: CGFloat
    
    /// The height of the search bar
    public var height: CGFloat
    
    /// The placeholder text
    public var placeholder: String
    
    /// The icon to display
    public var searchIcon: String
    
    /// Whether to show the cancel button when active
    public var showsCancelButton: Bool
    
    /// The tint color for icons and cursor
    public var tintColor: Color
    
    /// Whether to animate focus changes
    public var animatesFocus: Bool
    
    /// The search delay for debouncing
    public var debounceDelay: TimeInterval
    
    /// Whether to show search suggestions
    public var showsSuggestions: Bool
    
    /// The maximum number of suggestions to show
    public var maxSuggestions: Int
    
    /// Whether to enable voice search
    public var enableVoiceSearch: Bool
    
    /// Creates a new liquid search configuration
    public init(
        backgroundStyle: BackgroundStyle = .glass,
        cornerRadius: CGFloat = 12,
        height: CGFloat = 44,
        placeholder: String = "Search",
        searchIcon: String = "magnifyingglass",
        showsCancelButton: Bool = true,
        tintColor: Color = .primary,
        animatesFocus: Bool = true,
        debounceDelay: TimeInterval = 0.3,
        showsSuggestions: Bool = true,
        maxSuggestions: Int = 5,
        enableVoiceSearch: Bool = false
    ) {
        self.backgroundStyle = backgroundStyle
        self.cornerRadius = cornerRadius
        self.height = height
        self.placeholder = placeholder
        self.searchIcon = searchIcon
        self.showsCancelButton = showsCancelButton
        self.tintColor = tintColor
        self.animatesFocus = animatesFocus
        self.debounceDelay = debounceDelay
        self.showsSuggestions = showsSuggestions
        self.maxSuggestions = maxSuggestions
        self.enableVoiceSearch = enableVoiceSearch
    }
    
    /// Background style options
    public enum BackgroundStyle: String, CaseIterable, Sendable {
        case glass
        case solid
        case gradient
        case aqua
        case crystal
        case minimal
    }
    
    /// Default configuration preset
    public static let `default` = LiquidSearchConfiguration()
    
    /// Compact configuration preset
    public static let compact = LiquidSearchConfiguration(
        cornerRadius: 8,
        height: 36,
        showsCancelButton: false
    )
    
    /// Prominent configuration preset
    public static let prominent = LiquidSearchConfiguration(
        cornerRadius: 16,
        height: 52,
        animatesFocus: true
    )
}

// MARK: - Liquid Search Bar

/// A search bar with liquid glass styling.
public struct LiquidSearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    @State private var showCancelButton = false
    
    let configuration: LiquidSearchConfiguration
    let onSearch: ((String) -> Void)?
    let onCancel: (() -> Void)?
    
    /// Creates a liquid search bar
    public init(
        text: Binding<String>,
        configuration: LiquidSearchConfiguration = .default,
        onSearch: ((String) -> Void)? = nil,
        onCancel: (() -> Void)? = nil
    ) {
        self._text = text
        self.configuration = configuration
        self.onSearch = onSearch
        self.onCancel = onCancel
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            // Search field
            HStack(spacing: 8) {
                // Search icon
                Image(systemName: configuration.searchIcon)
                    .foregroundColor(configuration.tintColor.opacity(0.6))
                    .font(.body)
                
                // Text field
                TextField(configuration.placeholder, text: $text)
                    .focused($isFocused)
                    .textFieldStyle(.plain)
                    .submitLabel(.search)
                    .onSubmit {
                        onSearch?(text)
                    }
                
                // Clear button
                if !text.isEmpty {
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            text = ""
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                            .font(.body)
                    }
                    .transition(.scale.combined(with: .opacity))
                }
                
                // Voice search button
                if configuration.enableVoiceSearch && text.isEmpty {
                    Button {
                        // Voice search action
                    } label: {
                        Image(systemName: "mic.fill")
                            .foregroundColor(configuration.tintColor.opacity(0.6))
                            .font(.body)
                    }
                }
            }
            .padding(.horizontal, 12)
            .frame(height: configuration.height)
            .background {
                searchBarBackground
            }
            .clipShape(RoundedRectangle(cornerRadius: configuration.cornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: configuration.cornerRadius)
                    .stroke(
                        isFocused ? configuration.tintColor.opacity(0.5) : .white.opacity(0.2),
                        lineWidth: isFocused ? 2 : 1
                    )
            }
            .scaleEffect(isFocused && configuration.animatesFocus ? 1.02 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isFocused)
            
            // Cancel button
            if configuration.showsCancelButton && showCancelButton {
                Button("Cancel") {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        text = ""
                        isFocused = false
                        showCancelButton = false
                    }
                    onCancel?()
                }
                .foregroundColor(configuration.tintColor)
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .onChange(of: isFocused) { _, focused in
            withAnimation(.easeInOut(duration: 0.2)) {
                showCancelButton = focused
            }
        }
    }
    
    @ViewBuilder
    private var searchBarBackground: some View {
        switch configuration.backgroundStyle {
        case .glass:
            Rectangle()
                .fill(.ultraThinMaterial)
        case .solid:
            Rectangle()
                .fill(Color(.systemGray6))
        case .gradient:
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [.white.opacity(0.1), .white.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .background(.ultraThinMaterial)
        case .aqua:
            AquaMaterialView(configuration: .clearWater)
        case .crystal:
            CrystalMaterialView(configuration: .frostedGlass)
        case .minimal:
            Rectangle()
                .fill(.clear)
        }
    }
}

// MARK: - Debounced Search Bar

/// A search bar with debounced search functionality.
public struct DebouncedSearchBar: View {
    @Binding var text: String
    @State private var debouncedText: String = ""
    
    let configuration: LiquidSearchConfiguration
    let onDebouncedSearch: (String) -> Void
    
    /// Creates a debounced search bar
    public init(
        text: Binding<String>,
        configuration: LiquidSearchConfiguration = .default,
        onDebouncedSearch: @escaping (String) -> Void
    ) {
        self._text = text
        self.configuration = configuration
        self.onDebouncedSearch = onDebouncedSearch
    }
    
    public var body: some View {
        LiquidSearchBar(text: $text, configuration: configuration)
            .onChange(of: text) { _, newValue in
                debounceSearch(newValue)
            }
    }
    
    private func debounceSearch(_ value: String) {
        let delay = configuration.debounceDelay
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if text == value {
                debouncedText = value
                onDebouncedSearch(value)
            }
        }
    }
}

// MARK: - Search Bar with Suggestions

/// A search bar that displays suggestions.
public struct LiquidSearchBarWithSuggestions<Suggestion: Identifiable & CustomStringConvertible>: View {
    @Binding var text: String
    @Binding var suggestions: [Suggestion]
    @State private var showSuggestions = false
    @FocusState private var isFocused: Bool
    
    let configuration: LiquidSearchConfiguration
    let onSearch: (String) -> Void
    let onSuggestionSelected: (Suggestion) -> Void
    
    /// Creates a search bar with suggestions
    public init(
        text: Binding<String>,
        suggestions: Binding<[Suggestion]>,
        configuration: LiquidSearchConfiguration = .default,
        onSearch: @escaping (String) -> Void,
        onSuggestionSelected: @escaping (Suggestion) -> Void
    ) {
        self._text = text
        self._suggestions = suggestions
        self.configuration = configuration
        self.onSearch = onSearch
        self.onSuggestionSelected = onSuggestionSelected
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Search bar
            LiquidSearchBar(
                text: $text,
                configuration: configuration,
                onSearch: onSearch
            )
            
            // Suggestions dropdown
            if showSuggestions && !suggestions.isEmpty && configuration.showsSuggestions {
                VStack(spacing: 0) {
                    ForEach(suggestions.prefix(configuration.maxSuggestions)) { suggestion in
                        SuggestionRow(
                            suggestion: suggestion,
                            searchText: text
                        ) {
                            text = suggestion.description
                            showSuggestions = false
                            onSuggestionSelected(suggestion)
                        }
                        
                        if suggestion.id as AnyHashable != suggestions.prefix(configuration.maxSuggestions).last?.id as AnyHashable {
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                }
                .background {
                    RoundedRectangle(cornerRadius: configuration.cornerRadius)
                        .fill(.ultraThinMaterial)
                        .overlay {
                            RoundedRectangle(cornerRadius: configuration.cornerRadius)
                                .stroke(.white.opacity(0.2), lineWidth: 1)
                        }
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
                .padding(.top, 4)
            }
        }
        .onChange(of: text) { _, newValue in
            withAnimation(.easeInOut(duration: 0.2)) {
                showSuggestions = !newValue.isEmpty
            }
        }
        .onChange(of: isFocused) { _, focused in
            if !focused {
                withAnimation {
                    showSuggestions = false
                }
            }
        }
    }
}

/// A single suggestion row
struct SuggestionRow<Suggestion: CustomStringConvertible>: View {
    let suggestion: Suggestion
    let searchText: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .font(.caption)
                
                highlightedText
                
                Spacer()
                
                Image(systemName: "arrow.up.left")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    private var highlightedText: some View {
        let text = suggestion.description
        let searchLower = searchText.lowercased()
        let textLower = text.lowercased()
        
        if let range = textLower.range(of: searchLower) {
            let before = String(text[..<range.lowerBound])
            let match = String(text[range])
            let after = String(text[range.upperBound...])
            
            return Text(before) + Text(match).fontWeight(.bold) + Text(after)
        }
        
        return Text(text)
    }
}

// MARK: - Search Scope Selector

/// A segmented control for selecting search scope.
public struct SearchScopeSelector<Scope: Hashable>: View {
    @Binding var selection: Scope
    
    let scopes: [(Scope, String)]
    let style: ScopeSelectorStyle
    
    /// Creates a search scope selector
    public init(
        selection: Binding<Scope>,
        scopes: [(Scope, String)],
        style: ScopeSelectorStyle = .capsule
    ) {
        self._selection = selection
        self.scopes = scopes
        self.style = style
    }
    
    /// Scope selector style options
    public enum ScopeSelectorStyle {
        case capsule
        case underline
        case glass
    }
    
    public var body: some View {
        HStack(spacing: style == .underline ? 20 : 8) {
            ForEach(scopes, id: \.0) { scope, title in
                scopeButton(scope: scope, title: title)
            }
        }
    }
    
    @ViewBuilder
    private func scopeButton(scope: Scope, title: String) -> some View {
        let isSelected = selection == scope
        
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                selection = scope
            }
        } label: {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .primary : .secondary)
                .padding(.horizontal, style == .underline ? 0 : 16)
                .padding(.vertical, 8)
                .background {
                    if style != .underline {
                        scopeBackground(isSelected: isSelected)
                    }
                }
                .overlay(alignment: .bottom) {
                    if style == .underline && isSelected {
                        Rectangle()
                            .fill(Color.accentColor)
                            .frame(height: 2)
                            .matchedGeometryEffect(id: "underline", in: Namespace().wrappedValue)
                    }
                }
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    private func scopeBackground(isSelected: Bool) -> some View {
        switch style {
        case .capsule:
            Capsule()
                .fill(isSelected ? Color.accentColor : .clear)
        case .glass:
            Capsule()
                .fill(isSelected ? .ultraThinMaterial : .clear)
                .overlay {
                    if isSelected {
                        Capsule()
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                    }
                }
        case .underline:
            EmptyView()
        }
    }
}

// MARK: - Search Results Header

/// A header view for search results.
public struct SearchResultsHeader: View {
    let resultCount: Int
    let searchTerm: String
    let sortOptions: [String]?
    @Binding var selectedSort: String?
    
    /// Creates a search results header
    public init(
        resultCount: Int,
        searchTerm: String,
        sortOptions: [String]? = nil,
        selectedSort: Binding<String?> = .constant(nil)
    ) {
        self.resultCount = resultCount
        self.searchTerm = searchTerm
        self.sortOptions = sortOptions
        self._selectedSort = selectedSort
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("\(resultCount) results")
                    .font(.headline)
                
                if !searchTerm.isEmpty {
                    Text("for \"\(searchTerm)\"")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            if let options = sortOptions, !options.isEmpty {
                Menu {
                    ForEach(options, id: \.self) { option in
                        Button {
                            selectedSort = option
                        } label: {
                            HStack {
                                Text(option)
                                if selectedSort == option {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text(selectedSort ?? "Sort")
                            .font(.subheadline)
                        Image(systemName: "chevron.down")
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                }
            }
        }
        .padding()
    }
}

// MARK: - Empty Search Results View

/// A view to display when search results are empty.
public struct EmptySearchResultsView: View {
    let searchTerm: String
    let suggestions: [String]
    let onSuggestionTap: ((String) -> Void)?
    
    /// Creates an empty search results view
    public init(
        searchTerm: String,
        suggestions: [String] = [],
        onSuggestionTap: ((String) -> Void)? = nil
    ) {
        self.searchTerm = searchTerm
        self.suggestions = suggestions
        self.onSuggestionTap = onSuggestionTap
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(.secondary)
            
            VStack(spacing: 8) {
                Text("No results for \"\(searchTerm)\"")
                    .font(.headline)
                
                Text("Try searching for something else")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if !suggestions.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Suggestions")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    ForEach(suggestions, id: \.self) { suggestion in
                        Button {
                            onSuggestionTap?(suggestion)
                        } label: {
                            HStack {
                                Image(systemName: "arrow.turn.down.right")
                                    .font(.caption)
                                Text(suggestion)
                            }
                            .foregroundColor(.accentColor)
                        }
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.ultraThinMaterial)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

// MARK: - Recent Searches View

/// A view displaying recent search history.
public struct RecentSearchesView: View {
    @Binding var recentSearches: [String]
    let onSearchTap: (String) -> Void
    let onClearAll: () -> Void
    
    /// Creates a recent searches view
    public init(
        recentSearches: Binding<[String]>,
        onSearchTap: @escaping (String) -> Void,
        onClearAll: @escaping () -> Void
    ) {
        self._recentSearches = recentSearches
        self.onSearchTap = onSearchTap
        self.onClearAll = onClearAll
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Recent Searches")
                    .font(.headline)
                
                Spacer()
                
                Button("Clear All") {
                    withAnimation {
                        onClearAll()
                    }
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            
            if recentSearches.isEmpty {
                Text("No recent searches")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 20)
            } else {
                ForEach(recentSearches, id: \.self) { search in
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.secondary)
                            .font(.caption)
                        
                        Text(search)
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                recentSearches.removeAll { $0 == search }
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onSearchTap(search)
                    }
                }
            }
        }
        .padding()
    }
}

// MARK: - Trending Searches View

/// A view displaying trending searches.
public struct TrendingSearchesView: View {
    let trending: [String]
    let onSearchTap: (String) -> Void
    
    /// Creates a trending searches view
    public init(
        trending: [String],
        onSearchTap: @escaping (String) -> Void
    ) {
        self.trending = trending
        self.onSearchTap = onSearchTap
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "arrow.up.right.circle.fill")
                    .foregroundColor(.orange)
                
                Text("Trending")
                    .font(.headline)
            }
            
            FlowLayout(spacing: 8) {
                ForEach(trending, id: \.self) { term in
                    Button {
                        onSearchTap(term)
                    } label: {
                        Text(term)
                            .font(.subheadline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background {
                                Capsule()
                                    .fill(.ultraThinMaterial)
                            }
                            .overlay {
                                Capsule()
                                    .stroke(.white.opacity(0.2), lineWidth: 1)
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
    }
}

// MARK: - Flow Layout

/// A layout that arranges views in a flowing manner.
struct FlowLayout: Layout {
    let spacing: CGFloat
    
    init(spacing: CGFloat = 8) {
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return layout(sizes: sizes, containerWidth: proposal.width ?? .infinity).size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let positions = layout(sizes: sizes, containerWidth: bounds.width).positions
        
        for (index, subview) in subviews.enumerated() {
            subview.place(
                at: CGPoint(
                    x: bounds.minX + positions[index].x,
                    y: bounds.minY + positions[index].y
                ),
                proposal: .unspecified
            )
        }
    }
    
    private func layout(sizes: [CGSize], containerWidth: CGFloat) -> (positions: [CGPoint], size: CGSize) {
        var positions: [CGPoint] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0
        var maxWidth: CGFloat = 0
        
        for size in sizes {
            if currentX + size.width > containerWidth && currentX > 0 {
                currentX = 0
                currentY += lineHeight + spacing
                lineHeight = 0
            }
            
            positions.append(CGPoint(x: currentX, y: currentY))
            
            currentX += size.width + spacing
            lineHeight = max(lineHeight, size.height)
            maxWidth = max(maxWidth, currentX - spacing)
        }
        
        return (positions, CGSize(width: maxWidth, height: currentY + lineHeight))
    }
}
