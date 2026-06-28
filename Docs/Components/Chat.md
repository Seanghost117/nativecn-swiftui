# Chat Components

NativeCN chat components provide the presentation layer for conversational product surfaces without becoming a chat backend or streaming engine.

## Import And Setup

```swift
import NativeCN
import SwiftUI
```

Use chat components inside `CNThemeProvider` or a `.cnTheme(_:)` subtree.

## Basic Example

```swift
CNMessageScroller(minHeight: 420) {
    CNMarker("Today", variant: .date)

    CNMessage(role: .assistant, author: "NativeCN", timestamp: "9:41 AM", avatarFallback: "NC") {
        Text("I can help review the component surface.")
    }

    CNMessage(role: .user, author: "You", timestamp: "9:42 AM", status: .read, avatarFallback: "YO") {
        Text("Let's make the chat slice feel polished.")
    }
}
```

## Attachments

```swift
CNMessage(
    role: .user,
    attachments: [
        CNAttachment(id: "brief", title: "chat-brief.md", subtitle: "Markdown", metadata: "12 KB")
    ]
) {
    Text("I attached the brief.")
}
```

## Markers

```swift
CNMarker("Tool finished", message: "Registry metadata generated", variant: .tool)
CNMarker("Unable to send", message: "Retry when the connection returns.", variant: .error)
```

## Components

`CNMessageScroller` creates a tokenized scroll container for chat transcripts with bottom and custom anchor support.

`CNMessage` creates a full message row with role-aware alignment, optional avatar, metadata, delivery status, attachments, and footer content.

`CNBubble` creates a tokenized message bubble for user, assistant, system, and tool roles.

`CNAttachment` and `CNAttachmentView` render file and artifact metadata inside messages.

`CNMarker` displays date separators, status boundaries, tool events, and error markers.

## Accessibility

Messages preserve child content semantics and group related metadata, bubble content, attachments, and status together.

Markers expose their title and optional message as readable text.

Attachment icons are decorative; attachment title, subtitle, and metadata remain readable.

## Theming

Chat components read foreground, muted foreground, primary, secondary, accent, background, card, border, radius, spacing, and typography values from `CNTheme`.

## API Reference

- `CNMessageRole`: `user`, `assistant`, `system`, `tool`
- `CNMessageStatus`: `streaming`, `sent`, `delivered`, `read`, `failed`
- `CNAttachment(id:title:subtitle:metadata:systemImage:)`
- `CNAttachmentView(_:)`
- `CNBubble(role:maxWidthFraction:content:)`
- `CNBubble.normalizedMaxWidthFraction(_:)`
- `CNBubbleStyleValues`
- `CNMarker(_:message:variant:systemImage:)`
- `CNMarker.Variant`: `date`, `status`, `tool`, `error`
- `CNMessage(role:author:timestamp:status:avatarFallback:attachments:content:footer:)`
- `CNMessageScroller(anchorID:showsIndicators:minHeight:content:)`

## Platform Differences

These components are pure SwiftUI and do not use UIKit or AppKit bridges.

`CNMessageScroller` uses native `ScrollViewReader` and `ScrollView`, so scrolling behavior follows the host platform.

For live streaming chat, keep stream state in your app and update the message content passed into `CNMessage`.

