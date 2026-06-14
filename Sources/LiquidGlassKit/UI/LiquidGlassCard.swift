import SwiftUI

/// A ready-to-use Glass Card component.
public struct LiquidGlassCard<Content: View>: View {
    public let title: String?
    public let subtitle: String?
    public let content: Content
    
    public init(
        title: String? = nil,
        subtitle: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.content = content()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if title != nil || subtitle != nil {
                VStack(alignment: .leading, spacing: 4) {
                    if let title = title {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            content
        }
        .padding(20)
        .liquidGlass()
    }
}
