import SwiftUI

/// A beautiful, high-conversion Glass Button.
public struct LiquidGlassButton: View {
    public let title: String
    public let icon: String?
    public let action: () -> Void
    
    public init(title: String, icon: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon = icon {
                    Image(systemName: icon)
                }
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .liquidGlass(cornerRadius: 16, shadowRadius: 5)
        }
        .buttonStyle(.plain)
    }
}
