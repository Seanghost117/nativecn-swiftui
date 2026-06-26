import SwiftUI

/// A small inline monospaced code token.
public struct CNInlineCode: View {
    @Environment(\.cnTheme) private var theme

    private let text: String

    /// Creates inline code.
    public init(_ text: String) {
        self.text = text
    }

    /// The inline code body.
    public var body: some View {
        Text(verbatim: text)
            .font(theme.typography.mono.font)
            .foregroundStyle(theme.colors.foreground.color)
            .padding(.horizontal, theme.space.x1)
            .padding(.vertical, 1)
            .background(theme.colors.muted.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.sm))
            .accessibilityLabel(text)
    }
}
