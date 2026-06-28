# NativeCN Catalog

This directory contains the initial SwiftUI catalog shell for NativeCN examples.

The catalog shell includes component pages, theme previews, Dynamic Type checks, and real-world example screens built from the current MVP component set.

## Run

From the repository root:

```bash
swift run NativeCNCatalog
```

For a visible local macOS app bundle during QA:

```bash
swift build --product NativeCNCatalog
cp .build/x86_64-apple-macosx/debug/NativeCNCatalog .build/NativeCNCatalog.app/Contents/MacOS/NativeCNCatalog
codesign --force --sign - .build/NativeCNCatalog.app
open -n -F .build/NativeCNCatalog.app
```

To view it in Xcode:

```bash
open Package.swift
```

Then select the `NativeCNCatalog` scheme and run it on My Mac.

Current pages:

- MVP Components
- Tokens
- Theme Playground
- Button
- Badge
- Card
- Input
- Field
- Forms & Controls
- Loading & Media
- Feedback & Overlays
- Layout
- Navigation
- Data Display
- Content
- Interaction
- Command
- Calendar
- Chat
- Example Screens

Reserved shell sections:

- Forms
- Feedback
- Accessibility Playground
