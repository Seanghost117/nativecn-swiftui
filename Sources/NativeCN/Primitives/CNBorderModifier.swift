import SwiftUI

/// A token-driven rounded border modifier for NativeCN surfaces and controls.
public struct CNBorderModifier: ViewModifier {
    @Environment(\.cnTheme) private var theme

    private let color: CNColorToken?
    private let lineWidth: CGFloat
    private let cornerRadius: CGFloat?

    /// Creates a border modifier.
    public init(color: CNColorToken? = nil, lineWidth: CGFloat = 1, cornerRadius: CGFloat? = nil) {
        self.color = color
        self.lineWidth = lineWidth
        self.cornerRadius = cornerRadius
    }

    /// The modified view body.
    public func body(content: Content) -> some View {
        content.overlay {
            RoundedRectangle(cornerRadius: cornerRadius ?? theme.radius.lg)
                .stroke((color ?? theme.colors.border).color, lineWidth: lineWidth)
                .allowsHitTesting(false)
        }
    }
}

public extension View {
    /// Adds a token-driven rounded border.
    func cnBorder(color: CNColorToken? = nil, lineWidth: CGFloat = 1, cornerRadius: CGFloat? = nil) -> some View {
        modifier(CNBorderModifier(color: color, lineWidth: lineWidth, cornerRadius: cornerRadius))
    }
}
