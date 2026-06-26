import SwiftUI

/// A paired start/end date picker.
public struct CNDateRangePicker: View {
    @Environment(\.cnTheme) private var theme

    @Binding private var startDate: Date
    @Binding private var endDate: Date

    private let startLabel: String
    private let endLabel: String
    private let displayedComponents: DatePickerComponents
    private let style: CNDatePickerStyle
    private let isDisabled: Bool

    /// Creates a date range picker.
    public init(
        startDate: Binding<Date>,
        endDate: Binding<Date>,
        startLabel: String = "Start date",
        endLabel: String = "End date",
        displayedComponents: DatePickerComponents = [.date],
        style: CNDatePickerStyle = .compact,
        isDisabled: Bool = false
    ) {
        self._startDate = startDate
        self._endDate = endDate
        self.startLabel = startLabel
        self.endLabel = endLabel
        self.displayedComponents = displayedComponents
        self.style = style
        self.isDisabled = isDisabled
    }

    /// The date range picker body.
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x3) {
            HStack(spacing: theme.space.x2) {
                Image(systemName: "calendar")
                    .foregroundStyle(theme.colors.mutedForeground.color)
                    .accessibilityHidden(true)

                Text(summary)
                    .font(theme.typography.subheadline.font.weight(.medium))
                    .foregroundStyle(theme.colors.foreground.color)
            }
            .padding(.horizontal, theme.space.x3)
            .frame(minHeight: 36)
            .background(theme.colors.muted.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))

            CNDatePicker(
                startLabel,
                selection: $startDate,
                in: Date.distantPast...endDate,
                displayedComponents: displayedComponents,
                style: style,
                isDisabled: isDisabled
            )

            CNDatePicker(
                endLabel,
                selection: $endDate,
                in: startDate...Date.distantFuture,
                displayedComponents: displayedComponents,
                style: style,
                isDisabled: isDisabled
            )
        }
        .accessibilityElement(children: .contain)
        .onChange(of: startDate) { newValue in
            if newValue > endDate {
                endDate = newValue
            }
        }
        .onChange(of: endDate) { newValue in
            if newValue < startDate {
                startDate = newValue
            }
        }
    }

    private var summary: String {
        "\(startDate.formatted(date: .abbreviated, time: .omitted)) - \(endDate.formatted(date: .abbreviated, time: .omitted))"
    }
}
