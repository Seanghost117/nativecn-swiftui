# Forms And Controls

Phase 6 adds `CNTextarea`, `CNInputGroup`, `CNInputOTP`, `CNSwitch`, `CNToggle`, `CNToggleGroup`, `CNSlider`, `CNCheckbox`, `CNRadioGroup`, `CNSelect`, `CNNativeSelect`, and `CNCombobox`.

## Import And Setup

```swift
import NativeCN
import SwiftUI
```

Use these components inside `CNThemeProvider` or a `.cnTheme(_:)` subtree.

## Textarea

```swift
@State private var message = ""

CNField(label: "Message", description: "Add context.") {
    CNTextarea("Write your message", text: $message, minHeight: 120)
}
```

`CNTextarea` supports placeholder text, invalid state through `CNField`, disabled state, focus binding, and min/max height.

## Input Group

```swift
@State private var workspace = "nativecn"

CNField(label: "Workspace URL") {
    CNInputGroup("workspace", text: $workspace, trailingText: ".app")
}
```

`CNInputGroup` provides leading and trailing add-ons for currency, URLs, units, and compact search controls.

## Input OTP

```swift
@State private var code = ""

CNField(label: "Verification code") {
    CNInputOTP(text: $code, length: 6, groupSize: 3)
}
```

`CNInputOTP` provides grouped digit slots for one-time-code and verification flows.

## Switch

```swift
@State private var notifications = true

CNSwitch("Notifications", isOn: $notifications)
```

`CNSwitch` uses native SwiftUI switch behavior with NativeCN tint and typography.

## Toggle And Toggle Group

```swift
@State private var selected = true
@State private var formats: Set<String> = ["bold"]

CNToggle("Selected", isOn: $selected)

CNToggleGroup(
    selection: $formats,
    options: [
        CNToggleGroupOption("Bold", value: "bold", systemImage: "bold"),
        CNToggleGroupOption("Italic", value: "italic", systemImage: "italic")
    ]
)
```

`CNToggleGroup` supports multiple selection and optional SF Symbol labels.

## Slider

```swift
@State private var volume = 0.7

CNSlider(value: $volume, label: "Volume", showsValue: true)
```

`CNSlider` clamps values into its range and uses NativeCN primary tint.

## Checkbox

```swift
@State private var accepted = false

CNCheckbox("Accept terms", isOn: $accepted)
```

`CNCheckbox` provides a tokenized square check control for forms.

## Radio Group

```swift
@State private var plan = "pro"

CNRadioGroup(
    selection: $plan,
    options: [
        CNRadioOption("Free", value: "free"),
        CNRadioOption("Pro", value: "pro"),
        CNRadioOption("Team", value: "team")
    ]
)
```

`CNRadioGroup` supports single selection with optional descriptions.

## Select

```swift
@State private var role: String? = nil

CNSelect(
    "Role",
    selection: $role,
    options: [
        CNSelectOption("Admin", value: "admin"),
        CNSelectOption("Editor", value: "editor"),
        CNSelectOption("Viewer", value: "viewer")
    ]
)
```

`CNSelect` is a first-pass native select backed by SwiftUI `Menu`.

## Native Select

```swift
@State private var role = "editor"

CNNativeSelect(
    "Role",
    selection: $role,
    options: [
        CNSelectOption("Admin", value: "admin"),
        CNSelectOption("Editor", value: "editor"),
        CNSelectOption("Viewer", value: "viewer")
    ]
)
```

`CNNativeSelect` uses SwiftUI `Picker` for cases where the platform-default menu control is preferred over the tokenized `CNSelect` trigger.

## Combobox

```swift
@State private var team: String? = nil

CNCombobox(
    "Team",
    selection: $team,
    options: [
        CNComboboxOption("Design Systems", value: "design", subtitle: "Tokens and components"),
        CNComboboxOption("Platform", value: "platform", subtitle: "Build and release"),
        CNComboboxOption("Support", value: "support", subtitle: "Docs and enablement")
    ],
    searchPlaceholder: "Search teams"
)
```

`CNCombobox` adds searchable selection for larger option sets using native popover presentation.

## Real-World Example

```swift
CNCard {
    CNCardHeader {
        CNCardTitle("Preferences")
        CNCardDescription("Configure form controls.")
    }

    CNCardContent {
        CNField(label: "Bio") {
            CNTextarea("Tell us about yourself", text: $bio)
        }

        CNSwitch("Notifications", isOn: $notifications)
        CNCheckbox("Accept terms", isOn: $accepted)
    }
}
```

## Accessibility

Controls use native SwiftUI roles where possible. Custom checkbox, toggle, radio, select, combobox, and OTP controls expose selected, checked, or entered values. Textarea uses native multiline editing.

## Theming

Forms and controls use primary, background, foreground, muted, muted foreground, accent, border, input, ring, destructive, spacing, radius, and typography tokens.

## API Reference

- `CNTextarea(_:text:minHeight:maxHeight:isDisabled:isInvalid:focus:)`
- `CNInputGroup(_:text:isDisabled:isInvalid:leading:trailing:)`
- `CNInputGroup(_:text:leadingText:isDisabled:isInvalid:)`
- `CNInputGroup(_:text:trailingText:isDisabled:isInvalid:)`
- `CNInputOTP(text:length:groupSize:label:isDisabled:isInvalid:)`
- `CNInputOTP.sanitized(_:length:)`
- `CNInputOTP.normalizedLength(_:)`
- `CNInputOTP.normalizedGroupSize(_:length:)`
- `CNSwitch(_:isOn:isDisabled:)`
- `CNToggle(_:isOn:isDisabled:)`
- `CNToggleGroup(selection:options:isDisabled:)`
- `CNToggleGroupOption(_:value:systemImage:)`
- `CNSlider(value:in:step:label:showsValue:isDisabled:)`
- `CNCheckbox(_:isOn:isDisabled:)`
- `CNRadioGroup(selection:options:isDisabled:)`
- `CNRadioOption(_:value:description:)`
- `CNSelect(_:selection:options:isDisabled:)`
- `CNSelectOption(_:value:)`
- `CNNativeSelect(_:selection:options:isDisabled:)`
- `CNCombobox(_:selection:options:searchPlaceholder:emptyTitle:isDisabled:)`
- `CNComboboxOption(_:value:subtitle:systemImage:keywords:)`
- `CNComboboxOption.matches(_:)`

## Platform Differences

`CNSwitch`, `CNSlider`, `CNSelect`, and `CNCombobox` use native SwiftUI controls or presentation APIs, so rendering may vary slightly by platform. `CNCheckbox` and `CNRadioGroup` provide consistent tokenized visuals across supported platforms.
