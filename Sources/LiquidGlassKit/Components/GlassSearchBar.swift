import SwiftUI

/// A capsule search field on glass with a clear button and a Cancel button
/// that appears while the field has focus.
///
/// ```swift
/// @State private var query = ""
///
/// GlassSearchBar(text: $query, prompt: "Search photos") {
///     runSearch(query)
/// }
/// ```
public struct GlassSearchBar: View {
    @Binding private var text: String
    private let prompt: String
    private let material: GlassMaterial?
    private let onSubmit: (() -> Void)?

    @FocusState private var isFocused: Bool

    /// - Parameters:
    ///   - text: The search text.
    ///   - prompt: Placeholder shown while the field is empty.
    ///   - material: The glass material, or `nil` to use the theme's material.
    ///   - onSubmit: Called when the user submits the search.
    public init(
        text: Binding<String>,
        prompt: String = "Search",
        material: GlassMaterial? = nil,
        onSubmit: (() -> Void)? = nil
    ) {
        self._text = text
        self.prompt = prompt
        self.material = material
        self.onSubmit = onSubmit
    }

    public var body: some View {
        HStack(spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                    .accessibilityHidden(true)

                TextField(prompt, text: $text)
                    .focused($isFocused)
                    .textFieldStyle(.plain)
                    .onSubmit { onSubmit?() }

                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Clear search")
                    .transition(.opacity)
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .glassSurface(material, in: .capsule)

            if isFocused {
                Button("Cancel") {
                    text = ""
                    isFocused = false
                }
                .buttonStyle(.plain)
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.25), value: text.isEmpty)
        .animation(.easeInOut(duration: 0.25), value: isFocused)
    }
}
