import SwiftUI

/// A token-driven focus ring modifier for NativeCN controls.
public struct CNFocusRing: ViewModifier {
    @Environment(\.cnTheme) private var theme

    private let isFocused: Bool
    private let lineWidth: CGFloat
    private let cornerRadius: CGFloat?
    private let inset: CGFloat

    /// Creates a focus ring modifier.
    public init(isFocused: Bool, lineWidth: CGFloat = 2, cornerRadius: CGFloat? = nil, inset: CGFloat = -2) {
        self.isFocused = isFocused
        self.lineWidth = lineWidth
        self.cornerRadius = cornerRadius
        self.inset = inset
    }

    /// The modified view body.
    public func body(content: Content) -> some View {
        content.overlay {
            if isFocused {
                RoundedRectangle(cornerRadius: cornerRadius ?? theme.radius.lg)
                    .inset(by: inset)
                    .stroke(theme.colors.ring.color, lineWidth: lineWidth)
                    .allowsHitTesting(false)
            }
        }
    }
}

public extension View {
    /// Adds a token-driven focus ring when `isFocused` is true.
    func cnFocusRing(isFocused: Bool, lineWidth: CGFloat = 2, cornerRadius: CGFloat? = nil, inset: CGFloat = -2) -> some View {
        modifier(CNFocusRing(isFocused: isFocused, lineWidth: lineWidth, cornerRadius: cornerRadius, inset: inset))
    }
}
