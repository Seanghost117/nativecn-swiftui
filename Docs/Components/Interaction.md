# Interaction Components

NativeCN interaction components adapt shadcn-style disclosure and contextual actions to native SwiftUI behavior.

## Examples

```swift
CNAccordion("Deployment details", subtitle: "Build, checks, and release notes", systemImage: "shippingbox", initiallyExpanded: true) {
    VStack(alignment: .leading) {
        CNBadge("Ready", variant: .secondary)
        Text("All required checks passed.")
    }
}

CNCollapsible("Advanced options", subtitle: "Optional setup controls", systemImage: "slider.horizontal.3") {
    Toggle("Enable verbose logs", isOn: $verboseLogging)
}

CNListRow("Project Alpha", subtitle: "Right-click or long-press for actions", systemImage: "folder")
    .cnContextMenu(items: [
        CNContextMenuItem(id: "rename", title: "Rename", systemImage: "pencil"),
        CNContextMenuItem(id: "archive", title: "Archive", systemImage: "archivebox"),
        CNContextMenuItem(id: "delete", title: "Delete", systemImage: "trash", isDestructive: true),
    ]) { item in
        handle(item.id)
    }
```

## Components

`CNAccordion` displays collapsible content in a themed, bordered disclosure surface.

`CNCollapsible` displays optional or advanced content in a more compact themed disclosure surface.

`CNContextMenuItem` and `.cnContextMenu(items:onSelect:)` add native context menus to any SwiftUI view.

## Accessibility

Accordion and collapsible headers expose expanded and collapsed state, and decorative icons are hidden from accessibility.

Context menus use native SwiftUI menu semantics for right-click, trackpad, pointer, and long-press access.

## Theming

Interaction components read foreground, muted foreground, card, border, radius, spacing, and typography tokens from `CNTheme`.

## API Reference

- `CNAccordion(_:subtitle:systemImage:initiallyExpanded:content:)`
- `CNAccordion(_:subtitle:systemImage:isExpanded:content:)`
- `CNCollapsible(_:subtitle:systemImage:initiallyExpanded:content:)`
- `CNCollapsible(_:subtitle:systemImage:isExpanded:content:)`
- `CNContextMenuItem(id:title:systemImage:isDestructive:)`
- `.cnContextMenu(items:onSelect:)`

## Platform Differences

Context menus follow host platform behavior: right-click and secondary click on macOS and pointer-enabled iPad, long-press on touch-first devices.

`CNAccordion` and `CNCollapsible` are pure SwiftUI and behave consistently across iOS and macOS.
