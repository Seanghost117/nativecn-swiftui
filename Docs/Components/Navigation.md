# Navigation Components

NativeCN navigation components provide small SwiftUI-native building blocks for page hierarchy and local view switching.

## Examples

```swift
CNBreadcrumb(items: [
    CNBreadcrumbItem(id: "home", title: "Home", systemImage: "house"),
    CNBreadcrumbItem(id: "projects", title: "Projects"),
    CNBreadcrumbItem(id: "nativecn", title: "NativeCN", isCurrent: true)
])

CNTabs(selection: $tab, items: [
    CNTabItem("Overview", value: "overview", systemImage: "square.grid.2x2"),
    CNTabItem("Tasks", value: "tasks", systemImage: "checklist"),
    CNTabItem("Files", value: "files", systemImage: "folder")
])

CNSegmentedControl(selection: $density, options: [
    CNSegmentedControlOption("Compact", value: "compact"),
    CNSegmentedControlOption("Comfortable", value: "comfortable"),
    CNSegmentedControlOption("Spacious", value: "spacious")
])

CNNavigationMenu(selection: $destination, groups: [
    CNNavigationMenuGroup(id: "overview", title: "Overview", systemImage: "square.grid.2x2", value: "overview"),
    CNNavigationMenuGroup(id: "projects", title: "Projects", systemImage: "folder", items: [
        CNNavigationMenuItem("Active", value: "active", systemImage: "folder"),
        CNNavigationMenuItem("Archived", value: "archived", systemImage: "archivebox")
    ])
])

CNSidebar("Workspace", selection: $destination, sections: [
    CNSidebarSection(id: "main", title: "Main", items: [
        CNSidebarItem("Overview", value: "overview", systemImage: "square.grid.2x2"),
        CNSidebarItem("Inbox", value: "inbox", systemImage: "tray", badge: "4"),
        CNSidebarItem("Settings", value: "settings", systemImage: "gearshape")
    ])
])
```

## Components

`CNBreadcrumb` displays a compact hierarchy trail for iPad and macOS-style navigation.

`CNTabs` displays token-driven tab triggers. The consumer owns the selected content.

`CNSegmentedControl` displays a compact single-selection control for filters, density, modes, and local view options.

`CNNavigationMenu` displays top-level navigation triggers with direct items and native menu-backed child items.

`CNSidebar` displays grouped app-shell navigation with selected state, icons, badges, and disabled rows.

## Accessibility

Breadcrumb items expose native button semantics except for the current item, which is disabled and marked as the current page.

Tabs and segmented control options expose selected state through accessibility values.

Navigation menu triggers expose selected state through accessibility values and child menus use native `Menu` semantics.

Sidebar items expose selected state through accessibility values and announce disabled rows through hints.

Decorative SF Symbols are hidden from accessibility so labels remain concise.

## Theming

Navigation components read foreground, muted foreground, background, muted, border, spacing, radius, and typography values from `CNTheme`.

## API Reference

- `CNBreadcrumbItem(id:title:systemImage:isCurrent:)`
- `CNBreadcrumb(items:onSelect:)`
- `CNTabItem(_:value:systemImage:)`
- `CNTabs(selection:items:isDisabled:)`
- `CNSegmentedControlOption(_:value:systemImage:)`
- `CNSegmentedControl(selection:options:isDisabled:)`
- `CNNavigationMenuItem(_:value:subtitle:systemImage:badge:isDisabled:)`
- `CNNavigationMenuGroup(id:title:systemImage:value:items:isDisabled:)`
- `CNNavigationMenu(selection:groups:isDisabled:)`
- `CNSidebarItem(_:value:systemImage:badge:isDisabled:)`
- `CNSidebarSection(id:title:items:)`
- `CNSidebar(_:selection:sections:isDisabled:)`

## Platform Differences

These components are pure SwiftUI and do not use UIKit or AppKit bridges.

On iPhone, prefer `CNSegmentedControl` for compact local switching and reserve breadcrumbs for drill-down surfaces where hierarchy needs to be visible.

On iPadOS and macOS, breadcrumbs and tabs are useful in split-view, inspector, dashboard, and document-style layouts.

`CNNavigationMenu` uses native `Menu` for child destinations. This is intentionally more Apple-like than a web-style custom mega menu.

`CNSidebar` is designed for iPad and macOS app shells. On narrow iPhone layouts, prefer a `List`, sheet, or tab-based adaptation.
