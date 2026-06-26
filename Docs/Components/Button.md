# Button

`CNButton` is a token-driven SwiftUI button with variants, sizes, loading state, disabled state, and custom label content.

## Import And Setup

```swift
import NativeCN
import SwiftUI
```

Wrap your app or screen in `CNThemeProvider` or use `.cnTheme(_:)`.

## Basic Example

```swift
CNButton("Continue") {
    continueFlow()
}
```

## Variants

```swift
CNButton("Delete", variant: .destructive, role: .destructive) {
    deleteItem()
}
```

```swift
CNButton("Primary", variant: .primary) {}
CNButton("Secondary", variant: .secondary) {}
CNButton("Delete", variant: .destructive) {}
CNButton("Outline", variant: .outline) {}
CNButton("Ghost", variant: .ghost) {}
CNButton("Link", variant: .link) {}
```

## Sizes

```swift
CNButton("Small", size: .sm) {}
CNButton("Medium", size: .md) {}
CNButton("Large", size: .lg) {}

CNButton(variant: .outline, size: .icon) {
    openSettings()
} label: {
    Image(systemName: "gearshape")
}
.accessibilityLabel("Settings")
```

## States

```swift
CNButton("Saving", isLoading: true) {}
CNButton("Disabled", isDisabled: true) {}
```

## Real-World Example

```swift
CNCardFooter {
    CNButton("Cancel", variant: .outline) {}
    CNButton("Save") {
        save()
    }
}
```

## Accessibility

Icon-only buttons should include an accessibility label. Loading buttons are disabled while loading to avoid duplicate taps.

## Theming

Button variants resolve through `CNTheme.colors`: primary, secondary, destructive, border, background, and foreground tokens.

## API Reference

- `CNButton(_:variant:size:role:isLoading:isDisabled:loadingLabel:action:)`
- `CNButton(variant:size:role:isLoading:isDisabled:loadingLabel:action:label:)`
- `CNButton.Variant`: `primary`, `secondary`, `destructive`, `outline`, `ghost`, `link`
- `CNButton.Size`: `sm`, `md`, `lg`, `icon`

## Platform Differences

`CNButton` uses native SwiftUI `Button`, so keyboard, focus, and assistive behavior follow the host Apple platform.
