# Field And Input

`CNField`, `CNLabel`, and `CNInput` compose accessible form layouts.

## Import And Setup

```swift
import NativeCN
import SwiftUI
```

Use inside a themed subtree.

## Basic Example

```swift
@State private var email = ""

CNField(
    label: "Email",
    description: "Use your work email.",
    error: email.isEmpty ? "Email is required." : nil,
    isRequired: true
) {
    CNInput("Email", text: $email, keyboardType: .emailAddress)
}
```

When `CNField` has an error, it propagates invalid state to child controls through the SwiftUI environment.

## Variants And Layouts

```swift
CNField(label: "Email", layout: .vertical) {
    CNInput("Email", text: $email)
}

CNField(label: "Email", layout: .compact) {
    CNInput("Email", text: $email)
}
```

## States

```swift
CNInput("Disabled", text: $value, isDisabled: true)
CNInput("Invalid", text: $value, isInvalid: true)
```

## Accessories

```swift
CNInput("Search", text: $query, leadingIcon: "magnifyingglass")

CNInput("Amount", text: $amount, trailing: {
    Text("USD")
})
```

## Focus

```swift
@FocusState private var emailFocused: Bool

CNInput("Email", text: $email, focus: $emailFocused)
```

## Real-World Example

```swift
CNCard {
    CNCardHeader {
        CNCardTitle("Profile")
        CNCardDescription("Update account details.")
    }

    CNCardContent {
        CNField(label: "Display name") {
            CNInput("Display name", text: $displayName)
        }
    }
}
```

## Accessibility

`CNLabel` marks required labels in its accessibility label. `CNField` groups label, description, error, and control content. `CNInput` uses native `TextField` behavior and supports focus bindings.

## Theming

Fields use foreground, muted foreground, destructive, input, border, ring, spacing, radius, and typography tokens.

## API Reference

- `CNLabel(_:isRequired:)`
- `CNField(label:description:error:isRequired:layout:control:)`
- `CNField.Layout`: `vertical`, `compact`
- `CNInput(_:text:isDisabled:isInvalid:keyboardType:submitLabel:focus:)`
- `CNInput(_:text:leadingIcon:isDisabled:isInvalid:keyboardType:submitLabel:focus:)`
- `CNInput(_:text:trailing:)`
- `CNInputKeyboardType`: `default`, `emailAddress`, `numberPad`, `decimalPad`, `URL`, `phonePad`

## Platform Differences

`CNInput` uses native `TextField` editing behavior, supports disabled and invalid states, and accepts keyboard and submit-label hints where SwiftUI exposes them.
