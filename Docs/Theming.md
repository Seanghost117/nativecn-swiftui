# Theming

NativeCN components read visual values from `CNTheme`. A theme is a complete set of semantic design tokens for color, typography, radius, spacing, shadows, and motion.

## Provide A Theme

Use `CNThemeProvider` near the root of your app or feature.

```swift
import NativeCN
import SwiftUI

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            CNThemeProvider(.nativeCNLight) {
                ContentView()
            }
        }
    }
}
```

You can also override a subtree with the view modifier:

```swift
SettingsView()
    .cnTheme(.nativeCNDark)
```

## Read The Active Theme

Components and app views can read the current theme from the SwiftUI environment.

```swift
struct ExampleSurface: View {
    @Environment(\.cnTheme) private var theme

    var body: some View {
        Text("NativeCN")
            .font(theme.typography.headline.font)
            .foregroundStyle(theme.colors.foreground.color)
            .padding(theme.space.x4)
            .background(theme.colors.card.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
    }
}
```

## Default Themes

Phase 1 includes:

- `CNTheme.nativeCNLight`
- `CNTheme.nativeCNDark`
- `CNTheme.default`

The default theme is currently `nativeCNLight`. Apps that follow system appearance can resolve themes through `CNThemeMode.system(light:dark:)`.

## Token Rules

- Use semantic tokens such as `theme.colors.primary`, not hard-coded one-off colors.
- Use typography tokens so text remains Dynamic Type-compatible.
- Use `CNMotionTokens` and pass Reduce Motion state when resolving animations.
- Keep custom themes complete. Every `CNTheme` must provide all token groups.
