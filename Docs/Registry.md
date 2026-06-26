# Registry

NativeCN supports two usage modes:

- Swift Package Manager: import `NativeCN`.
- Copy mode: copy selected source files into an app-owned namespace such as `AppUI/NativeCN`.

The registry is metadata only. It does not require a CLI, build plugin, package product, or network service.

## Files

- `Registry/registry.json` is the top-level index.
- `Registry/components/*.json` contains item metadata.
- Every item declares its source `files`, optional `previewFiles`, `docs`, and item `dependencies`.

## Source Dependency Mapping

Each item metadata file is the source dependency map for that item:

- `dependencies` names other registry items that must be copied first.
- `files` lists required Swift source files.
- `previewFiles` lists optional preview-only Swift files.
- `docs` lists the human documentation for the item.

The registry keeps dependency names separate from file paths so a future CLI can resolve the same graph that a person follows manually today.

## Copy Mode

Start with the target app folder:

```text
AppUI/
└── NativeCN/
    ├── Tokens/
    ├── Theme/
    ├── Primitives/
    └── Components/
```

Copy foundation items first:

1. `tokens`
2. `theme`
3. `primitives`

Then copy each component's dependencies before the component itself. For example, `button` depends on `tokens`, `theme`, and `primitives`; `select` depends on `button`; `toast` depends on `alert`.

## Example

To copy `CNButton` manually:

1. Open `Registry/components/button.json`.
2. Copy every file listed in `dependencies` by following those registry item files.
3. Copy every file listed in `files`.
4. Optionally copy `previewFiles` into a preview-only target.
5. Keep the source files together under the destination listed in `copyPaste.destination`.

The `button` item maps to:

```json
{
  "dependencies": ["tokens", "theme", "primitives"],
  "files": ["Sources/NativeCN/Components/Button/CNButton.swift"]
}
```

## Source Ownership

In copy mode, the app owns the copied source. You can rename folders, adjust APIs, and remove components you do not use. Keep the `CN` prefix unless the app intentionally adopts a different namespace.

When copying into the same app target, the files do not need `import NativeCN`; they compile as local Swift files with their existing `SwiftUI` and `Foundation` imports.

## Validation

Run:

```bash
swift test
```

The registry tests verify that the top-level registry is valid JSON, item metadata files exist, item dependencies resolve, and every declared source/doc/preview path exists.

## Future CLI

A future CLI may automate:

```text
nativecn add button
nativecn add card input field
nativecn theme export --format swift
```

The CLI remains optional. The registry is designed to be useful with manual copy-paste first.
