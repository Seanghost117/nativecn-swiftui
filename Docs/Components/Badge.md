# Badge

`CNBadge` displays compact status or metadata using semantic theme tokens.

## Import And Setup

```swift
import NativeCN
import SwiftUI
```

Use inside a themed subtree.

## Basic Example

```swift
CNBadge("Beta")
CNBadge("Danger", variant: .destructive)
CNBadge(variant: .outline) {
    Label("Synced", systemImage: "checkmark.circle")
}
```

## Variants

```swift
CNBadge("Primary", variant: .primary)
CNBadge("Secondary", variant: .secondary)
CNBadge("Destructive", variant: .destructive)
CNBadge("Outline", variant: .outline)
```

## Sizes And States

Badges do not currently expose a size enum or interactive states. They use Dynamic Type-compatible caption typography and scale with content.

## Real-World Example

```swift
HStack {
    Text("Plan")
    Spacer()
    CNBadge("Pro", variant: .primary)
}
```

## Accessibility

Badge content is combined for accessibility and uses Dynamic Type-compatible caption typography.

## Theming

Badge variants resolve through primary, secondary, destructive, foreground, and border tokens.

## API Reference

- `CNBadge(_:variant:)`
- `CNBadge(variant:content:)`
- `CNBadge.Variant`: `primary`, `secondary`, `destructive`, `outline`

## Platform Differences

`CNBadge` is non-interactive and behaves the same across supported Apple platforms.
