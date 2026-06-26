import NativeCN
import SwiftUI

struct CatalogCalendarPage: View {
    @State private var dueDate = Date()
    @State private var launchDate = Date(timeIntervalSinceNow: 86_400 * 3)
    @State private var selectedDay: Date? = Date()
    @State private var startsAt = Date()
    @State private var endsAt = Date(timeIntervalSinceNow: 86_400 * 10)

    var body: some View {
        CatalogPage(
            title: "Calendar",
            subtitle: "Native date picking with token-framed NativeCN surfaces."
        ) {
            CNSection("Date Picker", subtitle: "Compact and graphical native date inputs.") {
                VStack(alignment: .leading, spacing: 16) {
                    CNField(label: "Due date", description: "Compact platform picker inside a field.") {
                        CNDatePicker("Due date", selection: $dueDate, hidesLabel: true)
                    }

                    CNField(label: "Launch date", description: "Graphical calendar-style presentation.") {
                        CNDatePicker("Launch date", selection: $launchDate, style: .graphical, hidesLabel: true)
                    }
                }
                .padding(16)
            }

            CNSection("Month Grid", subtitle: "A token-driven calendar grid for visible day selection.") {
                VStack(alignment: .leading, spacing: 12) {
                    CNCalendarMonth(selection: $selectedDay)

                    if let selectedDay {
                        CNNote(selectedDay.formatted(date: .complete, time: .omitted), title: "Selected day")
                    }
                }
                .padding(16)
            }

            CNSection("Date Range", subtitle: "Paired start and end pickers that keep the range ordered.") {
                CNDateRangePicker(startDate: $startsAt, endDate: $endsAt)
                    .padding(16)
            }
        }
    }
}
