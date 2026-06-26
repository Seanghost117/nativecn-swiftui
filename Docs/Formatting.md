# Formatting And Linting

Phase 0 does not add a formatting or linting dependency.

## Decision

- Use the default Swift style produced by Xcode and Swift Package Manager.
- Keep public APIs documented.
- Keep files small and component-focused.
- Do not gate CI on a formatter or linter until the initial token and component APIs stabilize.

## Future Review

Before the first public beta, revisit whether to adopt `swift-format`, SwiftLint, or both. Any tool should be lightweight, documented, and runnable locally without private infrastructure.
