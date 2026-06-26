# Data Display Components

NativeCN data display components make product screens feel real without requiring a heavy table system.

## Examples

```swift
CNStat("Revenue", value: "$12.4k", detail: "from last month", trend: "+12%") {
    Image(systemName: "chart.line.uptrend.xyaxis")
}

CNDescriptionList([
    CNDescriptionItem(id: "plan", label: "Plan", value: "Pro"),
    CNDescriptionItem(id: "renewal", label: "Renewal", value: "July 18, 2026"),
    CNDescriptionItem(id: "owner", label: "Owner", value: "Taylor Lee")
])

CNTimeline([
    CNTimelineItem(id: "created", title: "Project created", detail: "Workspace initialized.", timestamp: "9:12 AM", systemImage: "plus"),
    CNTimelineItem(id: "updated", title: "Tokens updated", detail: "Radius and color tokens synced.", timestamp: "10:04 AM", systemImage: "paintpalette")
])

CNStatusBadge("Healthy", variant: .success)

CNResourceList([
    CNResourceItem(id: "ios", title: "iOS App", subtitle: "Production workspace", metadata: "Updated today", systemImage: "iphone", status: "Healthy", statusVariant: .success),
    CNResourceItem(id: "api", title: "API", subtitle: "Staging cluster", metadata: "3 alerts", systemImage: "server.rack", status: "Warning", statusVariant: .warning)
])

CNDataTable(
    columns: [
        CNDataTableColumn(id: "name", title: "Name", minWidth: 160),
        CNDataTableColumn(id: "status", title: "Status", minWidth: 120),
        CNDataTableColumn(id: "usage", title: "Usage", minWidth: 100, alignment: .trailing)
    ],
    rows: [
        CNDataTableRow(id: "ios", values: ["name": "iOS App", "status": "Healthy", "usage": "82%"]),
        CNDataTableRow(id: "api", values: ["name": "API", "status": "Warning", "usage": "64%"])
    ]
)

CNPagination(currentPage: $page, totalPages: 8)
```

## Components

`CNStat` displays a KPI or summary value with optional detail, trend, and accessory content.

`CNDescriptionList` displays key-value metadata for billing, profiles, settings, and detail pages.

`CNTimeline` displays a vertical activity feed with optional detail, timestamp, and SF Symbol.

`CNStatusBadge` displays semantic record status with an optional dot.

`CNResourceList` displays records with title, subtitle, metadata, icon, status, and row selection.

`CNDataTable` displays simple column/row data with horizontal scrolling on compact widths.

`CNPagination` displays previous, next, page number, and ellipsis controls for paged resources.

## Accessibility

Stats combine title, value, trend, detail, and accessory content into one accessible element.

Description list rows combine each label and value into one readable item.

Timeline event icons are decorative and hidden from accessibility; event title, detail, and timestamp remain readable together.

Status badge dots are decorative; the status text remains readable.

Resource rows combine their visible text and status into one accessible row.

Data table rows are selectable buttons when `onSelect` is provided and combine visible cell text for assistive technologies.

Pagination controls expose page labels, current page values, and previous/next labels to assistive technologies.

## Theming

Data display components read foreground, muted foreground, primary, card, border, background, radius, spacing, and typography values from `CNTheme`.

## API Reference

- `CNStat(_:value:detail:trend:accessory:)`
- `CNDescriptionItem(id:label:value:)`
- `CNDescriptionList(_:)`
- `CNTimelineItem(id:title:detail:timestamp:systemImage:)`
- `CNTimeline(_:)`
- `CNStatusBadge(_:variant:showsDot:)`
- `CNResourceItem(id:title:subtitle:metadata:systemImage:status:statusVariant:)`
- `CNResourceList(_:onSelect:)`
- `CNDataTableColumn(id:title:minWidth:alignment:)`
- `CNDataTableRow(id:values:)`
- `CNDataTable(columns:rows:onSelect:)`
- `CNPaginationItem`
- `CNPagination(currentPage:totalPages:siblingCount:boundaryCount:isDisabled:)`
- `CNPagination.items(currentPage:totalPages:siblingCount:boundaryCount:)`

## Platform Differences

These components are pure SwiftUI and do not use UIKit or AppKit bridges.

`CNStat` and `CNDescriptionList` work well across iPhone, iPad, and macOS.

`CNTimeline` should be used with concise event text on compact iPhone layouts and can carry richer detail on iPad and macOS.

`CNResourceList` is preferred over dense tables on iPhone because it preserves readable touch targets and native list ergonomics.

`CNDataTable` is best for iPad and macOS comparison views. On iPhone, use it for compact datasets only, or prefer `CNResourceList`.

`CNPagination` works across platforms and should sit near the paged list or table it controls.
