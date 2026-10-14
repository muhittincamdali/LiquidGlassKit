import SwiftUI

/// A single-line text field on a glass surface, with an optional leading SF Symbol.
///
/// The edge switches to the accent color while the field has focus.
///
/// ```swift
/// @State private var email = ""
///
/// GlassTextField("Email", text: $email, systemImage: "envelope")
/// ```
public struct GlassTextField: View {
    private let title: String
    private let systemImage: String?
    private let material: GlassMaterial?
    private let cornerRadius: CGFloat

    @Binding private var text: String
    @FocusState private var isFocused: Bool

    public init(
        _ title: String,
        text: Binding<String>,
        systemImage: String? = nil,
        material: GlassMaterial? = nil,
        cornerRadius: CGFloat = 14
    ) {
        self.title = title
        self._text = text
        self.systemImage = systemImage
        self.material = material
        self.cornerRadius = cornerRadius
    }

    public var body: some View {
        HStack(spacing: 10) {
            if let systemImage {
                Image(systemName: systemImage)
                    .foregroundStyle(.secondary)
                    .accessibilityHidden(true)
            }
            TextField(title, text: $text)
                .focused($isFocused)
                .textFieldStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .glassSurface(material, in: .roundedRectangle(cornerRadius: cornerRadius))
        .overlay {
            GlassShape.roundedRectangle(cornerRadius: cornerRadius).shape
                .stroke(Color.accentColor.opacity(isFocused ? 0.7 : 0), lineWidth: 1.5)
                .allowsHitTesting(false)
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}
