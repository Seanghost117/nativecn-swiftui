import SwiftUI

/// A multiline token-driven text input.
public struct CNTextarea: View {
    @Environment(\.cnTheme) private var theme
    @Environment(\.cnFieldIsInvalid) private var fieldIsInvalid
    @FocusState private var isFocusedInternally: Bool

    private let placeholder: String
    @Binding private var text: String
    private let minHeight: CGFloat
    private let maxHeight: CGFloat?
    private let isDisabled: Bool
    private let isInvalid: Bool
    private let focusBinding: FocusState<Bool>.Binding?

    /// Creates a textarea.
    public init(
        _ placeholder: String,
        text: Binding<String>,
        minHeight: CGFloat = 120,
        maxHeight: CGFloat? = nil,
        isDisabled: Bool = false,
        isInvalid: Bool = false,
        focus: FocusState<Bool>.Binding? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.isDisabled = isDisabled
        self.isInvalid = isInvalid
        self.focusBinding = focus
    }

    /// The textarea body.
    public var body: some View {
        let invalid = isInvalid || fieldIsInvalid
        let borderColor = invalid ? theme.colors.destructive : theme.colors.input

        ZStack(alignment: .topLeading) {
            configuredEditor
                .font(theme.typography.body.font)
                .scrollContentBackground(.hidden)
                .padding(theme.space.x2)
                .frame(minHeight: minHeight, maxHeight: maxHeight)
                .disabled(isDisabled)

            if text.isEmpty {
                Text(placeholder)
                    .font(theme.typography.body.font)
                    .foregroundStyle(theme.colors.mutedForeground.color)
                    .padding(.horizontal, theme.space.x3)
                    .padding(.vertical, theme.space.x3)
                    .allowsHitTesting(false)
            }
        }
        .background(theme.colors.background.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .cnBorder(color: borderColor, lineWidth: invalid ? 1.5 : 1, cornerRadius: theme.radius.lg)
        .cnFocusRing(isFocused: isFocusedInternally, cornerRadius: theme.radius.lg)
        .opacity(isDisabled ? 0.55 : 1)
        .accessibilityHint(invalid ? "Invalid input" : "")
    }

    @ViewBuilder
    private var configuredEditor: some View {
        let editor = TextEditor(text: $text)

        if let focusBinding {
            editor.focused(focusBinding)
        } else {
            editor.focused($isFocusedInternally)
        }
    }
}
