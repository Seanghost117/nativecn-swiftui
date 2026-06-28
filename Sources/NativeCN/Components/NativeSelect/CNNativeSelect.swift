import SwiftUI

/// A SwiftUI Picker-backed select that preserves native platform presentation.
public struct CNNativeSelect<Value: Hashable & Sendable>: View {
    @Environment(\.cnTheme) private var theme

    private let title: String
    @Binding private var selection: Value
    private let options: [CNSelectOption<Value>]
    private let isDisabled: Bool

    /// Creates a native select.
    public init(_ title: String, selection: Binding<Value>, options: [CNSelectOption<Value>], isDisabled: Bool = false) {
        self.title = title
        self._selection = selection
        self.options = options
        self.isDisabled = isDisabled
    }

    /// The native select body.
    public var body: some View {
        Picker(title, selection: $selection) {
            ForEach(options) { option in
                Text(option.title).tag(option.value)
            }
        }
        .pickerStyle(.menu)
        .font(theme.typography.body.font)
        .tint(theme.colors.primary.color)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.55 : 1)
    }
}

