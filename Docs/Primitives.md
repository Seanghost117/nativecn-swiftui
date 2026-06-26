# Core Primitives

Phase 2 adds the low-level building blocks that NativeCN components use before any public component APIs ship.

## Control Size

`CNControlSize` defines the shared size scale for controls:

```swift
let metrics = CNControlSize.md.metrics(in: theme)
```

The metrics include height, minimum width, padding, icon length, content spacing, and radius. Values are derived from `CNTheme` spacing and radius tokens where possible.

## Control State

`CNControlState` carries shared interaction state:

```swift
let state = CNControlState(
    isEnabled: true,
    isPressed: false,
    isFocused: true,
    isHovered: false,
    isLoading: false,
    isInvalid: false
)
```

Button and input implementations should use this state shape for previews and style mapping.

## Focus Ring

Use `cnFocusRing(isFocused:)` to draw a token-driven focus outline:

```swift
Text("Focusable")
    .padding()
    .cnFocusRing(isFocused: isFocused)
```

The ring uses `theme.colors.ring`.

## Border

Use `cnBorder()` for tokenized rounded borders:

```swift
Text("Bordered")
    .padding()
    .cnBorder()
```

The default color is `theme.colors.border`.

## Loading Indicator

Use `CNLoadingIndicator` inside controls that need a compact progress affordance:

```swift
CNLoadingIndicator(size: 16)
```

The default tint is `theme.colors.primary`.

## Interactive Scale

Use `cnInteractiveScale(isPressed:)` for press feedback:

```swift
label
    .cnInteractiveScale(isPressed: configuration.isPressed)
```

The modifier resolves animation from `theme.motion.easeOut` and suppresses scaling when Reduce Motion is enabled.

## Platform Helpers

`CNPlatform.current`, `CNPlatform.supportsHover`, `CNPlatform.supportsKeyboardFocus`, and `CNPlatform.isTouchPrimary` provide compile-time platform guidance for native adaptations.

## Preview Harness

`CNPreviewMatrix` and `CNPreviewState.interactiveStates` provide a lightweight state-grid harness for component previews:

```swift
CNPreviewMatrix("Button States") { previewState in
    Text(previewState.name)
        .cnFocusRing(isFocused: previewState.controlState.isFocused)
}
```

Use this for variants, state matrices, and early component QA.
