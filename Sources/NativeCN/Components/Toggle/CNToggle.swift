import SwiftUI

/// A token-driven selected/unselected toggle button.
public struct CNToggle<Label: View>: View {
    @Environment(\.cnTheme) private var theme

    @Binding private var isOn: Bool
    private let isDisabled: Bool
    private let label: Label

    /// Creates a toggle with custom label content.
    public init(isOn: Binding<Bool>, isDisabled: Bool = false, @ViewBuilder label: () -> Label) {
        self._isOn = isOn
        self.isDisabled = isDisabled
        self.label = label()
    }

    /// The toggle body.
    public var body: some View {
        Button {
            isOn.toggle()
        } label: {
            label
                .font(theme.typography.body.font.weight(.medium))
                .foregroundStyle((isOn ? theme.colors.accentForeground : theme.colors.foreground).color)
                .padding(.horizontal, theme.space.x3)
                .padding(.vertical, theme.space.x2)
                .background((isOn ? theme.colors.accent : theme.colors.background).color)
                .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
                .cnBorder(color: isOn ? theme.colors.ring : theme.colors.border, cornerRadius: theme.radius.lg)
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.55 : 1)
        .accessibilityValue(isOn ? Text("Selected") : Text("Not selected"))
    }
}

public extension CNToggle where Label == Text {
    /// Creates a toggle with a text label.
    init(_ title: String, isOn: Binding<Bool>, isDisabled: Bool = false) {
        self.init(isOn: isOn, isDisabled: isDisabled) {
            Text(title)
        }
    }
}

/// A selectable option for `CNToggleGroup`.
public struct CNToggleGroupOption<Value: Hashable & Sendable>: Identifiable, Sendable, Equatable {
    /// Option title.
    public var title: String

    /// Option value.
    public var value: Value

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Stable identifier.
    public var id: Value { value }

    /// Creates a toggle group option.
    public init(_ title: String, value: Value, systemImage: String? = nil) {
        self.title = title
        self.value = value
        self.systemImage = systemImage
    }
}

/// A group of token-driven toggles that supports multiple selection.
public struct CNToggleGroup<Value: Hashable & Sendable>: View {
    @Binding private var selection: Set<Value>
    private let options: [CNToggleGroupOption<Value>]
    private let isDisabled: Bool

    /// Creates a toggle group.
    public init(selection: Binding<Set<Value>>, options: [CNToggleGroupOption<Value>], isDisabled: Bool = false) {
        self._selection = selection
        self.options = options
        self.isDisabled = isDisabled
    }

    /// The toggle group body.
    public var body: some View {
        HStack {
            ForEach(options) { option in
                CNToggle(isOn: binding(for: option.value), isDisabled: isDisabled) {
                    if let systemImage = option.systemImage {
                        Label(option.title, systemImage: systemImage)
                    } else {
                        Text(option.title)
                    }
                }
            }
        }
        .accessibilityElement(children: .contain)
    }

    private func binding(for value: Value) -> Binding<Bool> {
        Binding {
            selection.contains(value)
        } set: { isOn in
            if isOn {
                selection.insert(value)
            } else {
                selection.remove(value)
            }
        }
    }
}
