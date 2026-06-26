# Content Components

NativeCN content components support explanatory product copy, docs-like screens, onboarding, and developer workflows.

## Examples

```swift
CNCallout("Heads up", message: "Use callouts for contextual guidance.", variant: .info) {
    CNButton("Review", variant: .outline, size: .sm) {}
}

CNNote("Copy mode keeps source ownership inside your app.", title: "Registry note")

CNCodeBlock(
    """
    swift build
    swift test
    """,
    language: "bash",
    title: "Terminal"
)

HStack {
    Text("Wrap component names like")
    CNInlineCode("CNThemeProvider")
}

CNKeyboardShortcut("Command", "K")
```

## Components

`CNCallout` displays contextual guidance with a title, optional message, variant, icon, and actions.

`CNNote` displays quieter explanatory content for supporting copy.

`CNCodeBlock` displays titled, copyable, monospaced code or command snippets with horizontal scrolling by default.

`CNInlineCode` displays compact inline code tokens inside prose and notes.

`CNKeyboardShortcut` displays one or more keycaps for command palettes, menus, and shortcut hints.

## Accessibility

Callout icons are decorative and hidden from accessibility.

Notes combine title and body content into one readable element.

Code blocks allow text selection, keep a visible title or language label, and expose a copy action when enabled.

Inline code reads as plain text. Keyboard shortcuts combine their keys into one accessible element.

## Theming

Content components read foreground, muted foreground, card, muted, border, radius, spacing, and typography tokens from `CNTheme`.

## API Reference

- `CNCallout(_:message:variant:systemImage:actions:)`
- `CNNote(title:content:)`
- `CNNote(_:title:)`
- `CNCodeBlock(_:language:title:isCopyable:wrapsLines:)`
- `CNInlineCode(_:)`
- `CNKeyboardShortcut(_:)`
- `CNKeyboardShortcut(_ keys: [String])`

## Platform Differences

These components are pure SwiftUI. `CNCodeBlock` uses platform pasteboards for its copy action on iOS and macOS.

`CNCodeBlock` is horizontally scrollable by default, supports wrapped lines when requested, and supports text selection on supported platforms.
