import Foundation

struct RegistryIndex: Decodable {
    var name: String
    var registryVersion: Int
    var copyPasteRoot: String
    var docs: String
    var items: [RegistryIndexItem]
}

struct RegistryIndexItem: Decodable {
    var name: String
    var type: String
    var path: String
}

struct RegistryItem: Decodable {
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

struct RegistryCopyPaste: Decodable {
    var destination: String
}

enum RegistryToolError: Error, CustomStringConvertible {
    case invalidUsage(String)
    case validationFailed([String])
    case unknownItem(String)

    var description: String {
        switch self {
        case let .invalidUsage(message):
            return message
        case let .validationFailed(errors):
            return errors.joined(separator: "\n")
        case let .unknownItem(name):
            return "Unknown registry item: \(name)"
        }
    }
}

let arguments = Array(CommandLine.arguments.dropFirst())

do {
    let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    let registry = try Registry(root: root)

    switch arguments.first {
    case "validate":
        try registry.validate()
        print("Registry valid: \(registry.index.items.count) items")
    case "list":
        try registry.validate()
        for item in registry.index.items {
            print("\(item.name)\t\(item.type)")
        }
    case "plan":
        try registry.validate()
        let includePreviews = arguments.contains("--include-previews")
        let includeDocs = arguments.contains("--include-docs")
        let names = arguments.dropFirst().filter { !$0.hasPrefix("--") }
        guard !names.isEmpty else {
            throw RegistryToolError.invalidUsage("Usage: swift run NativeCNRegistry plan <item...> [--include-previews] [--include-docs]")
        }
        let plan = try registry.copyPlan(for: Array(names), includePreviews: includePreviews, includeDocs: includeDocs)
        print(plan.rendered())
    default:
        print("""
        NativeCNRegistry

        Usage:
          swift run NativeCNRegistry validate
          swift run NativeCNRegistry list
          swift run NativeCNRegistry plan button card --include-previews --include-docs
        """)
    }
} catch {
    fputs("\(error)\n", stderr)
    exit(1)
}

struct Registry {
    let root: URL
    let index: RegistryIndex

    private var itemByName: [String: RegistryItem] = [:]

    init(root: URL) throws {
        self.root = root
        self.index = try Self.decode(RegistryIndex.self, at: root.appendingPathComponent("Registry/registry.json"))
        var itemByName: [String: RegistryItem] = [:]
        for item in index.items {
            itemByName[item.name] = try Self.decode(RegistryItem.self, at: root.appendingPathComponent(item.path))
        }
        self.itemByName = itemByName
    }

    func validate() throws {
        var errors: [String] = []
        let indexNames = index.items.map(\.name)
        let itemNameSet = Set(indexNames)

        if indexNames.count != itemNameSet.count {
            errors.append("Registry item names must be unique.")
        }

        for schemaPath in ["Registry/schemas/registry.schema.json", "Registry/schemas/item.schema.json"] {
            if !exists(schemaPath) {
                errors.append("Missing schema file: \(schemaPath)")
            }
        }

        if !exists(index.docs) {
            errors.append("Missing registry docs: \(index.docs)")
        }

        for indexItem in index.items {
            guard let metadata = itemByName[indexItem.name] else {
                errors.append("Missing metadata for \(indexItem.name)")
                continue
            }

            if metadata.name != indexItem.name {
                errors.append("\(indexItem.path): metadata name \(metadata.name) does not match index name \(indexItem.name)")
            }

            if metadata.type != indexItem.type {
                errors.append("\(indexItem.path): metadata type \(metadata.type) does not match index type \(indexItem.type)")
            }

            if metadata.title.isEmpty || metadata.description.isEmpty {
                errors.append("\(indexItem.name): title and description are required.")
            }

            if metadata.stability != "stable" && metadata.stability != "experimental" {
                errors.append("\(indexItem.name): stability must be stable or experimental.")
            }

            if metadata.files.isEmpty {
                errors.append("\(indexItem.name): files must not be empty.")
            }

            if metadata.copyPaste.destination.isEmpty {
                errors.append("\(indexItem.name): copyPaste.destination must not be empty.")
            }

            for dependency in metadata.dependencies where !itemNameSet.contains(dependency) {
                errors.append("\(indexItem.name): unknown dependency \(dependency)")
            }

            for path in metadata.files + (metadata.previewFiles ?? []) + metadata.docs where !exists(path) {
                errors.append("\(indexItem.name): missing referenced path \(path)")
            }
        }

        for name in indexNames {
            detectCycle(from: name, path: [], errors: &errors)
        }

        if !errors.isEmpty {
            throw RegistryToolError.validationFailed(errors)
        }
    }

    func copyPlan(for names: [String], includePreviews: Bool, includeDocs: Bool) throws -> CopyPlan {
        var visited = Set<String>()
        var ordered: [RegistryItem] = []

        for name in names {
            try visit(name, visited: &visited, ordered: &ordered)
        }

        return CopyPlan(items: ordered, includePreviews: includePreviews, includeDocs: includeDocs)
    }

    private func visit(_ name: String, visited: inout Set<String>, ordered: inout [RegistryItem]) throws {
        if visited.contains(name) {
            return
        }

        guard let item = itemByName[name] else {
            throw RegistryToolError.unknownItem(name)
        }

        visited.insert(name)
        for dependency in item.dependencies {
            try visit(dependency, visited: &visited, ordered: &ordered)
        }
        ordered.append(item)
    }

    private func detectCycle(from name: String, path: [String], errors: inout [String]) {
        if path.contains(name) {
            errors.append("Dependency cycle detected: \((path + [name]).joined(separator: " -> "))")
            return
        }

        guard let item = itemByName[name] else {
            return
        }

        for dependency in item.dependencies {
            detectCycle(from: dependency, path: path + [name], errors: &errors)
        }
    }

    private func exists(_ path: String) -> Bool {
        FileManager.default.fileExists(atPath: root.appendingPathComponent(path).path)
    }

    private static func decode<T: Decodable>(_ type: T.Type, at url: URL) throws -> T {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

struct CopyPlan {
    var items: [RegistryItem]
    var includePreviews: Bool
    var includeDocs: Bool

    func rendered() -> String {
        var lines = ["Copy plan:"]

        for item in items {
            lines.append("")
            lines.append("- \(item.name) -> \(item.copyPaste.destination)")
            for file in item.files {
                lines.append("  source: \(file)")
            }
            if includePreviews {
                for file in item.previewFiles ?? [] {
                    lines.append("  preview: \(file)")
                }
            }
            if includeDocs {
                for doc in item.docs {
                    lines.append("  docs: \(doc)")
                }
            }
        }

        return lines.joined(separator: "\n")
    }
}

