# NativeCN SwiftUI 0.9.0

NativeCN 0.9.0 is the first public prerelease of a shadcn-inspired SwiftUI component system for Apple platforms.

This release includes a broad SwiftUI component catalog, semantic design tokens, theme support, registry metadata for source ownership workflows, and a local catalog app for visual review.

## Highlights

- Swift Package Manager support through `Package.swift`
- MIT license
- Token-driven theme system for color, spacing, radius, typography, shadows, and motion
- SwiftUI-native component APIs using the `CN` prefix
- Registry metadata for copy-paste adoption
- Local registry schemas and validation/copy-plan tooling
- Interactive NativeCNCatalog example app
- QA pass documentation for automated and manual release checks

## Component Coverage

This prerelease includes 75 component registry entries plus 3 foundation entries.

Major component groups:

- MVP and basic UI: Button, Button Group, Badge, Card, Separator, Label, Field, Input
- Forms and controls: Textarea, Input Group, Input OTP, Switch, Toggle, Toggle Group, Slider, Checkbox, Radio Group, Select, Native Select, Combobox
- Feedback and overlays: Alert, Dialog, Alert Dialog, Sheet, Drawer, Toast, Popover, Tooltip, Hover Card, Dropdown Menu, Menubar
- Layout: Page Header, Section, Item, List Row, Empty State, Aspect Ratio, Scroll Area, Resizable Panels, Carousel, Direction
- Navigation: Breadcrumb, Tabs, Segmented Control, Navigation Menu, Sidebar
- Data display: Stat, Description List, Timeline, Status Badge, Resource List, Chart scaffolding, Table, Data Table, Pagination
- Content: Callout, Note, Code Block, Inline Code, Keyboard Shortcut, Typography
- Interaction: Accordion, Collapsible, Context Menu
- Command workflows
- Calendar components
- Chat components: Message Scroller, Message, Bubble, Attachment, Marker
- Loading and media: Avatar, Skeleton, Progress, Spinner

## Registry Workflow

NativeCN supports Swift Package Manager installation and copy-paste source ownership.

Registry helper commands:

```bash
swift run NativeCNRegistry validate
swift run NativeCNRegistry list
swift run NativeCNRegistry plan button --include-previews --include-docs
```

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/Seanghost117/nativecn-swiftui.git", from: "0.9.0")
]
```

Then add the library product:

```swift
.product(name: "NativeCN", package: "nativecn-swiftui")
```

## Validation

Release validation for this build:

- `swift build`: passed
- `swift build --product NativeCNCatalog`: passed
- `swift run NativeCNRegistry validate`: passed, 78 registry items
- `swift test`: passed, 78 tests

## Notes

This is a prerelease. Public API naming, visual polish, and manual device QA may still change before a v1 release.

