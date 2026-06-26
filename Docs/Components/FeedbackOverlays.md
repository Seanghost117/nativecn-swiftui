# Feedback And Overlays

This phase adds `CNAlert`, `CNDialog`, `CNAlertDialog`, `CNSheet`, `CNDrawer`, `CNToast`, `CNPopover`, `CNTooltip`, `CNHoverCard`, `CNDropdownMenu`, and `CNMenubar`.

## Import And Setup

```swift
import NativeCN
import SwiftUI
```

Use these components inside `CNThemeProvider` or a `.cnTheme(_:)` subtree.

## Alert

```swift
CNAlert("Update available", message: "A new version is ready.")

CNAlert("Payment failed", message: "Update billing details.", variant: .destructive) {
    CNButton("Review", variant: .outline, size: .sm) {}
}
```

`CNAlert` is an inline feedback surface, not a system alert.

## Dialog

```swift
@State private var showingDialog = false

Button("Delete") {
    showingDialog = true
}
.cnDialog(isPresented: $showingDialog) {
    CNDialog(title: "Delete item?", message: "This cannot be undone.") {
        CNButton("Cancel", variant: .outline) {
            showingDialog = false
        }
        CNButton("Delete", variant: .destructive) {
            showingDialog = false
        }
    }
}
```

`CNDialog` is a custom modal surface for confirm flows.

## Alert Dialog

```swift
@State private var showingAlertDialog = false

CNButton("Delete project", variant: .destructive) {
    showingAlertDialog = true
}
.cnAlertDialog(
    isPresented: $showingAlertDialog,
    title: "Delete project?",
    message: "This action cannot be undone.",
    actionTitle: "Delete",
    role: .destructive
) {
    deleteProject()
}
```

`CNAlertDialog` is a purpose-built confirmation dialog for consequential actions.

## Sheet

```swift
@State private var showingSheet = false

CNButton("Open sheet") {
    showingSheet = true
}
.cnSheet(isPresented: $showingSheet, title: "Filters") {
    Text("Sheet content")
}
```

`CNSheet` uses native SwiftUI sheet presentation semantics.

## Drawer

```swift
@State private var showingDrawer = false

CNButton("Open inspector", variant: .outline) {
    showingDrawer = true
}
.cnDrawer(isPresented: $showingDrawer, edge: .trailing, title: "Inspector") {
    Text("Drawer content")
}
```

`CNDrawer` presents side-panel or task-panel content above the current screen.

## Toast

```swift
@State private var toast: CNToast?

CNButton("Save") {
    toast = CNToast(title: "Saved", message: "Your changes were saved.", variant: .success)
}
.cnToast($toast)
```

`CNToast` supports top or bottom placement and variants for default, success, warning, and destructive feedback.

## Popover

```swift
@State private var showingPopover = false

CNButton("Details", variant: .outline) {
    showingPopover = true
}
.cnPopover(isPresented: $showingPopover) {
    Text("Popover content")
}
```

`CNPopover` uses native SwiftUI popover behavior.

## Tooltip

```swift
CNButton("Save", variant: .outline) {}
    .cnTooltip("Saves the current draft.")

CNButton("Deploy", variant: .outline) {}
    .cnTooltip {
        VStack(alignment: .leading) {
            Text("Deploy")
                .font(.headline)
            Text("Publishes the selected environment.")
        }
    }
```

`CNTooltip` uses a compact NativeCN popover surface for short contextual help.

## Hover Card

```swift
CNButton("Project details", variant: .outline) {}
    .cnHoverCard {
        VStack(alignment: .leading) {
            Text("NativeCN")
                .font(.headline)
            Text("SwiftUI component primitives with registry-backed source ownership.")
        }
    }
```

`CNHoverCard` uses native popover presentation from a hover or tap trigger.

## Dropdown Menu

```swift
CNDropdownMenu("Actions", items: [
    CNDropdownMenuItem(id: "edit", title: "Edit", systemImage: "pencil"),
    CNDropdownMenuItem(id: "delete", title: "Delete", systemImage: "trash", isDestructive: true)
]) { item in
    handle(item.id)
}
```

`CNDropdownMenu` is backed by SwiftUI `Menu`.

## Menubar

```swift
CNMenubar(menus: [
    CNMenubarMenu(id: "file", title: "File", items: [
        CNMenubarItem(id: "new", title: "New Project", systemImage: "plus", shortcut: "Command N"),
        CNMenubarItem(id: "open", title: "Open", systemImage: "folder", shortcut: "Command O")
    ])
]) { item in
    handle(item.id)
}
```

`CNMenubar` displays compact menu clusters for macOS-style command surfaces.

## Accessibility

- Alerts and toasts combine their content for concise announcements.
- Dialogs and alert dialogs disable underlying content while presented.
- Sheets, drawers, popovers, tooltips, hover cards, dropdowns, and menubars use native SwiftUI presentation semantics.
- Toasts include a dismiss button when an `onDismiss` closure is supplied.

## Theming

Feedback and overlay components use card, popover, foreground, muted foreground, primary, destructive, border, radius, shadow, spacing, and typography tokens.

## API Reference

- `CNAlert(_:message:variant:systemImage:actions:)`
- `CNDialog(title:message:content:actions:)`
- `.cnDialog(isPresented:dialog:)`
- `CNAlertDialog(title:message:cancelTitle:actionTitle:role:onCancel:onAction:)`
- `CNAlertDialogRole`
- `.cnAlertDialog(isPresented:title:message:cancelTitle:actionTitle:role:onCancel:onAction:)`
- `CNSheet(title:message:content:)`
- `.cnSheet(isPresented:title:message:content:)`
- `CNDrawer(title:message:content:)`
- `CNDrawerPresenter(isPresented:edge:length:allowsBackdropDismiss:drawer:content:)`
- `.cnDrawer(isPresented:edge:length:allowsBackdropDismiss:title:message:content:)`
- `CNToast(title:message:variant:placement:)`
- `CNToastView(_:onDismiss:)`
- `.cnToast(_:)`
- `CNPopover(content:)`
- `.cnPopover(isPresented:arrowEdge:content:)`
- `CNTooltip(content:)`
- `.cnTooltip(_:arrowEdge:)`
- `.cnTooltip(arrowEdge:content:)`
- `CNHoverCard(content:)`
- `.cnHoverCard(arrowEdge:content:)`
- `CNDropdownMenuItem(id:title:systemImage:isDestructive:)`
- `CNDropdownMenu(_:items:onSelect:)`
- `CNMenubarItem(id:title:systemImage:shortcut:isDestructive:isDisabled:)`
- `CNMenubarMenu(id:title:systemImage:items:isDisabled:)`
- `CNMenubar(menus:isDisabled:onSelect:)`

## Platform Differences

Sheet, drawer, popover, dropdown, and menubar behavior follows SwiftUI conventions on the host platform. Popovers may adapt presentation style depending on device and size class.

`CNMenubar` is macOS-oriented. On iOS and iPadOS, it renders as a compact row of native menu triggers.
