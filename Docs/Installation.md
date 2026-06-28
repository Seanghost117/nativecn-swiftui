# Installation

NativeCN is distributed as a Swift Package Manager library.

## Swift Package Manager

Add the package to your app:

```swift
dependencies: [
    .package(url: "https://github.com/Seanghost117/nativecn-swiftui.git", from: "0.9.0")
]
```

Add the product to your app target:

```swift
.product(name: "NativeCN", package: "nativecn-swiftui")
```

Use versioned Swift Package Manager dependencies for release builds. Branch dependencies remain useful for testing unreleased changes.

## Import

```swift
import NativeCN
import SwiftUI
```

## Copy-Paste Mode

NativeCN can also be copied into an app as source. Start with `Registry/registry.json`, then follow the item metadata files in `Registry/components`.

See [Registry.md](Registry.md) for the manual copy-paste workflow.

## Theme Setup

Install a theme provider near the app or feature root:

```swift
CNThemeProvider(.nativeCNLight) {
    ContentView()
}
```

Override a subtree when needed:

```swift
SettingsView()
    .cnTheme(.nativeCNDark)
```

## Minimum Targets

The package manifest currently declares:

- iOS 16+
- macOS 13+
- Swift tools 5.9+

## Local Verification

```bash
swift build
swift test
```
