import SwiftUI

/// A press-scale modifier that respects Reduce Motion.
public struct CNInteractiveScaleModifier: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.cnTheme) private var theme

    private let isPressed: Bool
    private let scale: CGFloat

    /// Creates an interactive scale modifier.
    public init(isPressed: Bool, scale: CGFloat = 0.97) {
        self.isPressed = isPressed
        self.scale = scale
    }

    /// The modified view body.
    public func body(content: Content) -> some View {
        content
            .scaleEffect(reduceMotion ? 1 : (isPressed ? scale : 1))
            .animation(theme.motion.easeOut.animation(reduceMotion: reduceMotion), value: isPressed)
    }
}

public extension View {
    /// Applies tokenized press scaling while respecting Reduce Motion.
    func cnInteractiveScale(isPressed: Bool, scale: CGFloat = 0.97) -> some View {
        modifier(CNInteractiveScaleModifier(isPressed: isPressed, scale: scale))
    }
}
