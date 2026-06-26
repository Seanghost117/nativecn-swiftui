# Card

`CNCard` is a token-driven surface container with composable header, content, and footer sections.

## Import And Setup

```swift
import NativeCN
import SwiftUI
```

Use inside a themed subtree.

## Basic Example

```swift
CNCard {
    CNCardHeader {
        CNCardTitle("Billing")
        CNCardDescription("Manage your subscription and invoices.")
    }

    CNCardContent {
        Text("Pro plan")
    }

    CNCardFooter {
        CNButton("Update") {
            updatePlan()
        }
    }
}
```

## Variants, Sizes, And States

`CNCard` does not currently expose variants or interactive states. Use the `padding` initializer argument for compact or roomy surfaces.

## Real-World Example

```swift
CNCard {
    CNCardHeader {
        CNCardTitle("Settings")
        CNCardDescription("Manage app preferences.")
    }

    CNCardContent {
        CNField(label: "Display name") {
            CNInput("Display name", text: $displayName)
        }
    }

    CNCardFooter {
        CNButton("Save") {}
    }
}
```

## Accessibility

`CNCardTitle` adds heading traits. The card itself preserves child accessibility structure.

## Theming

Cards use `card`, `cardForeground`, `border`, spacing, and radius tokens. The root card accepts a custom `padding` value when a composition needs tighter or roomier layout.

## API Reference

- `CNCard(padding:content:)`
- `CNCardHeader(content:)`
- `CNCardTitle(_:)`
- `CNCardDescription(_:)`
- `CNCardContent(content:)`
- `CNCardFooter(content:)`

## Platform Differences

Cards are plain SwiftUI surfaces and adapt through normal SwiftUI layout behavior.
