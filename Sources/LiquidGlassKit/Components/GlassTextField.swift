import SwiftUI

// MARK: - GlassTextField

/// A text input field with Liquid Glass background styling.
/// Supports leading icon, placeholder text, and configurable glass material.
public struct GlassTextField: View {

    // MARK: - Properties

    private let placeholder: String
    private let icon: String?
    private let material: GlassMaterial
    private let cornerRadius: CGFloat

    @Binding private var text: String
    @FocusState private var isFocused: Bool

    // MARK: - Initialization

    /// Creates a glass text field.
    /// - Parameters:
    ///   - placeholder: Placeholder text displayed when empty.
    ///   - text: Binding to the text value.
    ///   - icon: Optional SF Symbol name for leading icon.
    ///   - material: Glass material. Default is `.frosted`.
    ///   - cornerRadius: Corner radius. Default is 12.
    public init(
        _ placeholder: String,
        text: Binding<String>,
        icon: String? = nil,
        material: GlassMaterial = .frosted,
        cornerRadius: CGFloat = 12
    ) {
        self.placeholder = placeholder
        self._text = text
        self.icon = icon
        self.material = material
        self.cornerRadius = cornerRadius
    }

    // MARK: - Body

    public var body: some View {
        HStack(spacing: 10) {
            if let icon {
                Image(systemName: icon)
                    .foregroundStyle(.secondary)
                    .font(.body)
            }

            TextField(placeholder, text: $text)
                .focused($isFocused)
                .textFieldStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(material.swiftUIMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(material.tintColor)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(
                            isFocused
                                ? Color.accentColor.opacity(0.5)
                                : Color.white.opacity(0.2),
                            lineWidth: isFocused ? 1.0 : 0.5
                        )
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .shadow(color: .black.opacity(0.06), radius: 4, y: 2)
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}

// MARK: - Preview

#if DEBUG
struct GlassTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.gradient.ignoresSafeArea()

            VStack(spacing: 16) {
                GlassTextField("Search...", text: .constant(""), icon: "magnifyingglass")
                GlassTextField("Email", text: .constant(""), icon: "envelope")
                GlassTextField("Username", text: .constant(""), material: .tinted(.purple))
            }
            .padding()
        }
    }
}
#endif
