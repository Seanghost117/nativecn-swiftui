# Calendar Components

NativeCN calendar components begin with native SwiftUI date picking. This keeps platform behavior, localization, accessibility, and input methods intact before any custom calendar grid is introduced.

## Examples

```swift
@State private var dueDate = Date()
@State private var startsAt = Date()
@State private var endsAt = Date(timeIntervalSinceNow: 86_400 * 7)

CNField(label: "Due date") {
    CNDatePicker("Due date", selection: $dueDate, hidesLabel: true)
}

CNDatePicker("Launch date", selection: $dueDate, style: .graphical)

CNCalendarMonth(selection: $selectedDay)

CNDateRangePicker(startDate: $startsAt, endDate: $endsAt)
```

## Components

`CNDatePicker` wraps SwiftUI `DatePicker` in a NativeCN token-framed control surface.

`CNCalendarMonth` displays a lightweight themed month grid for visible day selection, with selected, today, adjacent-month, and disabled states.

`CNDateRangePicker` pairs start and end date pickers and constrains each picker so the range stays ordered.

## Accessibility

Date controls use native SwiftUI date picker semantics, including platform localization and VoiceOver behavior.

Hidden labels are still passed to the underlying picker and exposed as accessibility labels.

Month grid days are native buttons with complete date labels and selected-state values.

## Theming

Calendar components read foreground, muted foreground, primary, primary foreground, card, muted, background, input, border, radius, spacing, and typography tokens from `CNTheme`.

## API Reference

- `CNDatePickerStyle`
- `CNDatePicker(_:selection:in:displayedComponents:style:isDisabled:hidesLabel:)`
- `CNCalendarMonth(selection:displayedMonth:in:calendar:showsAdjacentMonths:allowsMonthNavigation:)`
- `CNCalendarMonth.days(displayedMonth:selection:range:calendar:)`
- `CNDateRangePicker(startDate:endDate:startLabel:endLabel:displayedComponents:style:isDisabled:)`

## Platform Differences

`CNDatePicker` uses SwiftUI `DatePicker` styles, so compact and graphical presentations follow host platform conventions.

`CNCalendarMonth` is a custom SwiftUI grid for day selection. It complements, rather than replaces, native date input.

`CNDateRangePicker` is a composition of two native date pickers with an ordered range summary.
