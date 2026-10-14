import SwiftUI

/// Decides whether a drag on a ``GlassSheet`` should dismiss it.
public enum GlassSheetDismissal {
    /// Downward drag distance, in points, that dismisses the sheet.
    public static let distanceThreshold: CGFloat = 120
    /// Predicted downward travel, in points, that dismisses the sheet (a fast flick).
    public static let predictedThreshold: CGFloat = 200

    /// Returns `true` when a drag that ended with these values should close the sheet.
    /// - Parameters:
    ///   - translation: Vertical drag distance. Positive is downward.
    ///   - predictedEndTranslation: Vertical distance SwiftUI predicts the drag would travel.
    public static func shouldDismiss(translation: CGFloat, predictedEndTranslation: CGFloat) -> Bool {
        translation > distanceThreshold || predictedEndTranslation > predictedThreshold
    }
}

#if !os(tvOS)
/// Presents content in a floating bottom sheet drawn on glass, over the modified view.
///
/// Dismiss by tapping the dimmed background, dragging the sheet down, or the
/// accessibility escape gesture. Use ``SwiftUICore/View/glassSheet(isPresented:material:content:)``.
///
/// Not available on tvOS, which has no drag gesture.
public struct GlassSheet<SheetContent: View>: ViewModifier {
    @Binding private var isPresented: Bool
    private let material: GlassMaterial?
    private let cornerRadius: CGFloat
    private let sheetContent: SheetContent

    @State private var dragOffset: CGFloat = 0

    public init(
        isPresented: Binding<Bool>,
        material: GlassMaterial? = nil,
        cornerRadius: CGFloat = 28,
        @ViewBuilder content: () -> SheetContent
    ) {
        self._isPresented = isPresented
        self.material = material
        self.cornerRadius = cornerRadius
        self.sheetContent = content()
    }

    public func body(content: Content) -> some View {
        content
            .overlay {
                if isPresented {
                    sheet
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.85), value: isPresented)
    }

    private var sheet: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.25)
                .ignoresSafeArea()
                .onTapGesture { isPresented = false }
                .accessibilityHidden(true)

            VStack(spacing: 0) {
                Capsule()
                    .fill(.secondary.opacity(0.5))
                    .frame(width: 36, height: 5)
                    .padding(.vertical, 10)
                    .accessibilityHidden(true)
                sheetContent
                    .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
            .glassSurface(material, in: .roundedRectangle(cornerRadius: cornerRadius))
            .padding(.horizontal, 8)
            .offset(y: max(0, dragOffset))
            .gesture(dragGesture)
            .accessibilityAddTraits(.isModal)
            .accessibilityAction(.escape) { isPresented = false }
        }
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { dragOffset = $0.translation.height }
            .onEnded { value in
                if GlassSheetDismissal.shouldDismiss(
                    translation: value.translation.height,
                    predictedEndTranslation: value.predictedEndTranslation.height
                ) {
                    isPresented = false
                }
                dragOffset = 0
            }
    }
}

extension View {
    /// Presents a glass bottom sheet over this view while `isPresented` is `true`.
    @available(tvOS, unavailable)
    public func glassSheet<SheetContent: View>(
        isPresented: Binding<Bool>,
        material: GlassMaterial? = nil,
        @ViewBuilder content: () -> SheetContent
    ) -> some View {
        modifier(GlassSheet(isPresented: isPresented, material: material, content: content))
    }
}
#endif
