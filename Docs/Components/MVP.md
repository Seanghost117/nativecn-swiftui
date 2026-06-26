# MVP Components

Phase 3 ships the first NativeCN component set:

- `CNButton`
- `CNBadge`
- `CNCard`
- `CNSeparator`
- `CNLabel`
- `CNField`
- `CNInput`

Each component reads visual values from `CNTheme`, supports light/dark themes, and includes package previews. The MVP set is intentionally small so the token, primitive, documentation, and catalog workflows can stabilize before broader component work begins.

## Settings Screen Composition

```swift
CNCard {
    CNCardHeader {
        CNCardTitle("Account")
        CNCardDescription("Manage your profile details.")
    }

    CNCardContent {
        CNField(label: "Display name") {
            CNInput("Display name", text: $displayName)
        }
    }

    CNCardFooter {
        CNButton("Save") {
            save()
        }
    }
}
```
