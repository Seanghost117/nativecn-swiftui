# Command Components

NativeCN command components provide searchable command-palette workflows for iPad and macOS power-user surfaces, with a sheet-backed fallback for touch-first layouts.

## Examples

```swift
@State private var showingCommandPalette = false

CNButton("Open Command Palette", variant: .outline) {
    showingCommandPalette = true
}
.cnCommandPalette(
    isPresented: $showingCommandPalette,
    items: [
        CNCommandItem(id: "new", title: "New Project", subtitle: "Create a workspace", group: "Projects", systemImage: "plus"),
        CNCommandItem(id: "theme", title: "Toggle Theme", subtitle: "Switch light and dark mode", group: "Settings", systemImage: "moon"),
    ]
) { item in
    handle(item.id)
}
```

## Components

`CNCommandItem` describes a searchable command with a title, optional subtitle, group, icon, keywords, and disabled state.

`CNCommandPalette` displays grouped command rows, a search field, empty state, and selectable actions.

`.cnCommandPalette(isPresented:title:placeholder:emptyTitle:items:onSelect:)` presents the palette in a native SwiftUI sheet.

## Accessibility

The palette exposes its title as a header, focuses the search field on appear, and renders each command as a native button.

Disabled commands are unavailable to interaction and announce a disabled hint.

## Theming

Command components read foreground, muted foreground, background, card, border, radius, spacing, and typography tokens from `CNTheme`.

## API Reference

- `CNCommandItem(id:title:subtitle:group:systemImage:keywords:isDisabled:)`
- `CNCommandItem.matches(_:)`
- `CNCommandPalette(title:placeholder:emptyTitle:items:onSelect:)`
- `.cnCommandPalette(isPresented:title:placeholder:emptyTitle:items:onSelect:)`

## Platform Differences

The command palette uses native SwiftUI sheet presentation. On compact iPhone layouts it behaves like a focused sheet; on iPad and macOS it works well as a command surface opened by a keyboard shortcut or toolbar action.
