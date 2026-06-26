import SwiftUI
import XCTest

@testable import NativeCN

final class CalendarComponentTests: XCTestCase {
    func testDatePickerStylesCoverNativePresentations() {
        XCTAssertEqual(CNDatePickerStyle.allCases, [.automatic, .compact, .graphical])
    }

    func testCalendarMonthBuildsSixWeekGridWithSelectionAndRangeState() throws {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!

        let displayedMonth = try XCTUnwrap(calendar.date(from: DateComponents(year: 2026, month: 6, day: 15)))
        let selected = try XCTUnwrap(calendar.date(from: DateComponents(year: 2026, month: 6, day: 25)))
        let lowerBound = try XCTUnwrap(calendar.date(from: DateComponents(year: 2026, month: 6, day: 10)))
        let upperBound = try XCTUnwrap(calendar.date(from: DateComponents(year: 2026, month: 6, day: 30)))

        let days = CNCalendarMonth.days(
            displayedMonth: displayedMonth,
            selection: selected,
            range: lowerBound...upperBound,
            calendar: calendar
        )

        XCTAssertEqual(days.count, 42)
        XCTAssertTrue(days.contains { $0.day == 25 && $0.isSelected && $0.isInDisplayedMonth })
        XCTAssertTrue(days.contains { $0.day == 9 && $0.isDisabled })
        XCTAssertTrue(days.contains { $0.day == 30 && !$0.isDisabled })
    }

    func testCalendarComponentsCompileTogetherInFormSurface() {
        _ = CalendarSmokeView()
    }
}

private struct CalendarSmokeView: View {
    @State private var dueDate = Date()
    @State private var selectedDay: Date? = Date()
    @State private var startDate = Date()
    @State private var endDate = Date(timeIntervalSinceNow: 86_400)

    var body: some View {
        CNThemeProvider {
            VStack {
                CNField(label: "Due date") {
                    CNDatePicker("Due date", selection: $dueDate, hidesLabel: true)
                }

                CNDatePicker("Launch date", selection: $dueDate, style: .graphical)

                CNCalendarMonth(selection: $selectedDay)

                CNDateRangePicker(startDate: $startDate, endDate: $endDate)
            }
        }
    }
}
