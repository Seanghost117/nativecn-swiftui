# Loading And Media

Phase 5 adds `CNAvatar`, `CNSkeleton`, `CNProgress`, and `CNSpinner`.

## Import And Setup

```swift
import NativeCN
import SwiftUI
```

Use these components inside a themed subtree.

## Avatar

```swift
CNAvatar(url: user.avatarURL, fallback: "JD")
CNAvatar(image: Image("avatar"), fallback: "JD", size: .lg)
CNAvatar(fallback: "NA", size: .xl)
```

`CNAvatar` supports remote images, local `Image`, initials fallback, placeholder fallback, sizes `sm`, `md`, `lg`, and `xl`, plus tokenized clipping and borders.

## Skeleton

```swift
CNSkeleton(width: 160, height: 20)
CNSkeleton(shape: .circle, size: 48)
CNSkeleton(width: 240, height: 18, shape: .roundedRectangle, shimmer: false)
```

`CNSkeleton` supports rectangle, rounded rectangle, and circle placeholders. Shimmer is optional and automatically stops when Reduce Motion is enabled.

## Progress

```swift
CNProgress(value: uploadProgress)
CNProgress(value: 0.7, label: "Upload progress")
```

`CNProgress` clamps values into `0...1` and exposes an accessibility percentage.

## Spinner

```swift
CNSpinner(size: 24)
CNSpinner(size: 32, label: "Loading profile")
```

`CNSpinner` uses native circular progress behavior with tokenized tint.

## Real-World Example

```swift
CNCard {
    CNCardHeader {
        CNCardTitle("Loading profile")
        CNCardDescription("Skeletons compose into placeholder screens.")
    }

    CNCardContent {
        HStack {
            CNSkeleton(shape: .circle, size: 48)
            VStack(alignment: .leading) {
                CNSkeleton(width: 160, height: 16)
                CNSkeleton(width: 220, height: 16)
            }
        }
    }
}
```

## Accessibility

- Avatar images should receive a useful `accessibilityLabel` when they represent a person or entity.
- Skeletons expose a loading label.
- Progress exposes a percentage value.
- Spinners expose a loading label.

## Theming

These components use muted, accent, primary, border, radius, motion, and typography tokens.

## API Reference

- `CNAvatar(url:fallback:size:accessibilityLabel:)`
- `CNAvatar(image:fallback:size:accessibilityLabel:)`
- `CNAvatar(fallback:size:accessibilityLabel:)`
- `CNSkeleton(width:height:shape:shimmer:label:)`
- `CNSkeleton(shape:size:shimmer:label:)`
- `CNProgress(value:label:height:)`
- `CNSpinner(size:color:label:)`

## Platform Differences

`CNAvatar` uses SwiftUI `AsyncImage` for remote images. Loading indicators use native SwiftUI progress rendering, so appearance may vary slightly by platform.
