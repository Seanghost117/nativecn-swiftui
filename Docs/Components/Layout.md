# Layout Components

NativeCN layout components provide reusable screen structure without hiding normal SwiftUI composition.

## Examples

```swift
CNPageHeader("Projects", subtitle: "Track active client work.") {
    CNButton("New", size: .sm) {}
}

CNSection("Account", subtitle: "Manage profile settings.") {
    CNListRow("Profile", subtitle: "Name and avatar", systemImage: "person.crop.circle") {}
    CNSeparator()
    CNListRow("Notifications") {
        Image(systemName: "bell")
    } trailing: {
        CNBadge("On", variant: .secondary)
    }
}

CNEmptyState("No projects", message: "Create a project to get started.", systemImage: "tray") {
    CNButton("Create project", size: .sm) {}
}

CNAspectRatio(16.0 / 9.0) {
    Image("product-preview")
        .resizable()
        .scaledToFill()
}

CNScrollArea(maxHeight: 180) {
    VStack(alignment: .leading) {
        ForEach(activityItems) { item in
            Text(item.title)
        }
    }
    .padding()
}

CNResizablePanels(initialFraction: 0.35) {
    SidebarView()
} secondary: {
    DetailView()
}
.frame(height: 280)

CNCarousel(items: features, selection: $selectedFeature, itemWidth: 250) { feature in
    CNCard {
        CNCardHeader {
            CNCardTitle(feature.title)
            CNCardDescription(feature.subtitle)
        }
    }
}
```

## Components

`CNPageHeader` creates a page-level title area with optional subtitle and trailing actions.

`CNSection` groups related content in a token-driven surface with optional heading, subtitle, and footer.

`CNListRow` creates compact settings and menu rows with optional leading content, trailing content, and row action.

`CNEmptyState` creates centered empty-state content with optional SF Symbol and actions.

`CNAspectRatio` creates a stable width-to-height layout frame for media, previews, and responsive cards.

`CNScrollArea` creates a constrained native scrolling viewport for long content regions.

`CNResizablePanels` creates a two-pane layout with a draggable divider for inspector and workspace surfaces.

`CNCarousel` displays horizontally paged custom content with previous/next controls and indicators.

## Accessibility

Page and section titles are marked as headers.

Decorative empty-state icons are hidden from accessibility.

Rows combine their title, subtitle, leading content, and trailing content into one accessible element.

Action rows use native SwiftUI `Button` behavior with `.plain` styling.

Carousel controls and indicators expose native button semantics for previous, next, and item selection.

Aspect ratio content keeps normal SwiftUI accessibility behavior for its child views.

Scroll areas keep native SwiftUI scrolling behavior and child accessibility semantics.

Resizable panel handles expose an accessible resize control and keep panel content semantics intact.

## Theming

Layout components read typography, foreground, muted foreground, card, border, spacing, and radius values from `CNTheme`.

## API Reference

- `CNPageHeader(_:subtitle:actions:)`
- `CNSection(_:subtitle:content:footer:)`
- `CNListRow(_:subtitle:action:leading:trailing:)`
- `CNListRow(_:subtitle:systemImage:action:)`
- `CNEmptyState(_:message:systemImage:actions:)`
- `CNAspectRatio(_:content:)`
- `.cnAspectRatio(_:)`
- `CNAspectRatio.normalizedRatio(_:)`
- `CNScrollArea(_:showsIndicators:maxHeight:maxWidth:content:)`
- `.cnScrollArea(_:showsIndicators:maxHeight:maxWidth:)`
- `CNScrollArea.normalizedLength(_:)`
- `CNResizablePanels(axis:initialFraction:minFraction:maxFraction:handleThickness:primary:secondary:)`
- `CNResizablePanels(axis:fraction:minFraction:maxFraction:handleThickness:primary:secondary:)`
- `CNResizablePanels.normalizedFraction(_:minFraction:maxFraction:)`
- `CNResizablePanels.normalizedBounds(minFraction:maxFraction:)`
- `CNCarousel(items:selection:itemWidth:spacing:showsControls:showsIndicators:content:)`
- `CNCarousel.index(of:in:)`
- `CNCarousel.previousID(before:in:)`
- `CNCarousel.nextID(after:in:)`

## Platform Differences

These components are pure SwiftUI and do not use UIKit or AppKit bridges.

On iOS, they are intended for settings-style pages, empty screens, and grouped content.

On macOS and iPadOS, they work well inside wider split views and inspector-style surfaces.

`CNCarousel` uses `ScrollViewReader` for previous/next controls so it remains compatible with iOS 16 and macOS 13.

`CNScrollArea` is backed by native `ScrollView`, so scrolling physics and indicator behavior follow the host platform.

`CNResizablePanels` uses SwiftUI gestures and works best in wider iPadOS and macOS layouts where there is enough room for adjacent panes.
