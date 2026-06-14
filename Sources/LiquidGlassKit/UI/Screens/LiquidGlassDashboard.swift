import SwiftUI

/// A complete, drop-in Dashboard Screen using the LiquidGlass visual language.
public struct LiquidGlassDashboard: View {
    public let userName: String
    public let metrics: [(title: String, value: String)]
    
    public init(userName: String, metrics: [(title: String, value: String)]) {
        self.userName = userName
        self.metrics = metrics
    }
    
    public var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [.teal.opacity(0.6), .indigo.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Welcome back,")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                            Text(userName)
                                .font(.title.bold())
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                    
                    // Metrics Grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(metrics.indices, id: \.self) { index in
                            LiquidGlassCard {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(metrics[index].title)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text(metrics[index].value)
                                        .font(.title2.bold())
                                        .foregroundColor(.primary)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Action Area
                    LiquidGlassCard(title: "Quick Actions") {
                        HStack(spacing: 20) {
                            LiquidGlassButton(title: "Send", icon: "paperplane.fill") {}
                            LiquidGlassButton(title: "Receive", icon: "arrow.down.circle.fill") {}
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
