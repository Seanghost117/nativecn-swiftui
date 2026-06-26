import SwiftUI

struct CNCalendar_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            VStack(alignment: .leading, spacing: 16) {
                CNDatePicker("Due date", selection: .constant(.now))

                CNDatePicker("Launch date", selection: .constant(.now), style: .graphical)

                CNCalendarMonth(selection: .constant(.now))

                CNDateRangePicker(
                    startDate: .constant(.now),
                    endDate: .constant(Date(timeIntervalSinceNow: 86_400 * 7))
                )
            }
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}
