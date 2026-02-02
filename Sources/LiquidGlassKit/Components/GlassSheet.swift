import SwiftUI

// MARK: - GlassSheet

/// A modal sheet presentation with Liquid Glass background.
/// Supports drag-to-dismiss, custom detents, and glass material configuration.
public struct GlassSheet<Content: View>: ViewModifier {

    // MARK: - Properties

    @Binding private var isPresented: Bool
    private let material: GlassMaterial
    private let cornerRadius: CGFloat
    private let content: Content

    @State private var dragOffset: CGFloat = 0
    @GestureState private var isDragging = false

    // MARK: - Initialization

    /// Creates a glass sheet modifier.
    /// - Parameters:
    ///   - isPresented: Binding controlling sheet visibility.
    ///   - material: Glass material. Default is `.frosted`.
    ///   - cornerRadius: Top corner radius. Default is 28.
    ///   - content: Sheet content builder.
    public init(
        isPresented: Binding<Bool>,
        material: GlassMaterial = .frosted,
        cornerRadius: CGFloat = 28,
        @ViewBuilder content: () -> Content
    ) {
        self._isPresented = isPresented
        self.material = material
        self.cornerRadius = cornerRadius
        self.content = content()
    }

    // MARK: - Body

    public func body(content: Content) -> some View {
        content
            .overlay {
                if isPresented {
                    sheetOverlay
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.85), value: isPresented)
    }

    // MARK: - Private

    @ViewBuilder
    private var sheetOverlay: some View {
        ZStack(alignment: .bottom) {
            // Dimming background
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }

            // Sheet content
            VStack(spacing: 0) {
                // Drag handle
                Capsule()
                    .fill(.secondary.opacity(0.4))
                    .frame(width: 36, height: 5)
                    .padding(.top, 8)
                    .padding(.bottom, 12)

                self.content
                    .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
            .background(
                UnevenRoundedRectangle(
                    topLeadingRadius: cornerRadius,
                    topTrailingRadius: cornerRadius
                )
                .fill(material.swiftUIMaterial)
                .overlay(
                    UnevenRoundedRectangle(
                        topLeadingRadius: cornerRadius,
                        topTrailingRadius: cornerRadius
                    )
                    .fill(material.tintColor)
                )
                .overlay(
                    UnevenRoundedRectangle(
                        topLeadingRadius: cornerRadius,
                        topTrailingRadius: cornerRadius
                    )
                    .stroke(.white.opacity(0.2), lineWidth: 0.5)
                )
            )
            .shadow(color: .black.opacity(0.15), radius: 20, y: -5)
            .offset(y: max(0, dragOffset))
            .gesture(dragGesture)
        }
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .updating($isDragging) { _, state, _ in
                state = true
            }
            .onChanged { value in
                dragOffset = value.translation.height
            }
            .onEnded { value in
                if value.translation.height > 120 || value.predictedEndTranslation.height > 200 {
                    isPresented = false
                }
                dragOffset = 0
            }
    }
}

// MARK: - View Extension

extension View {

    /// Presents a glass sheet over the current view.
    /// - Parameters:
    ///   - isPresented: Binding controlling presentation.
    ///   - material: Glass material for the sheet background.
    ///   - content: Sheet content builder.
    public func glassSheet<Content: View>(
        isPresented: Binding<Bool>,
        material: GlassMaterial = .frosted,
        @ViewBuilder content: () -> Content
    ) -> some View {
        modifier(GlassSheet(
            isPresented: isPresented,
            material: material,
            content: content
        ))
    }
}
