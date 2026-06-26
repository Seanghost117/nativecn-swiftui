# Contributing

NativeCN is early and intentionally strict about component quality.

## Before Adding Components

Open an issue or discussion with:

- Purpose
- Related shadcn/ui component, if any
- Native Apple pattern
- Public API proposal
- Variants and states
- Accessibility behavior
- Dynamic Type behavior
- Testing plan
- Documentation plan

## Component Definition Of Done

A component is complete when it has:

- Public API docs
- Light and dark support
- Accessibility basics
- Dynamic Type consideration
- Previews for variants, sizes, and states
- At least smoke tests or token mapping tests
- Catalog example
- Docs with copy-paste examples

## Local Checks

```bash
swift build
swift test
```

If catalog files change, type-check the example app sources against the built module until a formal Xcode project/scheme is added.

## Style

- Prefix public symbols with `CN`.
- Keep files small and component-focused.
- Use `CNTheme` tokens for visual values.
- Avoid third-party dependencies in the core package.
- Prefer readable SwiftUI composition over clever abstraction.
