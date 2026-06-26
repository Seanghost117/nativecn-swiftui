import SwiftUI

/// A token-driven checkbox control.
public struct CNCheckbox<Label: View>: View {
    @Environment(\.cnTheme) private var theme

    @Binding private var isOn: Bool
    private let isDisabled: Bool
    private let label: Label

    /// Creates a checkbox with custom label content.
    public init(isOn: Binding<Bool>, isDisabled: Bool = false, @ViewBuilder label: () -> Label) {
        self._isOn = isOn
        self.isDisabled = isDisabled
        self.label = label()
    }

    /// The checkbox body.
    public var body: some View {
        Button {
            isOn.toggle()
        } label: {
            HStack(spacing: theme.space.x2) {
                ZStack {
                    RoundedRectangle(cornerRadius: theme.radius.sm)
                        .fill(isOn ? theme.colors.primary.color : theme.colors.background.color)
                        .frame(width: 20, height: 20)
                        .cnBorder(color: isOn ? theme.colors.primary : theme.colors.border, cornerRadius: theme.radius.sm)

                    if isOn {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(theme.colors.primaryForeground.color)
                    }
                }

                label
                    .font(theme.typography.body.font)
                    .foregroundStyle(theme.colors.foreground.color)
            }
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.55 : 1)
        .accessibilityLabel(Text(accessibilityText))
        .accessibilityValue(isOn ? Text("Checked") : Text("Unchecked"))
    }

    private var accessibilityText: String {
        isOn ? "Checked" : "Unchecked"
    }
}

public extension CNCheckbox where Label == Text {
    /// Creates a checkbox with a text label.
    init(_ title: String, isOn: Binding<Bool>, isDisabled: Bool = false) {
        self.init(isOn: isOn, isDisabled: isDisabled) {
            Text(title)
        }
    }
}
