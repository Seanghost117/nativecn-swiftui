# Accuracy Audit

This audit scores each stable NativeCN element against three visions:

- Apple fidelity: native SwiftUI behavior, platform expectations, Dynamic Type, accessibility, and restrained Apple-like ergonomics.
- shadcn fidelity: semantic tokens, readable source, component naming, composable APIs, and copy-paste ownership.
- NativeCN blend: how well the element combines native Apple interaction with shadcn-inspired system design.

Scores are 1-10.

## Summary

Overall scores:

- Apple fidelity: 8.2 / 10
- shadcn fidelity: 8.6 / 10
- NativeCN blend: 8.7 / 10

Strongest areas:

- Tokens, theme, registry, button, card, field/input, loading/media, and menu-backed controls.

Lowest-fit areas:

- `CNCheckbox` and `CNRadioGroup`, because they intentionally bring web-style controls into an Apple context.
- `CNDialog`, because custom modal dialogs need more platform nuance before they feel fully Apple-native.
- `CNAlert`, because the name can be confused with native system alerts even though the component is inline feedback.

## Element Scores

| Element | Apple | shadcn | Blend | Notes |
| --- | ---: | ---: | ---: | --- |
| Tokens | 9 | 10 | 10 | Semantic color, spacing, radius, typography, shadow, and motion tokens match the shadcn mental model while using SwiftUI-native values. |
| Theme | 9 | 10 | 10 | `CNThemeProvider` and `.cnTheme(_:)` make theme ownership native to SwiftUI environment patterns. |
| Primitives | 8 | 9 | 9 | Size, state, focus, border, loading, platform, and preview helpers map well to both systems. |
| Registry | 7 | 10 | 9 | Very true to shadcn copy-paste ownership; Apple fidelity is lower because registry metadata is outside normal Apple SDK workflows. |
| CNButton | 9 | 10 | 10 | Native `Button`, shadcn variants, sizes, loading state, and token-driven styling are well aligned. |
| CNButtonGroup | 9 | 9 | 9 | Compact action grouping improves shadcn Button Group parity while keeping ordinary NativeCN button semantics. |
| CNBadge | 8 | 10 | 9 | Strong shadcn parity with good SwiftUI implementation; Apple has no exact native badge equivalent. |
| CNCard | 9 | 10 | 10 | Composable content sections feel natural in SwiftUI and match shadcn card structure. |
| CNSeparator | 9 | 9 | 9 | Minimal, semantic, token-driven divider with native accessibility hiding. |
| CNLabel | 9 | 8 | 9 | Simple form label maps cleanly to Apple forms and shadcn field composition. |
| CNField | 9 | 9 | 9 | Good Apple form semantics and shadcn-style field scaffolding. |
| CNInput | 9 | 9 | 9 | Uses native `TextField` editing while providing shadcn-style invalid and accessory states. |
| CNInputGroup | 8 | 9 | 9 | Add-on input styling closes shadcn Input Group parity while preserving native text editing. |
| CNInputOTP | 8 | 9 | 9 | Slot-based code entry improves shadcn Input OTP parity while preserving native text entry and paste behavior. |
| CNAvatar | 9 | 9 | 9 | Familiar Apple profile imagery with shadcn-like fallback and sizing. |
| CNSkeleton | 8 | 10 | 9 | Strong shadcn loading pattern; Reduce Motion support keeps it Apple-respectful. |
| CNProgress | 9 | 8 | 9 | Native progress semantics with token styling; less distinctive from plain SwiftUI. |
| CNSpinner | 9 | 8 | 9 | Native progress semantics and accessible labels; shadcn parity is conceptual rather than exact. |
| CNTextarea | 9 | 9 | 9 | Native multiline editing with shadcn-like field styling and error inheritance. |
| CNSwitch | 10 | 7 | 9 | Very Apple-native; shadcn parity is lower because native switch behavior is intentionally preferred. |
| CNToggle | 8 | 9 | 9 | Button-like toggle fits shadcn patterns while remaining simple SwiftUI. |
| CNToggleGroup | 8 | 9 | 9 | Good segmented-control-like behavior with shadcn toggle group naming. |
| CNSlider | 10 | 7 | 9 | Very Apple-native; less shadcn-specific by design. |
| CNCheckbox | 7 | 9 | 8 | Useful for cross-platform forms but needs careful touch target and VoiceOver QA to feel fully Apple-native. |
| CNRadioGroup | 7 | 9 | 8 | Valuable for shadcn parity; Apple apps often use lists, pickers, or segmented controls instead. |
| CNSelect | 9 | 8 | 9 | Menu-backed native behavior is the right Apple adaptation of shadcn Select. |
| CNNativeSelect | 10 | 8 | 9 | Picker-backed presentation favors platform behavior while keeping registry-level parity for Native Select. |
| CNCombobox | 8 | 9 | 9 | Searchable selection improves shadcn Combobox parity while staying backed by native popover and text input behavior. |
| CNAlert | 8 | 9 | 8 | Inline feedback surface matches shadcn Alert; name requires docs because Apple `Alert` means modal system alert. |
| CNDialog | 7 | 9 | 8 | Good confirm-flow structure, but custom modals need more focus, dismissal, and platform polish. |
| CNAlertDialog | 8 | 9 | 9 | Dedicated confirmation API improves shadcn Alert Dialog parity while reusing the existing NativeCN dialog surface. |
| CNSheet | 10 | 8 | 9 | Excellent Apple adaptation for many overlay flows; not an exact shadcn Sheet clone. |
| CNDrawer | 8 | 9 | 9 | Side-panel presentation improves shadcn Drawer parity while keeping the implementation pure SwiftUI. |
| CNToast | 8 | 9 | 9 | Useful shadcn-like feedback pattern with token styling; Apple apps often use banners or inline feedback instead. |
| CNPopover | 10 | 8 | 9 | Uses native popover semantics, especially strong for iPad/macOS adaptation. |
| CNTooltip | 9 | 9 | 9 | Short contextual help maps well to shadcn Tooltip while using native hover/tap-triggered presentation. |
| CNHoverCard | 9 | 8 | 9 | Pointer hover preview behavior fits macOS and iPad well, while tap fallback keeps touch layouts usable. |
| CNDropdownMenu | 10 | 8 | 9 | Native `Menu` behavior is the right Apple adaptation of shadcn dropdown menus. |
| CNMenubar | 9 | 8 | 9 | Compact command menus are strongest on macOS while remaining usable as native menu triggers on touch platforms. |
| CNDirection | 10 | 8 | 9 | Direction maps directly to SwiftUI layout direction while adding a named registry item for shadcn Direction parity. |
| CNNavigationMenu | 9 | 8 | 9 | Top-level navigation with native menu-backed children is a strong Apple adaptation of shadcn Navigation Menu. |
| CNSidebar | 9 | 8 | 9 | Grouped app-shell navigation fits Apple split-view expectations while keeping shadcn-style source ownership and token styling. |
| CNAccordion | 9 | 9 | 9 | Disclosure-driven progressive content maps well to both shadcn Accordion and native SwiftUI interaction expectations. |
| CNCollapsible | 9 | 9 | 9 | Lightweight disclosure maps cleanly to shadcn Collapsible while staying compact and native to SwiftUI. |
| CNContextMenu | 10 | 8 | 9 | Native context menu behavior is the correct Apple adaptation for secondary actions, with shadcn-style item metadata. |
| CNCommand | 8 | 9 | 9 | Searchable grouped commands fit shadcn command workflows while using native text input, buttons, and sheet presentation. |
| CNDatePicker | 10 | 7 | 9 | Native SwiftUI date picking is the right first calendar step for Apple platforms, even though shadcn parity is intentionally looser. |
| CNCalendarMonth | 8 | 9 | 9 | A focused month grid improves shadcn Calendar parity while staying small, accessible, and token-driven. |
| CNDateRangePicker | 9 | 8 | 9 | Paired native pickers support common range workflows while avoiding premature custom calendar complexity. |
| CNPagination | 9 | 9 | 9 | Compact page controls pair naturally with tables and resource lists while preserving native button semantics. |
| CNAspectRatio | 10 | 9 | 9 | Native fixed-ratio layout maps directly to shadcn Aspect Ratio while preserving ordinary SwiftUI composition. |
| CNScrollArea | 10 | 8 | 9 | Native ScrollView preserves platform scrolling while providing shadcn-style constrained viewport ownership. |
| CNResizablePanels | 8 | 9 | 9 | Draggable split panes improve shadcn Resizable parity while staying implemented with native SwiftUI gestures. |
| CNCarousel | 8 | 9 | 9 | Horizontal paged content improves shadcn Carousel parity while staying compatible with iOS 16/macOS 13 scrolling APIs. |
| CNItem | 9 | 9 | 9 | Flexible content rows improve shadcn Item parity and fit Apple settings-style surfaces well. |
| CNTable | 9 | 9 | 9 | Static tables reuse NativeCN data-table styling for shadcn Table parity without adding unnecessary interaction. |
| CNTypography | 10 | 8 | 9 | Semantic text styles expose theme-backed typography while keeping SwiftUI `Text` behavior intact. |

## Accuracy Notes

The library is most accurate when it treats shadcn as a workflow and visual language rather than a literal web port. Elements that use native SwiftUI controls score higher for Apple fidelity, while elements that bring web-native patterns into iOS score lower unless they are adapted through native presentation APIs.

The envisioned NativeCN blend is strongest where all three conditions hold:

1. The component reads visual decisions from `CNTheme`.
2. The interaction is native SwiftUI or intentionally adapted for Apple platforms.
3. The source remains readable and copyable through the registry workflow.

## Lowest Supported iOS Version

The lowest compatible iOS version target is iOS 16.0.

Evidence:

- `Package.swift` declares `.iOS(.v16)`.
- `Docs/Installation.md` documents iOS 16+.
- `Docs/V1-Hardening.md` repeats iOS 16.0+ as the release support floor.

This audit does not prove iOS 15 compatibility. Lowering the target would require a separate API audit and likely changes around SwiftUI presentation and catalog navigation APIs.
