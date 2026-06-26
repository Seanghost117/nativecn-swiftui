import SwiftUI

/// Visual presentation options for NativeCN date pickers.
public enum CNDatePickerStyle: String, CaseIterable, Sendable, Equatable {
    /// Uses the platform default presentation.
    case automatic

    /// Uses the compact platform picker.
    case compact

    /// Uses the graphical calendar-style picker.
    case graphical
}

/// A token-framed native SwiftUI date picker.
public struct CNDatePicker: View {
    @Environment(\.cnTheme) private var theme

    private let label: String
    @Binding private var selection: Date
    private let range: ClosedRange<Date>?
    private let displayedComponents: DatePickerComponents
    private let style: CNDatePickerStyle
    private let isDisabled: Bool
    private let hidesLabel: Bool

    /// Creates a date picker.
    public init(
        _ label: String,
        selection: Binding<Date>,
        in range: ClosedRange<Date>? = nil,
        displayedComponents: DatePickerComponents = [.date],
        style: CNDatePickerStyle = .compact,
        isDisabled: Bool = false,
        hidesLabel: Bool = false
    ) {
        self.label = label
        self._selection = selection
        self.range = range
        self.displayedComponents = displayedComponents
        self.style = style
        self.isDisabled = isDisabled
        self.hidesLabel = hidesLabel
    }

    /// The date picker body.
    public var body: some View {
        styledPicker(basePicker)
            .font(theme.typography.body.font)
            .foregroundStyle(theme.colors.foreground.color)
            .padding(.horizontal, theme.space.x4)
            .padding(.vertical, theme.space.x3)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(theme.colors.background.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
            .cnBorder(color: theme.colors.input, cornerRadius: theme.radius.lg)
            .disabled(isDisabled)
            .opacity(isDisabled ? 0.55 : 1)
            .accessibilityLabel(label)
    }

    @ViewBuilder
    private var basePicker: some View {
        if let range {
            labelVisibility(
                DatePicker(label, selection: $selection, in: range, displayedComponents: displayedComponents)
            )
        } else {
            labelVisibility(
                DatePicker(label, selection: $selection, displayedComponents: displayedComponents)
            )
        }
    }

    @ViewBuilder
    private func labelVisibility<Picker: View>(_ picker: Picker) -> some View {
        if hidesLabel {
            picker.labelsHidden()
        } else {
            picker
        }
    }

    @ViewBuilder
    private func styledPicker<Picker: View>(_ picker: Picker) -> some View {
        switch style {
        case .automatic:
            picker
        case .compact:
            picker.datePickerStyle(.compact)
        case .graphical:
            picker.datePickerStyle(.graphical)
        }
    }
}
