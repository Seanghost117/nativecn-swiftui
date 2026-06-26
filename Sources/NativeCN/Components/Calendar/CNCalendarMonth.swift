import SwiftUI

/// A rendered day in `CNCalendarMonth`.
public struct CNCalendarMonthDay: Identifiable, Sendable, Equatable {
    /// Stable day identifier.
    public var id: String

    /// Date represented by this cell.
    public var date: Date

    /// Numeric day label.
    public var day: Int

    /// Whether the day belongs to the displayed month.
    public var isInDisplayedMonth: Bool

    /// Whether the day is today.
    public var isToday: Bool

    /// Whether the day is selected.
    public var isSelected: Bool

    /// Whether the day cannot be selected.
    public var isDisabled: Bool
}

/// A lightweight themed month grid for date selection.
public struct CNCalendarMonth: View {
    @Environment(\.cnTheme) private var theme

    @Binding private var selection: Date?
    @State private var displayedMonth: Date

    private let calendar: Calendar
    private let range: ClosedRange<Date>?
    private let showsAdjacentMonths: Bool
    private let allowsMonthNavigation: Bool

    /// Creates a calendar month grid.
    public init(
        selection: Binding<Date?>,
        displayedMonth: Date = Date(),
        in range: ClosedRange<Date>? = nil,
        calendar: Calendar = .current,
        showsAdjacentMonths: Bool = true,
        allowsMonthNavigation: Bool = true
    ) {
        self._selection = selection
        self._displayedMonth = State(initialValue: displayedMonth)
        self.calendar = calendar
        self.range = range
        self.showsAdjacentMonths = showsAdjacentMonths
        self.allowsMonthNavigation = allowsMonthNavigation
    }

    /// The calendar month body.
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x4) {
            header
            weekdayHeader
            dayGrid
        }
        .padding(theme.space.x4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.card.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.lg)
        .accessibilityElement(children: .contain)
    }

    private var header: some View {
        HStack(spacing: theme.space.x2) {
            Text(monthTitle)
                .font(theme.typography.headline.font)
                .foregroundStyle(theme.colors.foreground.color)
                .accessibilityAddTraits(.isHeader)

            Spacer(minLength: theme.space.x3)

            if allowsMonthNavigation {
                Button {
                    moveMonth(by: -1)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.caption.weight(.semibold))
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)
                .foregroundStyle(theme.colors.mutedForeground.color)
                .background(theme.colors.background.color)
                .clipShape(RoundedRectangle(cornerRadius: theme.radius.sm))
                .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.sm)
                .accessibilityLabel("Previous month")

                Button {
                    moveMonth(by: 1)
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.semibold))
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)
                .foregroundStyle(theme.colors.mutedForeground.color)
                .background(theme.colors.background.color)
                .clipShape(RoundedRectangle(cornerRadius: theme.radius.sm))
                .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.sm)
                .accessibilityLabel("Next month")
            }
        }
    }

    private var weekdayHeader: some View {
        Grid(horizontalSpacing: theme.space.x1, verticalSpacing: theme.space.x1) {
            GridRow {
                ForEach(weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(theme.typography.caption.font.weight(.semibold))
                        .foregroundStyle(theme.colors.mutedForeground.color)
                        .frame(maxWidth: .infinity, minHeight: 24)
                }
            }
        }
    }

    private var dayGrid: some View {
        Grid(horizontalSpacing: theme.space.x1, verticalSpacing: theme.space.x1) {
            ForEach(0..<6, id: \.self) { row in
                GridRow {
                    ForEach(0..<7, id: \.self) { column in
                        dayCell(days[(row * 7) + column])
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func dayCell(_ day: CNCalendarMonthDay) -> some View {
        if !showsAdjacentMonths && !day.isInDisplayedMonth {
            Color.clear
                .frame(maxWidth: .infinity, minHeight: 34)
                .accessibilityHidden(true)
        } else {
            Button {
                select(day)
            } label: {
                Text("\(day.day)")
                    .font(theme.typography.subheadline.font.weight(day.isSelected ? .semibold : .regular))
                    .frame(width: 34, height: 34)
                    .foregroundStyle(foreground(for: day).color)
                    .background(background(for: day).color)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(todayBorder(for: day).color, lineWidth: day.isToday && !day.isSelected ? 1 : 0)
                    }
                    .opacity(dayOpacity(for: day))
                    .frame(maxWidth: .infinity, minHeight: 34)
            }
            .buttonStyle(.plain)
            .disabled(day.isDisabled)
            .accessibilityLabel(day.date.formatted(date: .complete, time: .omitted))
            .accessibilityValue(day.isSelected ? "Selected" : "")
        }
    }

    private var days: [CNCalendarMonthDay] {
        Self.days(
            displayedMonth: displayedMonth,
            selection: selection,
            range: range,
            calendar: calendar
        )
    }

    private var weekdaySymbols: [String] {
        let symbols = calendar.veryShortStandaloneWeekdaySymbols
        let startIndex = max(calendar.firstWeekday - 1, 0)
        return Array(symbols[startIndex...] + symbols[..<startIndex])
    }

    private var monthTitle: String {
        displayedMonth.formatted(.dateTime.month(.wide).year())
    }

    private func select(_ day: CNCalendarMonthDay) {
        guard !day.isDisabled else {
            return
        }

        selection = day.date

        if !day.isInDisplayedMonth {
            displayedMonth = day.date
        }
    }

    private func moveMonth(by value: Int) {
        if let nextMonth = calendar.date(byAdding: .month, value: value, to: displayedMonth) {
            displayedMonth = nextMonth
        }
    }

    private func foreground(for day: CNCalendarMonthDay) -> CNColorToken {
        if day.isSelected {
            return theme.colors.primaryForeground
        }

        if day.isDisabled || !day.isInDisplayedMonth {
            return theme.colors.mutedForeground
        }

        return theme.colors.foreground
    }

    private func background(for day: CNCalendarMonthDay) -> CNColorToken {
        day.isSelected ? theme.colors.primary : CNColorToken(red: 0, green: 0, blue: 0, opacity: 0)
    }

    private func todayBorder(for day: CNCalendarMonthDay) -> CNColorToken {
        day.isToday ? theme.colors.primary : CNColorToken(red: 0, green: 0, blue: 0, opacity: 0)
    }

    private func dayOpacity(for day: CNCalendarMonthDay) -> Double {
        if day.isDisabled {
            return 0.35
        }

        return day.isInDisplayedMonth ? 1 : 0.5
    }

    /// Builds the six-week month grid for the supplied month.
    public static func days(
        displayedMonth: Date,
        selection: Date?,
        range: ClosedRange<Date>? = nil,
        calendar: Calendar = .current
    ) -> [CNCalendarMonthDay] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: displayedMonth),
            let gridStart = gridStart(for: monthInterval.start, calendar: calendar)
        else {
            return []
        }

        return (0..<42).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: gridStart) else {
                return nil
            }

            let day = calendar.component(.day, from: date)
            let isInDisplayedMonth = calendar.isDate(date, equalTo: monthInterval.start, toGranularity: .month)
            let isSelected = selection.map { calendar.isDate(date, inSameDayAs: $0) } ?? false
            let isDisabled = !isDate(date, inside: range, calendar: calendar)

            return CNCalendarMonthDay(
                id: stableID(for: date, calendar: calendar),
                date: date,
                day: day,
                isInDisplayedMonth: isInDisplayedMonth,
                isToday: calendar.isDateInToday(date),
                isSelected: isSelected,
                isDisabled: isDisabled
            )
        }
    }

    private static func gridStart(for monthStart: Date, calendar: Calendar) -> Date? {
        let firstWeekday = calendar.component(.weekday, from: monthStart)
        let leadingDays = (firstWeekday - calendar.firstWeekday + 7) % 7
        return calendar.date(byAdding: .day, value: -leadingDays, to: monthStart)
    }

    private static func isDate(_ date: Date, inside range: ClosedRange<Date>?, calendar: Calendar) -> Bool {
        guard let range else {
            return true
        }

        let day = calendar.startOfDay(for: date)
        let lowerBound = calendar.startOfDay(for: range.lowerBound)
        let upperBound = calendar.startOfDay(for: range.upperBound)
        return (lowerBound...upperBound).contains(day)
    }

    private static func stableID(for date: Date, calendar: Calendar) -> String {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return "\(components.year ?? 0)-\(components.month ?? 0)-\(components.day ?? 0)"
    }
}
