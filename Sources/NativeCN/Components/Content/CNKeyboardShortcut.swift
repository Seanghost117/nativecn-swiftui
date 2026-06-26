import SwiftUI

/// A compact visual keyboard shortcut.
public struct CNKeyboardShortcut: View {
    @Environment(\.cnTheme) private var theme

    private let keys: [String]

    /// Creates a keyboard shortcut from a list of keys.
    public init(_ keys: [String]) {
        self.keys = keys
    }

    /// Creates a keyboard shortcut from variadic keys.
    public init(_ keys: String...) {
        self.keys = keys
    }

    /// The keyboard shortcut body.
    public var body: some View {
        HStack(spacing: theme.space.x1) {
            ForEach(Array(keys.enumerated()), id: \.offset) { _, key in
                Text(verbatim: key)
                    .font(theme.typography.caption.font.weight(.semibold))
                    .foregroundStyle(theme.colors.foreground.color)
                    .padding(.horizontal, theme.space.x2)
                    .frame(minHeight: 24)
                    .background(theme.colors.card.color)
                    .clipShape(RoundedRectangle(cornerRadius: theme.radius.sm))
                    .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.sm)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Keyboard shortcut \(keys.joined(separator: " "))")
    }
}
