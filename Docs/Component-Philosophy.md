# Component Philosophy

NativeCN components are native SwiftUI views inspired by the source-owned, token-driven workflow of shadcn/ui.

## Native First

Components should respect SwiftUI and Apple platform behavior before chasing web parity. A component may share naming and semantic intent with a shadcn/ui component, but it should still feel native on iOS, iPadOS, and macOS.

## Tokens Before Styling

Visual decisions must flow through `CNTheme`:

```swift
@Environment(\.cnTheme) private var theme
```

Components should use semantic tokens such as `theme.colors.primary`, `theme.space.x4`, and `theme.radius.lg`.

## Composition Over Configuration

Prefer small view-builder slots and normal SwiftUI composition over large monolithic initializers. `CNCard`, for example, is built from `CNCardHeader`, `CNCardContent`, and `CNCardFooter`.

## Accessible Defaults

Interactive components should support disabled states, loading states where relevant, Dynamic Type, focus behavior, and clear VoiceOver semantics.

## Source Ownership

The package should remain useful through Swift Package Manager, while the code should stay readable enough for future copy-paste or registry workflows.
