import Foundation
import XCTest

final class RegistryTests: XCTestCase {
    func testRegistryIndexAndItemsAreValid() throws {
        let registry = try decode(RegistryIndex.self, at: "Registry/registry.json")

        XCTAssertEqual(registry.registryVersion, 1)
        XCTAssertEqual(registry.copyPasteRoot, "AppUI/NativeCN")
        XCTAssertTrue(fileExists(registry.docs), "Registry docs should exist")
        XCTAssertFalse(registry.items.isEmpty, "Registry should include stable items")

        let itemNames = Set(registry.items.map(\.name))
        XCTAssertEqual(itemNames.count, registry.items.count, "Registry item names should be unique")
        XCTAssertTrue(itemNames.isSuperset(of: requiredStableItems))

        for item in registry.items {
            XCTAssertTrue(fileExists(item.path), "\(item.path) should exist")

            let metadata = try decode(RegistryItem.self, at: item.path)
            XCTAssertEqual(metadata.name, item.name)
            XCTAssertEqual(metadata.type, item.type)
            XCTAssertEqual(metadata.stability, "stable")
            XCTAssertFalse(metadata.title.isEmpty)
            XCTAssertFalse(metadata.description.isEmpty)
            XCTAssertFalse(metadata.files.isEmpty, "\(item.name) should map at least one source file")
            XCTAssertFalse(metadata.copyPaste.destination.isEmpty)

            for dependency in metadata.dependencies {
                XCTAssertTrue(itemNames.contains(dependency), "\(item.name) dependency \(dependency) should be registered")
            }

            for path in metadata.files {
                XCTAssertTrue(fileExists(path), "\(item.name) source path should exist: \(path)")
            }

            for path in metadata.previewFiles ?? [] {
                XCTAssertTrue(fileExists(path), "\(item.name) preview path should exist: \(path)")
            }

            for path in metadata.docs {
                XCTAssertTrue(fileExists(path), "\(item.name) docs path should exist: \(path)")
            }
        }
    }

    func testRegistryDocumentationExplainsManualCopyPasteWorkflow() throws {
        let docs = try contents(of: "Docs/Registry.md")

        XCTAssertTrue(docs.contains("Copy mode"))
        XCTAssertTrue(docs.contains("Registry/registry.json"))
        XCTAssertTrue(docs.contains("Source Dependency Mapping"))
        XCTAssertTrue(docs.contains("dependencies"))
        XCTAssertTrue(docs.contains("source files"))
        XCTAssertTrue(docs.contains("CLI remains optional"))
    }

    private var requiredStableItems: Set<String> {
        [
            "tokens",
            "theme",
            "primitives",
            "button",
            "badge",
            "card",
            "separator",
            "label",
            "field",
            "input",
            "input-otp",
            "avatar",
            "skeleton",
            "progress",
            "spinner",
            "textarea",
            "switch",
            "toggle",
            "toggle-group",
            "slider",
            "checkbox",
            "radio-group",
            "select",
            "combobox",
            "alert",
            "dialog",
            "alert-dialog",
            "sheet",
            "drawer",
            "toast",
            "popover",
            "tooltip",
            "hover-card",
            "dropdown-menu",
            "menubar",
            "page-header",
            "section",
            "list-row",
            "empty-state",
            "aspect-ratio",
            "scroll-area",
            "resizable-panels",
            "carousel",
            "breadcrumb",
            "tabs",
            "segmented-control",
            "navigation-menu",
            "sidebar",
            "stat",
            "description-list",
            "timeline",
            "status-badge",
            "resource-list",
            "data-table",
            "pagination",
            "callout",
            "note",
            "code-block",
            "inline-code",
            "keyboard-shortcut",
            "accordion",
            "collapsible",
            "context-menu",
            "command",
            "calendar",
        ]
    }

    private func decode<T: Decodable>(_ type: T.Type, at path: String) throws -> T {
        let data = try Data(contentsOf: URL(fileURLWithPath: absolutePath(path)))
        return try JSONDecoder().decode(T.self, from: data)
    }

    private func fileExists(_ path: String) -> Bool {
        FileManager.default.fileExists(atPath: absolutePath(path))
    }

    private func contents(of path: String) throws -> String {
        try String(contentsOfFile: absolutePath(path), encoding: .utf8)
    }

    private func absolutePath(_ path: String) -> String {
        URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            .appendingPathComponent(path)
            .path
    }
}

private struct RegistryIndex: Decodable {
    var registryVersion: Int
    var copyPasteRoot: String
    var docs: String
    var items: [RegistryIndexItem]
}

private struct RegistryIndexItem: Decodable {
    var name: String
    var type: String
    var path: String
}

private struct RegistryItem: Decodable {
    var name: String
    var type: String
    var title: String
    var description: String
    var stability: String
    var dependencies: [String]
    var files: [String]
    var previewFiles: [String]?
    var docs: [String]
    var copyPaste: RegistryCopyPaste
}

private struct RegistryCopyPaste: Decodable {
    var destination: String
}
