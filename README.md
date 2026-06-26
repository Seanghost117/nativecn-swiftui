# NativeCN SwiftUI

A shadcn-inspired SwiftUI component system for Apple platforms.

NativeCN brings the shadcn/ui workflow to SwiftUI: token-driven visuals, readable source, copy-paste ownership, a registry metadata layer, and a catalog app that demonstrates components in real product contexts.

NativeCN is not affiliated with shadcn/ui, Vercel, or their maintainers. It is inspired by the same composable, copyable, token-driven philosophy and rebuilt natively for SwiftUI.

## Status

NativeCN is an early public SwiftUI package with a broad, registry-backed component catalog. The current package includes:

- Design tokens, themes, and SwiftUI environment plumbing
- Core styling and interaction primitives
- Production-oriented SwiftUI components across forms, overlays, layout, navigation, data display, content, and calendar workflows
- Registry metadata for copy-paste adoption
- A macOS/iOS-compatible Swift Package catalog app
- Hardening docs, roadmap, accessibility guidance, and accuracy audit

Minimum targets:

- iOS 16+
- macOS 13+
- Swift tools 5.9

## Installation

NativeCN is designed to install with Swift Package Manager.

```swift
dependencies: [
    .package(url: "https://github.com/Seanghost117/nativecn-swiftui.git", branch: "public")
]
```

Then add the library product to your target:

```swift
.product(name: "NativeCN", package: "nativecn-swiftui")
```

## Quick Start

```swift
import NativeCN
import SwiftUI

struct ContentView: View {
    var body: some View {
        CNThemeProvider {
            CNCard {
                CNCardHeader {
                    CNCardTitle("NativeCN")
                    CNCardDescription("SwiftUI components with shadcn-style source ownership.")
                }

                CNCardContent {
                    CNButton("Get started") {}
                }
            }
            .padding()
        }
    }
}
```

## Local Development

Build the package:

```bash
swift build
```

Run tests:

```bash
swift test
```

Run the catalog executable:

```bash
swift run NativeCNCatalog
```

The repository also contains a generated local macOS app bundle during development at `.build/NativeCNCatalog.app`; that bundle is ignored by Git.

## Project Assets

- `Sources/NativeCN`: library source for tokens, theme, primitives, components, previews, and utilities.
- `Examples/NativeCNCatalog`: interactive catalog app used for local QA and component demos.
- `Registry/registry.json`: registry index for stable copy-paste elements.
- `Registry/components/*.json`: per-component source, dependency, docs, and destination metadata.
- `Docs`: installation, theming, component, registry, accessibility, roadmap, and hardening documentation.
- `Tests/NativeCNTests`: unit and compile-smoke coverage for tokens, components, docs, registry, and audits.
- `Package.swift`: Swift Package manifest exposing `NativeCN` and `NativeCNCatalog`.

## Design System Elements

### Tokens And Theme

- `CNColorToken` / `CNColorTokens`: semantic light/dark color values.
- `CNSpaceTokens`: spacing scale used by component layouts.
- `CNRadiusTokens`: corner radius scale.
- `CNShadowTokens`: elevation values for sheets, dialogs, popovers, and toasts.
- `CNTypographyTokens`: Dynamic Type-compatible text styles.
- `CNMotionTokens`: animation defaults with Reduce Motion awareness.
- `CNTheme`, `CNThemeProvider`, and `.cnTheme(_:)`: environment-driven theming.

### Core Primitives

- `CNControlSize`: shared size metrics for controls.
- `CNControlState`: enabled, pressed, loading, selected, invalid, and focused state modeling.
- `.cnBorder(...)`: token-friendly rounded borders.
- `.cnFocusRing(...)`: consistent focus affordances.
- `CNLoadingIndicator`: inline loading spinner.
- `.cnInteractiveScale(...)`: subtle press feedback.
- `CNPreviewMatrix`: preview scaffolding for state coverage.
- `CNPlatform`: platform helpers for hover and OS-specific behavior.

## Component Inventory

### MVP And Basic UI

- `CNButton`: token-driven button with variants, sizes, roles, and loading state.
- `CNBadge`: compact status and label badge.
- `CNCard`, `CNCardHeader`, `CNCardTitle`, `CNCardDescription`, `CNCardContent`, `CNCardFooter`: grouped content surfaces.
- `CNSeparator`: horizontal or vertical divider.
- `CNLabel`: form label.
- `CNField`: label, description, error, and invalid-state wrapper.
- `CNInput`: single-line text input with accessories, invalid state, keyboard hints, and focus support.

### Forms And Controls

- `CNTextarea`: multiline editing with min/max height and invalid state.
- `CNInputOTP`: slot-based one-time-code input.
- `CNSwitch`: native switch with NativeCN tint.
- `CNToggle`: button-like boolean toggle.
- `CNToggleGroup`: multi-select toggle group.
- `CNSlider`: native slider with value display and clamping.
- `CNCheckbox`: tokenized checkbox.
- `CNRadioGroup`: single-selection radio group with descriptions.
- `CNSelect`: native menu-backed select.
- `CNCombobox`: searchable select using native popover presentation.

### Feedback And Overlays

- `CNAlert`: inline status, success, warning, and destructive feedback.
- `CNDialog`: custom modal dialog surface.
- `CNAlertDialog`: purpose-built consequential confirmation dialog.
- `CNSheet` / `.cnSheet(...)`: native sheet content wrapper.
- `CNDrawer` / `.cnDrawer(...)`: side-panel and task-panel overlay.
- `CNToast`, `CNToastView`, and `.cnToast(...)`: transient feedback.
- `CNPopover` / `.cnPopover(...)`: native popover wrapper.
- `CNTooltip` / `.cnTooltip(...)`: compact contextual help.
- `CNHoverCard` / `.cnHoverCard(...)`: richer hover or tap preview surface.
- `CNDropdownMenu` and `CNDropdownMenuItem`: native menu-backed action lists.
- `CNMenubar`, `CNMenubarMenu`, and `CNMenubarItem`: compact command menu clusters.

### Layout

- `CNPageHeader`: page title, subtitle, and trailing actions.
- `CNSection`: grouped content section with heading, subtitle, and footer.
- `CNListRow`: settings-style row with leading/trailing content.
- `CNEmptyState`: centered empty-state layout.
- `CNAspectRatio`: fixed-ratio media and preview frame.
- `CNScrollArea`: constrained native scroll viewport.
- `CNResizablePanels`: two-pane resizable workspace layout.
- `CNCarousel`: horizontally paged custom content with controls and indicators.

### Navigation

- `CNBreadcrumb`: hierarchical path navigation.
- `CNTabs`: tabbed content navigation.
- `CNSegmentedControl`: compact single-selection control.
- `CNNavigationMenu`: top-level menu-backed navigation.
- `CNSidebar`, `CNSidebarSection`, and `CNSidebarItem`: app-shell navigation for iPad and macOS.

### Data Display

- `CNStat`: metric card.
- `CNDescriptionList` and `CNDescriptionItem`: key-value detail lists.
- `CNTimeline` and `CNTimelineItem`: chronological event display.
- `CNStatusBadge`: semantic status indicator.
- `CNResourceList` and `CNResourceListItem`: structured list rows.
- `CNDataTable`, `CNDataColumn`, and `CNDataCell`: table display.
- `CNPagination`: compact pagination controls.

### Content

- `CNCallout`: contextual callout block.
- `CNNote`: compact note surface.
- `CNCodeBlock`: scrollable code block with optional copy affordance.
- `CNInlineCode`: inline code text styling.
- `CNKeyboardShortcut`: keyboard shortcut keycap display.

### Interaction

- `CNAccordion`: bordered progressive disclosure panel.
- `CNCollapsible`: compact single disclosure surface.
- `CNContextMenuItem` and `.cnContextMenu(...)`: native context menu metadata and presenter.
- `CNCommandItem`, `CNCommandPalette`, and `.cnCommandPalette(...)`: searchable command workflows.

### Calendar

- `CNDatePicker`: native date input wrapper.
- `CNCalendarMonth`: visible month grid.
- `CNDateRangePicker`: paired range selection.

### Loading And Media

- `CNAvatar`: image/fallback avatar.
- `CNSkeleton`: loading placeholder.
- `CNProgress`: progress indicator.
- `CNSpinner`: activity spinner.

## Registry Workflow

NativeCN keeps registry metadata in `Registry/` so teams can inspect component dependencies and copy the source they want to own.

Each registry item includes:

- Stable component name and type
- Source files
- Preview files
- Documentation references
- Component dependencies
- Suggested copy-paste destination

See [Docs/Registry.md](Docs/Registry.md).

## Documentation Map

- [Installation](Docs/Installation.md)
- [Theming](Docs/Theming.md)
- [Primitives](Docs/Primitives.md)
- [Component Philosophy](Docs/Component-Philosophy.md)
- [Accessibility](Docs/Accessibility.md)
- [Registry](Docs/Registry.md)
- [Roadmap](Docs/Roadmap.md)
- [v1 Hardening](Docs/V1-Hardening.md)
- [Accuracy Audit](Docs/Accuracy-Audit.md)
- [Component Docs](Docs/Components)

## License

MIT. See [LICENSE](LICENSE).
