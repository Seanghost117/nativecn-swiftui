# Accessibility

Accessibility is a release requirement for NativeCN components.

## Baseline Expectations

- Text-bearing components should use Dynamic Type-compatible typography tokens.
- Interactive controls should expose their native role whenever SwiftUI provides one.
- Disabled and loading states should be semantically clear.
- Icon-only buttons should include an accessibility label.
- Error text should be connected through field structure and clear wording.
- Motion should respect Reduce Motion.

## Current MVP Notes

`CNButton` uses SwiftUI `Button`, disables interaction while loading, and exposes loading text through accessibility value.

`CNBadge` combines custom content for accessibility.

`CNCardTitle` marks titles as headings.

`CNSeparator` is hidden from accessibility because it is visual structure.

`CNField` contains labels, descriptions, errors, and controls as one grouped field area. When `error` is present, the field propagates invalid state to child controls through `EnvironmentValues.cnFieldIsInvalid`.

`CNInput` uses native `TextField` editing behavior, supports disabled and invalid state, and accepts focus bindings.

`CNAvatar` supports explicit labels for people or entities and falls back to initials or a generic avatar label.

`CNSkeleton` exposes loading text and disables shimmer when Reduce Motion is enabled.

`CNProgress` exposes a percentage value after clamping progress into the supported range.

`CNSpinner` uses native progress semantics with a configurable loading label.

`CNTextarea` uses native multiline text editing and inherits field invalid state.

`CNSwitch`, `CNSlider`, and `CNSelect` use native SwiftUI controls where possible.

`CNCheckbox`, `CNToggle`, `CNToggleGroup`, and `CNRadioGroup` expose checked or selected values for assistive technologies.

`CNAlert` and `CNToast` combine status text for concise announcements.

`CNDialog` disables underlying content while presented.

`CNSheet`, `CNPopover`, and `CNDropdownMenu` use native SwiftUI presentation semantics where possible.

## Manual QA Checklist

- Run the catalog in light and dark themes.
- Test default, large, and accessibility Dynamic Type sizes.
- Navigate the catalog with VoiceOver.
- Confirm loading buttons do not submit twice.
- Confirm icon-only buttons have labels in examples.
- Confirm field errors are understandable when read aloud.
- Confirm Reduce Motion suppresses interactive scaling.
- Confirm skeleton shimmer stops when Reduce Motion is enabled.
- Confirm dialogs and sheets are reachable and dismissible with assistive technologies.
- Confirm toast text is understandable without relying on color alone.

See [QA Pass](QA.md) for the broader visual, accessibility, and screenshot matrix.
