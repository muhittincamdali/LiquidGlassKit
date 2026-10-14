import SwiftUI

extension View {
    /// Plays the system selection feedback when `trigger` changes and `condition` holds.
    ///
    /// `sensoryFeedback` exists on visionOS only from visionOS 26, while the
    /// package supports visionOS 1, so older visionOS releases get no feedback.
    func selectionFeedback<Trigger: Equatable>(
        trigger: Trigger,
        condition: @escaping (Trigger, Trigger) -> Bool = { _, _ in true }
    ) -> some View {
        modifier(SelectionFeedbackModifier(trigger: trigger, condition: condition))
    }
}

private struct SelectionFeedbackModifier<Trigger: Equatable>: ViewModifier {
    let trigger: Trigger
    let condition: (Trigger, Trigger) -> Bool

    func body(content: Content) -> some View {
        if #available(visionOS 26.0, *) {
            content.sensoryFeedback(.selection, trigger: trigger, condition: condition)
        } else {
            content
        }
    }
}
