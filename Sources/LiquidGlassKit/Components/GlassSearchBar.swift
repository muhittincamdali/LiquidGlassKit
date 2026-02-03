import SwiftUI

// MARK: - GlassSearchBar

/// A search bar component with Liquid Glass styling.
/// Features a magnifying glass icon, clear button, and cancel action.
public struct GlassSearchBar: View {

    // MARK: - Properties

    @Binding private var text: String
    private let placeholder: String
    private let material: GlassMaterial
    private let onSubmit: (() -> Void)?

    @FocusState private var isFocused: Bool
    @State private var showCancel = false

    // MARK: - Initialization

    /// Creates a glass search bar.
    /// - Parameters:
    ///   - text: Binding to the search text.
    ///   - placeholder: Placeholder text. Default is "Search".
    ///   - material: Glass material. Default is `.frosted`.
    ///   - onSubmit: Optional closure called on search submission.
    public init(
        text: Binding<String>,
        placeholder: String = "Search",
        material: GlassMaterial = .frosted,
        onSubmit: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.material = material
        self.onSubmit = onSubmit
    }

    // MARK: - Body

    public var body: some View {
        HStack(spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                    .font(.body)

                TextField(placeholder, text: $text)
                    .focused($isFocused)
                    .textFieldStyle(.plain)
                    .onSubmit { onSubmit?() }

                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                            .font(.body)
                    }
                    .buttonStyle(.plain)
                    .transition(.opacity)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(material.swiftUIMaterial)
                    .overlay(
                        Capsule()
                            .fill(material.tintColor)
                    )
                    .overlay(
                        Capsule()
                            .stroke(.white.opacity(0.2), lineWidth: 0.5)
                    )
            )

            if showCancel {
                Button("Cancel") {
                    text = ""
                    isFocused = false
                }
                .font(.body)
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.25), value: text.isEmpty)
        .onChange(of: isFocused) { _, focused in
            withAnimation(.easeInOut(duration: 0.25)) {
                showCancel = focused
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct GlassSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.teal.gradient.ignoresSafeArea()

            VStack {
                GlassSearchBar(text: .constant(""))
                GlassSearchBar(text: .constant("Swift"), placeholder: "Search packages...")
            }
            .padding()
        }
    }
}
#endif
