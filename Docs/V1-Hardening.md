# v1 Hardening

Phase 9 reviews NativeCN against the v1 release criteria. This is a hardening checkpoint, not a claim that the project is already a final v1 release.

## API Review

Status: pass with follow-up notes.

- Public symbols use the `CN` prefix.
- Components are ordinary SwiftUI `View` values and modifiers.
- Theme access flows through `CNThemeProvider`, `EnvironmentValues.cnTheme`, and `.cnTheme(_:)`.
- Variant and option values are `Sendable` and `Equatable` where useful.
- Copy-paste ownership is supported by readable source and registry file maps.

Follow-up:

- Stabilize naming before tagging v1, especially `CNAlert` versus native `Alert` expectations and `CNDialog` versus system confirmation dialogs.
- Consider public availability annotations if future platform-specific APIs are added.
- Decide whether `NativeCN.status` should remain public after v1 or move to docs-only metadata.

## Docs Review

Status: pass.

- Installation, theming, primitives, accessibility, registry, QA, component docs, contribution docs, and roadmap exist.
- Component docs include copy-paste Swift examples, accessibility notes, theming notes, API references, and platform differences.
- Registry docs describe manual copy-paste flow and source dependency mapping.

Follow-up:

- Add rendered screenshots after the catalog has an Xcode project or screenshot automation.
- Add DocC once public API names settle.

## Accessibility Review

Status: pass with manual QA required before release.

- Text styles use Dynamic Type-compatible `Font` text styles.
- Native SwiftUI controls are preferred for inputs, menus, sliders, switches, sheets, and popovers.
- Custom controls expose accessibility labels, values, traits, or hidden decoration where practical.
- Motion tokens and skeleton shimmer account for Reduce Motion.
- Field invalid state propagates to child controls.

Manual QA before v1:

- VoiceOver navigation through every catalog page.
- Dynamic Type at default, extra extra large, and accessibility sizes.
- Light and dark mode contrast review.
- Reduce Motion validation.
- Keyboard/focus review on macOS and iPad hardware keyboard.

See [QA Pass](QA.md) for the repeatable manual review matrix.

## Visual QA Review

Status: automated pass complete; manual screenshots still required for release.

- Components use semantic theme tokens for color, radius, spacing, typography, shadows, and motion.
- The catalog demonstrates light/dark theme toggling and Dynamic Type.
- Component pages cover MVP, loading/media, forms/controls, feedback/overlays, layout, navigation, data display, content, interaction, command, calendar, chat, and theme workflows.
- Automated validation currently covers package build, catalog build, registry validation, and tests.

Known visual risks:

- Some controls intentionally lean native Apple rather than exact shadcn visual parity.
- `CNCheckbox` and `CNRadioGroup` are custom controls and need device QA for touch target feel.
- Overlay components need screenshot review across compact iPhone, iPad, and macOS widths.

## Performance Review

Status: pass for current scope.

- Core package has no third-party runtime dependencies.
- Components are small SwiftUI views with local state and environment reads.
- There is no global mutable state.
- Registry metadata is static JSON and does not affect runtime.

Follow-up:

- Profile catalog scrolling once many more components are added.
- Avoid expensive measurement or animation work in future layout components.

## Release Checklist

- `swift build` passes.
- `swift build --product NativeCNCatalog` passes.
- `swift test` passes.
- `swift run NativeCNRegistry validate` passes.
- Catalog Swift files type-check and launch instructions are documented.
- README status and roadmap match the current phase.
- Minimum platform support is documented.
- Accessibility checklist is documented.
- QA pass checklist is documented.
- Copy-paste workflow is documented.

## v1 Migration Notes

NativeCN has not shipped a public v1 yet, so there are no end-user breaking migrations.

Current internal migration notes:

- Phase 8 introduced registry metadata and copy-paste docs without changing component APIs.
- Phase 9 updates project status and release documentation without changing component APIs.
- Consumers using Swift Package Manager should continue importing `NativeCN`.
- Consumers using copy mode should follow `Registry/registry.json` and item metadata files.

## Minimum Supported Targets

The package manifest declares:

- iOS 16.0+
- macOS 13.0+
- Swift tools 5.9+

The lowest supported iOS version is iOS 16.0. This is supported by `Package.swift` and by current SwiftUI choices such as sheet detents and the catalog's `NavigationStack` usage.
