//
//  LiquidList.swift
//  LiquidGlassKit
//
//  Created by Muhittin Camdali on 2025.
//  Copyright © 2025 Muhittin Camdali. All rights reserved.
//

import SwiftUI

// MARK: - Liquid List Configuration

/// Configuration options for liquid list styling.
public struct LiquidListConfiguration: Equatable, Sendable {
    /// The background style for list rows
    public var rowBackground: RowBackgroundStyle
    
    /// The corner radius for rows
    public var rowCornerRadius: CGFloat
    
    /// The spacing between rows
    public var rowSpacing: CGFloat
    
    /// The horizontal padding for rows
    public var rowHorizontalPadding: CGFloat
    
    /// The vertical padding for rows
    public var rowVerticalPadding: CGFloat
    
    /// Whether to show row separators
    public var showSeparators: Bool
    
    /// The separator style
    public var separatorStyle: SeparatorStyle
    
    /// Whether to animate row appearance
    public var animateRows: Bool
    
    /// The animation delay between rows
    public var animationStagger: TimeInterval
    
    /// The swipe action style
    public var swipeActionStyle: SwipeActionStyle
    
    /// Creates a new liquid list configuration
    public init(
        rowBackground: RowBackgroundStyle = .glass,
        rowCornerRadius: CGFloat = 12,
        rowSpacing: CGFloat = 8,
        rowHorizontalPadding: CGFloat = 16,
        rowVerticalPadding: CGFloat = 12,
        showSeparators: Bool = false,
        separatorStyle: SeparatorStyle = .subtle,
        animateRows: Bool = true,
        animationStagger: TimeInterval = 0.05,
        swipeActionStyle: SwipeActionStyle = .glass
    ) {
        self.rowBackground = rowBackground
        self.rowCornerRadius = rowCornerRadius
        self.rowSpacing = rowSpacing
        self.rowHorizontalPadding = rowHorizontalPadding
        self.rowVerticalPadding = rowVerticalPadding
        self.showSeparators = showSeparators
        self.separatorStyle = separatorStyle
        self.animateRows = animateRows
        self.animationStagger = animationStagger
        self.swipeActionStyle = swipeActionStyle
    }
    
    /// Row background style options
    public enum RowBackgroundStyle: String, CaseIterable, Sendable {
        case glass
        case solid
        case gradient
        case transparent
        case aqua
        case crystal
    }
    
    /// Separator style options
    public enum SeparatorStyle: String, CaseIterable, Sendable {
        case subtle
        case prominent
        case gradient
        case dashed
        case none
    }
    
    /// Swipe action style options
    public enum SwipeActionStyle: String, CaseIterable, Sendable {
        case glass
        case solid
        case destructive
        case minimal
    }
    
    /// Default list style preset
    public static let `default` = LiquidListConfiguration()
    
    /// Compact list style preset
    public static let compact = LiquidListConfiguration(
        rowCornerRadius: 8,
        rowSpacing: 4,
        rowHorizontalPadding: 12,
        rowVerticalPadding: 8,
        animationStagger: 0.03
    )
    
    /// Expanded list style preset
    public static let expanded = LiquidListConfiguration(
        rowCornerRadius: 16,
        rowSpacing: 12,
        rowHorizontalPadding: 20,
        rowVerticalPadding: 16,
        animationStagger: 0.08
    )
    
    /// Card-style list preset
    public static let cards = LiquidListConfiguration(
        rowBackground: .glass,
        rowCornerRadius: 20,
        rowSpacing: 16,
        rowHorizontalPadding: 16,
        rowVerticalPadding: 16,
        showSeparators: false
    )
}

// MARK: - Liquid List View

/// A list view with liquid glass styling.
public struct LiquidList<Data: RandomAccessCollection, RowContent: View>: View where Data.Element: Identifiable {
    let data: Data
    let configuration: LiquidListConfiguration
    let rowContent: (Data.Element) -> RowContent
    
    @State private var visibleRows: Set<Data.Element.ID> = []
    
    /// Creates a liquid list
    public init(
        _ data: Data,
        configuration: LiquidListConfiguration = .default,
        @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent
    ) {
        self.data = data
        self.configuration = configuration
        self.rowContent = rowContent
    }
    
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: configuration.rowSpacing) {
                ForEach(Array(data.enumerated()), id: \.element.id) { index, item in
                    LiquidListRow(
                        configuration: configuration,
                        index: index,
                        isVisible: visibleRows.contains(item.id)
                    ) {
                        rowContent(item)
                    }
                    .onAppear {
                        if configuration.animateRows {
                            let delay = Double(index) * configuration.animationStagger
                            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                    visibleRows.insert(item.id)
                                }
                            }
                        } else {
                            visibleRows.insert(item.id)
                        }
                    }
                    
                    if configuration.showSeparators && index < data.count - 1 {
                        LiquidSeparator(style: configuration.separatorStyle)
                            .padding(.horizontal, configuration.rowHorizontalPadding)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Liquid List Row

/// A single row in a liquid list.
public struct LiquidListRow<Content: View>: View {
    let configuration: LiquidListConfiguration
    let index: Int
    let isVisible: Bool
    let content: Content
    
    /// Creates a liquid list row
    public init(
        configuration: LiquidListConfiguration,
        index: Int,
        isVisible: Bool,
        @ViewBuilder content: () -> Content
    ) {
        self.configuration = configuration
        self.index = index
        self.isVisible = isVisible
        self.content = content()
    }
    
    public var body: some View {
        content
            .padding(.horizontal, configuration.rowHorizontalPadding)
            .padding(.vertical, configuration.rowVerticalPadding)
            .background {
                rowBackground
            }
            .clipShape(RoundedRectangle(cornerRadius: configuration.rowCornerRadius))
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : 20)
            .scaleEffect(isVisible ? 1 : 0.95)
    }
    
    @ViewBuilder
    private var rowBackground: some View {
        switch configuration.rowBackground {
        case .glass:
            RoundedRectangle(cornerRadius: configuration.rowCornerRadius)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: configuration.rowCornerRadius)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                }
        case .solid:
            RoundedRectangle(cornerRadius: configuration.rowCornerRadius)
                .fill(Color(.systemBackground).opacity(0.8))
        case .gradient:
            RoundedRectangle(cornerRadius: configuration.rowCornerRadius)
                .fill(
                    LinearGradient(
                        colors: [.white.opacity(0.1), .white.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .background(.ultraThinMaterial)
        case .transparent:
            Color.clear
        case .aqua:
            AquaMaterialView(configuration: .clearWater)
                .clipShape(RoundedRectangle(cornerRadius: configuration.rowCornerRadius))
        case .crystal:
            CrystalMaterialView(configuration: .frostedGlass)
                .clipShape(RoundedRectangle(cornerRadius: configuration.rowCornerRadius))
        }
    }
}

// MARK: - Liquid Separator

/// A separator view for liquid lists.
public struct LiquidSeparator: View {
    let style: LiquidListConfiguration.SeparatorStyle
    
    /// Creates a liquid separator
    public init(style: LiquidListConfiguration.SeparatorStyle = .subtle) {
        self.style = style
    }
    
    public var body: some View {
        switch style {
        case .subtle:
            Rectangle()
                .fill(.white.opacity(0.1))
                .frame(height: 1)
        case .prominent:
            Rectangle()
                .fill(.white.opacity(0.3))
                .frame(height: 1)
        case .gradient:
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [.clear, .white.opacity(0.2), .clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 1)
        case .dashed:
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                .foregroundColor(.white.opacity(0.2))
                .frame(height: 1)
        case .none:
            EmptyView()
        }
    }
}

/// A simple line shape for dashed separators
struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

// MARK: - Liquid Section Header

/// A section header for liquid lists.
public struct LiquidSectionHeader: View {
    let title: String
    let subtitle: String?
    let icon: String?
    let style: HeaderStyle
    
    /// Creates a liquid section header
    public init(
        title: String,
        subtitle: String? = nil,
        icon: String? = nil,
        style: HeaderStyle = .default
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.style = style
    }
    
    /// Header style options
    public enum HeaderStyle {
        case `default`
        case prominent
        case minimal
        case glass
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(style == .prominent ? .title2 : .headline)
                    .fontWeight(style == .prominent ? .bold : .semibold)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, style == .prominent ? 16 : 12)
        .background {
            if style == .glass {
                Rectangle()
                    .fill(.ultraThinMaterial)
            }
        }
    }
}

// MARK: - Swipeable Liquid Row

/// A liquid list row with swipe actions.
public struct SwipeableLiquidRow<Content: View, LeadingActions: View, TrailingActions: View>: View {
    @State private var offset: CGFloat = 0
    @State private var isDragging = false
    @GestureState private var dragOffset: CGFloat = 0
    
    let content: Content
    let leadingActions: LeadingActions
    let trailingActions: TrailingActions
    let actionWidth: CGFloat
    let configuration: LiquidListConfiguration
    
    /// Creates a swipeable liquid row
    public init(
        configuration: LiquidListConfiguration = .default,
        actionWidth: CGFloat = 80,
        @ViewBuilder content: () -> Content,
        @ViewBuilder leadingActions: () -> LeadingActions = { EmptyView() },
        @ViewBuilder trailingActions: () -> TrailingActions = { EmptyView() }
    ) {
        self.configuration = configuration
        self.actionWidth = actionWidth
        self.content = content()
        self.leadingActions = leadingActions()
        self.trailingActions = trailingActions()
    }
    
    public var body: some View {
        ZStack {
            // Action backgrounds
            HStack(spacing: 0) {
                // Leading actions
                leadingActions
                    .frame(width: actionWidth)
                    .opacity(offset > 0 ? 1 : 0)
                
                Spacer()
                
                // Trailing actions
                trailingActions
                    .frame(width: actionWidth)
                    .opacity(offset < 0 ? 1 : 0)
            }
            
            // Main content
            content
                .padding(.horizontal, configuration.rowHorizontalPadding)
                .padding(.vertical, configuration.rowVerticalPadding)
                .background {
                    RoundedRectangle(cornerRadius: configuration.rowCornerRadius)
                        .fill(.ultraThinMaterial)
                        .overlay {
                            RoundedRectangle(cornerRadius: configuration.rowCornerRadius)
                                .stroke(.white.opacity(0.2), lineWidth: 1)
                        }
                }
                .offset(x: offset + dragOffset)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation.width
                        }
                        .onChanged { _ in
                            isDragging = true
                        }
                        .onEnded { value in
                            isDragging = false
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                if value.translation.width > actionWidth / 2 {
                                    offset = actionWidth
                                } else if value.translation.width < -actionWidth / 2 {
                                    offset = -actionWidth
                                } else {
                                    offset = 0
                                }
                            }
                        }
                )
        }
    }
    
    /// Resets the row to its default position
    public func reset() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            offset = 0
        }
    }
}

// MARK: - Swipe Action Button

/// A button for swipe actions in liquid lists.
public struct SwipeActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    /// Creates a swipe action button
    public init(
        title: String,
        icon: String,
        color: Color,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.color = color
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.title2)
                Text(title)
                    .font(.caption2)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color)
        }
    }
}

// MARK: - Expandable Liquid Row

/// A liquid list row that can expand to show more content.
public struct ExpandableLiquidRow<Content: View, ExpandedContent: View>: View {
    @State private var isExpanded = false
    
    let configuration: LiquidListConfiguration
    let content: Content
    let expandedContent: ExpandedContent
    
    /// Creates an expandable liquid row
    public init(
        configuration: LiquidListConfiguration = .default,
        @ViewBuilder content: () -> Content,
        @ViewBuilder expandedContent: () -> ExpandedContent
    ) {
        self.configuration = configuration
        self.content = content()
        self.expandedContent = expandedContent()
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Main content
            HStack {
                content
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
            }
            .padding(.horizontal, configuration.rowHorizontalPadding)
            .padding(.vertical, configuration.rowVerticalPadding)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                    isExpanded.toggle()
                }
            }
            
            // Expanded content
            if isExpanded {
                Divider()
                    .padding(.horizontal)
                
                expandedContent
                    .padding(.horizontal, configuration.rowHorizontalPadding)
                    .padding(.vertical, configuration.rowVerticalPadding)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background {
            RoundedRectangle(cornerRadius: configuration.rowCornerRadius)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: configuration.rowCornerRadius)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                }
        }
    }
}

// MARK: - Selectable Liquid List

/// A liquid list with selection support.
public struct SelectableLiquidList<Data: RandomAccessCollection, RowContent: View>: View where Data.Element: Identifiable {
    @Binding var selection: Set<Data.Element.ID>
    
    let data: Data
    let configuration: LiquidListConfiguration
    let allowsMultipleSelection: Bool
    let rowContent: (Data.Element, Bool) -> RowContent
    
    /// Creates a selectable liquid list
    public init(
        _ data: Data,
        selection: Binding<Set<Data.Element.ID>>,
        configuration: LiquidListConfiguration = .default,
        allowsMultipleSelection: Bool = true,
        @ViewBuilder rowContent: @escaping (Data.Element, Bool) -> RowContent
    ) {
        self.data = data
        self._selection = selection
        self.configuration = configuration
        self.allowsMultipleSelection = allowsMultipleSelection
        self.rowContent = rowContent
    }
    
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: configuration.rowSpacing) {
                ForEach(Array(data.enumerated()), id: \.element.id) { index, item in
                    let isSelected = selection.contains(item.id)
                    
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            toggleSelection(item.id)
                        }
                    } label: {
                        HStack {
                            rowContent(item, isSelected)
                            
                            Spacer()
                            
                            // Selection indicator
                            ZStack {
                                Circle()
                                    .stroke(isSelected ? Color.accentColor : .gray.opacity(0.3), lineWidth: 2)
                                    .frame(width: 24, height: 24)
                                
                                if isSelected {
                                    Circle()
                                        .fill(Color.accentColor)
                                        .frame(width: 16, height: 16)
                                        .transition(.scale)
                                }
                            }
                        }
                        .padding(.horizontal, configuration.rowHorizontalPadding)
                        .padding(.vertical, configuration.rowVerticalPadding)
                        .background {
                            RoundedRectangle(cornerRadius: configuration.rowCornerRadius)
                                .fill(isSelected ? .ultraThinMaterial : .regularMaterial)
                                .overlay {
                                    RoundedRectangle(cornerRadius: configuration.rowCornerRadius)
                                        .stroke(
                                            isSelected ? Color.accentColor.opacity(0.5) : .white.opacity(0.2),
                                            lineWidth: isSelected ? 2 : 1
                                        )
                                }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func toggleSelection(_ id: Data.Element.ID) {
        if selection.contains(id) {
            selection.remove(id)
        } else {
            if allowsMultipleSelection {
                selection.insert(id)
            } else {
                selection = [id]
            }
        }
    }
}

// MARK: - Liquid List Item

/// A pre-styled item for liquid lists.
public struct LiquidListItem: View {
    let title: String
    let subtitle: String?
    let icon: String?
    let iconColor: Color
    let accessoryType: AccessoryType
    
    /// Creates a liquid list item
    public init(
        title: String,
        subtitle: String? = nil,
        icon: String? = nil,
        iconColor: Color = .accentColor,
        accessoryType: AccessoryType = .none
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.iconColor = iconColor
        self.accessoryType = accessoryType
    }
    
    /// Accessory type options
    public enum AccessoryType {
        case none
        case chevron
        case checkmark
        case info
        case custom(AnyView)
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            // Icon
            if let icon = icon {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(iconColor)
                    .frame(width: 32, height: 32)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(iconColor.opacity(0.15))
                    }
            }
            
            // Text content
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // Accessory
            accessoryView
        }
    }
    
    @ViewBuilder
    private var accessoryView: some View {
        switch accessoryType {
        case .none:
            EmptyView()
        case .chevron:
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        case .checkmark:
            Image(systemName: "checkmark")
                .font(.caption)
                .foregroundColor(.accentColor)
        case .info:
            Image(systemName: "info.circle")
                .font(.body)
                .foregroundColor(.secondary)
        case .custom(let view):
            view
        }
    }
}

// MARK: - View Extension

public extension View {
    /// Applies liquid list styling to a list view.
    func liquidListStyle(configuration: LiquidListConfiguration = .default) -> some View {
        self
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
    }
}
