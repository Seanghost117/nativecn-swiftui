# NativeCN Product Direction

NativeCN is a SwiftUI-first component system inspired by shadcn/ui's copyable, token-driven workflow.

## Goals

- Provide a polished set of Apple-platform SwiftUI components.
- Keep public APIs small, readable, and composable.
- Use semantic tokens for colors, spacing, radius, typography, shadows, and motion.
- Preserve native SwiftUI behavior wherever it gives a better Apple-platform experience.
- Support both package installation and copy-paste source ownership through registry metadata.
- Ship an interactive catalog app that demonstrates realistic component usage.

## Non-Goals

- NativeCN is not a web-port of shadcn/ui.
- NativeCN does not require Tailwind, CSS, JavaScript, or runtime code generation.
- NativeCN does not try to replace Apple's native controls when native behavior is the better fit.

## Current Product Surface

- Tokens and themes
- Core primitives
- Forms and controls
- Feedback and overlays
- Layout primitives
- Navigation
- Data display
- Content components
- Interaction components
- Calendar components
- Registry metadata
- Catalog app

For implementation status, see [Roadmap](Roadmap.md).
