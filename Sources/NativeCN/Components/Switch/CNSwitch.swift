import SwiftUI

/// A native toggle-backed switch with NativeCN tint and typography.
public struct CNSwitch<Label: View>: View {
    @Environment(\.cnTheme) private var theme

    @Binding private var isOn: Bool
    private let isDisabled: Bool
    private let label: Label

    /// Creates a switch with custom label content.
    public init(isOn: Binding<Bool>, isDisabled: Bool = false, @ViewBuilder label: () -> Label) {
        self._isOn = isOn
        self.isDisabled = isDisabled
        self.label = label()
    }

    /// The switch body.
    public var body: some View {
        Toggle(isOn: $isOn) {
            label
                .font(theme.typography.body.font)
                .foregroundStyle(theme.colors.foreground.color)
        }
        .toggleStyle(.switch)
        .tint(theme.colors.primary.color)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.55 : 1)
    }
}

public extension CNSwitch where Label == Text {
    /// Creates a switch with a text label.
    init(_ title: String, isOn: Binding<Bool>, isDisabled: Bool = false) {
        self.init(isOn: isOn, isDisabled: isDisabled) {
            Text(title)
        }
    }
}
