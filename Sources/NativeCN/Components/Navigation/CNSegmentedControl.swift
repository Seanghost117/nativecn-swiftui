import SwiftUI

/// A selectable option for `CNSegmentedControl`.
public struct CNSegmentedControlOption<Value: Hashable & Sendable>: Identifiable, Sendable, Equatable {
    /// Option title.
    public var title: String

    /// Option value.
    public var value: Value

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Stable identifier.
    public var id: Value { value }

    /// Creates a segmented control option.
    public init(_ title: String, value: Value, systemImage: String? = nil) {
        self.title = title
        self.value = value
        self.systemImage = systemImage
    }
}

/// A compact token-driven single-selection segmented control.
public struct CNSegmentedControl<Value: Hashable & Sendable>: View {
    @Environment(\.cnTheme) private var theme

    @Binding private var selection: Value
    private let options: [CNSegmentedControlOption<Value>]
    private let isDisabled: Bool

    /// Creates a segmented control.
    public init(selection: Binding<Value>, options: [CNSegmentedControlOption<Value>], isDisabled: Bool = false) {
        self._selection = selection
        self.options = options
        self.isDisabled = isDisabled
    }

    /// The segmented control body.
    public var body: some View {
        HStack(spacing: theme.space.x1) {
            ForEach(options) { option in
                Button {
                    selection = option.value
                } label: {
                    HStack(spacing: theme.space.x1) {
                        if let systemImage = option.systemImage {
                            Image(systemName: systemImage)
                                .accessibilityHidden(true)
                        }

                        Text(option.title)
                    }
                    .font(theme.typography.subheadline.font.weight(.medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)
                    .foregroundStyle(foreground(for: option).color)
                    .padding(.horizontal, theme.space.x3)
                    .frame(minHeight: 30)
                    .frame(maxWidth: .infinity)
                    .background(background(for: option).color)
                    .clipShape(RoundedRectangle(cornerRadius: theme.radius.sm))
                    .contentShape(RoundedRectangle(cornerRadius: theme.radius.sm))
                }
                .buttonStyle(.plain)
                .accessibilityValue(selection == option.value ? Text("Selected") : Text("Not selected"))
            }
        }
        .padding(theme.space.x1)
        .background(theme.colors.muted.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
        .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.md)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.55 : 1)
        .accessibilityElement(children: .contain)
    }

    private func foreground(for option: CNSegmentedControlOption<Value>) -> CNColorToken {
        selection == option.value ? theme.colors.foreground : theme.colors.mutedForeground
    }

    private func background(for option: CNSegmentedControlOption<Value>) -> CNColorToken {
        selection == option.value ? theme.colors.background : CNColorToken(red: 0, green: 0, blue: 0, opacity: 0)
    }
}
