import SwiftUI

/// A selectable option for `CNSelect`.
public struct CNSelectOption<Value: Hashable & Sendable>: Identifiable, Sendable, Equatable {
    /// Option title.
    public var title: String

    /// Option value.
    public var value: Value

    /// Stable identifier.
    public var id: Value { value }

    /// Creates a select option.
    public init(_ title: String, value: Value) {
        self.title = title
        self.value = value
    }
}

/// A first-pass native select control backed by SwiftUI `Menu`.
public struct CNSelect<Value: Hashable & Sendable>: View {
    @Environment(\.cnTheme) private var theme

    private let placeholder: String
    @Binding private var selection: Value?
    private let options: [CNSelectOption<Value>]
    private let isDisabled: Bool

    /// Creates a select control.
    public init(_ placeholder: String, selection: Binding<Value?>, options: [CNSelectOption<Value>], isDisabled: Bool = false) {
        self.placeholder = placeholder
        self._selection = selection
        self.options = options
        self.isDisabled = isDisabled
    }

    /// The select body.
    public var body: some View {
        Menu {
            ForEach(options) { option in
                Button {
                    selection = option.value
                } label: {
                    if selection == option.value {
                        Label(option.title, systemImage: "checkmark")
                    } else {
                        Text(option.title)
                    }
                }
            }
        } label: {
            HStack {
                Text(selectedTitle ?? placeholder)
                    .font(theme.typography.body.font)
                    .foregroundStyle(selectedTitle == nil ? theme.colors.mutedForeground.color : theme.colors.foreground.color)

                Spacer()

                Image(systemName: "chevron.down")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(theme.colors.mutedForeground.color)
            }
            .padding(.horizontal, theme.space.x4)
            .frame(minHeight: CNControlSize.md.metrics(in: theme).height)
            .background(theme.colors.background.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
            .cnBorder(color: theme.colors.input, cornerRadius: theme.radius.lg)
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.55 : 1)
        .accessibilityLabel(placeholder)
        .accessibilityValue(selectedTitle ?? "No selection")
    }

    private var selectedTitle: String? {
        guard let selection else { return nil }
        return options.first { $0.value == selection }?.title
    }
}
