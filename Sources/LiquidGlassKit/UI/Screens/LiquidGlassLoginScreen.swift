import SwiftUI

/// A complete, drop-in Authentication Screen using the LiquidGlass visual language.
public struct LiquidGlassLoginScreen: View {
    @State private var email = ""
    @State private var password = ""
    
    public let title: String
    public let subtitle: String
    public let onLogin: (String, String) -> Void
    
    public init(
        title: String = "Welcome Back",
        subtitle: String = "Sign in to continue",
        onLogin: @escaping (String, String) -> Void
    ) {
        self.title = title
        self.subtitle = subtitle
        self.onLogin = onLogin
    }
    
    public var body: some View {
        ZStack {
            // Background gradient for glass effect to pop
            LinearGradient(
                colors: [.blue.opacity(0.6), .purple.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack(spacing: 8) {
                    Text(title)
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    Text(subtitle)
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.bottom, 20)
                
                LiquidGlassCard {
                    VStack(spacing: 20) {
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .foregroundColor(.primary)
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .foregroundColor(.primary)
                        
                        LiquidGlassButton(title: "Sign In", icon: "arrow.right.circle.fill") {
                            onLogin(email, password)
                        }
                        .padding(.top, 10)
                    }
                }
                .padding(.horizontal, 30)
            }
        }
    }
}
