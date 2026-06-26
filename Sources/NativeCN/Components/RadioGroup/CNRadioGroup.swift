import SwiftUI

/// A selectable option for `CNRadioGroup`.
public struct CNRadioOption<Value: Hashable & Sendable>: Identifiable, Sendable, Equatable {
    /// Option title.
    public var title: String

    /// Option value.
    public var value: Value

    /// Optional supporting description.
    public var description: String?

    /// Stable identifier.
    public var id: Value { value }

    /// Creates a radio option.
    public init(_ title: String, value: Value, description: String? = nil) {
        self.title = title
        self.value = value
        self.description = description
    }
}

/// A token-driven single-selection radio group.
public struct CNRadioGroup<Value: Hashable & Sendable>: View {
    @Environment(\.cnTheme) private var theme

    @Binding private var selection: Value
    private let options: [CNRadioOption<Value>]
    private let isDisabled: Bool

    /// Creates a radio group.
    public init(selection: Binding<Value>, options: [CNRadioOption<Value>], isDisabled: Bool = false) {
        self._selection = selection
        self.options = options
        self.isDisabled = isDisabled
    }

    /// The radio group body.
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x3) {
            ForEach(options) { option in
                Button {
                    selection = option.value
                } label: {
                    HStack(alignment: .top, spacing: theme.space.x2) {
                        radioMark(isSelected: selection == option.value)

                        VStack(alignment: .leading, spacing: theme.space.x1) {
                            Text(option.title)
                                .font(theme.typography.body.font)
                                .foregroundStyle(theme.colors.foreground.color)

                            if let description = option.description {
                                Text(description)
                                    .font(theme.typography.footnote.font)
                                    .foregroundStyle(theme.colors.mutedForeground.color)
                            }
                        }
                    }
                }
                .buttonStyle(.plain)
                .disabled(isDisabled)
                .opacity(isDisabled ? 0.55 : 1)
                .accessibilityValue(selection == option.value ? Text("Selected") : Text("Not selected"))
            }
        }
        .accessibilityElement(children: .contain)
    }

    private func radioMark(isSelected: Bool) -> some View {
        ZStack {
            Circle()
                .stroke((isSelected ? theme.colors.primary : theme.colors.border).color, lineWidth: 1.5)
                .frame(width: 20, height: 20)

            if isSelected {
                Circle()
                    .fill(theme.colors.primary.color)
                    .frame(width: 10, height: 10)
            }
        }
    }
}
