# Separator

`CNSeparator` renders a horizontal or vertical separator using the theme border token.

## Import And Setup

```swift
import NativeCN
import SwiftUI
```

## Basic Example

```swift
VStack {
    Text("Top")
    CNSeparator()
    Text("Bottom")
}

HStack {
    Text("Left")
    CNSeparator(.vertical)
        .frame(height: 32)
    Text("Right")
}
```

## Variants, Sizes, And States

`CNSeparator` supports horizontal and vertical orientation plus a configurable thickness.

## Real-World Example

```swift
CNCardContent {
    Text("Account")
    CNSeparator()
    Text("Security")
}
```

## Accessibility

Separators are hidden from accessibility because they are visual structure.

## Theming

Separators use `theme.colors.border`.

## API Reference

- `CNSeparator(_ orientation:thickness:)`
- `CNSeparator.Orientation`: `horizontal`, `vertical`

## Platform Differences

Separators behave consistently across supported Apple platforms.
