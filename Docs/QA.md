# QA Pass

NativeCN uses a layered QA pass before release candidates:

1. Automated package, catalog, registry, and test validation.
2. Manual catalog visual review.
3. Manual accessibility review.
4. Screenshot capture for release notes and regressions.

## Automated Validation

Run these commands from the repository root:

```bash
swift build
swift build --product NativeCNCatalog
swift run NativeCNRegistry validate
swift test
```

Current automated pass:

- `swift build`: pass
- `swift build --product NativeCNCatalog`: pass
- `swift run NativeCNRegistry validate`: pass, 78 registry items
- `swift test`: pass, 79 tests

## Catalog Launch

SwiftPM can run the catalog executable:

```bash
swift run NativeCNCatalog
```

For a visible macOS app window during local QA, refresh and open the generated app bundle:

```bash
swift build --product NativeCNCatalog
cp .build/x86_64-apple-macosx/debug/NativeCNCatalog .build/NativeCNCatalog.app/Contents/MacOS/NativeCNCatalog
codesign --force --sign - .build/NativeCNCatalog.app
open -n -F .build/NativeCNCatalog.app
```

## Visual Matrix

Review every catalog page in:

- Light theme
- Dark theme
- Default Dynamic Type
- Extra large Dynamic Type
- Accessibility Dynamic Type
- Narrow window width
- Wide window width

Pages to review:

- Demo Lab
- Button
- Badge
- Card
- Input & Field
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
- MVP Components
- Tokens
- Theme Playground
- Example Screens

## Accessibility Matrix

Review with VoiceOver and keyboard/focus navigation:

- Navigation list reaches every catalog page.
- Icon-only controls expose readable labels.
- Field errors are readable without relying on color.
- Dialog, alert dialog, sheet, drawer, popover, tooltip, hover card, dropdown menu, and menubar examples are reachable and dismissible.
- Toast and alert text is understandable without relying on color alone.
- Chart empty/loading states expose readable labels.
- Chat messages, attachments, and markers read in a sensible order.
- Reduce Motion suppresses decorative motion and shimmer.

## Component Risk Focus

Pay special attention to:

- `CNCheckbox` and `CNRadioGroup` touch target feel.
- Overlay dismissal behavior on compact widths.
- `CNDrawer` edge presentation on narrow and wide windows.
- `CNResizablePanels` drag behavior.
- `CNCarousel` previous/next controls and indicators.
- `CNCalendarMonth` selected/range states.
- `CNCodeBlock` horizontal scrolling and copy behavior.
- `CNChartContainer` legends, loading, and empty states.
- `CNMessageScroller` bottom anchoring and transcript readability.

## Screenshot Capture

Capture screenshots for release notes after the manual visual pass:

- Demo Lab table of contents in light and dark theme
- Catalog home in light and dark theme
- Forms & Controls
- Feedback & Overlays
- Data Display with chart states
- Calendar
- Chat
- Theme Playground

Store release screenshots outside source control unless they become official docs assets.

## Sign-Off Template

```text
QA pass:
- Date:
- Commit:
- macOS:
- Xcode:
- Swift:
- Automated validation:
- Visual matrix:
- Accessibility matrix:
- Known issues:
- Release recommendation:
```
