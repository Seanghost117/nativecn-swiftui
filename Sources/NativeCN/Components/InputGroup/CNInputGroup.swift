import SwiftUI

/// A single-line input with tokenized leading and trailing add-ons.
public struct CNInputGroup<Leading: View, Trailing: View>: View {
    @Environment(\.cnTheme) private var theme
    @Environment(\.cnFieldIsInvalid) private var fieldIsInvalid
    @FocusState private var isFocused: Bool

    private let placeholder: String
    @Binding private var text: String
    private let isDisabled: Bool
    private let isInvalid: Bool
    private let leading: Leading
    private let trailing: Trailing

    /// Creates an input group with custom add-ons.
    public init(
        _ placeholder: String,
        text: Binding<String>,
        isDisabled: Bool = false,
        isInvalid: Bool = false,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.placeholder = placeholder
        self._text = text
        self.isDisabled = isDisabled
        self.isInvalid = isInvalid
        self.leading = leading()
        self.trailing = trailing()
    }

    /// The input group body.
    public var body: some View {
        let invalid = isInvalid || fieldIsInvalid
        let metrics = CNControlSize.md.metrics(in: theme)
        let borderColor = invalid ? theme.colors.destructive : theme.colors.input

        HStack(spacing: 0) {
            if Leading.self != EmptyView.self {
                accessory(leading)
            }

            TextField(placeholder, text: $text)
                .textFieldStyle(.plain)
                .font(theme.typography.body.font)
                .foregroundStyle(theme.colors.foreground.color)
                .focused($isFocused)
                .disabled(isDisabled)
                .padding(.horizontal, theme.space.x3)
                .frame(minHeight: metrics.height)

            if Trailing.self != EmptyView.self {
                accessory(trailing)
            }
        }
        .background(theme.colors.background.color)
        .clipShape(RoundedRectangle(cornerRadius: metrics.cornerRadius))
        .cnBorder(color: borderColor, lineWidth: invalid ? 1.5 : 1, cornerRadius: metrics.cornerRadius)
        .cnFocusRing(isFocused: isFocused, cornerRadius: metrics.cornerRadius)
        .opacity(isDisabled ? 0.55 : 1)
        .accessibilityElement(children: .combine)
        .accessibilityHint(invalid ? "Invalid input" : "")
    }

    private func accessory<Accessory: View>(_ accessory: Accessory) -> some View {
        accessory
            .font(theme.typography.subheadline.font.weight(.medium))
            .foregroundStyle(theme.colors.mutedForeground.color)
            .padding(.horizontal, theme.space.x3)
            .frame(minHeight: CNControlSize.md.metrics(in: theme).height)
            .background(theme.colors.muted.color.opacity(0.55))
    }
}

public extension CNInputGroup where Leading == Text, Trailing == EmptyView {
    /// Creates an input group with a leading text add-on.
    init(
        _ placeholder: String,
        text: Binding<String>,
        leadingText: String,
        isDisabled: Bool = false,
        isInvalid: Bool = false
    ) {
        self.init(placeholder, text: text, isDisabled: isDisabled, isInvalid: isInvalid) {
            Text(leadingText)
        } trailing: {
            EmptyView()
        }
    }
}

public extension CNInputGroup where Leading == EmptyView, Trailing == Text {
    /// Creates an input group with a trailing text add-on.
    init(
        _ placeholder: String,
        text: Binding<String>,
        trailingText: String,
        isDisabled: Bool = false,
        isInvalid: Bool = false
    ) {
        self.init(placeholder, text: text, isDisabled: isDisabled, isInvalid: isInvalid) {
            EmptyView()
        } trailing: {
            Text(trailingText)
        }
    }
}
